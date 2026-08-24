#' **Load hoopR NBA play-by-play**
#' @name load_nba_pbp
NULL
#' @title
#' **Load cleaned NBA play-by-play from the data repo**
#' @rdname load_nba_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab numeric \tab Id. \cr
#'       sequence_number \tab character \tab Sequence number representing a shot-possession (V3 PBP). \cr
#'       type_id \tab integer \tab Type identifier (numeric). \cr
#'       type_text \tab character \tab Display text for the type field. \cr
#'       text \tab character \tab Text description of the play / record. \cr
#'       away_score \tab integer \tab Away team score at the time of the play. \cr
#'       home_score \tab integer \tab Home team score at the time of the play. \cr
#'       period_number \tab integer \tab Numeric period (1-4 for quarters; 5+ for OT). \cr
#'       period_display_value \tab character \tab Period display label (e.g. '1st Quarter', 'OT'). \cr
#'       clock_display_value \tab character \tab Game clock display string (e.g. '8:32'). \cr
#'       scoring_play \tab logical \tab TRUE if the play resulted in points scored. \cr
#'       score_value \tab integer \tab Point value of the play (2 / 3 / 1). \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       athlete_id_1 \tab integer \tab Primary athlete identifier (e.g. shooter). \cr
#'       athlete_id_2 \tab integer \tab Secondary athlete identifier (e.g. assister / fouler). \cr
#'       athlete_id_3 \tab integer \tab Athlete id 3. \cr
#'       wallclock \tab character \tab Wallclock. \cr
#'       shooting_play \tab logical \tab TRUE if the play was a shooting attempt. \cr
#'       coordinate_x_raw \tab numeric \tab X coordinate as returned by the API before any adjustment. \cr
#'       coordinate_y_raw \tab numeric \tab Y coordinate as returned by the API before any adjustment. \cr
#'       season \tab integer \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       season_type \tab integer \tab Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_mascot \tab character \tab Away team mascot. \cr
#'       away_team_abbrev \tab character \tab Away team three-letter abbreviation. \cr
#'       away_team_name_alt \tab character \tab Alternate away team name. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_mascot \tab character \tab Home team mascot. \cr
#'       home_team_abbrev \tab character \tab Home team three-letter abbreviation. \cr
#'       home_team_name_alt \tab character \tab Alternate home team name. \cr
#'       home_team_spread \tab numeric \tab Home team's point spread. \cr
#'       game_spread \tab numeric \tab Game spread (signed; positive = home favored). \cr
#'       home_favorite \tab logical \tab TRUE if the home team is the betting favorite. \cr
#'       game_spread_available \tab logical \tab TRUE if a point spread was available. \cr
#'       game_id \tab integer \tab Unique game identifier. \cr
#'       qtr \tab integer \tab Quarter (1-4) or OT period (5+). \cr
#'       time \tab character \tab Time / clock value. \cr
#'       clock_minutes \tab integer \tab Clock minutes split out for convenience. \cr
#'       clock_seconds \tab numeric \tab Clock seconds split out for convenience. \cr
#'       half \tab character \tab Half of the game (1 or 2). \cr
#'       game_half \tab character \tab Half of the game (1 or 2). \cr
#'       lead_qtr \tab integer \tab Quarter lead (the next-play's quarter). \cr
#'       lead_game_half \tab character \tab Half lead (the next-play's half). \cr
#'       start_quarter_seconds_remaining \tab integer \tab Seconds remaining in the period at the start of the play. \cr
#'       start_half_seconds_remaining \tab integer \tab Seconds remaining in the half at the start of the play. \cr
#'       start_game_seconds_remaining \tab integer \tab Seconds remaining in the game at the start of the play. \cr
#'       game_play_number \tab integer \tab Sequential play number within the game. \cr
#'       end_quarter_seconds_remaining \tab integer \tab Seconds remaining in the period at the end of the play. \cr
#'       end_half_seconds_remaining \tab integer \tab Seconds remaining in the half at the end of the play. \cr
#'       end_game_seconds_remaining \tab integer \tab Seconds remaining in the game at the end of the play. \cr
#'       period \tab integer \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       lag_qtr \tab integer \tab Quarter lag (the previous-play's quarter). \cr
#'       lag_game_half \tab character \tab Half lag (the previous-play's half). \cr
#'       coordinate_x \tab numeric \tab X coordinate on the court (half-court layout). \cr
#'       coordinate_y \tab numeric \tab Y coordinate on the court (half-court layout). \cr
#'       game_date \tab Date \tab Game date (YYYY-MM-DD). \cr
#'       game_date_time \tab POSIXct \tab Game start date/time (ISO 8601). \cr
#'       type_abbreviation \tab character \tab Type abbreviation. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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

  loader <- rds_from_url

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_pbp/play_by_play_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    Columns as documented in the shared [espn_nba_game_all_team_schema] table.
#'
#'
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

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_boxscores/team_box_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    Columns as documented in the shared [espn_nba_game_all_player_schema] table.
#'
#'
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

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_boxscores/player_box_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Id. \cr
#'       uid \tab character \tab ESPN UID string (universal identifier). \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       attendance \tab integer \tab Reported attendance. \cr
#'       time_valid \tab logical \tab Time valid. \cr
#'       neutral_site \tab logical \tab Neutral site. \cr
#'       conference_competition \tab logical \tab Conference competition. \cr
#'       recent \tab logical \tab Recent. \cr
#'       start_date \tab character \tab Start date (YYYY-MM-DD). \cr
#'       notes_type \tab character \tab Notes type. \cr
#'       notes_headline \tab character \tab Notes headline. \cr
#'       type_id \tab integer \tab Type identifier (numeric). \cr
#'       type_abbreviation \tab character \tab Type abbreviation. \cr
#'       venue_id \tab integer \tab Unique venue identifier. \cr
#'       venue_full_name \tab character \tab Venue full name. \cr
#'       venue_address_city \tab character \tab Venue address city. \cr
#'       venue_capacity \tab integer \tab Venue seating capacity. \cr
#'       venue_indoor \tab logical \tab TRUE if the venue is indoors. \cr
#'       status_clock \tab integer \tab Status clock. \cr
#'       status_display_clock \tab character \tab Status display clock. \cr
#'       status_period \tab integer \tab Status period. \cr
#'       status_type_id \tab integer \tab Unique identifier for status type. \cr
#'       status_type_name \tab character \tab Status type name. \cr
#'       status_type_state \tab character \tab Status type state. \cr
#'       status_type_completed \tab logical \tab Status type completed. \cr
#'       status_type_description \tab character \tab Status type description. \cr
#'       status_type_detail \tab character \tab Status type detail. \cr
#'       status_type_short_detail \tab character \tab Status type short detail. \cr
#'       format_regulation_periods \tab integer \tab Format regulation periods. \cr
#'       home_id \tab integer \tab Unique identifier for home. \cr
#'       home_uid \tab character \tab Home team's uid. \cr
#'       home_location \tab character \tab Home team's location. \cr
#'       home_name \tab character \tab Home name. \cr
#'       home_abbreviation \tab character \tab Home team's abbreviation. \cr
#'       home_display_name \tab character \tab Home display name. \cr
#'       home_short_display_name \tab character \tab Home short display name. \cr
#'       home_color \tab character \tab Color code (hex) for home. \cr
#'       home_alternate_color \tab character \tab Color code (hex) for home alternate. \cr
#'       home_is_active \tab logical \tab Home team's is active. \cr
#'       home_venue_id \tab integer \tab Unique identifier for home venue. \cr
#'       home_logo \tab character \tab Home team logo URL. \cr
#'       home_score \tab integer \tab Home team score at the time of the play. \cr
#'       home_winner \tab logical \tab Home team's winner. \cr
#'       away_id \tab integer \tab Unique identifier for away. \cr
#'       away_uid \tab character \tab Away team's uid. \cr
#'       away_location \tab character \tab Away team's location. \cr
#'       away_name \tab character \tab Away name. \cr
#'       away_abbreviation \tab character \tab Away team's abbreviation. \cr
#'       away_display_name \tab character \tab Away display name. \cr
#'       away_short_display_name \tab character \tab Away short display name. \cr
#'       away_color \tab character \tab Color code (hex) for away. \cr
#'       away_alternate_color \tab character \tab Color code (hex) for away alternate. \cr
#'       away_is_active \tab logical \tab Away team's is active. \cr
#'       away_venue_id \tab integer \tab Unique identifier for away venue. \cr
#'       away_logo \tab character \tab Away team logo URL. \cr
#'       away_score \tab integer \tab Away team score at the time of the play. \cr
#'       away_winner \tab logical \tab Away team's winner. \cr
#'       game_id \tab integer \tab Unique game identifier. \cr
#'       season \tab integer \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       season_type \tab integer \tab Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). \cr
#'       venue_address_state \tab character \tab Venue address state / region. \cr
#'       status_type_alt_detail \tab character \tab Status type alt detail. \cr
#'       PBP \tab logical \tab  \cr
#'       team_box \tab logical \tab Team box. \cr
#'       player_box \tab logical \tab Player box. \cr
#'       game_date_time \tab POSIXct \tab Game start date/time (ISO 8601). \cr
#'       game_date \tab Date \tab Game date (YYYY-MM-DD). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'
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

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_schedules/nba_schedule_", seasons, ".rds")

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
load_nba_games <- function() {
  .url <- "https://raw.githubusercontent.com/sportsdataverse/hoopR-data/main/nba/nba_games_in_data_repo.csv"
  dat <- csv_from_url(.url)
  return(dat)
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
#' @param dbdir Directory in which the database is or shall be located
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
update_nba_db <- function(dbdir = ".",
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
    cli::cli_alert_danger("{my_time()} | Directory {.file {dbdir}} doesn't exist yet. Try creating...")
    dir.create(dbdir)
  }

  if (is.null(db_connection)) {
    connection <- DBI::dbConnect(RSQLite::SQLite(), file.path(dbdir, dbname))
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
  if (is.null(db_connection)) DBI::dbDisconnect(connection)
  # rule_footer("DONE")
}

# this is a helper function to build hoopR database from Scratch
build_nba_db <- function(tblname = "hoopR_nba_pbp", db_conn, rebuild = FALSE, show_message = TRUE) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  valid_seasons <- load_nba_games() %>%
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
  db_ids <- dplyr::tbl(dbConnection, tablename) %>%
    dplyr::select("game_id") %>%
    dplyr::distinct() %>%
    dplyr::collect() %>%
    dplyr::pull("game_id")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the standings data table within the database.
#' @return Returns a tibble of per-season NBA standings.
#' @export
load_nba_standings <- function(seasons = most_recent_nba_season(), ...,
                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_standings/standings_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the game-rosters data table within the database.
#' @return Returns a tibble of per-game NBA rosters.
#' @export
load_nba_game_rosters <- function(seasons = most_recent_nba_season(), ...,
                                  dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_game_rosters/game_rosters_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the officials data table within the database.
#' @return Returns a tibble of per-game NBA officials.
#' @export
load_nba_officials <- function(seasons = most_recent_nba_season(), ...,
                               dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_officials/officials_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA draft years. (Min: 2003)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the draft data table within the database.
#' @return Returns a tibble of NBA draft picks.
#' @export
load_nba_draft <- function(seasons = most_recent_nba_season(), ...,
                           dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2003:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2003,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_draft/draft_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the player season stats data table within the database.
#' @return Returns a tibble of NBA player season stats (long format).
#' @export
load_nba_player_stats <- function(seasons = most_recent_nba_season(), ...,
                                  dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_season_stats/player_season_stats_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the team season stats data table within the database.
#' @return Returns a tibble of NBA team season stats (long format).
#' @export
load_nba_team_stats <- function(seasons = most_recent_nba_season(), ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_season_stats/team_season_stats_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the rosters data table within the database.
#' @return Returns a tibble of NBA team rosters.
#' @export
load_nba_rosters <- function(seasons = most_recent_nba_season(), ...,
                             dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_rosters/rosters_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the player core data table within the database.
#' @return Returns a tibble of NBA athlete core records (one row per athlete-season).
#' @export
load_nba_player_core <- function(seasons = most_recent_nba_season(), ...,
                                 dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_core/player_core_", seasons, ".rds")

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
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by `DBI::dbConnect()`.
#' @param tablename The name of the shots data table within the database.
#' @return Returns a tibble with one row per shot attempt.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab integer \tab Unique game identifier. \cr
#'       season \tab integer \tab Season identifier (4-digit year). \cr
#'       period_number \tab integer \tab Numeric period (1-4 for quarters; 5+ for OT). \cr
#'       clock_display_value \tab character \tab Game clock display string (e.g. '8:32'). \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       athlete_id_1 \tab integer \tab Primary athlete identifier (the shooter). \cr
#'       athlete_id_2 \tab integer \tab Secondary athlete identifier (e.g. assister / fouler). \cr
#'       type_id \tab integer \tab Type identifier (numeric). \cr
#'       type_text \tab character \tab Display text for the shot/play type. \cr
#'       scoring_play \tab logical \tab TRUE if the play resulted in points scored. \cr
#'       score_value \tab integer \tab Point value of the shot (2 / 3 / 1). \cr
#'       coordinate_x \tab numeric \tab X coordinate on the court (half-court layout). \cr
#'       coordinate_y \tab numeric \tab Y coordinate on the court (half-court layout). \cr
#'       coordinate_x_raw \tab numeric \tab X coordinate as returned by the API before any adjustment. \cr
#'       coordinate_y_raw \tab numeric \tab Y coordinate as returned by the API before any adjustment. \cr
#'       athlete_name_1 \tab character \tab Display name of the primary athlete (the shooter). \cr
#'       athlete_name_2 \tab character \tab Display name of the secondary athlete, when present. \cr
#'       team_name \tab character \tab Full team display name. \cr
#'       team_mascot \tab character \tab Team mascot / nickname. \cr
#'       team_abbrev \tab character \tab Short team abbreviation. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_shots/shots_", seasons, ".rds")

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  }
  out
}
