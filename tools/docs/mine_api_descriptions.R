## mine_api_descriptions.R
## ------------------------
## Driver that calls `mine_espn_api_descriptions()` (defined in
## tools/docs/markdown_man_table_helper.R) against the ESPN endpoint
## families that self-document their columns inside the response
## payload, and writes the aggregate result to
## `tools/docs/column_descriptions_api.csv`.
##
## Endpoint families probed (see tools/docs/espn_endpoints_catalog.md
## for the full catalog):
##
##   1. core-v2 athlete statistics (per-season + career)
##      `splits.categories[].stats[].description` — covers the
##      general_*, offensive_*, defensive_*, rebounding_*, shooting_*,
##      misc_* stat-section column families.
##   2. core-v2 team statistics (per-season).
##   3. core-v2 athlete statisticslog (game-by-game).
##   4. core-v2 leaders (statistical leaders).
##   5. web-common-v3 athlete stats (averages / totals / etc.).
##   6. web-common-v3 athlete splits (home/away/opponent splits).
##   7. web-common-v3 athlete gamelog (game-by-game).
##   8. web-common-v3 athlete overview.
##   9. web-common-v3 statistics/byathlete leaderboard (per category).
##
## The mined entries become the second-highest-precedence source in
## the dictionary build — see tools/docs/build_column_descriptions.R.
## Re-mine at any time:
##   Rscript tools/docs/mine_api_descriptions.R

options(warn = 1)
suppressPackageStartupMessages({
  library(dplyr); library(tibble); library(readr)
})

source("tools/docs/markdown_man_table_helper.R")

## ----- Known-good IDs --------------------------------------------------
## NBA: Scottie Barnes (athlete_id 4433134; team_id 28 = Toronto).
## MBB: 4433134 also has historical MBB stats from his Florida State year.
nba_athlete_id <- "4433134"; nba_team_id <- "28";  nba_season <- 2024
mbb_athlete_id <- "4433134"; mbb_team_id <- "52";  mbb_season <- 2021

CORE2 <- "https://sports.core.api.espn.com/v2"
WEBV3 <- "https://site.web.api.espn.com/apis/common/v3"

leagues <- list(
  list(slug = "nba",
       athlete_id = nba_athlete_id, team_id = nba_team_id,
       season = nba_season, label = "NBA"),
  list(slug = "mens-college-basketball",
       athlete_id = mbb_athlete_id, team_id = mbb_team_id,
       season = mbb_season, label = "MBB")
)

build_endpoints <- function(L) {
  with(L, c(
    ## 1. core-v2 athlete statistics
    sprintf("%s/sports/basketball/leagues/%s/seasons/%d/types/2/athletes/%s/statistics",
            CORE2, slug, season, athlete_id),
    sprintf("%s/sports/basketball/leagues/%s/seasons/%d/types/3/athletes/%s/statistics",
            CORE2, slug, season, athlete_id),
    sprintf("%s/sports/basketball/leagues/%s/athletes/%s/statistics",
            CORE2, slug, athlete_id),
    ## 2. core-v2 team statistics
    sprintf("%s/sports/basketball/leagues/%s/seasons/%d/types/2/teams/%s/statistics",
            CORE2, slug, season, team_id),
    ## 3. core-v2 athlete statisticslog
    sprintf("%s/sports/basketball/leagues/%s/athletes/%s/statisticslog",
            CORE2, slug, athlete_id),
    ## 4. core-v2 leaders
    sprintf("%s/sports/basketball/leagues/%s/leaders",
            CORE2, slug),
    sprintf("%s/sports/basketball/leagues/%s/seasons/%d/types/2/leaders",
            CORE2, slug, season),
    ## 5-8. web-v3 athlete stats / splits / gamelog / overview
    sprintf("%s/sports/basketball/%s/athletes/%s/stats?season=%d",
            WEBV3, slug, athlete_id, season),
    sprintf("%s/sports/basketball/%s/athletes/%s/splits?season=%d",
            WEBV3, slug, athlete_id, season),
    sprintf("%s/sports/basketball/%s/athletes/%s/gamelog?season=%d",
            WEBV3, slug, athlete_id, season),
    sprintf("%s/sports/basketball/%s/athletes/%s/overview",
            WEBV3, slug, athlete_id),
    ## 9. web-v3 leaderboard (per stat category)
    sprintf("%s/sports/basketball/%s/statistics/byathlete?category=offensive&season=%d",
            WEBV3, slug, season),
    sprintf("%s/sports/basketball/%s/statistics/byathlete?category=defensive&season=%d",
            WEBV3, slug, season),
    sprintf("%s/sports/basketball/%s/statistics/byathlete?category=general&season=%d",
            WEBV3, slug, season)
  ))
}

all_rows <- list()
for (L in leagues) {
  cat("\n=== ", L$label, " ===\n", sep = "")
  for (url in build_endpoints(L)) {
    short <- sub("^https?://[^/]+", "", url)
    cat("probing ", short, "\n", sep = "")
    rows <- mine_espn_api_descriptions(url)
    cat("  mined ", nrow(rows), " rows\n", sep = "")
    if (nrow(rows) > 0) all_rows[[length(all_rows) + 1]] <- rows
    Sys.sleep(1)
  }
}

dict <- bind_rows(all_rows) |>
  distinct(col_name, .keep_all = TRUE) |>
  arrange(col_name)

cat("\n=== Total unique API-mined col_names: ", nrow(dict), " ===\n", sep = "")
write_csv(dict, "tools/docs/column_descriptions_api.csv")
cat("Wrote tools/docs/column_descriptions_api.csv\n\n")

cat("Sample (first 30):\n")
print(head(dict, 30), n = 30)
