# Build `mbb_team_names`: the extra team-name sources in data-raw/dict_hoopR.csv
# (NCAA, ESPN play-by-play, Warren Nolan, 247Sports, Sports-Reference), keyed
# on `espn_team_id` so mbb_team_crosswalk() can join them.
#
# Run from the package root:
#   Rscript data-raw/mbb_team_names.R
# Needs pkgload and usethis. Makes one network call: ESPN's men's college
# basketball team directory (site.api.espn.com), the list mbb_team_crosswalk()
# itself is built on.
#
# Inputs
#   * data-raw/dict_hoopR.csv: 367 rows, all 2023, keyed by the KenPom team
#     name with no ids. It is the source of truth for every name column; this
#     script only re-keys it and never edits a value.
#   * hoopR::teams_links: the current KenPom names (2026 and 2027).
#   * ESPN's current team directory (.bb_espn_team_directory()).
# Outputs
#   * data/mbb_team_names.rda and data-raw/mbb_team_names.csv
#
# How each row gets its espn_team_id
#   1. The dict's KenPom key is renamed to the team's current KenPom name
#      (`kp_rename` below), so the keys match teams_links.
#   2. That name goes through the crosswalk's own KenPom matching
#      (.bb_assemble_team_crosswalk_mbb(), alias table included) against
#      ESPN's current directory.
#   3. The few teams that are not in ESPN's current Division I list are mapped
#      by hand (`hand_ids` below).
#   The dict's Torvik (`Trank`) column is matched the same way as a cross-check;
#   the script stops if the two routes ever disagree.
#
# Teams that joined Division I after 2023 (in teams_links, not in the dict) get
# a row with only what can be checked without fetching anything: their ESPN id
# and, where the repository has one, their NCAA name. Every other name column
# stays NA. Sports-Reference slugs are not derived from the school name: in the
# dict, lowercase-hyphenating the school name gives the slug for only 183 of the
# 210 schools whose KenPom, NCAA and ESPN names all agree, so it is a guess.

pkgload::load_all(".", quiet = TRUE)

# ---- dict -----------------------------------------------------------------
dict <- utils::read.csv("data-raw/dict_hoopR.csv", stringsAsFactors = FALSE,
                        na.strings = c("", "NA"), encoding = "UTF-8")
dict[] <- lapply(dict, function(x) if (is.character(x)) trimws(x) else x)

# Four rows have no KenPom key: Birmingham-Southern, Centenary, Morris Brown and
# Savannah St. All four left Division I (or folded) before ESPN's current list,
# so no crosswalk row can ever carry them. Dropped.
dropped <- dict$ESPN[is.na(dict$kenpom)]
stopifnot(setequal(dropped, c("Birmingham-Southern", "Centenary", "Morris Brown", "Savannah St")))
dict <- dict[!is.na(dict$kenpom), ]

# ---- KenPom renames since 2023 -----------------------------------------------
# Old dict key -> current teams_links name. Hartford (left Division I after
# 2022-23) and St. Francis NY (dropped athletics in 2023) have no current name
# and keep their dict key.
kp_rename <- c(
  "IUPUI"                  = "IU Indy",
  "UMKC"                   = "Kansas City",
  "St. Francis PA"         = "Saint Francis",
  "Cal St. Northridge"     = "CSUN",
  "McNeese St."            = "McNeese",
  "Nicholls St."           = "Nicholls",
  "SIU Edwardsville"       = "SIUE",
  "Southeast Missouri St." = "Southeast Missouri",
  "Texas A&M Commerce"     = "East Texas A&M",
  "New Orleans"            = "LSU New Orleans"
)
kp_current <- function(x) {
  hit <- match(x, names(kp_rename))
  ifelse(is.na(hit), x, unname(kp_rename[hit]))
}
dict$kp_team <- kp_current(dict$kenpom)

# 2026 still says "New Orleans"; 2027 says "LSU New Orleans".
kp_now <- unique(kp_current(hoopR::teams_links$Team[hoopR::teams_links$Year %in% c(2026L, 2027L)]))
stale <- setdiff(dict$kp_team, kp_now)
stopifnot(setequal(stale, c("Hartford", "St. Francis NY")))

# Teams in the current KenPom directory the dict does not have (joined
# Division I after 2023). NCAA names come from the 2025-26 rows of SDV's
# NCAA-ESPN team crosswalk (sportsdataverse-py
# sportsdataverse/mbb/data/ncaa_espn_team_crosswalk_mbb.csv). West Florida
# joined in 2026-27 and is not in that season, so its NCAA name stays NA.
new_teams <- data.frame(
  kp_team   = c("Le Moyne", "Mercyhurst", "New Haven", "West Georgia", "West Florida"),
  ncaa_team = c("Le Moyne", "Mercyhurst", "New Haven", "West Ga.",     NA),
  stringsAsFactors = FALSE
)
stopifnot(setequal(setdiff(kp_now, dict$kp_team), new_teams$kp_team))

# ---- espn_team_id via the crosswalk's KenPom matching ------------------------
espn <- .bb_espn_team_directory("mens-college-basketball", "mbb", 2027L)
keys <- c(dict$kp_team, new_teams$kp_team)
xw <- .bb_assemble_team_crosswalk_mbb(
  espn = espn, fox = NULL, bart = NULL,
  kp = data.frame(Team = keys, Conf = NA_character_, stringsAsFactors = FALSE),
  season = 2027L
)
ids <- stats::setNames(xw$espn_team_id, xw$kp_team)[!is.na(xw$kp_team)]

# Not in the directory the crosswalk reads (site.api.espn.com teams?groups=50),
# so resolved by hand. Each id is checked against the SDV conference-membership
# fixtures (tests/testthat/fixtures/crosswalk_basketball/
# mbb_team_group_seasons_<season>.parquet) or the 2023 directory snapshot.
hand_ids <- c(
  # Left Division I: the id ESPN used while the team was Division I.
  "Hartford"         = 42L,    # data-raw/espn_mbb_teams.csv (2023), "Hartford Hawks"
  "St. Francis NY"   = 2597L,  # data-raw/espn_mbb_teams.csv (2023), "St. Francis Brooklyn Terriers"
  "Saint Francis"    = 2598L,  # group seasons 2026, "Saint Francis Red Wolves"; Division II from 2026-27
  # Division I (in the 2026 and 2027 group seasons and in espn_mbb_teams()),
  # but missing from the groups=50 directory, so the crosswalk has no row for
  # them yet. Kept so they join once ESPN lists them.
  "Lindenwood"       = 2815L,  # "Lindenwood Lions"
  "Queens"           = 2511L,  # "Queens University Royals"
  "Southern Indiana" = 88L     # "Southern Indiana Screaming Eagles"
)
gs <- as.data.frame(arrow::read_parquet(
  "tests/testthat/fixtures/crosswalk_basketball/mbb_team_group_seasons_2026.parquet"
))
stopifnot(as.character(hand_ids[c("Saint Francis", "Lindenwood", "Queens", "Southern Indiana")]) %in% gs$team_id)
unmapped <- setdiff(keys, names(ids))
cli::cli_alert_info("Not matched to ESPN's current directory: {.val {unmapped}}")
stopifnot(setequal(unmapped, names(hand_ids)))
ids <- c(ids, hand_ids)

# Cross-check: the dict's Torvik names land on the same ESPN teams.
xb <- .bb_assemble_team_crosswalk_mbb(
  espn = espn, fox = NULL,
  bart = data.frame(team = dict$Trank, conf = NA_character_, stringsAsFactors = FALSE),
  kp = NULL, season = 2027L
)
via_trank <- stats::setNames(xb$espn_team_id, xb$bart_team)[!is.na(xb$bart_team)]
both <- !is.na(dict$Trank) & dict$Trank %in% names(via_trank)
disagree <- dict$kp_team[both][ids[dict$kp_team[both]] != via_trank[dict$Trank[both]]]
cli::cli_alert_info("Torvik route matched {sum(both)} of {nrow(dict)} rows; disagreements: {length(disagree)}")
stopifnot(length(disagree) == 0L)

# ---- assemble -------------------------------------------------------------
old <- data.frame(
  kp_team           = dict$kp_team,
  ncaa_team         = dict$NCAA,
  espn_pbp_name     = dict$ESPN_PBP,
  warren_nolan_team = dict$Warren_Nolan,
  team_247          = dict$name_247,
  sref_slug         = dict$sref_link,
  sref_team         = dict$sref_name,
  stringsAsFactors  = FALSE
)
new <- data.frame(
  kp_team           = new_teams$kp_team,
  ncaa_team         = new_teams$ncaa_team,
  espn_pbp_name     = NA_character_,
  warren_nolan_team = NA_character_,
  team_247          = NA_character_,
  sref_slug         = NA_character_,
  sref_team         = NA_character_,
  stringsAsFactors  = FALSE
)
mbb_team_names <- rbind(old, new)
mbb_team_names <- cbind(
  data.frame(espn_team_id = as.integer(unname(ids[mbb_team_names$kp_team]))),
  mbb_team_names
)
mbb_team_names <- mbb_team_names[order(mbb_team_names$kp_team), ]
rownames(mbb_team_names) <- NULL

stopifnot(
  !anyNA(mbb_team_names$espn_team_id),
  !anyDuplicated(mbb_team_names$espn_team_id),
  !anyDuplicated(mbb_team_names$kp_team)
)
cli::cli_alert_success("{nrow(mbb_team_names)} teams; NA per column:")
print(colSums(is.na(mbb_team_names)))

utils::write.csv(mbb_team_names, "data-raw/mbb_team_names.csv", row.names = FALSE, na = "")
usethis::use_data(mbb_team_names, overwrite = TRUE, compress = "xz")
