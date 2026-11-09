# -----------------------------------------------------------------------------
# NBA Stats API release-dataset loaders
# -----------------------------------------------------------------------------
# Thin wrappers around rds_from_url() / parquet_from_url() that read the
# hoopR-nba-stats-data pipeline's published sportsdataverse-data release
# assets (the `nba_stats_*` tag family). Mirrors the shape of wehoop's
# R/load_wnba_stats.R (post-#78 dots-forwarding + update_*_db registration).
#
# Season convention: `seasons` here is the season's START year (e.g. `2024`
# for the 2024-25 season) -- matching sportsdataverse-py's `load_nba_stats_*` Python
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
#'   (e.g. `2024` for the 2024-25 season), matching sportsdataverse-py's `load_nba_stats_*`
#'   convention (see the file-level note in `R/load_nba_stats.R`). Published
#'   coverage floors vary by loader (1996 for most; 2007 for
#'   [load_nba_stats_lineups()] -- see that function's own Description) and
#'   run through the most recent season with no gaps. Pass `seasons = TRUE`
#'   for every published season for that specific loader.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_coaches", unit = "coach-team-season")
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_draft", unit = "pick")
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_game_lineups", unit = "play-by-play action")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_game_rosters", unit = "inactive athlete-game pair")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_officials", unit = "official-game pair")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_pbp", unit = "play-by-play action")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~19 MB download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_player_boxscores", unit = "athlete-game pair")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_player_game_logs", unit = "athlete-game pair")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_possessions", unit = "possession")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_rosters", unit = "athlete-team-season")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_schedule", unit = "game")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_shots", unit = "shot attempt")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_team_boxscores", unit = "team-game pair")
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: this help page holds 17 loaders, each a download.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @param dbdir Directory in which the database is or shall be located. Defaults to
#'   the per-user data directory `tools::R_user_dir("hoopR", "data")`, so nothing is
#'   written to the working directory unless you ask for it (`dbdir = "."`).
#' @param dbname File name of an existing or desired SQLite database within
#'   `dbdir`.
#' @param datasets Character vector of dataset shortnames (see Details).
#' @param seasons Optional integer vector of seasons to load. Defaults to all
#'   available seasons (`seasons = TRUE`).
#' @param db_connection A `DBIConnection` object. When supplied, `dbdir` and
#'   `dbname` are ignored.
#' @return Invisibly returns `TRUE` on success.
#' @export
update_nba_stats_db <- function(dbdir = tools::R_user_dir("hoopR", "data"),
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
    user_message(paste0("Creating database directory '", dbdir, "'"), "info")
    dir.create(dbdir, recursive = TRUE)
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
