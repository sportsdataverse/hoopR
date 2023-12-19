#' **Load hoopR men's college basketball play-by-play**
#' @name load_mbb_pbp
NULL
#' @title
#' **Load cleaned men's college basketball play-by-play from the data repo**
#' @rdname load_mbb_pbp
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given men's college basketball seasons. (Min: 2006)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_mbb_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |id                              |numeric   |
#'    |sequence_number                 |character |
#'    |type_id                         |character |
#'    |type_text                       |character |
#'    |text                            |character |
#'    |away_score                      |integer   |
#'    |home_score                      |integer   |
#'    |period_number                   |integer   |
#'    |period_display_value            |character |
#'    |clock_display_value             |character |
#'    |scoring_play                    |logical   |
#'    |score_value                     |integer   |
#'    |team_id                         |character |
#'    |participants_0_athlete_id       |character |
#'    |wallclock                       |character |
#'    |shooting_play                   |logical   |
#'    |participants_1_athlete_id       |character |
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
#'    |clock_minutes                   |character |
#'    |clock_seconds                   |character |
#'    |half                            |character |
#'    |game_half                       |character |
#'    |lag_qtr                         |numeric   |
#'    |lead_qtr                        |numeric   |
#'    |lag_game_half                   |character |
#'    |lead_game_half                  |character |
#'    |start_quarter_seconds_remaining |integer   |
#'    |start_half_seconds_remaining    |integer   |
#'    |start_game_seconds_remaining    |integer   |
#'    |game_play_number                |integer   |
#'    |end_quarter_seconds_remaining   |numeric   |
#'    |end_half_seconds_remaining      |numeric   |
#'    |end_game_seconds_remaining      |numeric   |
#'    |period                          |integer   |
#'    |coordinate_x                    |integer   |
#'    |coordinate_y                    |integer   |
#'    |media_id                        |character |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples
#' \donttest{
#' load_mbb_pbp(seasons = most_recent_mbb_season())
#' }
load_mbb_pbp <- function(seasons = most_recent_mbb_season(), ...,
                         dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2006:most_recent_mbb_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2006,
    seasons <= most_recent_mbb_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_pbp/play_by_play_", seasons, ".rds")

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
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  }
  out
}

#' **Load hoopR men's college basketball team box scores**
#' @name load_mbb_team_box
NULL
#' @title
#' **Load cleaned men's college basketball team box scores from the data repo**
#' @rdname load_mbb_team_box
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given men's college basketball seasons. (Min: 2003)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_mbb_db()`).
#' @param dbConnection A `DBIConnection` object, as returned by
#' @param tablename The name of the play by play data table within the database
#' @return Returns a tibble
#'
#'    |col_name                                                       |types     |
#'    |:--------------------------------------------------------------|:---------|
#'    |team_id                                                        |character |
#'    |team_uid                                                       |character |
#'    |team_slug                                                      |character |
#'    |team_location                                                  |character |
#'    |team_name                                                      |character |
#'    |team_abbreviation                                              |character |
#'    |team_display_name                                              |character |
#'    |team_short_display_name                                        |character |
#'    |team_color                                                     |character |
#'    |team_alternate_color                                           |character |
#'    |team_logo                                                      |character |
#'    |field_goals_made_field_goals_attempted                         |character |
#'    |field_goal_pct                                                 |character |
#'    |three_point_field_goals_made_three_point_field_goals_attempted |character |
#'    |three_point_field_goal_pct                                     |character |
#'    |free_throws_made_free_throws_attempted                         |character |
#'    |free_throw_pct                                                 |character |
#'    |total_rebounds                                                 |character |
#'    |offensive_rebounds                                             |character |
#'    |defensive_rebounds                                             |character |
#'    |assists                                                        |character |
#'    |steals                                                         |character |
#'    |blocks                                                         |character |
#'    |turnovers                                                      |character |
#'    |team_turnovers                                                 |character |
#'    |total_turnovers                                                |character |
#'    |technical_fouls                                                |character |
#'    |total_technical_fouls                                          |character |
#'    |flagrant_fouls                                                 |character |
#'    |fouls                                                          |character |
#'    |largest_lead                                                   |character |
#'    |home_away                                                      |character |
#'    |opponent_id                                                    |integer   |
#'    |opponent_name                                                  |character |
#'    |opponent_mascot                                                |character |
#'    |opponent_abbrev                                                |character |
#'    |game_id                                                        |integer   |
#'    |season                                                         |integer   |
#'    |season_type                                                    |integer   |
#'    |game_date                                                      |Date      |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples \donttest{
#' load_mbb_team_box(seasons = most_recent_mbb_season())
#' }
load_mbb_team_box <- function(seasons = most_recent_mbb_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE
  if (isTRUE(seasons)) seasons <- 2003:most_recent_mbb_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2003,
    seasons <= most_recent_mbb_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_team_boxscores/team_box_", seasons, ".rds")

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
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  }
  out
}


#' **Load hoopR men's college basketball player box scores**
#' @name load_mbb_player_box
NULL
#' @title
#' **Load cleaned men's college basketball player box scores from the data repo**
#' @rdname load_mbb_player_box
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given men's college basketball seasons. (Min: 2003)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_mbb_db()`).
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
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
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
#' @examples \donttest{
#' load_mbb_player_box(seasons = most_recent_mbb_season())
#' }
load_mbb_player_box <- function(seasons = most_recent_mbb_season(), ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE
  if (isTRUE(seasons)) seasons <- 2003:most_recent_mbb_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2003,
    seasons <= most_recent_mbb_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_player_boxscores/player_box_", seasons, ".rds")

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
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  }
  out
}

#' **Load hoopR men's college basketball schedule**
#' @name load_mbb_schedule
NULL
#' @title
#' **Load cleaned men's college basketball schedule from the data repo**
#' @rdname load_mbb_schedule
#' @description helper that loads multiple seasons from the data repo either into memory
#' or writes it into a db using some forwarded arguments in the dots
#' @param seasons A vector of 4-digit years associated with given men's college basketball seasons. (Min: 2002)
#' @param ... Additional arguments passed to an underlying function that writes
#' the season data into a database (used by `update_mbb_db()`).
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
#'    |type_id                   |character |
#'    |type_abbreviation         |character |
#'    |venue_id                  |character |
#'    |venue_full_name           |character |
#'    |venue_address_city        |character |
#'    |venue_address_state       |character |
#'    |venue_capacity            |integer   |
#'    |venue_indoor              |logical   |
#'    |status_clock              |numeric   |
#'    |status_display_clock      |character |
#'    |status_period             |integer   |
#'    |status_type_id            |character |
#'    |status_type_name          |character |
#'    |status_type_state         |character |
#'    |status_type_completed     |logical   |
#'    |status_type_description   |character |
#'    |status_type_detail        |character |
#'    |status_type_short_detail  |character |
#'    |format_regulation_periods |integer   |
#'    |home_id                   |character |
#'    |home_uid                  |character |
#'    |home_location             |character |
#'    |home_name                 |character |
#'    |home_abbreviation         |character |
#'    |home_display_name         |character |
#'    |home_short_display_name   |character |
#'    |home_color                |character |
#'    |home_alternate_color      |character |
#'    |home_is_active            |logical   |
#'    |home_venue_id             |character |
#'    |home_logo                 |character |
#'    |home_conference_id        |character |
#'    |home_score                |character |
#'    |home_winner               |logical   |
#'    |away_id                   |character |
#'    |away_uid                  |character |
#'    |away_location             |character |
#'    |away_name                 |character |
#'    |away_abbreviation         |character |
#'    |away_display_name         |character |
#'    |away_short_display_name   |character |
#'    |away_color                |character |
#'    |away_alternate_color      |character |
#'    |away_is_active            |logical   |
#'    |away_venue_id             |character |
#'    |away_logo                 |character |
#'    |away_conference_id        |character |
#'    |away_score                |character |
#'    |away_winner               |logical   |
#'    |game_id                   |integer   |
#'    |season                    |integer   |
#'    |season_type               |integer   |
#'    |status_type_alt_detail    |character |
#'    |groups_id                 |character |
#'    |groups_name               |character |
#'    |groups_short_name         |character |
#'    |groups_is_conference      |logical   |
#'    |tournament_id             |numeric   |
#'    |game_date_time            |POSIXct   |
#'    |game_date                 |Date      |
#'    |PBP                       |logical   |
#'    |team_box                  |logical   |
#'    |player_box                |logical   |
#'
#' @import furrr
#' @export
#' @family hoopR Loader Functions
#' @examples \donttest{
#' load_mbb_schedule(seasons = most_recent_mbb_season())
#' }
load_mbb_schedule <- function(seasons = most_recent_mbb_season(), ...,
                              dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE
  if (isTRUE(seasons)) seasons <- 2002:most_recent_mbb_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_mbb_season()
  )

  urls <- paste0("https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_schedules/mbb_schedule_", seasons, ".rds")

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
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  }
  out
}

# load games file
load_mbb_games <- function() {
  .url <- "https://raw.githubusercontent.com/sportsdataverse/hoopR-data/main/mbb/mbb_games_in_data_repo.csv"
  dat <- hoopR::csv_from_url(.url)
  # close(con)
  return(dat)
}

#' **Update or create a hoopR MBB play-by-play database**
#'
#' `update_mbb_db()` updates or creates a database with `hoopR`
#' play by play data of all completed and available games since 2006.
#'
#' @details This function creates and updates a data table with the name `tblname`
#' within a SQLite database (other drivers via `db_connection`) located in
#' `dbdir` and named `dbname`.
#' The data table combines all play by play data for every available game back
#' to the 2006 season and adds the most recent completed games as soon as they
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
update_mbb_db <- function(dbdir = ".",
                          dbname = "hoopR_db",
                          tblname = "hoopR_mbb_pbp",
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
    cli::cli_abort(
      "{my_time()} | The argument {.code force_rebuild = {.val NEW}} is only for internal usage."
    )
  }

  if (!is.logical(force_rebuild) || !is.numeric(force_rebuild)) {
    cli::cli_abort("{my_time()} | {.arg force_rebuild} has to be either logical or numeric!")
  }

  if (!dir.exists(dbdir) & is.null(db_connection)) {
    cli::cli_alert_danger("{my_time()} | Directory {.val {dbdir}} doesn't exist yet.")
    cli::cli_alert_info("Trying to create it.")
    dir.create(dbdir)
  }

  if (is.null(db_connection)) {
    connection <- DBI::dbConnect(RSQLite::SQLite(), glue::glue("{dbdir}/{dbname}"))
  } else {
    connection <- db_connection
  }

  # create db if it doesn't exist or user forces rebuild
  if (!DBI::dbExistsTable(connection, tblname)) {
    build_mbb_db(tblname, connection, rebuild = "NEW")
  } else if (DBI::dbExistsTable(connection, tblname) & all(force_rebuild != FALSE)) {
    build_mbb_db(tblname, connection, rebuild = force_rebuild)
  }

  hoop_todo("Checking for missing completed games...")
  completed_games <- load_mbb_games() %>%
    # completed games since 2006, excluding the broken games
    dplyr::filter(.data$season >= 2006) %>%
    dplyr::pull("game_id")

  # function below
  missing <- get_missing_mbb_games(completed_games, connection, tblname)

  # rebuild db if number of missing games is too large
  if (length(missing) > 16) { # limit set to >16 to make sure this doesn't get triggered on gameday (e.g. week 17)
    # message("The number of missing games is so large that rebuilding the database is more efficient.")
    build_mbb_db(tblname, connection, show_message = FALSE, rebuild = as.numeric(unique(stringr::str_sub(missing, 1, 4))))
    missing <- get_missing_mbb_games(completed_games, connection, tblname)
  }

  # # if there's missing games, scrape and write to db
  # if (length(missing) > 0) {
  #   new_pbp <- build_hoopR_pbp(missing, rules = FALSE)
  #
  #   if (nrow(new_pbp) == 0) {
  #     cli::cli_alert_danger("Raw data of new games are not yet ready. Please try again in about 10 minutes.")
  #   } else {
  #     hoop_todo("Appending new data to database...")
  #     DBI::dbWriteTable(connection, tblname, new_pbp, append = TRUE)
  #   }
  # }

  cli::cli_alert_success(cli::col_green("Database update completed"))
  cli::cli_inform("{my_time()} | Path to your db: {.path {DBI::dbGetInfo(connection)$dbname}}")
  if (is.null(db_connection)) DBI::dbDisconnect(connection)
  # rule_footer("DONE")
}

# this is a helper function to build hoopR database from Scratch
build_mbb_db <- function(tblname = "hoopR_mbb_pbp", db_conn, rebuild = FALSE, show_message = TRUE) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  valid_seasons <- load_mbb_games() %>%
    dplyr::filter(.data$season >= 2006) %>%
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
      hoop_todo("Purging {string} {cli::qty(length(rebuild))} from the data table {.val {tblname}} in your connected database...")
    }
    DBI::dbExecute(db_conn, glue::glue_sql("DELETE FROM {`tblname`} WHERE season IN ({vals*})", vals = rebuild, .con = db_conn))
    seasons <- valid_seasons %>%
      dplyr::filter(.data$season %in% rebuild) %>%
      dplyr::pull("season")
    hoop_todo("Starting download of the {string} {cli::qty(length(seasons))} season{?s}...")
  } else if (all(rebuild == "NEW")) {
    hoop_info("Can't find the data table {.val {tblname}} in your database. Will load the play by play data from scratch.")
    seasons <- valid_seasons %>% dplyr::pull("season")
    hoop_todo("Starting download of {length(seasons)} season{?s} between {min(seasons)} and {max(seasons)}...")
  } else {
    seasons <- NULL
    cli::cli_alert_danger("{my_time()} | At least one invalid value passed to argument {.arg force_rebuild}. Please try again with valid input.")
  }

  if (!is.null(seasons)) {
    # this function lives in R/utils.R
    load_mbb_pbp(seasons, dbConnection = db_conn, tablename = tblname)
  }
}

# this is a helper function to check a list of completed games
# against the games that exist in a database connection
get_missing_mbb_games <- function(completed_games, dbConnection, tablename) {
  db_ids <- dplyr::tbl(dbConnection, tablename) %>%
    dplyr::select("game_id") %>%
    dplyr::distinct() %>%
    dplyr::collect() %>%
    dplyr::pull("game_id")

  need_scrape <- completed_games[!completed_games %in% db_ids]

  hoop_info("You have {length(db_ids)} game{?s} and are missing {length(need_scrape)}.")
  return(need_scrape)
}
