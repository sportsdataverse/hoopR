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
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |id                              |numeric   |
#'    |sequence_number                 |character |
#'    |type_id                         |integer   |
#'    |type_text                       |character |
#'    |text                            |character |
#'    |away_score                      |integer   |
#'    |home_score                      |integer   |
#'    |period_number                   |integer   |
#'    |period_display_value            |character |
#'    |clock_display_value             |character |
#'    |scoring_play                    |logical   |
#'    |score_value                     |integer   |
#'    |team_id                         |integer   |
#'    |athlete_id_1                    |integer   |
#'    |athlete_id_2                    |integer   |
#'    |athlete_id_3                    |integer   |
#'    |wallclock                       |character |
#'    |shooting_play                   |logical   |
#'    |coordinate_x_raw                |numeric   |
#'    |coordinate_y_raw                |numeric   |
#'    |season                          |integer   |
#'    |season_type                     |integer   |
#'    |away_team_id                    |integer   |
#'    |away_team_name                  |character |
#'    |away_team_mascot                |character |
#'    |away_team_abbrev                |character |
#'    |away_team_name_alt              |character |
#'    |home_team_id                    |integer   |
#'    |home_team_name                  |character |
#'    |home_team_mascot                |character |
#'    |home_team_abbrev                |character |
#'    |home_team_name_alt              |character |
#'    |home_team_spread                |numeric   |
#'    |game_spread                     |numeric   |
#'    |home_favorite                   |logical   |
#'    |game_spread_available           |logical   |
#'    |game_id                         |integer   |
#'    |qtr                             |integer   |
#'    |time                            |character |
#'    |clock_minutes                   |integer   |
#'    |clock_seconds                   |numeric   |
#'    |half                            |character |
#'    |game_half                       |character |
#'    |lead_qtr                        |integer   |
#'    |lead_game_half                  |character |
#'    |start_quarter_seconds_remaining |integer   |
#'    |start_half_seconds_remaining    |integer   |
#'    |start_game_seconds_remaining    |integer   |
#'    |game_play_number                |integer   |
#'    |end_quarter_seconds_remaining   |integer   |
#'    |end_half_seconds_remaining      |integer   |
#'    |end_game_seconds_remaining      |integer   |
#'    |period                          |integer   |
#'    |lag_qtr                         |integer   |
#'    |lag_game_half                   |character |
#'    |coordinate_x                    |numeric   |
#'    |coordinate_y                    |numeric   |
#'    |game_date                       |Date      |
#'    |game_date_time                  |POSIXct   |
#'    |type_abbreviation               |character |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#'   load_nba_pbp(seasons = most_recent_nba_season())
#' }
load_nba_pbp <- function(seasons = most_recent_nba_season(), ...,
                         dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(is.numeric(seasons),
            seasons >= 2002,
            seasons <= most_recent_nba_season())

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_pbp/play_by_play_", seasons, ".rds")

  out <- lapply(
    cli::cli_progress_along(seasons, name = "Loading"),
    function(i) {
      rds_from_url(urls[i])
  })

  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")

  }
  out
}

#' **Load hoopR NBA team box scores**
#' @name load_nba_team_box
NULL
#' @title
#' **Load cleaned NBA team box scores from the data repo**
#' @rdname load_nba_team_box
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |game_date_time                    |POSIXct   |
#'    |team_id                           |integer   |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_location                     |character |
#'    |team_name                         |character |
#'    |team_abbreviation                 |character |
#'    |team_display_name                 |character |
#'    |team_short_display_name           |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |team_logo                         |character |
#'    |team_home_away                    |character |
#'    |team_score                        |integer   |
#'    |team_winner                       |logical   |
#'    |assists                           |integer   |
#'    |blocks                            |integer   |
#'    |defensive_rebounds                |integer   |
#'    |fast_break_points                 |character |
#'    |field_goal_pct                    |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |flagrant_fouls                    |integer   |
#'    |fouls                             |integer   |
#'    |free_throw_pct                    |numeric   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |largest_lead                      |character |
#'    |offensive_rebounds                |integer   |
#'    |points_in_paint                   |character |
#'    |steals                            |integer   |
#'    |team_turnovers                    |integer   |
#'    |technical_fouls                   |integer   |
#'    |three_point_field_goal_pct        |numeric   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |total_rebounds                    |integer   |
#'    |total_technical_fouls             |integer   |
#'    |total_turnovers                   |integer   |
#'    |turnover_points                   |character |
#'    |turnovers                         |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_uid                 |character |
#'    |opponent_team_slug                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_name                |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_short_display_name  |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_score               |integer   |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#'   load_nba_team_box(seasons = most_recent_nba_season())
#' }
load_nba_team_box <- function(seasons = most_recent_nba_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(is.numeric(seasons),
            seasons >= 2002,
            seasons <= most_recent_nba_season())

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_boxscores/team_box_", seasons, ".rds")

  out <- lapply(
    cli::cli_progress_along(seasons, name = "Loading"),
    function(i) {
      rds_from_url(urls[i])
  })

  out <- rbindlist_with_attrs(out)
  class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  out
}


#' **Load hoopR NBA player box scores**
#' @name load_nba_player_box
NULL
#' @title
#' **Load cleaned NBA player box scores from the data repo**
#' @rdname load_nba_player_box
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |game_date_time                    |POSIXct   |
#'    |athlete_id                        |integer   |
#'    |athlete_display_name              |character |
#'    |team_id                           |integer   |
#'    |team_name                         |character |
#'    |team_location                     |character |
#'    |team_short_display_name           |character |
#'    |minutes                           |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |offensive_rebounds                |integer   |
#'    |defensive_rebounds                |integer   |
#'    |rebounds                          |integer   |
#'    |assists                           |integer   |
#'    |steals                            |integer   |
#'    |blocks                            |integer   |
#'    |turnovers                         |integer   |
#'    |fouls                             |integer   |
#'    |plus_minus                        |character |
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
#'    |reason                            |character |
#'    |active                            |logical   |
#'    |athlete_jersey                    |character |
#'    |athlete_short_name                |character |
#'    |athlete_headshot_href             |character |
#'    |athlete_position_name             |character |
#'    |athlete_position_abbreviation     |character |
#'    |team_display_name                 |character |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_logo                         |character |
#'    |team_abbreviation                 |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |home_away                         |character |
#'    |team_winner                       |logical   |
#'    |team_score                        |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_name                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_score               |integer   |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#'   load_nba_player_box(seasons = most_recent_nba_season())
#' }
load_nba_player_box <- function(seasons = most_recent_nba_season(), ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(is.numeric(seasons),
            seasons >= 2002,
            seasons <= most_recent_nba_season())

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_boxscores/player_box_", seasons, ".rds")

  out <- lapply(
    cli::cli_progress_along(seasons, name = "Loading"),
    function(i) {
      rds_from_url(urls[i])
    })
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

#' **Load hoopR NBA schedules**
#' @name load_nba_schedule
NULL
#' @title
#' **Load cleaned NBA schedules from the data repo**
#' @rdname load_nba_schedule
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given NBA seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_nba_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |id                        |integer   |
#'    |uid                       |character |
#'    |date                      |character |
#'    |attendance                |integer   |
#'    |time_valid                |logical   |
#'    |neutral_site              |logical   |
#'    |conference_competition    |logical   |
#'    |recent                    |logical   |
#'    |start_date                |character |
#'    |notes_type                |character |
#'    |notes_headline            |character |
#'    |type_id                   |integer   |
#'    |type_abbreviation         |character |
#'    |venue_id                  |integer   |
#'    |venue_full_name           |character |
#'    |venue_address_city        |character |
#'    |venue_capacity            |integer   |
#'    |venue_indoor              |logical   |
#'    |status_clock              |integer   |
#'    |status_display_clock      |character |
#'    |status_period             |integer   |
#'    |status_type_id            |integer   |
#'    |status_type_name          |character |
#'    |status_type_state         |character |
#'    |status_type_completed     |logical   |
#'    |status_type_description   |character |
#'    |status_type_detail        |character |
#'    |status_type_short_detail  |character |
#'    |format_regulation_periods |integer   |
#'    |home_id                   |integer   |
#'    |home_uid                  |character |
#'    |home_location             |character |
#'    |home_name                 |character |
#'    |home_abbreviation         |character |
#'    |home_display_name         |character |
#'    |home_short_display_name   |character |
#'    |home_color                |character |
#'    |home_alternate_color      |character |
#'    |home_is_active            |logical   |
#'    |home_venue_id             |integer   |
#'    |home_logo                 |character |
#'    |home_score                |integer   |
#'    |home_winner               |logical   |
#'    |away_id                   |integer   |
#'    |away_uid                  |character |
#'    |away_location             |character |
#'    |away_name                 |character |
#'    |away_abbreviation         |character |
#'    |away_display_name         |character |
#'    |away_short_display_name   |character |
#'    |away_color                |character |
#'    |away_alternate_color      |character |
#'    |away_is_active            |logical   |
#'    |away_venue_id             |integer   |
#'    |away_logo                 |character |
#'    |away_score                |integer   |
#'    |away_winner               |logical   |
#'    |game_id                   |integer   |
#'    |season                    |integer   |
#'    |season_type               |integer   |
#'    |venue_address_state       |character |
#'    |status_type_alt_detail    |character |
#'    |PBP                       |logical   |
#'    |team_box                  |logical   |
#'    |player_box                |logical   |
#'    |game_date_time            |POSIXct   |
#'    |game_date                 |Date      |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#'   load_nba_schedule(seasons = most_recent_nba_season())
#' }
load_nba_schedule <- function(seasons = most_recent_nba_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(is.numeric(seasons),
            seasons >= 2002,
            seasons <= most_recent_nba_season())

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_schedules/nba_schedule_", seasons, ".rds")

  out <- lapply(
    cli::cli_progress_along(seasons, name = "Loading"),
    function(i) {
      rds_from_url(urls[i])
    })
  out <- rbindlist_with_attrs(out)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

# load games file
load_nba_games <- function(){
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
#' @import furrr
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

  suggest_required <- c("DBI", "purrr")
  # need RSQLite if db_connection
  if (!is.null(db_connection)) {
    suggest_required <- c(suggest_required, "RSQLite")
  }
  rlang::check_installed(suggest_required, "for database communication.")

  if (any(force_rebuild == "NEW")) {
    cli::cli_abort("{my_time()} | The argument {.code force_rebuild = {.val NEW}} is only for internal usage!")
  }

  if (!is.logical(force_rebuild) || !is.numeric(force_rebuild)) {
    cli::cli_abort("{my_time()} | The argument {.val force_rebuild} has to be either logical or numeric!")
  }

  if (!dir.exists(dbdir) & is.null(db_connection)) {
    cli::cli_alert_danger("{my_time()} | Directory {.path {dbdir}} doesn't exist yet.")
    hoop_todo("Trying to create...")
    dir.create(dbdir)
  }

  if (is.null(db_connection)) {
    connection <- DBI::dbConnect(RSQLite::SQLite(), glue::glue("{dbdir}/{dbname}"))
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
  hoop_todo("Checking for missing completed games...")
  completed_games <- load_nba_games() %>%
    # completed games since 2002, excluding the broken games
    dplyr::filter(.data$season >= 2002) %>%
    dplyr::pull("game_id")

  # function below
  missing <- get_missing_nba_games(completed_games, connection, tblname)

  # rebuild db if number of missing games is too large
  if (length(missing) > 16) {# limit set to >16 to make sure this doesn't get triggered on gameday (e.g. week 17)
    # message("The number of missing games is so large that rebuilding the database is more efficient.")
    build_nba_db(tblname, connection, show_message = FALSE, rebuild = as.numeric(unique(stringr::str_sub(missing, 1, 4))))
    missing <- get_missing_nba_games(completed_games, connection, tblname)
  }

  cli::cli_alert_success("{.field Database update completed}")
  hoop_info("Path to your db: {.path {DBI::dbGetInfo(connection)$dbname}}")
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
    dplyr::summarise(.groups = "drop")

  if (all(rebuild == TRUE)) {
    hoop_todo("Purging the complete data table {.val {tblname}} in your connected database...")
    DBI::dbRemoveTable(db_conn, tblname)
    seasons <- valid_seasons %>% dplyr::pull("season")
    hoop_todo("Starting download of {length(seasons)} season{?s} between {min(seasons)} and {max(seasons)}...")
  } else if (is.numeric(rebuild) & all(rebuild %in% valid_seasons$season)) {
    string <- paste0(rebuild, collapse = ", ")
    if (show_message) {
      hoop_todo("Purging {string} {cli::qty(length(rebuild)} season{?s} from the data table {.val {tblname}} in your connected database...")
    }
    DBI::dbExecute(db_conn, glue::glue_sql("DELETE FROM {`tblname`} WHERE season IN ({vals*})", vals = rebuild, .con = db_conn))
    seasons <- valid_seasons %>% dplyr::filter(.data$season %in% rebuild) %>% dplyr::pull("season")
    hoop_todo("Starting download of the {string} season(s)...")
  } else if (all(rebuild == "NEW")) {
    hoop_info("Can't find the data table {.val {tblname}} in your database. Will load the play by play data from scratch.")
    seasons <- valid_seasons %>% dplyr::pull("season")
    hoop_todo("Starting download of {length(seasons)} season{?s} between {min(seasons)} and {max(seasons)}...")
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

  hoop_info("You have {length(db_ids)} game{?s} and are missing {length(need_scrape)}.")
  return(need_scrape)
}
