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
#'    |col_name                        |types     |description                                                                                                        |
#'    |:-------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |id                              |numeric   |Id.                                                                                                                |
#'    |sequence_number                 |character |Sequence number representing a shot-possession (V3 PBP).                                                           |
#'    |type_id                         |integer   |Type identifier (numeric).                                                                                         |
#'    |type_text                       |character |Display text for the type field.                                                                                   |
#'    |text                            |character |Text description of the play / record.                                                                             |
#'    |away_score                      |integer   |Away team score at the time of the play.                                                                           |
#'    |home_score                      |integer   |Home team score at the time of the play.                                                                           |
#'    |period_number                   |integer   |Numeric period (1-4 for quarters; 5+ for OT).                                                                      |
#'    |period_display_value            |character |Period display label (e.g. '1st Quarter', 'OT').                                                                   |
#'    |clock_display_value             |character |Game clock display string (e.g. '8:32').                                                                           |
#'    |scoring_play                    |logical   |TRUE if the play resulted in points scored.                                                                        |
#'    |score_value                     |integer   |Point value of the play (2 / 3 / 1).                                                                               |
#'    |team_id                         |integer   |Unique team identifier.                                                                                            |
#'    |athlete_id_1                    |integer   |Primary athlete identifier (e.g. shooter).                                                                         |
#'    |athlete_id_2                    |integer   |Secondary athlete identifier (e.g. assister / fouler).                                                             |
#'    |athlete_id_3                    |integer   |Athlete id 3.                                                                                                      |
#'    |wallclock                       |character |Wallclock.                                                                                                         |
#'    |shooting_play                   |logical   |TRUE if the play was a shooting attempt.                                                                           |
#'    |coordinate_x_raw                |numeric   |X coordinate as returned by the API before any adjustment.                                                         |
#'    |coordinate_y_raw                |numeric   |Y coordinate as returned by the API before any adjustment.                                                         |
#'    |season                          |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type                     |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                                                               |
#'    |away_team_name                  |character |Away team name.                                                                                                    |
#'    |away_team_mascot                |character |Away team mascot.                                                                                                  |
#'    |away_team_abbrev                |character |Away team three-letter abbreviation.                                                                               |
#'    |away_team_name_alt              |character |Alternate away team name.                                                                                          |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                                                               |
#'    |home_team_name                  |character |Home team name.                                                                                                    |
#'    |home_team_mascot                |character |Home team mascot.                                                                                                  |
#'    |home_team_abbrev                |character |Home team three-letter abbreviation.                                                                               |
#'    |home_team_name_alt              |character |Alternate home team name.                                                                                          |
#'    |home_team_spread                |numeric   |Home team's point spread.                                                                                          |
#'    |game_spread                     |numeric   |Game spread (signed; positive = home favored).                                                                     |
#'    |home_favorite                   |logical   |TRUE if the home team is the betting favorite.                                                                     |
#'    |game_spread_available           |logical   |TRUE if a point spread was available.                                                                              |
#'    |game_id                         |integer   |Unique game identifier.                                                                                            |
#'    |qtr                             |integer   |Quarter (1-4) or OT period (5+).                                                                                   |
#'    |time                            |character |Time / clock value.                                                                                                |
#'    |clock_minutes                   |integer   |Clock minutes split out for convenience.                                                                           |
#'    |clock_seconds                   |numeric   |Clock seconds split out for convenience.                                                                           |
#'    |half                            |character |Half of the game (1 or 2).                                                                                         |
#'    |game_half                       |character |Half of the game (1 or 2).                                                                                         |
#'    |lead_qtr                        |integer   |Quarter lead (the next-play's quarter).                                                                            |
#'    |lead_game_half                  |character |Half lead (the next-play's half).                                                                                  |
#'    |start_quarter_seconds_remaining |integer   |Seconds remaining in the period at the start of the play.                                                          |
#'    |start_half_seconds_remaining    |integer   |Seconds remaining in the half at the start of the play.                                                            |
#'    |start_game_seconds_remaining    |integer   |Seconds remaining in the game at the start of the play.                                                            |
#'    |game_play_number                |integer   |Sequential play number within the game.                                                                            |
#'    |end_quarter_seconds_remaining   |integer   |Seconds remaining in the period at the end of the play.                                                            |
#'    |end_half_seconds_remaining      |integer   |Seconds remaining in the half at the end of the play.                                                              |
#'    |end_game_seconds_remaining      |integer   |Seconds remaining in the game at the end of the play.                                                              |
#'    |period                          |integer   |Period of the game (1-4 quarters; 5+ for OT).                                                                      |
#'    |lag_qtr                         |integer   |Quarter lag (the previous-play's quarter).                                                                         |
#'    |lag_game_half                   |character |Half lag (the previous-play's half).                                                                               |
#'    |coordinate_x                    |numeric   |X coordinate on the court (half-court layout).                                                                     |
#'    |coordinate_y                    |numeric   |Y coordinate on the court (half-court layout).                                                                     |
#'    |game_date                       |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |game_date_time                  |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'    |type_abbreviation               |character |Type abbreviation.                                                                                                 |
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
  dots <- rlang::dots_list(...)

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
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
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
#'    |col_name                          |types     |description                                                                                                        |
#'    |:---------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |game_id                           |integer   |Unique game identifier.                                                                                            |
#'    |season                            |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type                       |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |game_date                         |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |game_date_time                    |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'    |team_id                           |integer   |Unique team identifier.                                                                                            |
#'    |team_uid                          |character |ESPN universal team identifier (UID format 's:40~l:...~t:...').                                                    |
#'    |team_slug                         |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                                                          |
#'    |team_location                     |character |Team city or location string.                                                                                      |
#'    |team_name                         |character |Full team display name (e.g. 'Las Vegas Aces').                                                                    |
#'    |team_abbreviation                 |character |Short team abbreviation (e.g. 'LAS').                                                                              |
#'    |team_display_name                 |character |Full team display name.                                                                                            |
#'    |team_short_display_name           |character |Short team display name (e.g. 'Aces').                                                                             |
#'    |team_color                        |character |Team primary color (hex without leading '#').                                                                      |
#'    |team_alternate_color              |character |Team alternate color (hex without leading '#').                                                                    |
#'    |team_logo                         |character |Team logo image URL.                                                                                               |
#'    |team_home_away                    |character |Team home away.                                                                                                    |
#'    |team_score                        |integer   |Team's score / final score.                                                                                        |
#'    |team_winner                       |logical   |TRUE if the team won this game.                                                                                    |
#'    |assists                           |integer   |Total assists.                                                                                                     |
#'    |blocks                            |integer   |Total blocks.                                                                                                      |
#'    |defensive_rebounds                |integer   |Defensive rebounds.                                                                                                |
#'    |fast_break_points                 |character |Fast-break points scored.                                                                                          |
#'    |field_goal_pct                    |numeric   |Field goal percentage (0-1).                                                                                       |
#'    |field_goals_made                  |integer   |Field goals made (2-pt + 3-pt).                                                                                    |
#'    |field_goals_attempted             |integer   |Field goal attempts (2-pt + 3-pt).                                                                                 |
#'    |flagrant_fouls                    |integer   |Total flagrant fouls.                                                                                              |
#'    |fouls                             |integer   |Personal fouls.                                                                                                    |
#'    |free_throw_pct                    |numeric   |Free throw percentage (0-1).                                                                                       |
#'    |free_throws_made                  |integer   |Free throws made.                                                                                                  |
#'    |free_throws_attempted             |integer   |Free throw attempts.                                                                                               |
#'    |largest_lead                      |character |Largest lead during the game.                                                                                      |
#'    |offensive_rebounds                |integer   |Offensive rebounds.                                                                                                |
#'    |points_in_paint                   |character |Points scored in the paint.                                                                                        |
#'    |steals                            |integer   |Total steals.                                                                                                      |
#'    |team_turnovers                    |integer   |Team turnovers (turnovers credited to the team rather than a player).                                              |
#'    |technical_fouls                   |integer   |Total technical fouls.                                                                                             |
#'    |three_point_field_goal_pct        |numeric   |Three-point field goal percentage (0-1).                                                                           |
#'    |three_point_field_goals_made      |integer   |Three-point field goals made.                                                                                      |
#'    |three_point_field_goals_attempted |integer   |Three-point field goal attempts.                                                                                   |
#'    |total_rebounds                    |integer   |Total rebounds.                                                                                                    |
#'    |total_technical_fouls             |integer   |Total technical fouls (player + team).                                                                             |
#'    |total_turnovers                   |integer   |Total turnovers (player + team).                                                                                   |
#'    |turnover_points                   |character |Turnover points.                                                                                                   |
#'    |turnovers                         |integer   |Total turnovers.                                                                                                   |
#'    |opponent_team_id                  |integer   |Unique identifier for the opponent team.                                                                           |
#'    |opponent_team_uid                 |character |Opponent team uid.                                                                                                 |
#'    |opponent_team_slug                |character |Opponent team slug.                                                                                                |
#'    |opponent_team_location            |character |Opponent team city / location.                                                                                     |
#'    |opponent_team_name                |character |Opponent team display name.                                                                                        |
#'    |opponent_team_abbreviation        |character |Opponent team abbreviation.                                                                                        |
#'    |opponent_team_display_name        |character |Opponent team full display name.                                                                                   |
#'    |opponent_team_short_display_name  |character |Opponent team short display name.                                                                                  |
#'    |opponent_team_color               |character |Opponent team primary color (hex).                                                                                 |
#'    |opponent_team_alternate_color     |character |Opponent team alternate color (hex).                                                                               |
#'    |opponent_team_logo                |character |Opponent team logo URL.                                                                                            |
#'    |opponent_team_score               |integer   |Opponent team's score.                                                                                             |
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
  dots <- rlang::dots_list(...)

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
  class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
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
#'    |col_name                          |types     |description                                                                                                        |
#'    |:---------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |game_id                           |integer   |Unique game identifier.                                                                                            |
#'    |season                            |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type                       |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |game_date                         |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |game_date_time                    |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'    |athlete_id                        |integer   |Unique athlete identifier (ESPN).                                                                                  |
#'    |athlete_display_name              |character |Athlete display name (full).                                                                                       |
#'    |team_id                           |integer   |Unique team identifier.                                                                                            |
#'    |team_name                         |character |Full team display name (e.g. 'Las Vegas Aces').                                                                    |
#'    |team_location                     |character |Team city or location string.                                                                                      |
#'    |team_short_display_name           |character |Short team display name (e.g. 'Aces').                                                                             |
#'    |minutes                           |numeric   |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2).                                   |
#'    |field_goals_made                  |integer   |Field goals made (2-pt + 3-pt).                                                                                    |
#'    |field_goals_attempted             |integer   |Field goal attempts (2-pt + 3-pt).                                                                                 |
#'    |three_point_field_goals_made      |integer   |Three-point field goals made.                                                                                      |
#'    |three_point_field_goals_attempted |integer   |Three-point field goal attempts.                                                                                   |
#'    |free_throws_made                  |integer   |Free throws made.                                                                                                  |
#'    |free_throws_attempted             |integer   |Free throw attempts.                                                                                               |
#'    |offensive_rebounds                |integer   |Offensive rebounds.                                                                                                |
#'    |defensive_rebounds                |integer   |Defensive rebounds.                                                                                                |
#'    |rebounds                          |integer   |Total rebounds.                                                                                                    |
#'    |assists                           |integer   |Total assists.                                                                                                     |
#'    |steals                            |integer   |Total steals.                                                                                                      |
#'    |blocks                            |integer   |Total blocks.                                                                                                      |
#'    |turnovers                         |integer   |Total turnovers.                                                                                                   |
#'    |fouls                             |integer   |Personal fouls.                                                                                                    |
#'    |plus_minus                        |character |Plus/minus point differential while on court.                                                                      |
#'    |points                            |integer   |Points scored.                                                                                                     |
#'    |starter                           |logical   |TRUE if the player was in the starting lineup; FALSE otherwise.                                                    |
#'    |ejected                           |logical   |TRUE if the player was ejected from the game.                                                                      |
#'    |did_not_play                      |logical   |TRUE if the player did not appear in the game.                                                                     |
#'    |reason                            |character |Reason.                                                                                                            |
#'    |active                            |logical   |TRUE if the row represents an active record (player / team / season).                                              |
#'    |athlete_jersey                    |character |Athlete jersey number.                                                                                             |
#'    |athlete_short_name                |character |Athlete short display name.                                                                                        |
#'    |athlete_headshot_href             |character |Athlete headshot image URL.                                                                                        |
#'    |athlete_position_name             |character |Athlete position ('Guard', 'Forward', 'Center').                                                                   |
#'    |athlete_position_abbreviation     |character |Athlete position abbreviation (G / F / C).                                                                         |
#'    |team_display_name                 |character |Full team display name.                                                                                            |
#'    |team_uid                          |character |ESPN universal team identifier (UID format 's:40~l:...~t:...').                                                    |
#'    |team_slug                         |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                                                          |
#'    |team_logo                         |character |Team logo image URL.                                                                                               |
#'    |team_abbreviation                 |character |Short team abbreviation (e.g. 'LAS').                                                                              |
#'    |team_color                        |character |Team primary color (hex without leading '#').                                                                      |
#'    |team_alternate_color              |character |Team alternate color (hex without leading '#').                                                                    |
#'    |home_away                         |character |Game venue label ('home' or 'away').                                                                               |
#'    |team_winner                       |logical   |TRUE if the team won this game.                                                                                    |
#'    |team_score                        |integer   |Team's score / final score.                                                                                        |
#'    |opponent_team_id                  |integer   |Unique identifier for the opponent team.                                                                           |
#'    |opponent_team_name                |character |Opponent team display name.                                                                                        |
#'    |opponent_team_location            |character |Opponent team city / location.                                                                                     |
#'    |opponent_team_display_name        |character |Opponent team full display name.                                                                                   |
#'    |opponent_team_abbreviation        |character |Opponent team abbreviation.                                                                                        |
#'    |opponent_team_logo                |character |Opponent team logo URL.                                                                                            |
#'    |opponent_team_color               |character |Opponent team primary color (hex).                                                                                 |
#'    |opponent_team_alternate_color     |character |Opponent team alternate color (hex).                                                                               |
#'    |opponent_team_score               |integer   |Opponent team's score.                                                                                             |
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
  dots <- rlang::dots_list(...)
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
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
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
#'    |col_name                  |types     |description                                                                                                        |
#'    |:-------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |id                        |integer   |Id.                                                                                                                |
#'    |uid                       |character |ESPN UID string (universal identifier).                                                                            |
#'    |date                      |character |Date in YYYY-MM-DD format.                                                                                         |
#'    |attendance                |integer   |Reported attendance.                                                                                               |
#'    |time_valid                |logical   |Time valid.                                                                                                        |
#'    |neutral_site              |logical   |Neutral site.                                                                                                      |
#'    |conference_competition    |logical   |Conference competition.                                                                                            |
#'    |recent                    |logical   |Recent.                                                                                                            |
#'    |start_date                |character |Start date (YYYY-MM-DD).                                                                                           |
#'    |notes_type                |character |Notes type.                                                                                                        |
#'    |notes_headline            |character |Notes headline.                                                                                                    |
#'    |type_id                   |integer   |Type identifier (numeric).                                                                                         |
#'    |type_abbreviation         |character |Type abbreviation.                                                                                                 |
#'    |venue_id                  |integer   |Unique venue identifier.                                                                                           |
#'    |venue_full_name           |character |Venue full name.                                                                                                   |
#'    |venue_address_city        |character |Venue address city.                                                                                                |
#'    |venue_capacity            |integer   |Venue seating capacity.                                                                                            |
#'    |venue_indoor              |logical   |TRUE if the venue is indoors.                                                                                      |
#'    |status_clock              |integer   |Status clock.                                                                                                      |
#'    |status_display_clock      |character |Status display clock.                                                                                              |
#'    |status_period             |integer   |Status period.                                                                                                     |
#'    |status_type_id            |integer   |Unique identifier for status type.                                                                                 |
#'    |status_type_name          |character |Status type name.                                                                                                  |
#'    |status_type_state         |character |Status type state.                                                                                                 |
#'    |status_type_completed     |logical   |Status type completed.                                                                                             |
#'    |status_type_description   |character |Status type description.                                                                                           |
#'    |status_type_detail        |character |Status type detail.                                                                                                |
#'    |status_type_short_detail  |character |Status type short detail.                                                                                          |
#'    |format_regulation_periods |integer   |Format regulation periods.                                                                                         |
#'    |home_id                   |integer   |Unique identifier for home.                                                                                        |
#'    |home_uid                  |character |Home team's uid.                                                                                                   |
#'    |home_location             |character |Home team's location.                                                                                              |
#'    |home_name                 |character |Home name.                                                                                                         |
#'    |home_abbreviation         |character |Home team's abbreviation.                                                                                          |
#'    |home_display_name         |character |Home display name.                                                                                                 |
#'    |home_short_display_name   |character |Home short display name.                                                                                           |
#'    |home_color                |character |Color code (hex) for home.                                                                                         |
#'    |home_alternate_color      |character |Color code (hex) for home alternate.                                                                               |
#'    |home_is_active            |logical   |Home team's is active.                                                                                             |
#'    |home_venue_id             |integer   |Unique identifier for home venue.                                                                                  |
#'    |home_logo                 |character |Home team logo URL.                                                                                                |
#'    |home_score                |integer   |Home team score at the time of the play.                                                                           |
#'    |home_winner               |logical   |Home team's winner.                                                                                                |
#'    |away_id                   |integer   |Unique identifier for away.                                                                                        |
#'    |away_uid                  |character |Away team's uid.                                                                                                   |
#'    |away_location             |character |Away team's location.                                                                                              |
#'    |away_name                 |character |Away name.                                                                                                         |
#'    |away_abbreviation         |character |Away team's abbreviation.                                                                                          |
#'    |away_display_name         |character |Away display name.                                                                                                 |
#'    |away_short_display_name   |character |Away short display name.                                                                                           |
#'    |away_color                |character |Color code (hex) for away.                                                                                         |
#'    |away_alternate_color      |character |Color code (hex) for away alternate.                                                                               |
#'    |away_is_active            |logical   |Away team's is active.                                                                                             |
#'    |away_venue_id             |integer   |Unique identifier for away venue.                                                                                  |
#'    |away_logo                 |character |Away team logo URL.                                                                                                |
#'    |away_score                |integer   |Away team score at the time of the play.                                                                           |
#'    |away_winner               |logical   |Away team's winner.                                                                                                |
#'    |game_id                   |integer   |Unique game identifier.                                                                                            |
#'    |season                    |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type               |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |venue_address_state       |character |Venue address state / region.                                                                                      |
#'    |status_type_alt_detail    |character |Status type alt detail.                                                                                            |
#'    |PBP                       |logical   |                                                                                                                   |
#'    |team_box                  |logical   |Team box.                                                                                                          |
#'    |player_box                |logical   |Player box.                                                                                                        |
#'    |game_date_time            |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'    |game_date                 |Date      |Game date (YYYY-MM-DD).                                                                                            |
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
  dots <- rlang::dots_list(...)

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
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
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


#' **Load hoopR NBA standings**
#' @name load_nba_standings
NULL
#' @title
#' **Load cleaned NBA standings from the data repo**
#' @rdname load_nba_standings
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
  dots <- rlang::dots_list(...)

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
  class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  out
}


#' **Load hoopR NBA game rosters**
#' @name load_nba_game_rosters
NULL
#' @title
#' **Load cleaned NBA per-game rosters from the data repo**
#' @rdname load_nba_game_rosters
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
  dots <- rlang::dots_list(...)

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
  class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  out
}
