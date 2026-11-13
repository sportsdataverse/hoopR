#' **Load hoopR NBA play-by-play**
#' @name load_nba_pbp
NULL
#' @title
#' **Load cleaned NBA play-by-play from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given NBA seasons, or
#'   `TRUE` for every published season. Each loader accepts only the seasons its
#'   release tag publishes (any other season is an error):
#'   * `load_nba_team_box()`, `load_nba_player_box()`, `load_nba_schedule()`,
#'     `load_nba_player_stats()`, `load_nba_player_core()`, `load_nba_game_rosters()`,
#'     `load_nba_officials()`, `load_nba_team_stats()`: 1994 onward.
#'   * `load_nba_pbp()`, `load_nba_shots()`, `load_nba_standings()`: 2002 onward.
#'   * `load_nba_draft()`: 2003 onward.
#'   * `load_nba_rosters()`: 2025 onward.
#'
#'   The upper bound is [most_recent_nba_season()]. When `seasons` is left at
#'   its default and that season's file is not published yet, the loader reads
#'   the newest published season instead, with a message. An explicit request
#'   for that not-yet-published season is kept as asked: the read warns and
#'   returns an empty frame. A season outside the published range, or in a
#'   known gap, is an error.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @details
#' The play `id` is returned as character, matching [espn_nba_pbp()].
#' `load_nba_pbp()` reads the `.parquet` release asset (exact 64-bit ids) when the
#' \pkg{arrow} package is installed and the `.rds` asset otherwise.
#'
#' ESPN join ids are integer in every loader, as they are in the box scores and
#' schedules: `load_nba_game_rosters()` casts `game_id`, and `load_nba_rosters()`
#' casts `athlete_id`, both of which the release publishes as character.
#' @eval .returns_rd("load_nba_pbp", unit = "play-by-play event")
#' @source The `espn_nba_pbp` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_pbp>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_nba_pbp(seasons = most_recent_nba_season())
#' }
load_nba_pbp <- function(seasons = most_recent_nba_season(), ...,
                         dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  loader <- function(url) pbp_from_url(url, "ESPN NBA pbp from hoopR data repository")

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_pbp/play_by_play_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 2002, most_recent_nba_season(), fn = "load_nba_pbp", url_for = url_for, default = missing(seasons), parquet = TRUE)

  # pbp_from_url() appends .parquet or .rds itself
  urls <- sub("\\.rds$", "", url_for(seasons))

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA team box scores from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @eval .returns_rd("load_nba_team_box", unit = "team-game")
#' @source The `espn_nba_team_boxscores` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_team_boxscores>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_nba_team_box(seasons = most_recent_nba_season())
#' }
load_nba_team_box <- function(seasons = most_recent_nba_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_boxscores/team_box_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_team_box", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA player box scores from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @eval .returns_rd("load_nba_player_box", unit = "player-game")
#' @source The `espn_nba_player_boxscores` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_boxscores>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_nba_player_box(seasons = most_recent_nba_season())
#' }
load_nba_player_box <- function(seasons = most_recent_nba_season(), ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_boxscores/player_box_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_player_box", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA schedules from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @eval .returns_rd("load_nba_schedule", unit = "game")
#' @source The `espn_nba_schedules` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_schedules>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_nba_schedule(seasons = most_recent_nba_season())
#' }
load_nba_schedule <- function(seasons = most_recent_nba_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_schedules/nba_schedule_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_schedule", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

# load games file
.nba_games_index_url <- "https://raw.githubusercontent.com/sportsdataverse/hoopR-data/main/nba/nba_games_in_data_repo.csv"
load_nba_games <- function(strict = FALSE) {
  .release_csv_from_url(.nba_games_index_url, strict = strict)
}

#' **Update or create a hoopR NBA play-by-play database**
#' @name update_nba_db
NULL
#' @title
#' **Update or create a hoopR NBA play-by-play database**
#' @rdname update_nba_db
#' @description `update_nba_db()` updates or creates a database with `hoopR`
#' play by play data of all completed and available games since 2002.
#'
#' @details This function creates and updates a data table with the name `tblname`
#' within a SQLite database (other drivers via `db_connection`) located in
#' `dbdir` and named `dbname`.
#' The data table combines all play by play data for every available game back
#' to the 2002 season and adds the most recent completed games as soon as they
#' are available for `hoopR`.
#'
#' The argument `force_rebuild` is of hybrid type. It can rebuild the play
#' by play data table either for the whole hoopR era (with `force_rebuild = TRUE`)
#' or just for specified seasons (e.g. `force_rebuild = c(2019, 2020)`).
#' Please note the following behavior:
#'
#'  - `force_rebuild = TRUE`: The data table with the name `tblname`
#'   will be removed completely and rebuilt from scratch. This is helpful when
#'   new columns are added during the Off-Season.
#'  - `force_rebuild = c(2019, 2020)`: The data table with the name `tblname`
#'  will be preserved and only rows from the 2019 and 2020 seasons will be
#'  deleted and re-added. This is intended to be used for ongoing seasons because
#'  ESPN's data provider can make changes to the underlying data during the week.
#'
#'
#' The parameter `db_connection` is intended for advanced users who want
#' to use other DBI drivers, such as MariaDB, Postgres or odbc. Please note that
#' the arguments `dbdir` and `dbname` are dropped in case a `db_connection`
#' is provided but the argument `tblname` will still be used to write the
#' data table into the database.
#'
#' @param dbdir Directory in which the database is or shall be located. Defaults to
#'   the per-user data directory `tools::R_user_dir("hoopR", "data")`, so nothing is
#'   written to the working directory unless you ask for it (`dbdir = "."`).
#' @param dbname File name of an existing or desired SQLite database within `dbdir`
#' @param tblname The name of the play by play data table within the database
#' @param force_rebuild Hybrid parameter (logical or numeric) to rebuild parts
#' of or the complete play by play data table within the database (please see details for further information)
#' @param db_connection A `DBIConnection` object, as returned by
#' [DBI::dbConnect()] (please see details for further information)
#' @return Returns a logical value (TRUE/FALSE)
#'
#' @export
#' @family hoopR Database Functions
update_nba_db <- function(dbdir = tools::R_user_dir("hoopR", "data"),
                          dbname = "hoopR_db",
                          tblname = "hoopR_nba_pbp",
                          force_rebuild = FALSE,
                          db_connection = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  # rule_header("Update hoopR Play-by-Play Database")

  if (!is_installed("DBI") | !is_installed("purrr") |
    (!is_installed("RSQLite") & is.null(db_connection))) {
    cli::cli_abort("{my_time()} | Packages {.val DBI}, {.val RSQLite} and {.val purrr} required for database communication. Please install them.")
  }

  if (any(force_rebuild == "NEW")) {
    cli::cli_abort("{my_time()} | The argument {.val force_rebuild = NEW} is only for internal usage!")
  }

  if (!(is.logical(force_rebuild) | is.numeric(force_rebuild))) {
    cli::cli_abort("{my_time()} | The argument {.val force_rebuild} has to be either logical or numeric!")
  }

  if (!dir.exists(dbdir) & is.null(db_connection)) {
    cli::cli_alert_info("{my_time()} | Creating database directory {.file {dbdir}}")
    dir.create(dbdir, recursive = TRUE)
  }

  if (is.null(db_connection)) {
    connection <- DBI::dbConnect(RSQLite::SQLite(), file.path(dbdir, dbname))
    on.exit(DBI::dbDisconnect(connection), add = TRUE)
  } else {
    connection <- db_connection
  }

  # create db if it doesn't exist or user forces rebuild
  if (!DBI::dbExistsTable(connection, tblname)) {
    build_nba_db(tblname, connection, rebuild = "NEW")
  } else if (DBI::dbExistsTable(connection, tblname) & all(force_rebuild != FALSE)) {
    build_nba_db(tblname, connection, rebuild = force_rebuild)
  }

  # get completed games using Lee's file (thanks Lee!)
  user_message("Checking for missing completed games...", "todo")
  completed_games <- load_nba_games() %>%
    # completed games since 2002, excluding the broken games
    dplyr::filter(.data$season >= 2002) %>%
    dplyr::pull("game_id")

  # function below
  missing <- get_missing_nba_games(completed_games, connection, tblname)

  # rebuild db if number of missing games is too large
  if (length(missing) > 16) { # limit set to >16 to make sure this doesn't get triggered on gameday (e.g. week 17)
    # message("The number of missing games is so large that rebuilding the database is more efficient.")
    build_nba_db(tblname, connection, show_message = FALSE, rebuild = as.numeric(unique(stringr::str_sub(missing, 1, 4))))
    missing <- get_missing_nba_games(completed_games, connection, tblname)
  }

  message_completed("Database update completed", in_builder = TRUE)
  cli::cli_alert_info("{my_time()} | Path to your db: {.file {DBI::dbGetInfo(connection)$dbname}}")
  # rule_footer("DONE")
  invisible(TRUE)
}

# this is a helper function to build hoopR database from Scratch
build_nba_db <- function(tblname = "hoopR_nba_pbp", db_conn, rebuild = FALSE, show_message = TRUE) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  # The index decides which seasons are rebuilt after the purge below, so it is
  # read strictly and before anything is dropped: a partial index would lose
  # the missing seasons from the user's table.
  games <- tryCatch(
    load_nba_games(strict = TRUE),
    error = function(e) {
      cli::cli_abort(c(
        "{my_time()} | Could not read the games index {.url {(.nba_games_index_url)}}.",
        "i" = "Nothing was written to the data table {.val {tblname}}.",
        "x" = "{conditionMessage(e)}"
      ), call = NULL)
    }
  )
  valid_seasons <- games %>%
    dplyr::filter(.data$season >= 2002) %>%
    dplyr::group_by(.data$season) %>%
    dplyr::summarise() %>%
    dplyr::ungroup()

  if (all(rebuild == TRUE)) {
    cli::cli_ul("{my_time()} | Purging the complete data table {.val {tblname}} in your connected database...")
    DBI::dbRemoveTable(db_conn, tblname)
    seasons <- valid_seasons %>% dplyr::pull("season")
    cli::cli_ul("{my_time()} | Starting download of {length(seasons)} seasons between {min(seasons)} and {max(seasons)}...")
  } else if (is.numeric(rebuild) & all(rebuild %in% valid_seasons$season)) {
    string <- paste0(rebuild, collapse = ", ")
    if (show_message) {
      cli::cli_ul("{my_time()} | Purging {string} season(s) from the data table {.val {tblname}} in your connected database...")
    }
    DBI::dbExecute(
      db_conn,
      paste0(
        "DELETE FROM ", DBI::dbQuoteIdentifier(db_conn, tblname),
        " WHERE season IN (",
        paste(rep("?", length(rebuild)), collapse = ", "),
        ")"
      ),
      params = as.list(rebuild)
    )
    seasons <- valid_seasons %>%
      dplyr::filter(.data$season %in% rebuild) %>%
      dplyr::pull("season")
    cli::cli_ul("{my_time()} | Starting download of the {string} season(s)...")
  } else if (all(rebuild == "NEW")) {
    cli::cli_alert_info("{my_time()} | Can't find the data table {.val {tblname}} in your database. Will load the play by play data from scratch.")
    seasons <- valid_seasons %>% dplyr::pull("season")
    cli::cli_ul("{my_time()} | Starting download of {length(seasons)} seasons between {min(seasons)} and {max(seasons)}...")
  } else {
    seasons <- NULL
    cli::cli_alert_danger("{my_time()} | At least one invalid value passed to argument {.code force_rebuild}. Please try again with valid input.")
  }

  if (!is.null(seasons)) {
    # this function lives in R/utils.R
    load_nba_pbp(seasons, dbConnection = db_conn, tablename = tblname)
  }
}

# this is a helper function to check a list of completed games
# against the games that exist in a database connection
get_missing_nba_games <- function(completed_games, dbConnection, tablename) {
  # Plain DBI: dplyr::tbl() on a connection needs dbplyr, which hoopR does not declare.
  db_ids <- DBI::dbGetQuery(
    dbConnection,
    paste0("SELECT DISTINCT game_id FROM ", DBI::dbQuoteIdentifier(dbConnection, tablename))
  )[["game_id"]]

  need_scrape <- completed_games[!completed_games %in% db_ids]

  cli::cli_alert_info("{my_time()} | You have {length(db_ids)} games and are missing {length(need_scrape)}.")
  return(need_scrape)
}


#' @title
#' **Load cleaned NBA standings from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA standings from the
#' sportsdataverse-data release repo (tidy long format: one row per team-per-stat),
#' either into memory or into a database via forwarded arguments in the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of per-season NBA standings.
#' @source The `espn_nba_standings` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_standings>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_standings <- function(seasons = most_recent_nba_season(), ...,
                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_standings/standings_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 2002, most_recent_nba_season(), fn = "load_nba_standings", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA per-game rosters from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA per-game rosters
#' from the sportsdataverse-data release repo, either into memory or into a
#' database via forwarded arguments in the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of per-game NBA rosters.
#' @source The `espn_nba_game_rosters` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_game_rosters>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_game_rosters <- function(seasons = most_recent_nba_season(), ...,
                                  dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- function(url) .ids_as_integer(rds_from_url(url), c("game_id", "team_id", "athlete_id"))
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_game_rosters/game_rosters_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_game_rosters", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}


#' @title
#' **Load cleaned NBA per-game officials from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA per-game officials
#' from the sportsdataverse-data release repo, either into memory or into a
#' database via forwarded arguments in the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of per-game NBA officials.
#' @source The `espn_nba_officials` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_officials>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_officials <- function(seasons = most_recent_nba_season(), ...,
                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_officials/officials_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_officials", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA draft results from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA draft results
#' (overall pick, round, drafted player, and team) from the sportsdataverse-data
#' release repo, either into memory or into a database via forwarded arguments in
#' the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of NBA draft picks.
#' @source The `espn_nba_draft` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_draft>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_draft <- function(seasons = most_recent_nba_season(), ...,
                           dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_draft/draft_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 2003, most_recent_nba_season(), fn = "load_nba_draft", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA player season stats from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA per-player season
#' stats (averages / totals / miscellaneous categories, long format) from the
#' sportsdataverse-data release repo, either into memory or into a database via
#' forwarded arguments in the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of NBA player season stats (long format).
#' @source The `espn_nba_player_season_stats` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_season_stats>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_player_stats <- function(seasons = most_recent_nba_season(), ...,
                                  dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_season_stats/player_season_stats_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_player_stats", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA team season stats from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA per-team season
#' stats (general / offensive / defensive categories, long format) from the
#' sportsdataverse-data release repo, either into memory or into a database via
#' forwarded arguments in the dots.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of NBA team season stats (long format).
#' @source The `espn_nba_team_season_stats` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_team_season_stats>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_team_stats <- function(seasons = most_recent_nba_season(), ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_season_stats/team_season_stats_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_team_stats", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA team rosters from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA team rosters (one
#' row per athlete) from the sportsdataverse-data release repo, either into
#' memory or into a database via forwarded arguments in the dots. NOTE: ESPN's
#' roster endpoint returns the current roster, so season files are snapshots
#' as-of-scrape rather than true historical rosters.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of NBA team rosters.
#' @source The `espn_nba_rosters` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_rosters>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_rosters <- function(seasons = most_recent_nba_season(), ...,
                             dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- function(url) .ids_as_integer(rds_from_url(url), c("team_id", "athlete_id"))
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_rosters/rosters_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 2025, most_recent_nba_season(), fn = "load_nba_rosters", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA player core (identity + bio) from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons of ESPN NBA athlete core
#' records -- identity and biographical fields, one row per athlete who
#' appeared in the season -- from the sportsdataverse-data release repo,
#' either into memory or into a database via forwarded arguments in the dots.
#'
#' This is the only source of athlete bio in the pipeline: the player season
#' stats payload carries no identity at all -- not even the athlete id.
#'
#' Two properties of the source are worth knowing before joining:
#' \itemize{
#'   \item \code{current_team_id} is the athlete's CURRENT team, not their team
#'     in the requested season. Season team lives in
#'     \code{load_nba_player_box()} / \code{load_nba_player_stats()}.
#'   \item Bio (height / weight / jersey) is a current snapshot that ESPN
#'     overwrites in place; it is not era-correct for a historical season. The
#'     season dimension here is participation, not the bio's vintage.
#' }
#' Field coverage is era-dependent by nature -- headshots exist only for modern
#' players, while college and date of birth thin out the other way.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @return Returns a tibble of NBA athlete core records (one row per athlete-season).
#' @source The `espn_nba_player_core` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_core>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
load_nba_player_core <- function(seasons = most_recent_nba_season(), ...,
                                 dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_core/player_core_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 1994, most_recent_nba_season(), fn = "load_nba_player_core", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

#' @title
#' **Load cleaned NBA shot events from the data repo**
#' @rdname load_nba_pbp
#' @description Loads shot events parsed from ESPN NBA play-by-play feeds.
#' One row per shot attempt (made or missed), with court coordinates and
#' shot metadata. Backed by the `hoopR-nba-data` pipeline, publishing
#' parquet/rds artifacts to the `espn_nba_shots` release tag.
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @eval .returns_rd("load_nba_shots", unit = "shot attempt")
#' @source The `espn_nba_shots` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_shots>, published by <https://github.com/sportsdataverse/hoopR-nba-data>.
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_nba_shots(seasons = most_recent_nba_season())
#' }
load_nba_shots <- function(seasons = most_recent_nba_season(), ...,
                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_shots/shots_", seasons, ".rds")
  seasons <- .loader_seasons(seasons, 2002, most_recent_nba_season(), fn = "load_nba_shots", url_for = url_for, default = missing(seasons))

  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}
