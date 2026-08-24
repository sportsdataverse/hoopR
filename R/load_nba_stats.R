# -----------------------------------------------------------------------------
# NBA Stats API release-dataset loaders
# -----------------------------------------------------------------------------
# Thin wrappers around rds_from_url() / parquet_from_url() that read the
# hoopR-nba-stats-data pipeline's published sportsdataverse-data release
# assets (the `nba_stats_*` tag family). Mirrors the shape of wehoop's
# R/load_wnba_stats.R (post-#78 dots-forwarding + update_*_db registration).
#
# Season convention: `seasons` here is the season's START year (e.g. `2024`
# for the 2024-25 season) -- matching sdv-py's `load_nba_stats_*` Python
# loaders -- NOT hoopR's ESPN-family `load_nba_*()` loaders, which key
# directly on the END year with no offset. The published `nba_stats_*`
# asset is keyed by the END year, so every URL below uses `seasons + 1`.
# [most_recent_nba_stats_season()] returns that START-year default; it is
# `most_recent_nba_season() - 1`, not a plain alias of it (unlike wehoop's
# `most_recent_wnba_stats_season()`, which *is* a plain alias -- the WNBA is
# a single-calendar-year league and needs no START/END offset).
#
# None of the `nba_stats_*` release tags currently ship an
# `*_in_data_repo.csv` manifest asset (several `wnba_stats_*` tags do), so
# there are no manifest loaders in this file.
# -----------------------------------------------------------------------------

#' **Load hoopR NBA Stats Coaches**
#' @name load_nba_stats_coaches
NULL

#' @title
#' **Load cleaned NBA Stats API season coaches from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA coaching staff data scraped from the
#'   NBA Stats API. One row per coach-team-season triple. Backed by the
#'   `hoopR-nba-stats-data` pipeline that reads raw JSONs from
#'   `hoopR-nba-stats-raw` and publishes csv/parquet/rds artifacts to the
#'   `nba_stats_coaches` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per coach-team-season.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |coach_id |integer |Unique coach identifier. |
#'    |first_name |character |Coach's first name. |
#'    |last_name |character |Coach's last name. |
#'    |coach_name |character |Coach's full name. |
#'    |is_assistant |integer |Whether the coach is an assistant coach (1) or head coach (0). |
#'    |coach_type |character |Coaching role (e.g. 'Head Coach', 'Assistant Coach'). |
#'    |sort_sequence |integer |Display sort order within the coaching staff. |
#'    |sub_sort_sequence |integer |Secondary display sort order within the coaching staff. |
#'    |season_type |character |Portion of the season (e.g. 'Regular Season', 'Playoffs'). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_coaches(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_coaches <- function(seasons = most_recent_nba_stats_season(),
                                   ...,
                                   dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_coaches/coaches_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API draft picks from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA draft picks scraped from the NBA
#'   Stats API (`drafthistory`-style outputs). One row per pick. Backed by
#'   the `hoopR-nba-stats-data` pipeline that reads raw JSONs from
#'   `hoopR-nba-stats-raw` and publishes csv/parquet/rds artifacts to the
#'   `nba_stats_draft` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024 NBA draft class), matching sdv-py's
#'   `load_nba_stats_*` convention (see the file-level note in
#'   `R/load_nba_stats.R`). Published coverage floors vary by loader (1996
#'   for most; 2007 for [load_nba_stats_lineups()] -- see that function's own
#'   Description) and run through the most recent season with no gaps. Pass
#'   `seasons = TRUE` for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of NBA draft picks.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |person_id |integer |Unique player identifier. |
#'    |player_name |character |Player's name. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |round_number |integer |Draft round number. |
#'    |round_pick |integer |Pick number within the round. |
#'    |overall_pick |integer |Overall pick number. |
#'    |draft_type |character |Draft type ('Draft', 'Undrafted', etc.). |
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |team_city |character |Team city or region. |
#'    |team_name |character |Full team display name. |
#'    |team_abbreviation |character |Three-letter team abbreviation. |
#'    |organization |character |Player's college / organization prior to the draft. |
#'    |organization_type |character |Type of organization (e.g. college, international). |
#'    |player_profile_flag |integer |Player profile flag. |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_draft(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_draft <- function(seasons = most_recent_nba_stats_season(),
                                 ...,
                                 dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_draft/draft_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API per-game 10-man on-court lineups from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads the per-event 10-man on-court lineup (5 home + 5 away)
#'   scraped alongside the NBA Stats API play-by-play feed. One row per
#'   play-by-play action, with each player slot's NBA Stats person id. Backed
#'   by the `hoopR-nba-stats-data` pipeline that publishes csv.gz/parquet/rds
#'   artifacts to the `nba_stats_game_lineups` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per play-by-play action.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |game_id |character |Unique game identifier. |
#'    |action_number |integer |Sequential play-by-play action number within the game. |
#'    |period |integer |Period of the game (1-4 quarters; 5+ for OT). |
#'    |home_player_1 |integer |Home on-court lineup slot 1 player identifier. |
#'    |home_player_2 |integer |Home on-court lineup slot 2 player identifier. |
#'    |home_player_3 |integer |Home on-court lineup slot 3 player identifier. |
#'    |home_player_4 |integer |Home on-court lineup slot 4 player identifier. |
#'    |home_player_5 |integer |Home on-court lineup slot 5 player identifier. |
#'    |away_player_1 |integer |Away on-court lineup slot 1 player identifier. |
#'    |away_player_2 |integer |Away on-court lineup slot 2 player identifier. |
#'    |away_player_3 |integer |Away on-court lineup slot 3 player identifier. |
#'    |away_player_4 |integer |Away on-court lineup slot 4 player identifier. |
#'    |away_player_5 |integer |Away on-court lineup slot 5 player identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_game_lineups(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_game_lineups <- function(seasons = most_recent_nba_stats_season(),
                                        ...,
                                        dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_game_lineups/nba_lineups_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API per-game inactive rosters from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads the per-game **inactive player** list scraped from the
#'   NBA Stats API -- the `InactivePlayers` result set of
#'   `boxscoresummaryv2`. One row per inactive athlete-game pair, not a full
#'   per-game roster: use [load_nba_stats_player_game_logs()] for the
#'   athletes who did play. Backed by the `hoopR-nba-stats-data` pipeline
#'   that publishes csv/parquet/rds artifacts to the `nba_stats_game_rosters`
#'   release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per inactive
#'   athlete-game pair.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |player_id |integer |Unique player identifier. |
#'    |first_name |character |Player's first name. |
#'    |last_name |character |Player's last name. |
#'    |jersey_num |character |Jersey number worn by the player. |
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |team_city |character |Team city or region. |
#'    |team_name |character |Full team display name. |
#'    |team_abbreviation |character |Three-letter team abbreviation. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |game_id |character |Unique game identifier. |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_game_rosters(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_game_rosters <- function(seasons = most_recent_nba_stats_season(),
                                        ...,
                                        dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_game_rosters/game_rosters_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API 5-man on-court lineup season stats from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level 5-man on-court lineup statistics
#'   (`leaguedashlineups`-style outputs, `Base` measure). Backed by the
#'   `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds artifacts
#'   to the `nba_stats_lineups` release tag. For `Advanced`/`Misc`/`Scoring`/
#'   `Opponent`/`Four Factors` measures and 2/3/4-man groupings, use
#'   [load_nba_stats_leaguedash()] with `table = "lineups_*"`.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader; **this loader's own floor is 2007**
#'   (earlier seasons don't exist upstream), while most other `nba_stats_*`
#'   loaders floor at 1996. Coverage runs through the most recent season with
#'   no gaps. Pass `seasons = TRUE` for every published season for this loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of 5-man lineup season stats (182
#'   columns: standard box-score rate/counting stats plus the 5 player-id
#'   slots and `group_id`/`group_name`). See `names(load_nba_stats_lineups())`
#'   for the full column set, or the `lineups_base` table of
#'   [load_nba_stats_leaguedash()] for the equivalent parameter-cube asset.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_lineups(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_lineups <- function(seasons = most_recent_nba_stats_season(),
                                   ...,
                                   dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  # Lineup publication starts at the 2007-08 season (file suffix 2008) --
  # earlier seasons don't exist upstream, so expanding `seasons = TRUE` from
  # 1996 would issue eleven guaranteed-404 downloads.
  if (isTRUE(seasons)) seasons <- 2007:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2007),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_lineups/lineups_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API game officials from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads game-level officials data scraped from the NBA Stats
#'   API (`boxscoresummaryv2`-style outputs). One row per official-game pair.
#'   Backed by the `hoopR-nba-stats-data` pipeline that publishes
#'   csv/parquet/rds artifacts to the `nba_stats_officials` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per official-game pair.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |official_id |integer |Unique official / referee identifier. |
#'    |first_name |character |Official's first name. |
#'    |last_name |character |Official's last name. |
#'    |jersey_num |character |Jersey number worn by the official. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |game_id |character |Unique game identifier. |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_officials(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_officials <- function(seasons = most_recent_nba_stats_season(),
                                     ...,
                                     dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_officials/officials_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API play-by-play from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA play-by-play scraped from the NBA
#'   Stats API modern game-feed. One row per play-by-play action, with shot
#'   location, on/off-court lineup joins available via
#'   [load_nba_stats_game_lineups()]. Backed by the `hoopR-nba-stats-data`
#'   pipeline that publishes csv.gz/parquet/rds artifacts to the
#'   `nba_stats_pbp` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of per-event play-by-play rows.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |order_index |integer |Play-by-play chronological order index within the game. |
#'    |action_number |integer |Sequential play-by-play action number within the game. |
#'    |clock |character |Game clock remaining in the period. |
#'    |period |integer |Period of the game (1-4 quarters; 5+ for OT). |
#'    |team_id |integer |Unique NBA Stats team identifier for the acting team. |
#'    |team_tricode |character |Three-letter team code. |
#'    |person_id |integer |Unique player identifier for the acting player. |
#'    |player_name |character |Acting player's name. |
#'    |player_name_i |character |Acting player's name with abbreviated first initial. |
#'    |x_legacy |integer |Legacy X coordinate on the court (0 = basket center). |
#'    |y_legacy |integer |Legacy Y coordinate on the court (baseline at 0). |
#'    |shot_distance |integer |Shot distance from the basket, in feet (shot events only). |
#'    |shot_result |character |Shot result, 'Made' or 'Missed' (shot events only). |
#'    |is_field_goal |integer |Whether the action is a field goal attempt (1) or not (0). |
#'    |score_home |character |Home team score after the play. |
#'    |score_away |character |Away team score after the play. |
#'    |points_total |integer |Points scored on the action, if any. |
#'    |location |character |Court location code for the action. |
#'    |description |character |Text description of the play. |
#'    |action_type |character |Action type label (e.g. 'Made Shot', 'Missed Shot', 'Rebound'). |
#'    |sub_type |character |Sub type of the action (e.g. 'Jump Shot', 'Layup'). |
#'    |video_available |integer |Whether NBA Stats video is available for the action. |
#'    |shot_value |integer |Points the shot was worth, 2 or 3 (shot events only). |
#'    |action_id |integer |Unique play-by-play action identifier. |
#'    |game_id |character |Unique game identifier. |
#'    |seconds_remaining |numeric |Seconds remaining in the period at the action. |
#'    |event_type |character |Normalized event type label. |
#'    |is_made_shot |logical |Whether the action is a made shot. |
#'    |is_missed_shot |logical |Whether the action is a missed shot. |
#'    |is_free_throw |logical |Whether the action is a free throw. |
#'    |is_rebound |logical |Whether the action is a rebound. |
#'    |is_turnover |logical |Whether the action is a turnover. |
#'    |is_foul |logical |Whether the action is a foul. |
#'    |is_substitution |logical |Whether the action is a substitution. |
#'    |is_jump_ball |logical |Whether the action is a jump ball. |
#'    |is_timeout |logical |Whether the action is a timeout. |
#'    |is_period |logical |Whether the action is a period-boundary marker. |
#'    |possession_number |integer |Sequential possession number within the game. |
#'    |off_player_1 |integer |Offensive on-court lineup slot 1 player identifier. |
#'    |off_player_2 |integer |Offensive on-court lineup slot 2 player identifier. |
#'    |off_player_3 |integer |Offensive on-court lineup slot 3 player identifier. |
#'    |off_player_4 |integer |Offensive on-court lineup slot 4 player identifier. |
#'    |off_player_5 |integer |Offensive on-court lineup slot 5 player identifier. |
#'    |def_player_1 |integer |Defensive on-court lineup slot 1 player identifier. |
#'    |def_player_2 |integer |Defensive on-court lineup slot 2 player identifier. |
#'    |def_player_3 |integer |Defensive on-court lineup slot 3 player identifier. |
#'    |def_player_4 |integer |Defensive on-court lineup slot 4 player identifier. |
#'    |def_player_5 |integer |Defensive on-court lineup slot 5 player identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_pbp(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_pbp <- function(seasons = most_recent_nba_stats_season(),
                               ...,
                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_pbp/nba_play_by_play_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API player box scores from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads per-player per-game box scores scraped from the NBA
#'   Stats API `boxscoretraditionalv3`-style output. One row per
#'   athlete-game pair. Backed by the `hoopR-nba-stats-data` pipeline that
#'   publishes csv/parquet/rds artifacts to the `nba_stats_player_boxscores`
#'   release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per athlete-game pair.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |team_name |character |Full team display name. |
#'    |team_tricode |character |Three-letter team code. |
#'    |side |character |Whether the team was 'home' or 'away'. |
#'    |person_id |integer |Unique player identifier. |
#'    |first_name |character |Player's first name. |
#'    |family_name |character |Player's family (last) name. |
#'    |name_i |character |Player's name with abbreviated first initial. |
#'    |player_slug |character |URL-safe player name slug. |
#'    |position |character |Player's roster position. |
#'    |comment |character |Reason the player did not play, if applicable (e.g. 'DND - Injury'). |
#'    |jersey_num |character |Jersey number worn by the player. |
#'    |minutes |character |Minutes played, as an `MM:SS` string. |
#'    |field_goals_made |integer |Field goals made. |
#'    |field_goals_attempted |integer |Field goal attempts. |
#'    |field_goals_percentage |numeric |Field goal percentage (0-1). |
#'    |three_pointers_made |integer |Three-point field goals made. |
#'    |three_pointers_attempted |integer |Three-point field goal attempts. |
#'    |three_pointers_percentage |numeric |Three-point field goal percentage (0-1). |
#'    |free_throws_made |integer |Free throws made. |
#'    |free_throws_attempted |integer |Free throw attempts. |
#'    |free_throws_percentage |numeric |Free throw percentage (0-1). |
#'    |rebounds_offensive |integer |Offensive rebounds. |
#'    |rebounds_defensive |integer |Defensive rebounds. |
#'    |rebounds_total |integer |Total rebounds. |
#'    |assists |integer |Assists. |
#'    |steals |integer |Steals. |
#'    |blocks |integer |Blocks. |
#'    |turnovers |integer |Turnovers. |
#'    |fouls_personal |integer |Personal fouls. |
#'    |points |integer |Points scored. |
#'    |plus_minus_points |numeric |Plus/minus point differential while on court. |
#'    |game_id |character |Unique game identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_player_boxscores(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_player_boxscores <- function(seasons = most_recent_nba_stats_season(),
                                            ...,
                                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_player_boxscores/player_boxscores_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API per-player per-game logs from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads per-player per-game logs scraped from
#'   `stats.nba.com/leaguegamelog?PlayerOrTeam=P` (one row per
#'   athlete-game pair: minutes, shooting splits, rebounds, steals, blocks,
#'   turnovers, personal fouls, plus/minus). Backed by the
#'   `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds
#'   artifacts to the `nba_stats_player_game_logs` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of per-athlete per-game log rows.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |season_id |character |Unique season identifier string. |
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |team_abbreviation |character |Three-letter team abbreviation. |
#'    |team_name |character |Full team display name. |
#'    |game_id |character |Unique game identifier. |
#'    |game_date |character |Date the game was played, as an ISO 'YYYY-MM-DD' string. |
#'    |matchup |character |Matchup string, e.g. 'BOS vs. NYK' or 'BOS @ NYK'. |
#'    |wl |character |Game result, 'W' or 'L'. |
#'    |min |integer |Minutes played. |
#'    |fgm |integer |Field goals made. |
#'    |fga |integer |Field goal attempts. |
#'    |fg_pct |numeric |Field goal percentage (0-1). |
#'    |fg3m |integer |Three-point field goals made. |
#'    |fg3a |integer |Three-point field goal attempts. |
#'    |fg3_pct |numeric |Three-point field goal percentage (0-1). |
#'    |ftm |integer |Free throws made. |
#'    |fta |integer |Free throw attempts. |
#'    |ft_pct |numeric |Free throw percentage (0-1). |
#'    |oreb |integer |Offensive rebounds. |
#'    |dreb |integer |Defensive rebounds. |
#'    |reb |integer |Total rebounds. |
#'    |ast |integer |Assists. |
#'    |stl |integer |Steals. |
#'    |blk |integer |Blocks. |
#'    |tov |integer |Turnovers. |
#'    |pf |integer |Personal fouls. |
#'    |pts |integer |Points scored. |
#'    |plus_minus |integer |Plus/minus point differential while on court. |
#'    |video_available |integer |Whether NBA Stats video is available for the game. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |season_type |character |Portion of the season (e.g. 'Regular Season', 'Playoffs'). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_player_game_logs(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_player_game_logs <- function(seasons = most_recent_nba_stats_season(),
                                            ...,
                                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_player_game_logs/player_game_logs_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API player season stats from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA player statistics
#'   (`leaguedashplayerstats`-style outputs, `Base` measure). Backed by the
#'   `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds
#'   artifacts to the `nba_stats_player_season_stats` release tag. For
#'   `Advanced`/`Misc`/`Scoring`/`Usage`/`Defense` measures and player
#'   tracking (drives, passing, touches, speed/distance, etc.), use
#'   [load_nba_stats_leaguedash()] with `table = "player_stats_*"` or
#'   `table = "player_tracking_*"`.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of player season stats (210
#'   columns: rank fields, bio fields, and standard/rank box-score
#'   rate/counting stats for the season). See
#'   `names(load_nba_stats_player_season_stats())` for the full column set,
#'   or the `player_stats_base` table of [load_nba_stats_leaguedash()] for
#'   the equivalent parameter-cube asset.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_player_season_stats(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_player_season_stats <- function(seasons = most_recent_nba_stats_season(),
                                               ...,
                                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_player_season_stats/player_season_stats_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API possessions from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads possession-level data derived from the NBA Stats API
#'   play-by-play -- one row per possession, with the on-court 5-man
#'   lineups for both teams, shooting/rebounding/turnover splits, and the
#'   possession start type. Backed by the `hoopR-nba-stats-data` pipeline
#'   that publishes csv.gz/parquet/rds artifacts to the
#'   `nba_stats_possessions` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per possession.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |game_id |character |Unique game identifier. |
#'    |period |integer |Period of the game (1-4 quarters; 5+ for OT). |
#'    |possession_number |integer |Sequential possession number within the game. |
#'    |offense_team_id |integer |Team identifier for the team on offense. |
#'    |defense_team_id |integer |Team identifier for the team on defense. |
#'    |start_order_index |integer |Play-by-play order index at the start of the possession. |
#'    |end_order_index |integer |Play-by-play order index at the end of the possession. |
#'    |start_seconds_remaining |numeric |Seconds remaining in the period at possession start. |
#'    |end_seconds_remaining |numeric |Seconds remaining in the period at possession end. |
#'    |points |integer |Points scored on the possession. |
#'    |is_second_chance |logical |Whether the possession followed an offensive rebound. |
#'    |number_in_period |integer |Sequential possession number within the period. |
#'    |possession_start_type |character |How the possession started (e.g. 'OffDeadball', 'OffRebound'). |
#'    |count_as_possession |logical |Whether the event counts as a scoreable possession. |
#'    |fg2a |integer |2-point field goal attempts by the lineup. |
#'    |fg2m |integer |2-point field goals made by the lineup. |
#'    |fg3a |integer |3-point field goal attempts by the lineup. |
#'    |fg3m |integer |3-point field goals made by the lineup. |
#'    |fta |integer |Free throw attempts by the lineup. |
#'    |ftm |integer |Free throws made by the lineup. |
#'    |oreb |integer |Offensive rebounds. |
#'    |dreb |integer |Defensive rebounds. |
#'    |tov |integer |Turnovers. |
#'    |off_player_1 |integer |Offensive lineup slot 1 player identifier. |
#'    |off_player_2 |integer |Offensive lineup slot 2 player identifier. |
#'    |off_player_3 |integer |Offensive lineup slot 3 player identifier. |
#'    |off_player_4 |integer |Offensive lineup slot 4 player identifier. |
#'    |off_player_5 |integer |Offensive lineup slot 5 player identifier. |
#'    |def_player_1 |integer |Defensive lineup slot 1 player identifier. |
#'    |def_player_2 |integer |Defensive lineup slot 2 player identifier. |
#'    |def_player_3 |integer |Defensive lineup slot 3 player identifier. |
#'    |def_player_4 |integer |Defensive lineup slot 4 player identifier. |
#'    |def_player_5 |integer |Defensive lineup slot 5 player identifier. |
#'    |lineup_source |character |Provenance of the lineup join (e.g. 'game_lineups', 'derived'). |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_possessions(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_possessions <- function(seasons = most_recent_nba_stats_season(),
                                       ...,
                                       dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_possessions/nba_possessions_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API season rosters from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA team rosters scraped from the NBA
#'   Stats API. One row per athlete-team-season triple. Backed by the
#'   `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds
#'   artifacts to the `nba_stats_rosters` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per athlete-team-season.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |league_id |character |League identifier ('00' for NBA). |
#'    |player |character |Player's full name. |
#'    |nickname |character |Player's nickname. |
#'    |player_slug |character |URL-safe player name slug. |
#'    |num |character |Jersey number worn by the player. |
#'    |position |character |Player's roster position. |
#'    |height |character |Player's listed height (feet-inches). |
#'    |weight |character |Player's listed weight (lbs). |
#'    |birth_date |character |Player's date of birth. |
#'    |age |numeric |Player's age. |
#'    |exp |character |Years of NBA experience ('R' for rookie). |
#'    |school |character |Player's last college / school attended. |
#'    |player_id |integer |Unique player identifier. |
#'    |how_acquired |character |How the player joined the roster (e.g. 'Draft', 'Trade'). |
#'    |supplemental_status |integer |Roster supplemental / two-way status flag. |
#'    |season_type |character |Portion of the season (e.g. 'Regular Season', 'Playoffs'). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_rosters(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_rosters <- function(seasons = most_recent_nba_stats_season(),
                                   ...,
                                   dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_rosters/rosters_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API season schedules from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA schedules scraped from
#'   `stats.nba.com/leaguegamefinder` (regular season + playoffs combined,
#'   pre-rejoined home/away). Backed by the `hoopR-nba-stats-data` pipeline
#'   that publishes csv/parquet/rds artifacts to the `nba_stats_schedules`
#'   release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of per-season schedules, one row per
#'   game with the home/away sides pre-joined into `home_*` / `away_*` columns.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |game_id |character |Unique game identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |season_type |character |Portion of the season (e.g. 'Regular Season', 'Playoffs'). |
#'    |game_date |character |Date the game was played, as an ISO 'YYYY-MM-DD' string. |
#'    |matchup |character |Matchup string, home side first (e.g. 'BOS vs. NYK'). |
#'    |home_team_id |integer |Unique NBA Stats team identifier for the home team. |
#'    |home_team_abbreviation |character |Home team abbreviation. |
#'    |home_team_name |character |Home team full name. |
#'    |home_pts |integer |Points scored by the home team. |
#'    |home_wl |character |Home team result, 'W' or 'L'. |
#'    |away_team_id |integer |Unique NBA Stats team identifier for the away team. |
#'    |away_team_abbreviation |character |Away team abbreviation. |
#'    |away_team_name |character |Away team full name. |
#'    |away_pts |integer |Points scored by the away team. |
#'    |away_wl |character |Away team result, 'W' or 'L'. |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_schedule(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_schedule <- function(seasons = most_recent_nba_stats_season(),
                                    ...,
                                    dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_schedules/nba_schedule_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API shot events from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads shot events scraped from the NBA Stats API. One row
#'   per shot attempt with legacy court coordinates, action/sub type,
#'   distance, and made/missed result, carried through from the play-by-play
#'   feed (not `shotchartdetail`). Backed by the `hoopR-nba-stats-data`
#'   pipeline that publishes csv/parquet/rds artifacts to the
#'   `nba_stats_shots` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per shot attempt.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |game_id |character |Unique game identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'    |period |integer |Period of the game (1-4 quarters; 5+ for OT). |
#'    |clock |character |Game clock remaining in the period. |
#'    |team_id |integer |Unique NBA Stats team identifier for the shooting team. |
#'    |team_tricode |character |Three-letter team code (e.g. 'BOS' / 'NYK'). |
#'    |person_id |integer |Unique player identifier for the shooter. |
#'    |player_name |character |Shooter's name. |
#'    |action_type |character |Action type label ('Made Shot' or 'Missed Shot'). |
#'    |sub_type |character |Shot sub type (e.g. 'Jump Shot', 'Layup', 'Dunk'). |
#'    |shot_result |character |Shot result, 'Made' or 'Missed'. |
#'    |shot_value |integer |Points the shot was worth (2 or 3). |
#'    |shot_distance |integer |Shot distance from the basket, in feet. |
#'    |x_legacy |integer |Legacy X coordinate on the court (0 = basket center). |
#'    |y_legacy |integer |Legacy Y coordinate on the court (baseline at 0). |
#'    |description |character |Text description of the play. |
#'    |score_home |character |Home team score after the play. |
#'    |score_away |character |Away team score after the play. |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_shots(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_shots <- function(seasons = most_recent_nba_stats_season(),
                                 ...,
                                 dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_shots/shots_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API season standings from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level NBA standings (`leaguestandingsv3`-style
#'   outputs). One row per team-season. Backed by the `hoopR-nba-stats-data`
#'   pipeline that publishes csv/parquet/rds artifacts to the
#'   `nba_stats_standings` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of team standings (94 columns: win/
#'   loss splits by home/road/conference/division/last-10, streak fields,
#'   and points-per-game aggregates). See
#'   `names(load_nba_stats_standings())` for the full column set. The
#'   `standings` table of [load_nba_stats_leaguedash()] is the equivalent
#'   parameter-cube asset (same underlying `leaguestandingsv3` endpoint).
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_standings(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_standings <- function(seasons = most_recent_nba_stats_season(),
                                     ...,
                                     dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_standings/standings_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API team box scores from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads per-team per-game box scores scraped from the NBA
#'   Stats API `boxscoretraditionalv3`-style output. One row per team-game
#'   pair. Backed by the `hoopR-nba-stats-data` pipeline that publishes
#'   csv/parquet/rds artifacts to the `nba_stats_team_boxscores` release tag.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per team-game pair.
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |team_id |integer |Unique NBA Stats team identifier. |
#'    |team_name |character |Full team display name. |
#'    |team_tricode |character |Three-letter team code. |
#'    |side |character |Whether the team was 'home' or 'away'. |
#'    |minutes |character |Total minutes played, as an `MM:SS` string. |
#'    |field_goals_made |integer |Field goals made. |
#'    |field_goals_attempted |integer |Field goal attempts. |
#'    |field_goals_percentage |numeric |Field goal percentage (0-1). |
#'    |three_pointers_made |integer |Three-point field goals made. |
#'    |three_pointers_attempted |integer |Three-point field goal attempts. |
#'    |three_pointers_percentage |numeric |Three-point field goal percentage (0-1). |
#'    |free_throws_made |integer |Free throws made. |
#'    |free_throws_attempted |integer |Free throw attempts. |
#'    |free_throws_percentage |numeric |Free throw percentage (0-1). |
#'    |rebounds_offensive |integer |Offensive rebounds. |
#'    |rebounds_defensive |integer |Defensive rebounds. |
#'    |rebounds_total |integer |Total rebounds. |
#'    |assists |integer |Assists. |
#'    |steals |integer |Steals. |
#'    |blocks |integer |Blocks. |
#'    |turnovers |integer |Turnovers. |
#'    |fouls_personal |integer |Personal fouls. |
#'    |points |integer |Points scored. |
#'    |plus_minus_points |numeric |Plus/minus point differential. |
#'    |game_id |character |Unique game identifier. |
#'    |season |integer |Season identifier (4-digit year, END year of the season). |
#'
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_team_boxscores(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_team_boxscores <- function(seasons = most_recent_nba_stats_season(),
                                          ...,
                                          dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_team_boxscores/team_boxscores_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA Stats API team season stats from the data repo**
#' @rdname load_nba_stats_coaches
#' @description Loads season-level team statistics
#'   (`leaguedashteamstats`-style outputs, `Base` measure). Backed by the
#'   `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds
#'   artifacts to the `nba_stats_team_season_stats` release tag. For
#'   `Advanced`/`Misc`/`Scoring`/`Defense`/`Opponent`/`Four Factors`
#'   measures, use [load_nba_stats_leaguedash()] with `table = "team_stats_*"`.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of team season stats (178 columns:
#'   rank fields plus standard/rank box-score rate/counting stats for the
#'   season). See `names(load_nba_stats_team_season_stats())` for the full
#'   column set, or the `team_stats_base` table of
#'   [load_nba_stats_leaguedash()] for the equivalent parameter-cube asset.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_team_season_stats(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_team_season_stats <- function(seasons = most_recent_nba_stats_season(),
                                             ...,
                                             dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_team_season_stats/team_season_stats_", seasons + 1, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load hoopR NBA Stats League Dashboard cube**
#' @name load_nba_stats_leaguedash
NULL

#' Valid `table` values for [load_nba_stats_leaguedash()].
#' @keywords Internal
#' @noRd
nba_stats_leaguedash_tables <- c(
  "player_bio", "player_master",
  "player_stats_base", "player_stats_advanced", "player_stats_misc",
  "player_stats_scoring", "player_stats_usage", "player_stats_defense",
  "player_tracking_catchshoot", "player_tracking_defense",
  "player_tracking_drives", "player_tracking_efficiency",
  "player_tracking_elbowtouch", "player_tracking_painttouch",
  "player_tracking_passing", "player_tracking_possessions",
  "player_tracking_posttouch", "player_tracking_pullupshot",
  "player_tracking_rebounding", "player_tracking_speeddistance",
  "team_master",
  "team_stats_base", "team_stats_advanced", "team_stats_misc",
  "team_stats_scoring", "team_stats_defense", "team_stats_opponent",
  "team_stats_fourfactors",
  "lineups_master",
  "lineups_base", "lineups_advanced", "lineups_misc",
  "lineups_scoring", "lineups_opponent", "lineups_fourfactors",
  "standings"
)

#' @title
#' **Load a single table of the NBA Stats league dashboard cube**
#' @rdname load_nba_stats_leaguedash
#' @description Loads one asset of the `nba_stats_leaguedash` release tag --
#'   the parameter cube that supersedes the narrower `Base`-measure tags
#'   ([load_nba_stats_player_season_stats()], [load_nba_stats_team_season_stats()],
#'   [load_nba_stats_lineups()], [load_nba_stats_standings()]). The cube
#'   publishes 36 tables per season and is the only route to
#'   `Advanced`/`Misc`/`Scoring`/`Usage`/`Defense`/`Opponent`/`Four Factors`
#'   measures, 2/3/4-man lineup groupings, the `*_bio`/`*_master` wide joins,
#'   and player tracking (drives, passing, touches, catch-and-shoot,
#'   pull-up shooting, rebounding, speed/distance).
#'
#'   Coverage floors differ by table and are **not** individually enforced
#'   here (only the global 1996 floor is): the `lineups_*` tables start at
#'   the 2007-08 season and the `player_tracking_*` tables (other than
#'   `catchshoot`/`pullupshot`, which go back to 1996) start at the 2013-14
#'   season. Requesting an out-of-range season for those tables 404s
#'   gracefully with a warning and contributes no rows, same as any other
#'   `nba_stats_*` loader.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage runs 1996
#'   through the most recent season for most tables (see Description for
#'   per-table floors). Pass `seasons = TRUE` for every published season.
#'   (Min: 1996)
#' @param table Name of the cube table to load. One of `player_bio`,
#'   `player_master`, `player_stats_base`, `player_stats_advanced`,
#'   `player_stats_misc`, `player_stats_scoring`, `player_stats_usage`,
#'   `player_stats_defense`, `player_tracking_catchshoot`,
#'   `player_tracking_defense`, `player_tracking_drives`,
#'   `player_tracking_efficiency`, `player_tracking_elbowtouch`,
#'   `player_tracking_painttouch`, `player_tracking_passing`,
#'   `player_tracking_possessions`, `player_tracking_posttouch`,
#'   `player_tracking_pullupshot`, `player_tracking_rebounding`,
#'   `player_tracking_speeddistance`, `team_master`, `team_stats_base`,
#'   `team_stats_advanced`, `team_stats_misc`, `team_stats_scoring`,
#'   `team_stats_defense`, `team_stats_opponent`, `team_stats_fourfactors`,
#'   `lineups_master`, `lineups_base`, `lineups_advanced`, `lineups_misc`,
#'   `lineups_scoring`, `lineups_opponent`, `lineups_fourfactors`,
#'   `standings`.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble of the requested cube table, one
#'   row per player-season, team-season or lineup-season depending on
#'   `table`. Column sets differ per table (11 to 625 columns); the
#'   `*_master` tables are wide joins of every measure type for that entity.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_leaguedash(seasons = most_recent_nba_stats_season(),
#'                                 table = "player_bio"))
#' }
load_nba_stats_leaguedash <- function(seasons = most_recent_nba_stats_season(),
                                      table = NULL,
                                      ...,
                                      dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  if (is.null(table) || length(table) != 1 ||
      !table %in% nba_stats_leaguedash_tables) {
    cli::cli_abort(c(
      "x" = "{.arg table} must be exactly one of the published cube tables.",
      "i" = "Valid choices: {.val {nba_stats_leaguedash_tables}}."
    ))
  }

  loader <- parquet_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1996:most_recent_nba_stats_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1996),
            all(seasons <= most_recent_nba_stats_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_stats_leaguedash/", table, "_", seasons + 1, ".parquet"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Build/update hoopR NBA Stats database**
#' @name update_nba_stats_db
NULL

#' @title
#' **Update or create a hoopR NBA Stats database**
#' @rdname update_nba_stats_db
#' @description `update_nba_stats_db()` writes one or more NBA Stats API
#'   datasets into a database. Mirrors the NBA / MBB `update_*_db()` shape
#'   but points at the `load_nba_stats_*` family. Each dataset is written
#'   to its own table, named `nba_stats_<dataset>`.
#' @details
#' Unlike `update_nba_db()`, there is no historical "play-by-play table"
#' default to preserve, so `datasets` is required.
#'
#' Valid `datasets` values:
#' `"coaches"`, `"draft"`, `"game_lineups"`, `"game_rosters"`, `"lineups"`,
#' `"officials"`, `"pbp"`, `"player_boxscores"`, `"player_game_logs"`,
#' `"player_season_stats"`, `"possessions"`, `"rosters"`, `"schedule"`,
#' `"shots"`, `"standings"`, `"team_boxscores"`, `"team_season_stats"`.
#'
#' @param dbdir Directory in which the database is or shall be located.
#' @param dbname File name of an existing or desired SQLite database within
#'   `dbdir`.
#' @param datasets Character vector of dataset shortnames (see Details).
#' @param seasons Optional integer vector of seasons to load. Defaults to all
#'   available seasons (`seasons = TRUE`).
#' @param db_connection A `DBIConnection` object. When supplied, `dbdir` and
#'   `dbname` are ignored.
#' @return Invisibly returns `TRUE` on success.
#' @export
update_nba_stats_db <- function(dbdir = ".",
                                dbname = "hoopR_db",
                                datasets = NULL,
                                seasons = TRUE,
                                db_connection = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  if (!is_installed("DBI") |
      (!is_installed("RSQLite") & is.null(db_connection))) {
    cli::cli_abort(c(
      "x" = "Packages {.pkg DBI} and {.pkg RSQLite} required for database communication.",
      "i" = "Install them and retry."
    ))
  }

  valid <- c("coaches", "draft", "game_lineups", "game_rosters", "lineups",
             "officials", "pbp", "player_boxscores", "player_game_logs",
             "player_season_stats", "possessions", "rosters", "schedule",
             "shots", "standings", "team_boxscores", "team_season_stats")
  if (is.null(datasets) || length(datasets) == 0) {
    cli::cli_abort(c(
      "x" = "{.arg datasets} is required for {.fn update_nba_stats_db}.",
      "i" = "Valid choices: {.val {valid}}."
    ))
  }
  bad <- setdiff(datasets, valid)
  if (length(bad) > 0) {
    cli::cli_abort(c(
      "x" = "Unknown {.arg datasets} value{?s}: {.val {bad}}.",
      "i" = "Valid choices: {.val {valid}}."
    ))
  }

  if (!dir.exists(dbdir) & is.null(db_connection)) {
    user_message(paste0("Directory '", dbdir, "' doesn't exist yet. Try creating..."), "oops")
    dir.create(dbdir)
  }

  if (is.null(db_connection)) {
    connection <- DBI::dbConnect(RSQLite::SQLite(), file.path(dbdir, dbname))
  } else {
    connection <- db_connection
  }

  loader_map <- list(
    coaches              = load_nba_stats_coaches,
    draft                = load_nba_stats_draft,
    game_lineups         = load_nba_stats_game_lineups,
    game_rosters         = load_nba_stats_game_rosters,
    lineups              = load_nba_stats_lineups,
    officials            = load_nba_stats_officials,
    pbp                  = load_nba_stats_pbp,
    player_boxscores     = load_nba_stats_player_boxscores,
    player_game_logs     = load_nba_stats_player_game_logs,
    player_season_stats  = load_nba_stats_player_season_stats,
    possessions          = load_nba_stats_possessions,
    rosters              = load_nba_stats_rosters,
    schedule             = load_nba_stats_schedule,
    shots                = load_nba_stats_shots,
    standings            = load_nba_stats_standings,
    team_boxscores       = load_nba_stats_team_boxscores,
    team_season_stats    = load_nba_stats_team_season_stats
  )

  for (ds in datasets) {
    ds_table <- paste0("nba_stats_", ds)
    user_message(paste0("Writing nba_stats dataset '", ds, "' to table '", ds_table, "'..."), "todo")
    tryCatch(
      loader_map[[ds]](seasons = seasons,
                       dbConnection = connection,
                       tablename = ds_table),
      error = function(e) {
        cli::cli_alert_danger("{Sys.time()}: dataset {.val {ds}} failed: {e$message}")
      }
    )
  }

  message_completed("Database update completed", in_builder = TRUE)
  user_message(paste0("Path to your db: ", DBI::dbGetInfo(connection)$dbname), "info")
  if (is.null(db_connection)) DBI::dbDisconnect(connection)
  invisible(TRUE)
}
