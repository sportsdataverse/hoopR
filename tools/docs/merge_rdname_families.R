## merge_rdname_families.R
## ------------------------
## Lever 3 of the win-builder manual-build time reduction: cut man/ PAGE
## COUNT by merging sibling function families onto one shared Rd topic
## via @rdname (roxygen2's standard multi-object-one-topic mechanism --
## see e.g. base::mean/mean.Date). Every function keeps its own \alias,
## \usage, and @return content; ?fn still resolves for every member.
##
## Common source shape for a family member (verified against the repo's
## generated nba_stats_*.R / espn_*.R / load_*.R modules):
##
##   #' **Title**
##   #' @name <member>
##   NULL
##   #' @title
##   #' **Title**
##   #' @rdname <member>
##   #' @author ...
##   #' @param ...
##   #' @return ...
##   <member> <- function(...) { ... }
##
## For the chosen PRIMARY member of a family, nothing changes. For every
## OTHER member: the tiny `#' @name <member>` / NULL stub block is
## deleted (it exists only to seed the object's own topic, which the
## family now shares with the primary), and the main block's
## `@rdname <member>` becomes `@rdname <primary>`. Title/description/
## param/return content in the main block is left untouched --
## roxygen2 concatenates it into the shared topic (verified in a pilot:
## tools::checkRd stays clean, \alias/\usage/\value all show every
## member).
##
## Every family below was verified by an exact-formal-parameter-name-set
## grep across R/*.R (order-insensitive; see the ported lever1/find_families
## analysis) -- not just a naming-template guess -- to avoid the "same file,
## different shape" bug class.
##
## Usage:
##   Rscript tools/docs/merge_rdname_families.R            # apply
##   Rscript tools/docs/merge_rdname_families.R --dry-run   # report only

source("tools/docs/gate_tables_pdf.R")  ## for doc_blocks(), block_rdname(), is_roxy()

args <- commandArgs(trailingOnly = TRUE)
dry_run <- "--dry-run" %in% args

## ---- family definitions: file(s) -> list of c(primary, other1, other2, ...) ----
## One file's functions merge onto the FIRST family member's topic name.
families <- list(
  load_mbb.R = list(
    c("load_mbb_pbp", "load_mbb_team_box", "load_mbb_player_box", "load_mbb_schedule",
      "load_mbb_rosters", "load_mbb_player_stats", "load_mbb_team_stats", "load_mbb_standings",
      "load_mbb_game_rosters", "load_mbb_officials", "load_mbb_player_core", "load_mbb_shots")
  ),
  load_nba.R = list(
    c("load_nba_pbp", "load_nba_team_box", "load_nba_player_box", "load_nba_schedule",
      "load_nba_standings", "load_nba_game_rosters", "load_nba_officials", "load_nba_draft",
      "load_nba_player_stats", "load_nba_team_stats", "load_nba_rosters", "load_nba_player_core",
      "load_nba_shots")
  ),
  ## load_nba_stats.R, load_ncaa_mbb.R, and load_models.R are already fully @rdname-merged
  ## (verified: every member's block_rdname() already resolves to a single
  ## shared primary) -- nothing left to do, so they're omitted here.
  load_crosswalk.R = list(
    c("load_nba_team_crosswalk", "load_nba_schedule_crosswalk", "load_nba_player_crosswalk",
      "load_mbb_team_crosswalk", "load_mbb_schedule_crosswalk", "load_mbb_player_crosswalk")
  ),
  nba_stats_boxscore.R = list(
    c("nba_boxscoretraditionalv2", "nba_boxscoreadvancedv2", "nba_boxscorefourfactorsv2",
      "nba_boxscoremiscv2", "nba_boxscorescoringv2", "nba_boxscoreusagev2"),
    c("nba_boxscoredefensive", "nba_boxscoresummaryv2", "nba_boxscorematchups",
      "nba_boxscoreplayertrackv2", "nba_hustlestatsboxscore")
  ),
  nba_stats_boxscore_v3.R = list(
    c("nba_boxscoretraditionalv3", "nba_boxscoreadvancedv3", "nba_boxscoremiscv3",
      "nba_boxscorescoringv3", "nba_boxscoreusagev3", "nba_boxscorefourfactorsv3",
      "nba_boxscoreplayertrackv3", "nba_boxscorematchupsv3", "nba_boxscoredefensivev2")
  ),
  ## nba_stats_player_dash.R / nba_stats_team_dash.R: the 8-member
  ## `*dashboardby*` families are already @rdname-merged onto
  ## nba_playerdashboard / nba_teamdashboard. Only the still-separate
  ## pt-tracking siblings are merged here.
  nba_stats_player_dash.R = list(
    c("nba_playerdashptreb", "nba_playerdashptshotdefend", "nba_playerdashptshots")
  ),
  nba_stats_draft.R = list(
    c("nba_draftcombinestats", "nba_draftcombinedrillresults",
      "nba_draftcombinenonstationaryshooting", "nba_draftcombineplayeranthro",
      "nba_draftcombinespotshooting")
  ),
  nba_stats_hustle.R = list(
    c("nba_leaguehustlestatsplayer", "nba_leaguehustlestatsplayerleaders",
      "nba_leaguehustlestatsteam", "nba_leaguehustlestatsteamleaders")
  ),
  nba_stats_team.R = list(
    c("nba_teamplayeronoffdetails", "nba_teamplayeronoffsummary", "nba_teamplayerdashboard")
  ),
  espn_mbb_event_detail.R = list(
    c("espn_mbb_game_odds", "espn_mbb_game_officials", "espn_mbb_game_broadcasts",
      "espn_mbb_game_situation", "espn_mbb_game_predictor", "espn_mbb_game_powerindex"),
    c("espn_mbb_game_team_linescores", "espn_mbb_game_team_leaders", "espn_mbb_game_team_roster",
      "espn_mbb_game_team_statistics", "espn_mbb_game_team_records", "espn_mbb_game_team_score")
  ),
  espn_nba_event_detail.R = list(
    c("espn_nba_game_odds", "espn_nba_game_officials", "espn_nba_game_broadcasts",
      "espn_nba_game_situation", "espn_nba_game_predictor", "espn_nba_game_powerindex"),
    c("espn_nba_game_team_linescores", "espn_nba_game_team_leaders", "espn_nba_game_team_roster",
      "espn_nba_game_team_statistics", "espn_nba_game_team_records", "espn_nba_game_team_score")
  ),
  espn_mbb_athletes.R = list(
    c("espn_mbb_player_overview", "espn_mbb_player_stats_v3", "espn_mbb_player_gamelog",
      "espn_mbb_player_splits", "espn_mbb_player_eventlog", "espn_mbb_player_statisticslog")
  ),
  espn_nba_athletes.R = list(
    c("espn_nba_player_overview", "espn_nba_player_stats_v3", "espn_nba_player_gamelog",
      "espn_nba_player_splits", "espn_nba_player_eventlog", "espn_nba_player_statisticslog")
  ),
  espn_mbb_data.R = list(
    c("espn_mbb_game_all", "espn_mbb_pbp", "espn_mbb_team_box", "espn_mbb_player_box",
      "espn_mbb_game_rosters", "espn_mbb_betting"),
    c("helper_espn_mbb_pbp", "helper_espn_mbb_team_box", "helper_espn_mbb_player_box")
  ),
  espn_nba_data.R = list(
    c("espn_nba_game_all", "espn_nba_pbp", "espn_nba_team_box", "espn_nba_player_box",
      "espn_nba_game_rosters", "espn_nba_betting"),
    c("helper_espn_nba_pbp", "helper_espn_nba_team_box", "helper_espn_nba_player_box")
  ),
  espn_mbb_team_detail.R = list(
    c("espn_mbb_team", "espn_mbb_team_roster", "espn_mbb_team_leaders",
      "espn_mbb_team_season_profile")
  ),
  espn_nba_team_detail.R = list(
    c("espn_nba_team", "espn_nba_team_roster", "espn_nba_team_leaders",
      "espn_nba_team_season_profile")
  ),
  espn_mbb_groups_v2.R = list(
    c("espn_mbb_season_group", "espn_mbb_season_group_children", "espn_mbb_season_group_teams")
  ),
  espn_nba_groups_v2.R = list(
    c("espn_nba_season_group", "espn_nba_season_group_children", "espn_nba_season_group_teams")
  ),
  espn_nba_athlete_career.R = list(
    c("espn_nba_draft_rounds", "espn_nba_draft_athletes", "espn_nba_draft_status",
      "espn_nba_season_draft")
  ),
  ## fox_basketball.R: already @rdname-merged, but pairwise per resource
  ## (fox_basketball_pbp, fox_basketball_boxscore, ... 9 topics) rather
  ## than the bigger groupings this campaign would otherwise propose --
  ## nothing left to do.
  cbbd_games.R = list(
    c("cbbd_games_media", "cbbd_games_teams", "cbbd_games_players")
  ),
  cbbd_stats.R = list(
    c("cbbd_stats_team_season", "cbbd_stats_team_shooting_season", "cbbd_stats_player_season",
      "cbbd_stats_player_shooting_season")
  ),
  cbbd_ratings.R = list(
    c("cbbd_ratings_srs", "cbbd_ratings_adjusted", "cbbd_ratings_elo")
  ),
  kp_ratings_tables.R = list(
    c("kp_pomeroy_ratings", "kp_efficiency", "kp_fourfactors", "kp_pointdist", "kp_height",
      "kp_foul_trouble", "kp_teamstats")
  ),
  kp_team_tables.R = list(
    c("kp_team_schedule", "kp_gameplan", "kp_opptracker", "kp_team_players", "kp_minutes_matrix",
      "kp_team_player_stats", "kp_team_depth_chart", "kp_team_lineups")
  )
)

## ---- transform one file for its family list ----
process_family_file <- function(fname, fam_list, dry_run = FALSE) {
  r_path <- file.path("R", fname)
  if (!file.exists(r_path)) {
    cat(sprintf("SKIP %s: file not found\n", fname)); return(invisible(NULL))
  }
  lines <- readLines(r_path, warn = FALSE)
  n_saved <- 0L

  for (fam in fam_list) {
    primary <- fam[1]
    others  <- fam[-1]

    for (member in others) {
      blocks <- doc_blocks(lines)
      matched <- FALSE
      for (b in blocks) {
        bstart <- b[1]; bend <- b[2]
        bl <- lines[bstart:bend]
        rn <- block_rdname(bl, lines, bend)
        if (is.na(rn) || rn != member) next

        ## classify: tiny stub block (followed by NULL) vs main block
        nxt <- bend + 1L
        while (nxt <= length(lines) && !nzchar(trimws(lines[nxt]))) nxt <- nxt + 1L
        is_stub <- nxt <= length(lines) && trimws(lines[nxt]) == "NULL"

        if (is_stub) {
          ## delete the stub block AND the following NULL line (+ any
          ## blank lines strictly between them, which is none in this
          ## repo's pattern, plus trailing blank lines already left as-is)
          del_end <- nxt
          lines[bstart:del_end] <- NA_character_
          matched <- TRUE
        } else {
          rdname_ln <- grep(paste0("^#'\\s*@rdname\\s+", member, "\\s*$"), bl, perl = TRUE)
          name_ln   <- grep(paste0("^#'\\s*@name\\s+", member, "\\s*$"), bl, perl = TRUE)
          if (length(rdname_ln) == 1L) {
            abs_ln <- bstart + rdname_ln[1] - 1L
            lines[abs_ln] <- sub(paste0("@rdname\\s+", member, "\\s*$"),
                                  paste0("@rdname ", primary), lines[abs_ln], perl = TRUE)
          } else if (length(name_ln) == 1L) {
            abs_ln <- bstart + name_ln[1] - 1L
            lines[abs_ln] <- sub(paste0("@name\\s+", member, "\\s*$"),
                                  paste0("@rdname ", primary), lines[abs_ln], perl = TRUE)
          } else if (length(rdname_ln) == 0L && length(name_ln) == 0L) {
            ## no explicit @rdname/@name tag at all (roxygen2's own
            ## function-name fallback was in play). Insert one right before
            ## the block's FIRST real @tag line -- NOT at the block's
            ## absolute start, which would swallow any leading title-prose
            ## line into the new tag and silently drop the @export/@title
            ## parse (verified: doing this wrong produced "Undocumented
            ## code objects" in R CMD check).
            first_tag <- grep("^#'\\s*@\\S", bl, perl = TRUE)
            insert_at <- if (length(first_tag) > 0) bstart + first_tag[1] - 1L else bend + 1L
            lines <- append(lines, paste0("#' @rdname ", primary), after = insert_at - 1L)
          } else {
            stop(sprintf("%s: ambiguous @rdname/@name match for member '%s'", fname, member))
          }
          matched <- TRUE
        }
      }
      if (!matched) {
        stop(sprintf("%s: member '%s' -- no matching doc block found (0 of 2 expected hits)", fname, member))
      }
      ## re-derive line indices since we may have blanked lines (NA marks deletion,
      ## applied at the end) -- doc_blocks() on the NA-containing vector below would
      ## break, so purge NAs after each member's full pass, not mid-loop.
      keep <- !is.na(lines)
      lines <- lines[keep]
    }
    n_saved <- n_saved + length(others)
  }

  cat(sprintf("%s%s: %d topic(s) merged away (%d page(s) saved)\n",
              if (dry_run) "[dry-run] " else "", fname, n_saved, n_saved))
  if (!dry_run) writeLines(lines, r_path)
  n_saved
}

main <- function() {
  total <- 0L
  for (fname in names(families)) {
    total <- total + process_family_file(fname, families[[fname]], dry_run = dry_run)
  }
  cat(sprintf("\n%sTotal pages saved: %d\n", if (dry_run) "[dry-run] " else "", total))
}

if (sys.nframe() == 0) main()
