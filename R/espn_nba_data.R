#' **Get ESPN NBA game data (Pbp, Team and Player Box)**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A named list of data frames: Plays, Team, Player
#'
#'    **Plays**
#'
#'
#'    |col_name                  |types     |description                                                                                                        |
#'    |:-------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |id                        |character |Id.                                                                                                                |
#'    |sequence_number           |character |Sequence number representing a shot-possession (V3 PBP).                                                           |
#'    |text                      |character |Text description of the play / record.                                                                             |
#'    |away_score                |integer   |Away team score at the time of the play.                                                                           |
#'    |home_score                |integer   |Home team score at the time of the play.                                                                           |
#'    |scoring_play              |logical   |TRUE if the play resulted in points scored.                                                                        |
#'    |score_value               |integer   |Point value of the play (2 / 3 / 1).                                                                               |
#'    |wallclock                 |character |Wallclock.                                                                                                         |
#'    |shooting_play             |logical   |TRUE if the play was a shooting attempt.                                                                           |
#'    |type_id                   |integer   |Type identifier (numeric).                                                                                         |
#'    |type_text                 |character |Display text for the type field.                                                                                   |
#'    |period_number             |integer   |Numeric period (1-4 for quarters; 5+ for OT).                                                                      |
#'    |period_display_value      |character |Period display label (e.g. '1st Quarter', 'OT').                                                                   |
#'    |clock_display_value       |character |Game clock display string (e.g. '8:32').                                                                           |
#'    |team_id                   |integer   |Unique team identifier.                                                                                            |
#'    |coordinate_x_raw          |numeric   |X coordinate as returned by the API before any adjustment.                                                         |
#'    |coordinate_y_raw          |numeric   |Y coordinate as returned by the API before any adjustment.                                                         |
#'    |coordinate_x              |numeric   |X coordinate on the court (half-court layout).                                                                     |
#'    |coordinate_y              |numeric   |Y coordinate on the court (half-court layout).                                                                     |
#'    |play_id                   |character |Unique play identifier within a game.                                                                              |
#'    |athlete_id_1              |integer   |Primary athlete identifier (e.g. shooter).                                                                         |
#'    |athlete_id_2              |integer   |Secondary athlete identifier (e.g. assister / fouler).                                                             |
#'    |athlete_id_3              |integer   |Athlete id 3.                                                                                                      |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                                                               |
#'    |home_team_mascot          |character |Home team mascot.                                                                                                  |
#'    |home_team_name            |character |Home team name.                                                                                                    |
#'    |home_team_abbrev          |character |Home team three-letter abbreviation.                                                                               |
#'    |home_team_logo            |character |Home team logo URL.                                                                                                |
#'    |home_team_logo_dark       |character |Home team logo URL for dark backgrounds.                                                                           |
#'    |home_team_full_name       |character |Full home team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |home_team_color           |character |Home team primary color (hex).                                                                                     |
#'    |home_team_alternate_color |character |Home team alternate color (hex).                                                                                   |
#'    |home_team_score           |integer   |Home team's score.                                                                                                 |
#'    |home_team_winner          |logical   |TRUE if the home team won this game.                                                                               |
#'    |home_team_record          |character |Home team's win-loss record.                                                                                       |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                                                               |
#'    |away_team_mascot          |character |Away team mascot.                                                                                                  |
#'    |away_team_name            |character |Away team name.                                                                                                    |
#'    |away_team_abbrev          |character |Away team three-letter abbreviation.                                                                               |
#'    |away_team_logo            |character |Away team logo URL.                                                                                                |
#'    |away_team_logo_dark       |character |Away team logo URL for dark backgrounds.                                                                           |
#'    |away_team_full_name       |character |Full away team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |away_team_color           |character |Away team primary color (hex).                                                                                     |
#'    |away_team_alternate_color |character |Away team alternate color (hex).                                                                                   |
#'    |away_team_score           |integer   |Away team's score.                                                                                                 |
#'    |away_team_winner          |logical   |TRUE if the away team won this game.                                                                               |
#'    |away_team_record          |character |Away team's win-loss record.                                                                                       |
#'    |game_id                   |integer   |Unique game identifier.                                                                                            |
#'    |season                    |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type               |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |game_date                 |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |game_date_time            |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'
#'    **Team**
#'
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
#'    **Player**
#'
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_game_all(game_id = 401283399))
#' }
#'
espn_nba_game_all <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  pbp <- list(Plays = NULL, Team = NULL, Player = NULL)
  resp <- NULL
  plays_df <- NULL
  team_box_score <- NULL
  player_box_score <- NULL

  #---- Fetch the summary endpoint (single outer tryCatch) -------------------
  tryCatch(
    expr = {
      res <- .retry_request(full_url)
      check_status(res)
      resp <- res %>%
        .resp_text()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Could not fetch game summary for game_id = {game_id}",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  if (is.null(resp)) {
    return(pbp)
  }

  #---- Play-by-Play ------
  tryCatch(
    expr = {
      plays_df <- helper_espn_nba_pbp(resp)

      if (is.null(plays_df)) {
        message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  #---- Team Box ------
  tryCatch(
    expr = {
      team_box_score <- helper_espn_nba_team_box(resp)

      if (is.null(team_box_score)) {
        message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  #---- Player Box ------
  tryCatch(
    expr = {
      player_box_score <- helper_espn_nba_player_box(resp)

      if (is.null(player_box_score)) {
        message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  pbp <- c(list(plays_df), list(team_box_score), list(player_box_score))
  names(pbp) <- c("Plays", "Team", "Player")
  return(pbp)
}


#' **Get ESPN NBA PBP data**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A play-by-play data frame.
#'
#'    **Plays**
#'
#'
#'    |col_name                  |types     |description                                                                                                        |
#'    |:-------------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |id                        |character |Id.                                                                                                                |
#'    |sequence_number           |character |Sequence number representing a shot-possession (V3 PBP).                                                           |
#'    |text                      |character |Text description of the play / record.                                                                             |
#'    |away_score                |integer   |Away team score at the time of the play.                                                                           |
#'    |home_score                |integer   |Home team score at the time of the play.                                                                           |
#'    |scoring_play              |logical   |TRUE if the play resulted in points scored.                                                                        |
#'    |score_value               |integer   |Point value of the play (2 / 3 / 1).                                                                               |
#'    |wallclock                 |character |Wallclock.                                                                                                         |
#'    |shooting_play             |logical   |TRUE if the play was a shooting attempt.                                                                           |
#'    |type_id                   |integer   |Type identifier (numeric).                                                                                         |
#'    |type_text                 |character |Display text for the type field.                                                                                   |
#'    |period_number             |integer   |Numeric period (1-4 for quarters; 5+ for OT).                                                                      |
#'    |period_display_value      |character |Period display label (e.g. '1st Quarter', 'OT').                                                                   |
#'    |clock_display_value       |character |Game clock display string (e.g. '8:32').                                                                           |
#'    |team_id                   |integer   |Unique team identifier.                                                                                            |
#'    |coordinate_x_raw          |numeric   |X coordinate as returned by the API before any adjustment.                                                         |
#'    |coordinate_y_raw          |numeric   |Y coordinate as returned by the API before any adjustment.                                                         |
#'    |coordinate_x              |numeric   |X coordinate on the court (half-court layout).                                                                     |
#'    |coordinate_y              |numeric   |Y coordinate on the court (half-court layout).                                                                     |
#'    |play_id                   |character |Unique play identifier within a game.                                                                              |
#'    |athlete_id_1              |integer   |Primary athlete identifier (e.g. shooter).                                                                         |
#'    |athlete_id_2              |integer   |Secondary athlete identifier (e.g. assister / fouler).                                                             |
#'    |athlete_id_3              |integer   |Athlete id 3.                                                                                                      |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                                                               |
#'    |home_team_mascot          |character |Home team mascot.                                                                                                  |
#'    |home_team_name            |character |Home team name.                                                                                                    |
#'    |home_team_abbrev          |character |Home team three-letter abbreviation.                                                                               |
#'    |home_team_logo            |character |Home team logo URL.                                                                                                |
#'    |home_team_logo_dark       |character |Home team logo URL for dark backgrounds.                                                                           |
#'    |home_team_full_name       |character |Full home team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |home_team_color           |character |Home team primary color (hex).                                                                                     |
#'    |home_team_alternate_color |character |Home team alternate color (hex).                                                                                   |
#'    |home_team_score           |integer   |Home team's score.                                                                                                 |
#'    |home_team_winner          |logical   |TRUE if the home team won this game.                                                                               |
#'    |home_team_record          |character |Home team's win-loss record.                                                                                       |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                                                               |
#'    |away_team_mascot          |character |Away team mascot.                                                                                                  |
#'    |away_team_name            |character |Away team name.                                                                                                    |
#'    |away_team_abbrev          |character |Away team three-letter abbreviation.                                                                               |
#'    |away_team_logo            |character |Away team logo URL.                                                                                                |
#'    |away_team_logo_dark       |character |Away team logo URL for dark backgrounds.                                                                           |
#'    |away_team_full_name       |character |Full away team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |away_team_color           |character |Away team primary color (hex).                                                                                     |
#'    |away_team_alternate_color |character |Away team alternate color (hex).                                                                                   |
#'    |away_team_score           |integer   |Away team's score.                                                                                                 |
#'    |away_team_winner          |logical   |TRUE if the away team won this game.                                                                               |
#'    |away_team_record          |character |Away team's win-loss record.                                                                                       |
#'    |game_id                   |integer   |Unique game identifier.                                                                                            |
#'    |season                    |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type               |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |game_date                 |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |game_date_time            |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA PBP
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_pbp(game_id = 401071880))
#' }
#'
espn_nba_pbp <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  plays_df <- NULL

  #---- Play-by-Play ------
  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      plays_df <- helper_espn_nba_pbp(resp)

      if (is.null(plays_df)) {
        return(message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  return(plays_df)
}


#' **Get ESPN NBA team box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A team boxscore data frame
#'
#'    **Team**
#'
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Team Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_team_box(game_id = 401071880))
#' }
#'
espn_nba_team_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  #---- Team Box ------
  team_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      team_box_score <- helper_espn_nba_team_box(resp)

      if (is.null(team_box_score)) {
        return(message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(team_box_score)
}
#' **Get ESPN NBA player box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A player boxscore data frame
#'
#'    **Player**
#'
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Player Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_player_box(game_id = 401071880))
#' }
#'
espn_nba_player_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  #---- Player Box ------
  player_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      player_box_score <- helper_espn_nba_player_box(resp)

      if (is.null(player_box_score)) {
        return(message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(player_box_score)
}


#' **Get ESPN NBA game rosters**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A game rosters data frame
#'
#'    |col_name                                   |types     |description                                                           |
#'    |:------------------------------------------|:---------|:---------------------------------------------------------------------|
#'    |athlete_id                                 |integer   |Unique athlete identifier (ESPN).                                     |
#'    |athlete_uid                                |character |ESPN athlete UID (universal identifier).                              |
#'    |athlete_guid                               |character |ESPN athlete GUID.                                                    |
#'    |athlete_type                               |character |Athlete type / class.                                                 |
#'    |sdr                                        |integer   |Sdr.                                                                  |
#'    |first_name                                 |character |Player's first name.                                                  |
#'    |last_name                                  |character |Player's last name.                                                   |
#'    |full_name                                  |character |Player's full name.                                                   |
#'    |athlete_display_name                       |character |Athlete display name (full).                                          |
#'    |short_name                                 |character |Short display name.                                                   |
#'    |weight                                     |integer   |Player weight in pounds.                                              |
#'    |display_weight                             |character |Player weight in display format (e.g. '180 lbs').                     |
#'    |height                                     |integer   |Player height (string e.g. '6-2' or inches).                          |
#'    |display_height                             |character |Player height in display format (e.g. '6-2').                         |
#'    |age                                        |integer   |Player age (in years).                                                |
#'    |date_of_birth                              |character |Date of birth (YYYY-MM-DD).                                           |
#'    |debut_year                                 |integer   |Year of professional debut.                                           |
#'    |birth_place_city                           |character |Birth place city.                                                     |
#'    |birth_place_state                          |character |Birth place state.                                                    |
#'    |birth_place_country                        |character |Birth place country.                                                  |
#'    |slug                                       |character |URL-safe identifier.                                                  |
#'    |headshot_href                              |character |Headshot image URL.                                                   |
#'    |headshot_alt                               |character |Alternative-text label for the headshot.                              |
#'    |jersey                                     |character |Jersey number worn by the player.                                     |
#'    |position_id                                |integer   |Unique position identifier.                                           |
#'    |position_name                              |character |Listed roster position ('Guard', 'Forward', 'Center').                |
#'    |position_display_name                      |character |Position display name.                                                |
#'    |position_abbreviation                      |character |Position abbreviation ('G' / 'F' / 'C').                              |
#'    |position_leaf                              |logical   |Position leaf.                                                        |
#'    |linked                                     |logical   |TRUE if the record is linked to a related entity.                     |
#'    |years                                      |integer   |Years.                                                                |
#'    |active                                     |logical   |TRUE if the row represents an active record (player / team / season). |
#'    |contract_bird_status                       |integer   |Contract bird status.                                                 |
#'    |contract_active                            |logical   |Contract active.                                                      |
#'    |contract_active_1                          |logical   |Contract active 1.                                                    |
#'    |contract_incoming_trade_value              |integer   |Contract incoming trade value.                                        |
#'    |contract_outgoing_trade_value              |integer   |Contract outgoing trade value.                                        |
#'    |contract_minimum_salary_exception          |logical   |Contract minimum salary exception.                                    |
#'    |contract_option_type                       |integer   |Contract option type.                                                 |
#'    |contract_salary                            |integer   |Contract salary.                                                      |
#'    |contract_salary_remaining                  |integer   |Contract salary remaining.                                            |
#'    |contract_years_remaining                   |integer   |Contract years remaining.                                             |
#'    |contract_trade_kicker_active               |logical   |Contract trade kicker active.                                         |
#'    |contract_trade_kicker_percentage           |integer   |Contract trade kicker percentage (0-1 decimal).                       |
#'    |contract_trade_kicker_value                |integer   |Contract trade kicker value.                                          |
#'    |contract_trade_kicker_trade_value          |integer   |Contract trade kicker trade value.                                    |
#'    |contract_trade_restriction                 |logical   |Contract trade restriction.                                           |
#'    |contract_unsigned_foreign_pick             |logical   |Contract unsigned foreign pick.                                       |
#'    |contract_active_2                          |logical   |Contract active 2.                                                    |
#'    |draft_display_text                         |character |Draft display text.                                                   |
#'    |draft_round                                |integer   |Round of the draft selection.                                         |
#'    |draft_year                                 |integer   |Draft year (4-digit).                                                 |
#'    |draft_selection                            |integer   |Draft selection.                                                      |
#'    |status_id                                  |integer   |Status identifier.                                                    |
#'    |status_name                                |character |Status label.                                                         |
#'    |status_type                                |character |Status type.                                                          |
#'    |status_abbreviation                        |character |Status abbreviation.                                                  |
#'    |starter                                    |logical   |TRUE if the player was in the starting lineup; FALSE otherwise.       |
#'    |valid                                      |logical   |Valid.                                                                |
#'    |did_not_play                               |logical   |TRUE if the player did not appear in the game.                        |
#'    |display_name                               |character |Display name.                                                         |
#'    |reason                                     |character |Reason.                                                               |
#'    |ejected                                    |logical   |TRUE if the player was ejected from the game.                         |
#'    |team_id                                    |integer   |Unique team identifier.                                               |
#'    |team_guid                                  |character |ESPN team GUID.                                                       |
#'    |team_uid                                   |character |ESPN universal team identifier (UID format 's:40~l:...~t:...').       |
#'    |team_slug                                  |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').             |
#'    |team_location                              |character |Team city or location string.                                         |
#'    |team_name                                  |character |Full team display name (e.g. 'Las Vegas Aces').                       |
#'    |team_abbreviation                          |character |Short team abbreviation (e.g. 'LAS').                                 |
#'    |team_display_name                          |character |Full team display name.                                               |
#'    |team_short_display_name                    |character |Short team display name (e.g. 'Aces').                                |
#'    |team_color                                 |character |Team primary color (hex without leading '#').                         |
#'    |team_alternate_color                       |character |Team alternate color (hex without leading '#').                       |
#'    |team_is_active                             |logical   |TRUE if the team is currently active.                                 |
#'    |team_is_all_star                           |logical   |TRUE if the row represents an All-Star team.                          |
#'    |logo_href                                  |character |Team or league logo URL.                                              |
#'    |logo_dark_href                             |character |Logo URL for dark backgrounds.                                        |
#'    |logos_href_2                               |character |Logos href 2.                                                         |
#'    |logos_href_3                               |character |Logos href 3.                                                         |
#'    |game_id                                    |integer   |Unique game identifier.                                               |
#'    |order                                      |integer   |Display order within the result set.                                  |
#'    |home_away                                  |character |Game venue label ('home' or 'away').                                  |
#'    |winner                                     |logical   |Winner.                                                               |
#'    |citizenship                                |character |Citizenship.                                                          |
#'    |contract_base_year_compensation_active     |logical   |Contract base year compensation active.                               |
#'    |contract_base_year_compensation_expiration |character |Contract base year compensation expiration.                           |
#'    |hand_type                                  |character |Hand type.                                                            |
#'    |hand_abbreviation                          |character |Hand abbreviation.                                                    |
#'    |hand_display_value                         |character |Hand display value.                                                   |
#'
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game Roster
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_game_rosters(game_id = 401283399))
#' }
espn_nba_game_rosters <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  athlete_roster_df <- .empty_hoopR_data("ESPN NBA Game Roster Information from ESPN.com")

  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/events/",
        game_id,
        "/competitions/",
        game_id,
        "/competitors/"
      )
      game_res <- .retry_request(play_base_url)
      # Check the result
      check_status(game_res)

      game_resp <- game_res %>%
        .resp_text()
      game_df <- jsonlite::fromJSON(game_resp)[["items"]] %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename("team_statistics_href" = "statistics.$ref")

      colnames(game_df) <- gsub(".\\$ref", "_href", colnames(game_df))

      game_df <- game_df %>%
        dplyr::rename(
          "team_id" = "id",
          "team_uid" = "uid"
        )

      game_df$game_id <- game_id

      teams_df <- purrr::map_dfr(game_df$team_href, function(x) {
        res <- .retry_request(x)
        # Check the result
        check_status(res)

        team_df <- res %>%
          .resp_text() %>%
          jsonlite::fromJSON(
            simplifyDataFrame = FALSE,
            simplifyVector = FALSE,
            simplifyMatrix = FALSE
          )

        team_df[["links"]] <- NULL
        team_df[["injuries"]] <- NULL
        team_df[["record"]] <- NULL
        team_df[["athletes"]] <- NULL
        team_df[["venue"]] <- NULL
        team_df[["groups"]] <- NULL
        team_df[["ranks"]] <- NULL
        team_df[["statistics"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["links"]] <- NULL
        team_df[["notes"]] <- NULL
        team_df[["franchise"]] <- NULL
        team_df[["againstTheSpreadRecords"]] <- NULL
        team_df[["oddsRecords"]] <- NULL
        team_df[["college"]] <- NULL
        team_df[["transactions"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["depthCharts"]] <- NULL
        team_df[["awards"]] <- NULL
        team_df[["events"]] <- NULL

        team_df <- team_df %>%
          purrr::map_if(is.list, as.data.frame) %>%
          as.data.frame() %>%
          dplyr::select(
            -dplyr::any_of(
              c(
                "logos.width",
                "logos.height",
                "logos.alt",
                "logos.rel..full.",
                "logos.rel..default.",
                "logos.rel..scoreboard.",
                "logos.rel..scoreboard..1",
                "logos.rel..scoreboard.2",
                "logos.lastUpdated",
                "logos.width.1",
                "logos.height.1",
                "logos.alt.1",
                "logos.rel..full..1",
                "logos.rel..dark.",
                "logos.rel..dark..1",
                "logos.lastUpdated.1",
                "logos.width.2",
                "logos.height.2",
                "logos.alt.2",
                "logos.rel..full..2",
                "logos.rel..scoreboard.",
                "logos.lastUpdated.2",
                "logos.width.3",
                "logos.height.3",
                "logos.alt.3",
                "logos.rel..full..3",
                "logos.lastUpdated.3",
                "X.ref",
                "X.ref.1",
                "X.ref.2"
              )
            )
          ) %>%
          janitor::clean_names()

        colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

        team_df <- team_df %>%
          dplyr::rename(
            "logo_href" = "logos_href",
            "logo_dark_href" = "logos_href_1"
          ) %>%
          dplyr::left_join(
            game_df %>%
              dplyr::select(
                "game_id",
                "team_id",
                "team_uid",
                "order",
                "homeAway",
                "winner",
                "roster_href"
              ),
            by = c(
              "team_id" = "team_id",
              "team_uid" = "team_uid"
            )
          )
      })

      ## Inputs
      ## game_id
      team_roster_df <- purrr::map_dfr(teams_df$team_id, function(x) {
        res <- .retry_request(paste0(play_base_url, x, "/roster"))

        # Check the result
        check_status(res)

        resp <- res %>%
          .resp_text()

        raw_play_df <- jsonlite::fromJSON(resp)[["entries"]]

        raw_play_df <- raw_play_df %>%
          jsonlite::toJSON() %>%
          jsonlite::fromJSON(flatten = TRUE) %>%
          dplyr::mutate(team_id = x) %>%
          dplyr::select(-"period", -"forPlayerId", -"active")

        raw_play_df <- raw_play_df %>%
          dplyr::left_join(teams_df, by = c("team_id" = "team_id"))
      })

      colnames(team_roster_df) <- gsub(
        ".\\$ref",
        "_href",
        colnames(team_roster_df)
      )

      athlete_roster_df <- purrr::map_dfr(
        team_roster_df$athlete_href,
        function(x) {
          res <- .retry_request(x)

          # Check the result
          check_status(res)

          resp <- res %>%
            .resp_text()

          raw_play_df <- jsonlite::fromJSON(resp, flatten = TRUE)
          raw_play_df[["links"]] <- NULL
          raw_play_df[["injuries"]] <- NULL
          raw_play_df[["teams"]] <- NULL
          raw_play_df[["team"]] <- NULL
          raw_play_df[["college"]] <- NULL
          raw_play_df[["proAthlete"]] <- NULL
          raw_play_df[["statistics"]] <- NULL
          raw_play_df[["notes"]] <- NULL
          raw_play_df[["eventLog"]] <- NULL
          raw_play_df[["$ref"]] <- NULL
          raw_play_df[["position"]][["$ref"]] <- NULL

          raw_play_df2 <- raw_play_df %>%
            jsonlite::toJSON() %>%
            jsonlite::fromJSON(flatten = TRUE) %>%
            as.data.frame() %>%
            dplyr::mutate(id = as.integer(.data$id)) %>%
            dplyr::rename(
              "athlete_id" = "id",
              "athlete_uid" = "uid",
              "athlete_guid" = "guid",
              "athlete_type" = "type",
              "athlete_display_name" = "displayName",
              "athlete_jersey_number" = "jersey"
            )

          raw_play_df2 <- raw_play_df2 %>%
            dplyr::left_join(team_roster_df, by = c("athlete_id" = "playerId"))
        }
      )

      colnames(athlete_roster_df) <- gsub(
        ".\\$ref",
        "_href",
        colnames(athlete_roster_df)
      )

      athlete_roster_df <- athlete_roster_df %>%
        janitor::clean_names() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "x_ref",
            "x_ref_1",
            "contract_ref",
            "contract_ref_1",
            "contract_ref_2",
            "draft_ref",
            "draft_ref_1",
            "athlete_href",
            "position_ref",
            "position_href",
            "roster_href",
            "statistics_href"
          ))
        ) %>%
        dplyr::mutate_at(
          c(
            "game_id",
            "athlete_id",
            "team_id",
            "position_id",
            "status_id",
            "sdr"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Game Roster Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game roster data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(athlete_roster_df)
}


#' **Get ESPN NBA team names and IDs**
#' @author Saiem Gilani
#' @return A teams data frame
#'
#'    |col_name        |types     |description                                |
#'    |:---------------|:---------|:------------------------------------------|
#'    |team_id         |integer   |Unique team identifier.                    |
#'    |abbreviation    |character |Short abbreviation.                        |
#'    |display_name    |character |Display name.                              |
#'    |short_name      |character |Short display name.                        |
#'    |mascot          |character |Team mascot.                               |
#'    |nickname        |character |Team or athlete nickname.                  |
#'    |team            |character |Team-side label or team identifier.        |
#'    |color           |character |Primary color (hex without leading '#').   |
#'    |alternate_color |character |Alternate color (hex without leading '#'). |
#'    |logo            |character |Team or league logo URL.                   |
#'    |logo_dark       |character |Logo dark.                                 |
#'    |logos_href_3    |character |Logos href 3.                              |
#'    |logos_href_4    |character |Logos href 4.                              |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import rvest
#' @export
#' @keywords NBA Teams
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_teams())
#' }
#'
espn_nba_teams <- function() {
  .args <- .capture_args()
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  teams_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams?limit=1000"

  teams <- .empty_hoopR_data("ESPN NBA Teams Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(teams_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      leagues <- jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][[
        "teams"
      ]][[1]][["team"]] %>%
        dplyr::group_by(.data$id) %>%
        tidyr::unnest_wider("logos", names_sep = "_") %>%
        tidyr::unnest_wider("logos_href", names_sep = "_") %>%
        dplyr::select(
          -"logos_width",
          -"logos_height",
          -"logos_alt",
          -"logos_rel"
        ) %>%
        dplyr::ungroup()

      if ("records" %in% colnames(leagues)) {
        records <- leagues$record
        records <- records %>%
          tidyr::unnest_wider("items") %>%
          tidyr::unnest_wider("stats", names_sep = "_") %>%
          dplyr::mutate(row = dplyr::row_number())
        stat <- records %>%
          dplyr::group_by(.data$row) %>%
          purrr::map_if(is.data.frame, list)
        stat <- lapply(stat$stats_1, function(x) {
          x %>%
            purrr::map_if(is.data.frame, list) %>%
            dplyr::as_tibble()
        })

        s <- lapply(stat, function(x) {
          tidyr::pivot_wider(x)
        })

        s <- tibble::tibble(g = s)
        stats <- s %>%
          tidyr::unnest_wider("g")

        records <- dplyr::bind_cols(records %>% dplyr::select("summary"), stats)
        leagues <- leagues %>%
          dplyr::select(-"record")
      }
      leagues <- leagues %>%
        dplyr::select(
          -"links",
          -"isActive",
          -"isAllStar",
          -"uid",
          -"slug"
        )
      teams <- leagues %>%
        dplyr::rename(
          "logo" = "logos_href_1",
          "logo_dark" = "logos_href_2",
          "mascot" = "name",
          "team" = "location",
          "team_id" = "id",
          "short_name" = "shortDisplayName",
          "alternate_color" = "alternateColor",
          "display_name" = "displayName"
        ) %>%
        janitor::clean_names() %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        make_hoopR_data("ESPN NBA Teams Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no teams data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(teams)
}


#' **Get ESPN NBA current team roster**
#'
#' @author Saiem Gilani
#' @param team_id Either numeric or character (YYYY)
#' @return A teams data frame
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import rvest
#' @export
#' @keywords NBA Team Roster
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_team_current_roster(team_id = 13))
#' }
espn_nba_team_current_roster <- function(team_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  team_roster_full <- .empty_hoopR_data("ESPN NBA Team Current Roster Information from ESPN.com")

  tryCatch(
    expr = {
      teams_base_url <- sprintf(
        "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/%s?enable=roster",
        team_id
      )

      res <- .retry_request(teams_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      team_roster <- resp %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("team") %>%
        purrr::discard_at(c("links", "nextEvent", "record"))

      players <- team_roster %>%
        purrr::pluck("athletes") %>%
        purrr::discard_at(c("links", "injuries", "teams")) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::as_tibble() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "headshot.width",
            "headshot.height",
            "headshot.alt",
            "headshot.rel",
            "teams",
            "flag.alt",
            "flag.rel",
            "flag.width",
            "flag.height"
          ))
        )

      colnames(players) <- paste0("athlete_", colnames(players))

      players <- players %>%
        dplyr::mutate(
          athlete_id = as.integer(.data$athlete_id),
          team_id = as.integer(team_id)
        ) %>%
        janitor::clean_names()

      conference_info <- team_roster %>%
        purrr::pluck("groups") %>%
        dplyr::as_tibble() %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename(dplyr::any_of(c(
          "group_id" = "id",
          "group_is_conference" = "isConference",
          "parent_group_id" = "parent"
        ))) %>%
        dplyr::mutate(
          group_id = as.integer(.data$group_id),
          conference_id = .data$group_id,
          parent_group_id = as.integer(.data$parent_group_id)
        )

      team_roster_full <- team_roster %>%
        purrr::discard_at(c("groups", "athletes")) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        data.frame() %>%
        dplyr::slice(1:2) %>%
        dplyr::mutate(
          logo = .data$logos.href[1],
          logo_dark = .data$logos.href[2]
        ) %>%
        dplyr::slice(1) %>%
        dplyr::select(
          -dplyr::any_of(c(
            "logos.href",
            "logos.width",
            "logos.height",
            "logos.alt",
            "logos.rel",
            "logos.lastUpdated"
          ))
        ) %>%
        dplyr::rename(dplyr::any_of(c(
          "team_id" = "id",
          "team_uid" = "uid",
          "team_guid" = "guid",
          "team_slug" = "slug",
          "team_is_active" = "isActive",
          "team_type" = "type",
          "team_display_name" = "displayName",
          "team_short_name" = "shortDisplayName",
          "team_location" = "location",
          "team_name" = "name",
          "team_nickname" = "nickname",
          "team_abbreviation" = "abbreviation",
          "team_color" = "color",
          "team_alternate_color" = "alternateColor"
        ))) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        dplyr::bind_cols(conference_info) %>%
        dplyr::left_join(players, by = c("team_id" = "team_id")) %>%
        make_hoopR_data(
          "ESPN NBA Team Current Roster Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team current roster data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(team_roster_full)
}


#' **Get ESPN NBA schedule for a specific year**
#'
#' @param season Either numeric or character (YYYYMMDD)
#' @return Returns a tibble with scoreboard data
#'
#'    |col_name            |types     |description                                                                                                        |
#'    |:-------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |matchup             |character |Matchup.                                                                                                           |
#'    |matchup_short       |character |Matchup short.                                                                                                     |
#'    |season              |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type         |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |season_slug         |character |Season slug.                                                                                                       |
#'    |game_id             |integer   |Unique game identifier.                                                                                            |
#'    |game_uid            |character |Game uid.                                                                                                          |
#'    |game_date           |Date      |Game date (YYYY-MM-DD).                                                                                            |
#'    |attendance          |integer   |Reported attendance.                                                                                               |
#'    |notes               |logical   |Free-form notes attached to the record.                                                                            |
#'    |status_name         |character |Status label.                                                                                                      |
#'    |broadcasts          |logical   |JSON array of broadcast records.                                                                                   |
#'    |start_date          |character |Start date (YYYY-MM-DD).                                                                                           |
#'    |geo_broadcasts      |logical   |Geo broadcasts.                                                                                                    |
#'    |game_date_time      |POSIXct   |Game start date/time (ISO 8601).                                                                                   |
#'    |home_team_name      |character |Home team name.                                                                                                    |
#'    |home_team_logo      |character |Home team logo URL.                                                                                                |
#'    |home_team_abb       |character |Home team's team abb.                                                                                              |
#'    |home_team_id        |integer   |Unique identifier for the home team.                                                                               |
#'    |home_team_location  |character |Home team's team location.                                                                                         |
#'    |home_team_full_name |character |Full home team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |home_team_color     |character |Home team primary color (hex).                                                                                     |
#'    |home_score          |integer   |Home team score at the time of the play.                                                                           |
#'    |home_win            |integer   |Home team's win.                                                                                                   |
#'    |home_record         |character |Home win-loss record.                                                                                              |
#'    |away_team_name      |character |Away team name.                                                                                                    |
#'    |away_team_logo      |character |Away team logo URL.                                                                                                |
#'    |away_team_abb       |character |Away team's team abb.                                                                                              |
#'    |away_team_id        |integer   |Unique identifier for the away team.                                                                               |
#'    |away_team_location  |character |Away team's team location.                                                                                         |
#'    |away_team_full_name |character |Full away team name (e.g. 'Las Vegas Aces').                                                                       |
#'    |away_team_color     |character |Away team primary color (hex).                                                                                     |
#'    |away_score          |integer   |Away team score at the time of the play.                                                                           |
#'    |away_win            |integer   |Away team's win.                                                                                                   |
#'    |away_record         |character |Away win-loss record.                                                                                              |
#'
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom lubridate with_tz ymd_hm
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @examples
#'
#' # Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
#' \donttest{
#' try(espn_nba_scoreboard(season = 20230423))
#' }
espn_nba_scoreboard <- function(season) {
  .args <- mget(setdiff(names(formals()), "..."))
  max_year <- substr(Sys.Date(), 1, 4)

  if (!(as.integer(substr(season, 1, 4)) > 2001)) {
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  schedule_api <- sprintf(
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?limit=1000&dates=%s",
    season_dates
  )

  tryCatch(
    expr = {
      res <- .retry_request(schedule_api)

      # Check the result
      check_status(res)

      raw_sched <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      nba_data <- raw_sched[["events"]] %>%
        tibble::tibble(data = .data$.) %>%
        tidyr::unnest_wider("data") %>%
        tidyr::unchop("competitions") %>%
        dplyr::select(
          -"id",
          -"uid",
          -"date",
          -"status"
        ) %>%
        tidyr::unnest_wider("competitions") %>%
        dplyr::rename(
          "matchup" = "name",
          "matchup_short" = "shortName",
          "game_id" = "id",
          "game_uid" = "uid",
          "game_date" = "date"
        ) %>%
        tidyr::hoist("status", status_name = list("type", "name")) %>%
        dplyr::select(
          !dplyr::any_of(
            c(
              "timeValid",
              "neutralSite",
              "conferenceCompetition",
              "recent",
              "venue",
              "type"
            )
          )
        ) %>%
        tidyr::unnest_wider("season", names_sep = "_") %>%
        dplyr::rename("season" = "season_year") %>%
        dplyr::select(-dplyr::any_of("status"))

      nba_data <- nba_data %>%
        dplyr::mutate(
          game_date_time = lubridate::ymd_hm(substr(
            .data$game_date,
            1,
            nchar(.data$game_date) - 1
          )) %>%
            lubridate::with_tz(tzone = "America/New_York"),
          game_date = as.Date(substr(.data$game_date_time, 1, 10))
        )

      nba_data <- nba_data %>%
        tidyr::hoist(
          "competitors",
          homeAway = list(1, "homeAway")
        )
      nba_data <- nba_data %>%
        tidyr::hoist(
          "competitors",
          team1_team_name = list(1, "team", "name"),
          team1_team_logo = list(1, "team", "logo"),
          team1_team_abb = list(1, "team", "abbreviation"),
          team1_team_id = list(1, "team", "id"),
          team1_team_location = list(1, "team", "location"),
          team1_team_full = list(1, "team", "displayName"),
          team1_team_color = list(1, "team", "color"),
          team1_score = list(1, "score"),
          team1_win = list(1, "winner"),
          team1_record = list(1, "records", 1, "summary"),
          # away team
          team2_team_name = list(2, "team", "name"),
          team2_team_logo = list(2, "team", "logo"),
          team2_team_abb = list(2, "team", "abbreviation"),
          team2_team_id = list(2, "team", "id"),
          team2_team_location = list(2, "team", "location"),
          team2_team_full = list(2, "team", "displayName"),
          team2_team_color = list(2, "team", "color"),
          team2_score = list(2, "score"),
          team2_win = list(2, "winner"),
          team2_record = list(2, "records", 1, "summary")
        )

      nba_data <- nba_data %>%
        dplyr::mutate(
          home_team_name = ifelse(
            .data$homeAway == "home",
            .data$team1_team_name,
            .data$team2_team_name
          ),
          home_team_logo = ifelse(
            .data$homeAway == "home",
            .data$team1_team_logo,
            .data$team2_team_logo
          ),
          home_team_abb = ifelse(
            .data$homeAway == "home",
            .data$team1_team_abb,
            .data$team2_team_abb
          ),
          home_team_id = ifelse(
            .data$homeAway == "home",
            .data$team1_team_id,
            .data$team2_team_id
          ),
          home_team_location = ifelse(
            .data$homeAway == "home",
            .data$team1_team_location,
            .data$team2_team_location
          ),
          home_team_full_name = ifelse(
            .data$homeAway == "home",
            .data$team1_team_full,
            .data$team2_team_full
          ),
          home_team_color = ifelse(
            .data$homeAway == "home",
            .data$team1_team_color,
            .data$team2_team_color
          ),
          home_score = ifelse(
            .data$homeAway == "home",
            .data$team1_score,
            .data$team2_score
          ),
          home_win = ifelse(
            .data$homeAway == "home",
            .data$team1_win,
            .data$team2_win
          ),
          home_record = ifelse(
            .data$homeAway == "home",
            .data$team1_record,
            .data$team2_record
          ),
          away_team_name = ifelse(
            .data$homeAway == "away",
            .data$team1_team_name,
            .data$team2_team_name
          ),
          away_team_logo = ifelse(
            .data$homeAway == "away",
            .data$team1_team_logo,
            .data$team2_team_logo
          ),
          away_team_abb = ifelse(
            .data$homeAway == "away",
            .data$team1_team_abb,
            .data$team2_team_abb
          ),
          away_team_id = ifelse(
            .data$homeAway == "away",
            .data$team1_team_id,
            .data$team2_team_id
          ),
          away_team_location = ifelse(
            .data$homeAway == "away",
            .data$team1_team_location,
            .data$team2_team_location
          ),
          away_team_full_name = ifelse(
            .data$homeAway == "away",
            .data$team1_team_full,
            .data$team2_team_full
          ),
          away_team_color = ifelse(
            .data$homeAway == "away",
            .data$team1_team_color,
            .data$team2_team_color
          ),
          away_score = ifelse(
            .data$homeAway == "away",
            .data$team1_score,
            .data$team2_score
          ),
          away_win = ifelse(
            .data$homeAway == "away",
            .data$team1_win,
            .data$team2_win
          ),
          away_record = ifelse(
            .data$homeAway == "away",
            .data$team1_record,
            .data$team2_record
          )
        )

      nba_data <- nba_data %>%
        dplyr::mutate_at(
          c(
            "game_id",
            "home_team_id",
            "home_win",
            "away_team_id",
            "away_win",
            "home_score",
            "away_score"
          ),
          as.integer
        )
      nba_data <- nba_data %>%
        dplyr::select(
          -dplyr::any_of(dplyr::starts_with("team1")),
          -dplyr::any_of(dplyr::starts_with("team2")),
          -dplyr::any_of(c("homeAway"))
        )

      if ("leaders" %in% names(nba_data)) {
        schedule_out <- nba_data %>%
          tidyr::hoist(
            "leaders",
            # points
            points_leader_points = list(1, "leaders", 1, "value"),
            points_leader_stat = list(1, "leaders", 1, "displayValue"),
            points_leader_name = list(
              1,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            points_leader_shortname = list(
              1,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            points_leader_headshot = list(
              1,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            points_leader_team_id = list(1, "leaders", 1, "team", "id"),
            points_leader_pos = list(
              1,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
            # rebounds
            rebounds_leader_rebounds = list(2, "leaders", 1, "value"),
            rebounds_leader_stat = list(2, "leaders", 1, "displayValue"),
            rebounds_leader_name = list(
              2,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            rebounds_leader_shortname = list(
              2,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            rebounds_leader_headshot = list(
              2,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            rebounds_leader_team_id = list(2, "leaders", 1, "team", "id"),
            rebounds_leader_pos = list(
              2,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
            # assists
            assists_leader_assists = list(3, "leaders", 1, "value"),
            assists_leader_stat = list(3, "leaders", 1, "displayValue"),
            assists_leader_name = list(
              3,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            assists_leader_shortname = list(
              3,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            assists_leader_headshot = list(
              3,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            assists_leader_team_id = list(3, "leaders", 1, "team", "id"),
            assists_leader_pos = list(
              3,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
          )

        if (
          "broadcasts" %in%
            names(schedule_out) &&
            !any(is.na(schedule_out[["broadcasts"]]))
        ) {
          schedule_out %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        }
      } else {
        if (
          "broadcasts" %in%
            names(nba_data) &&
            !any(is.na(nba_data[["broadcasts"]]))
        ) {
          nba_data %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        } else {
          nba_data %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        }
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
}

#' **Get ESPN NBA's Standings**
#'
#' @param year Either numeric or character (YYYY)
#' @return A standings data frame
#'
#'    |col_name           |types     |description                                           |
#'    |:------------------|:---------|:-----------------------------------------------------|
#'    |team_id            |integer   |Unique team identifier.                               |
#'    |team               |character |Team-side label or team identifier.                   |
#'    |avgpointsagainst   |numeric   |Avgpointsagainst.                                     |
#'    |avgpointsfor       |numeric   |Avgpointsfor.                                         |
#'    |clincher           |numeric   |Clincher.                                             |
#'    |differential       |numeric   |Differential.                                         |
#'    |divisionwinpercent |numeric   |Divisionwinpercent.                                   |
#'    |gamesbehind        |numeric   |Gamesbehind.                                          |
#'    |leaguewinpercent   |numeric   |Leaguewinpercent.                                     |
#'    |losses             |numeric   |Total losses.                                         |
#'    |playoffseed        |numeric   |Playoffseed.                                          |
#'    |streak             |numeric   |Current streak (e.g. 'W3' for three-game win streak). |
#'    |winpercent         |numeric   |Winpercent.                                           |
#'    |wins               |numeric   |Total wins.                                           |
#'    |leaguestandings    |character |Leaguestandings.                                      |
#'    |home               |character |Home.                                                 |
#'    |road               |character |Road.                                                 |
#'    |vsdiv              |character |Vsdiv.                                                |
#'    |vsconf             |character |Vsconf.                                               |
#'    |lasttengames       |character |Lasttengames.                                         |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @keywords NBA Standings
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_standings(year = 2021))
#' }
espn_nba_standings <- function(year) {
  .args <- mget(setdiff(names(formals()), "..."))
  standings_url <- "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings?region=us&lang=en&contentorigin=espn&type=0&level=1&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

  ## Inputs
  ## year
  full_url <- paste0(
    standings_url,
    "season=",
    year
  )

  standings <- .empty_hoopR_data("ESPN NBA Standings Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      raw_standings <- jsonlite::fromJSON(resp)[["standings"]]

      # Create a dataframe of all NBA teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]

      teams <- teams %>%
        dplyr::select("id", "displayName") %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName"
        )

      # creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <- data.table::rbindlist(
        standings_df,
        fill = TRUE,
        idcol = T
      )

      # Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <- ifelse(
        is.na(standings_data$value) & !is.na(standings_data$summary),
        standings_data$summary,
        standings_data$value
      )

      standings_data <- standings_data %>%
        dplyr::select(
          ".id",
          "type",
          "value"
        )

      # Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(names_from = "type", values_from = "value")

      standings_data <- standings_data %>%
        dplyr::select(-".id")

      # joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        dplyr::mutate_at(
          c(
            "avgpointsagainst",
            "avgpointsfor",
            "clincher",
            "differential",
            "divisionwinpercent",
            "gamesbehind",
            "leaguewinpercent",
            "losses",
            "playoffseed",
            "streak",
            "winpercent",
            "wins"
          ),
          as.numeric
        )
      standings <- standings %>%
        make_hoopR_data(
          "ESPN NBA Standings Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no standings data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(standings)
}


#' **Get ESPN NBA's Betting information**
#'
#' @param game_id  Game ID
#' @returns Returns a named list of data frames: pickcenter, againstTheSpread, predictor
#'
#'    **pickcenter**
#'
#'
#'    |col_name                             |types     |description                                  |
#'    |:------------------------------------|:---------|:--------------------------------------------|
#'    |details                              |character |Details.                                     |
#'    |over_under                           |numeric   |Over under.                                  |
#'    |spread                               |numeric   |Spread.                                      |
#'    |provider_id                          |integer   |Unique identifier for provider.              |
#'    |provider_name                        |character |Provider name.                               |
#'    |provider_priority                    |integer   |Provider priority.                           |
#'    |away_team_odds_favorite              |logical   |Away team's team odds favorite.              |
#'    |away_team_odds_underdog              |logical   |Away team's team odds underdog.              |
#'    |away_team_odds_money_line            |integer   |Away team's team odds money line.            |
#'    |away_team_odds_spread_odds           |numeric   |Away team's team odds spread odds.           |
#'    |away_team_odds_team_id               |integer   |Unique identifier for away team odds team.   |
#'    |away_team_odds_win_percentage        |numeric   |Away team odds win percentage (0-1 decimal). |
#'    |away_team_odds_average_score         |numeric   |Away team's team odds average score.         |
#'    |away_team_odds_money_line_odds       |numeric   |Away team's team odds money line odds.       |
#'    |away_team_odds_spread_return         |numeric   |Away team's team odds spread return.         |
#'    |away_team_odds_spread_record_wins    |integer   |Away team's team odds spread record wins.    |
#'    |away_team_odds_spread_record_losses  |integer   |Away team's team odds spread record losses.  |
#'    |away_team_odds_spread_record_pushes  |integer   |Away team's team odds spread record pushes.  |
#'    |away_team_odds_spread_record_summary |character |Away team's team odds spread record summary. |
#'    |home_team_odds_favorite              |logical   |Home team's team odds favorite.              |
#'    |home_team_odds_underdog              |logical   |Home team's team odds underdog.              |
#'    |home_team_odds_money_line            |integer   |Home team's team odds money line.            |
#'    |home_team_odds_spread_odds           |numeric   |Home team's team odds spread odds.           |
#'    |home_team_odds_team_id               |integer   |Unique identifier for home team odds team.   |
#'    |home_team_odds_win_percentage        |numeric   |Home team odds win percentage (0-1 decimal). |
#'    |home_team_odds_average_score         |numeric   |Home team's team odds average score.         |
#'    |home_team_odds_money_line_odds       |numeric   |Home team's team odds money line odds.       |
#'    |home_team_odds_spread_return         |numeric   |Home team's team odds spread return.         |
#'    |home_team_odds_spread_record_wins    |integer   |Home team's team odds spread record wins.    |
#'    |home_team_odds_spread_record_losses  |integer   |Home team's team odds spread record losses.  |
#'    |home_team_odds_spread_record_pushes  |integer   |Home team's team odds spread record pushes.  |
#'    |home_team_odds_spread_record_summary |character |Home team's team odds spread record summary. |
#'    |game_id                              |integer   |Unique game identifier.                      |
#'
#'    **againstTheSpread**
#'
#'
#'    |col_name     |types     |description                             |
#'    |:------------|:---------|:---------------------------------------|
#'    |id           |integer   |Id.                                     |
#'    |uid          |character |ESPN UID string (universal identifier). |
#'    |display_name |character |Display name.                           |
#'    |abbreviation |character |Short abbreviation.                     |
#'    |logo         |character |Team or league logo URL.                |
#'    |logos        |list      |Logos.                                  |
#'    |records      |list      |Records.                                |
#'    |game_id      |integer   |Unique game identifier.                 |
#'    |team_id      |integer   |Unique team identifier.                 |
#'
#'    **predictor**
#'
#'
#'    |col_name                  |types   |description                          |
#'    |:-------------------------|:-------|:------------------------------------|
#'    |game_id                   |integer |Unique game identifier.              |
#'    |home_team_id              |integer |Unique identifier for the home team. |
#'    |away_team_id              |integer |Unique identifier for the away team. |
#'    |away_team_game_projection |numeric |Away team's team game projection.    |
#'    |away_team_chance_loss     |numeric |Away team's team chance loss.        |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @export
#' @keywords NBA Betting
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_betting(game_id = 401283399))
#' }
espn_nba_betting <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()

  betting <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      raw_summary <- jsonlite::fromJSON(resp)
      if ("pickcenter" %in% names(raw_summary)) {
        pickcenter <- jsonlite::fromJSON(
          jsonlite::toJSON(raw_summary$pickcenter),
          flatten = TRUE
        ) %>%
          janitor::clean_names() %>%
          dplyr::select(-dplyr::any_of("links")) %>%
          dplyr::mutate(game_id = as.integer(game_id)) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "provider_id",
            "away_team_odds_team_id",
            "home_team_odds_team_id"
          )), as.integer)) %>%
          make_hoopR_data(
            "ESPN NBA Pickcenter Information from ESPN.com",
            Sys.time()
          )
      }
      if ("againstTheSpread" %in% names(raw_summary)) {
        againstTheSpread <- jsonlite::fromJSON(jsonlite::toJSON(
          raw_summary$againstTheSpread
        )) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-dplyr::any_of("links")) %>%
          janitor::clean_names()
        records <- againstTheSpread$records

        teams$records <- records
        againstTheSpread <- teams %>%
          dplyr::mutate(
            game_id = as.integer(game_id),
            id = as.integer(.data$id),
            team_id = as.integer(.data$id)
          ) %>%
          make_hoopR_data(
            "ESPN NBA Against the Spread Information from ESPN.com",
            Sys.time()
          )
      }
      if ("predictor" %in% names(raw_summary)) {
        predictor_df <- data.frame(
          game_id = as.integer(game_id),
          home_team_id = as.integer(raw_summary$predictor$homeTeam$id),
          away_team_id = as.integer(raw_summary$predictor$awayTeam$id),
          away_team_game_projection = as.numeric(
            raw_summary$predictor$awayTeam$gameProjection
          ),
          away_team_chance_loss = as.numeric(
            raw_summary$predictor$awayTeam$teamChanceLoss
          )
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data(
            "ESPN NBA Predictor Information from ESPN.com",
            Sys.time()
          )
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no betting data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  betting <- c(list(pickcenter), list(againstTheSpread), list(predictor_df))
  names(betting) <- c("pickcenter", "againstTheSpread", "predictor")
  return(betting)
}


#' @title
#' **Get ESPN NBA team stats data**
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the team stats data
#'
#'    |col_name                                         |types     |description                                                                                                                                                                                                                                                        |
#'    |:------------------------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
#'    |team_id                                          |integer   |Unique team identifier.                                                                                                                                                                                                                                            |
#'    |team_guid                                        |character |ESPN team GUID.                                                                                                                                                                                                                                                    |
#'    |team_uid                                         |character |ESPN universal team identifier (UID format 's:40~l:...~t:...').                                                                                                                                                                                                    |
#'    |team_slug                                        |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                                                                                                                                                                                                          |
#'    |team_location                                    |character |Team city or location string.                                                                                                                                                                                                                                      |
#'    |team_name                                        |character |Full team display name (e.g. 'Las Vegas Aces').                                                                                                                                                                                                                    |
#'    |team_abbreviation                                |character |Short team abbreviation (e.g. 'LAS').                                                                                                                                                                                                                              |
#'    |team_display_name                                |character |Full team display name.                                                                                                                                                                                                                                            |
#'    |team_short_display_name                          |character |Short team display name (e.g. 'Aces').                                                                                                                                                                                                                             |
#'    |team_color                                       |character |Team primary color (hex without leading '#').                                                                                                                                                                                                                      |
#'    |team_alternate_color                             |character |Team alternate color (hex without leading '#').                                                                                                                                                                                                                    |
#'    |team_is_active                                   |logical   |TRUE if the team is currently active.                                                                                                                                                                                                                              |
#'    |team_is_all_star                                 |logical   |TRUE if the row represents an All-Star team.                                                                                                                                                                                                                       |
#'    |logo_href                                        |character |Team or league logo URL.                                                                                                                                                                                                                                           |
#'    |logo_dark_href                                   |character |Logo URL for dark backgrounds.                                                                                                                                                                                                                                     |
#'    |logos_href_2                                     |character |Logos href 2.                                                                                                                                                                                                                                                      |
#'    |logos_href_3                                     |character |Logos href 3.                                                                                                                                                                                                                                                      |
#'    |defensive_blocks                                 |numeric   |Short for blocked shot, number of times when a defensive player legally deflects a field goal attempt from an offensive player.                                                                                                                                    |
#'    |defensive_defensive_rebounds                     |numeric   |The number of times when the defense obtains the possession of the ball after a missed shot by the offense.                                                                                                                                                        |
#'    |defensive_steals                                 |numeric   |The number of times a defensive player forced a turnover by intercepting or deflecting a pass or a dribble of an offensive player.                                                                                                                                 |
#'    |defensive_turnover_points                        |numeric   |The amount of points resulting from the possession following a turnover.                                                                                                                                                                                           |
#'    |defensive_def_rebound_rate                       |numeric   |The percentage of missed shots that a team rebounds defensively. Rebound Rate = (Defensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Defensive Rebounds + Opponent Defensive Rebounds)).                                                         |
#'    |defensive_avg_defensive_rebounds                 |numeric   |The average defensive rebounds per game.                                                                                                                                                                                                                           |
#'    |defensive_avg_blocks                             |numeric   |The average blocks per game.                                                                                                                                                                                                                                       |
#'    |defensive_avg_steals                             |numeric   |The average steals per game.                                                                                                                                                                                                                                       |
#'    |defensive_avg48defensive_rebounds                |numeric   |The average number of defensive rebounds per 48 minutes.                                                                                                                                                                                                           |
#'    |defensive_avg48blocks                            |numeric   |The average number of blocks per 48 minutes.                                                                                                                                                                                                                       |
#'    |defensive_avg48steals                            |numeric   |The average number of steals per 48 minutes.                                                                                                                                                                                                                       |
#'    |general_disqualifications                        |numeric   |The number of times a player reached the foul limit.                                                                                                                                                                                                               |
#'    |general_flagrant_fouls                           |numeric   |The number of fouls that the officials thought were unnecessary or excessive.                                                                                                                                                                                      |
#'    |general_fouls                                    |numeric   |The number of times a player had illegal contact with the opponent.                                                                                                                                                                                                |
#'    |general_rebound_rate                             |numeric   |The percentage of missed shots that a team rebounds. Rebound Rate = (Rebounds x Team Minutes) divided by (Player Minutes x (Team Rebounds + Opponent Rebounds)).                                                                                                   |
#'    |general_ejections                                |numeric   |The number of times a player or coach is removed from the game as a result of a serious offense.                                                                                                                                                                   |
#'    |general_technical_fouls                          |numeric   |The number of times an player or coach was called for a technical foul (unsportsmanlike conduct or violations).                                                                                                                                                    |
#'    |general_rebounds                                 |numeric   |The total number of rebounds (offensive and defensive).                                                                                                                                                                                                            |
#'    |general_minutes                                  |numeric   |The total number of minutes played.                                                                                                                                                                                                                                |
#'    |general_avg_minutes                              |numeric   |The average number of minutes per game.                                                                                                                                                                                                                            |
#'    |general_fantasy_rating                           |numeric   |The Fantasy Rating of a player.                                                                                                                                                                                                                                    |
#'    |general_nba_rating                               |numeric   |General nba rating.                                                                                                                                                                                                                                                |
#'    |general_plus_minus                               |numeric   |A player's estimated on-court impact on team performance measured in point differential per 100 possessions.                                                                                                                                                       |
#'    |general_avg_rebounds                             |numeric   |The average rebounds per game.                                                                                                                                                                                                                                     |
#'    |general_avg_fouls                                |numeric   |The average fouls committed per game.                                                                                                                                                                                                                              |
#'    |general_avg_flagrant_fouls                       |numeric   |The average number of flagrant fouls per game.                                                                                                                                                                                                                     |
#'    |general_avg_technical_fouls                      |numeric   |The average number of technical fouls per game.                                                                                                                                                                                                                    |
#'    |general_avg_ejections                            |numeric   |The average ejections per game.                                                                                                                                                                                                                                    |
#'    |general_avg_disqualifications                    |numeric   |The average number of disqualifications per game.                                                                                                                                                                                                                  |
#'    |general_assist_turnover_ratio                    |numeric   |The average number of assists a player or team records per turnover.                                                                                                                                                                                               |
#'    |general_steal_foul_ratio                         |numeric   |The average number of steals a player or team records per foul committed.                                                                                                                                                                                          |
#'    |general_block_foul_ratio                         |numeric   |The average number of blocks a player or record per foul committed.                                                                                                                                                                                                |
#'    |general_avg_team_rebounds                        |numeric   |The average number of rebounds for a team per game.                                                                                                                                                                                                                |
#'    |general_total_rebounds                           |numeric   |The total number of rebounds for a team or player.                                                                                                                                                                                                                 |
#'    |general_total_technical_fouls                    |numeric   |The total number of technical fouls for a team or player.                                                                                                                                                                                                          |
#'    |general_team_assist_turnover_ratio               |numeric   |The number of assists per turnover for a team.                                                                                                                                                                                                                     |
#'    |general_team_rebounds                            |numeric   |The total number of rebounds for a team.                                                                                                                                                                                                                           |
#'    |general_steal_turnover_ratio                     |numeric   |The number of steals per turnover.                                                                                                                                                                                                                                 |
#'    |general_avg48rebounds                            |numeric   |The average number of rebounds per 48 minutes.                                                                                                                                                                                                                     |
#'    |general_avg48fouls                               |numeric   |The average number of fouls committed per 48 minutes.                                                                                                                                                                                                              |
#'    |general_avg48flagrant_fouls                      |numeric   |The average number of flagrant fouls committed per 48 minutes.                                                                                                                                                                                                     |
#'    |general_avg48technical_fouls                     |numeric   |The average number of technical fouls committed per 48 minutes.                                                                                                                                                                                                    |
#'    |general_avg48ejections                           |numeric   |The average number of ejections per 48 minutes.                                                                                                                                                                                                                    |
#'    |general_avg48disqualifications                   |numeric   |The average number of disqualifications per 48 minutes.                                                                                                                                                                                                            |
#'    |general_r40                                      |numeric   |Rebounds Per 40 Minutes.                                                                                                                                                                                                                                           |
#'    |general_games_played                             |numeric   |Games Played.                                                                                                                                                                                                                                                      |
#'    |general_games_started                            |numeric   |The number of games started by an athlete.                                                                                                                                                                                                                         |
#'    |general_double_double                            |numeric   |The number of times double digit values were accumulated in 2 of the following categories: points, rebounds, assists, steals, and blocked shots.                                                                                                                   |
#'    |general_triple_double                            |numeric   |The number of times double digit values were accumulated in 3 of the following categories: points, rebounds, assists, steals, and blocked shots.                                                                                                                   |
#'    |offensive_assists                                |numeric   |The number of times a player who passes the ball to a teammate in a way that leads to a score by field goal, meaning that he or she was "assisting" in the basket. There is some judgment involved in deciding whether a passer should be credited with an assist. |
#'    |offensive_effective_fg_pct                       |numeric   |Offensive effective field goals percentage (0-1 decimal).                                                                                                                                                                                                          |
#'    |offensive_field_goals                            |numeric   |Field Goal makes and attempts.                                                                                                                                                                                                                                     |
#'    |offensive_field_goals_attempted                  |numeric   |The number of times a 2pt field goal was attempted.                                                                                                                                                                                                                |
#'    |offensive_field_goals_made                       |numeric   |The number of times a 2pt field goal was made.                                                                                                                                                                                                                     |
#'    |offensive_field_goal_pct                         |numeric   |The ratio of field goals made to field goals attempted: FGM / FGA.                                                                                                                                                                                                 |
#'    |offensive_free_throws                            |numeric   |Free Throw makes and attempts.                                                                                                                                                                                                                                     |
#'    |offensive_free_throw_pct                         |numeric   |The ratio of free throws made to free throws attempted: FTM / FTA.                                                                                                                                                                                                 |
#'    |offensive_free_throws_attempted                  |numeric   |The number of times a free throw was attempted.                                                                                                                                                                                                                    |
#'    |offensive_free_throws_made                       |numeric   |The number of times a free throw was made.                                                                                                                                                                                                                         |
#'    |offensive_offensive_rebounds                     |numeric   |The number of times when the offense obtains the possession of the ball after a missed shot.                                                                                                                                                                       |
#'    |offensive_points                                 |numeric   |The number of points scored.                                                                                                                                                                                                                                       |
#'    |offensive_turnovers                              |numeric   |The number of times a player loses possession to the other team.                                                                                                                                                                                                   |
#'    |offensive_three_point_pct                        |numeric   |The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA.                                                                                                                                                                                         |
#'    |offensive_three_point_field_goals_attempted      |numeric   |The number of times a 3pt field goal was attempted.                                                                                                                                                                                                                |
#'    |offensive_three_point_field_goals_made           |numeric   |The number of times a 3pt field goal was made.                                                                                                                                                                                                                     |
#'    |offensive_true_shooting_pct                      |numeric   |What a team's shooting percentage would be if we accounted for free throws and 3-pointers. True Shooting Percentage = (Total points x 50) divided by ((FGA + (FTA x 0.44)).                                                                                        |
#'    |offensive_team_turnovers                         |numeric   |The number of turnovers for the team.                                                                                                                                                                                                                              |
#'    |offensive_total_turnovers                        |numeric   |The number of turnovers plus team turnovers for the team.                                                                                                                                                                                                          |
#'    |offensive_assist_ratio                           |numeric   |The percentage of a team's possessions that ends in an assist. Assist Ratio = (Assists x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers).                                                                                                              |
#'    |offensive_points_in_paint                        |numeric   |The amount of points scored in the area known as "the Paint"(the rectangle between the foul line and the baseline).                                                                                                                                                |
#'    |offensive_off_rebound_rate                       |numeric   |The percentage of missed shots that a team rebounds offensively. Offensive Rebound Rate = (Offensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Offensive Rebounds + Opponent Defensive Rebounds)).                                               |
#'    |offensive_turnover_ratio                         |numeric   |The percentage of a team's possessions that end in a turnover. Turnover Ratio = (Turnover x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers).                                                                                                           |
#'    |offensive_fast_break_points                      |numeric   |The number of points scored on fast breaks.                                                                                                                                                                                                                        |
#'    |offensive_possessions                            |numeric   |The total number of possessions for a team or player.                                                                                                                                                                                                              |
#'    |offensive_pace_factor                            |numeric   |The number of possessions a team uses per game.                                                                                                                                                                                                                    |
#'    |offensive_avg_field_goals_made                   |numeric   |The average field goals made per game.                                                                                                                                                                                                                             |
#'    |offensive_avg_field_goals_attempted              |numeric   |The average field goals attempted per game.                                                                                                                                                                                                                        |
#'    |offensive_avg_three_point_field_goals_made       |numeric   |The average three point field goals made per game.                                                                                                                                                                                                                 |
#'    |offensive_avg_three_point_field_goals_attempted  |numeric   |The average three point field goals attempted per game.                                                                                                                                                                                                            |
#'    |offensive_avg_free_throws_made                   |numeric   |The average free throw shots made per game.                                                                                                                                                                                                                        |
#'    |offensive_avg_free_throws_attempted              |numeric   |The average free throw shots attempted per game.                                                                                                                                                                                                                   |
#'    |offensive_avg_points                             |numeric   |The average number of points scored per game.                                                                                                                                                                                                                      |
#'    |offensive_avg_offensive_rebounds                 |numeric   |The average offensive rebounds per game.                                                                                                                                                                                                                           |
#'    |offensive_avg_assists                            |numeric   |The average assists per game.                                                                                                                                                                                                                                      |
#'    |offensive_avg_turnovers                          |numeric   |The average turnovers committed per game.                                                                                                                                                                                                                          |
#'    |offensive_offensive_rebound_pct                  |numeric   |The percentage of the number of times they obtain the possession of the ball after a missed shot.                                                                                                                                                                  |
#'    |offensive_estimated_possessions                  |numeric   |An estimation of the number of possessions for a team or player.                                                                                                                                                                                                   |
#'    |offensive_avg_estimated_possessions              |numeric   |The average number of estimated possessions per game for a team or player.                                                                                                                                                                                         |
#'    |offensive_points_per_estimated_possessions       |numeric   |The number of points per estimated possession for a team or player.                                                                                                                                                                                                |
#'    |offensive_avg_team_turnovers                     |numeric   |The average number of turnovers for a team per game.                                                                                                                                                                                                               |
#'    |offensive_avg_total_turnovers                    |numeric   |The average number of total turnovers for a team per game.                                                                                                                                                                                                         |
#'    |offensive_three_point_field_goal_pct             |numeric   |The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA.                                                                                                                                                                                         |
#'    |offensive_two_point_field_goals_made             |numeric   |The number of 2-point field goals made for a team or player.                                                                                                                                                                                                       |
#'    |offensive_two_point_field_goals_attempted        |numeric   |The number of 2-point field goals attempted for a team or player.                                                                                                                                                                                                  |
#'    |offensive_avg_two_point_field_goals_made         |numeric   |The number of 2-point field goals made per game for a team or player.                                                                                                                                                                                              |
#'    |offensive_avg_two_point_field_goals_attempted    |numeric   |The number of 2-point field goals attempted per game for a team or player.                                                                                                                                                                                         |
#'    |offensive_two_point_field_goal_pct               |numeric   |The percentage of 2-points fields goals made by a team or player.                                                                                                                                                                                                  |
#'    |offensive_shooting_efficiency                    |numeric   |The efficiency with which a team or player shoots the basketball.                                                                                                                                                                                                  |
#'    |offensive_scoring_efficiency                     |numeric   |The efficiency with which a team or player scores the basketball.                                                                                                                                                                                                  |
#'    |offensive_avg48field_goals_made                  |numeric   |The average number of fieldgoals made per 48 minutes.                                                                                                                                                                                                              |
#'    |offensive_avg48field_goals_attempted             |numeric   |The average number of fieldgoals attempted per 48 minutes.                                                                                                                                                                                                         |
#'    |offensive_avg48three_point_field_goals_made      |numeric   |The average per number of 3-Pointers made per 48 minutes.                                                                                                                                                                                                          |
#'    |offensive_avg48three_point_field_goals_attempted |numeric   |The average number of 3-pointers attempted per 48 minutes.                                                                                                                                                                                                         |
#'    |offensive_avg48free_throws_made                  |numeric   |The average number of Free Throws made per 48 minutes.                                                                                                                                                                                                             |
#'    |offensive_avg48free_throws_attempted             |numeric   |The average number of free throws attempted per 48 minutes.                                                                                                                                                                                                        |
#'    |offensive_avg48points                            |numeric   |The average number of points scored per 48 minutes.                                                                                                                                                                                                                |
#'    |offensive_avg48offensive_rebounds                |numeric   |The average number of offenseive rebounds per 48 minutes.                                                                                                                                                                                                          |
#'    |offensive_avg48assists                           |numeric   |The average number of assists per 48 minutes.                                                                                                                                                                                                                      |
#'    |offensive_avg48turnovers                         |numeric   |The average number of turnovers per 48 minutes.                                                                                                                                                                                                                    |
#'    |offensive_p40                                    |numeric   |Points Per 40 Minutes.                                                                                                                                                                                                                                             |
#'    |offensive_a40                                    |numeric   |Assists Per 40 Minutes.                                                                                                                                                                                                                                            |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @keywords NBA Team Stats
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_team_stats(team_id = 13, year = 2020))
#' }
espn_nba_team_stats <- function(
    team_id,
    year,
    season_type = "regular",
    total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/",
    s_type,
    "/teams/",
    team_id,
    "/statistics/",
    totals
  )

  df <- data.frame()
  tryCatch(
    expr = {
      # Create the GET request and set response as res
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      # Get the content and return result as data.frame
      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_url <- df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL

      team_df <- team_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c(
              "logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"
            )
          )
        ) %>%
        janitor::clean_names()

      colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1"
        )

      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep = "_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = paste0(.data$name, "_", .data$stats_name)
        ) %>%
        dplyr::select(
          "stats_category_name",
          "stats_value"
        ) %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first
        ) %>%
        janitor::clean_names()

      df <- team_df %>%
        dplyr::bind_cols(df)

      df <- df %>%
        dplyr::mutate_at(
          c(
            "team_id"
          ),
          as.integer
        ) %>%
        make_hoopR_data("ESPN NBA Team Season Stats from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team season stats data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(df)
}

#' @title
#' **Get ESPN NBA player stats data**
#' @author Saiem Gilani
#' @param athlete_id Athlete ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the player stats data
#'
#'    |col_name                                         |types     |description                                                                                                                                                                                                                                                        |
#'    |:------------------------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
#'    |athlete_id                                       |integer   |Unique athlete identifier (ESPN).                                                                                                                                                                                                                                  |
#'    |athlete_uid                                      |character |ESPN athlete UID (universal identifier).                                                                                                                                                                                                                           |
#'    |athlete_guid                                     |character |ESPN athlete GUID.                                                                                                                                                                                                                                                 |
#'    |athlete_type                                     |character |Athlete type / class.                                                                                                                                                                                                                                              |
#'    |sdr                                              |integer   |Sdr.                                                                                                                                                                                                                                                               |
#'    |first_name                                       |character |Player's first name.                                                                                                                                                                                                                                               |
#'    |last_name                                        |character |Player's last name.                                                                                                                                                                                                                                                |
#'    |full_name                                        |character |Player's full name.                                                                                                                                                                                                                                                |
#'    |display_name                                     |character |Display name.                                                                                                                                                                                                                                                      |
#'    |short_name                                       |character |Short display name.                                                                                                                                                                                                                                                |
#'    |weight                                           |numeric   |Player weight in pounds.                                                                                                                                                                                                                                           |
#'    |display_weight                                   |character |Player weight in display format (e.g. '180 lbs').                                                                                                                                                                                                                  |
#'    |height                                           |numeric   |Player height (string e.g. '6-2' or inches).                                                                                                                                                                                                                       |
#'    |display_height                                   |character |Player height in display format (e.g. '6-2').                                                                                                                                                                                                                      |
#'    |age                                              |integer   |Player age (in years).                                                                                                                                                                                                                                             |
#'    |date_of_birth                                    |character |Date of birth (YYYY-MM-DD).                                                                                                                                                                                                                                        |
#'    |slug                                             |character |URL-safe identifier.                                                                                                                                                                                                                                               |
#'    |headshot_href                                    |character |Headshot image URL.                                                                                                                                                                                                                                                |
#'    |headshot_alt                                     |character |Alternative-text label for the headshot.                                                                                                                                                                                                                           |
#'    |jersey                                           |character |Jersey number worn by the player.                                                                                                                                                                                                                                  |
#'    |position_id                                      |integer   |Unique position identifier.                                                                                                                                                                                                                                        |
#'    |position_name                                    |character |Listed roster position ('Guard', 'Forward', 'Center').                                                                                                                                                                                                             |
#'    |position_display_name                            |character |Position display name.                                                                                                                                                                                                                                             |
#'    |position_abbreviation                            |character |Position abbreviation ('G' / 'F' / 'C').                                                                                                                                                                                                                           |
#'    |position_leaf                                    |logical   |Position leaf.                                                                                                                                                                                                                                                     |
#'    |linked                                           |logical   |TRUE if the record is linked to a related entity.                                                                                                                                                                                                                  |
#'    |years                                            |integer   |Years.                                                                                                                                                                                                                                                             |
#'    |active                                           |logical   |TRUE if the row represents an active record (player / team / season).                                                                                                                                                                                              |
#'    |contract_x_ref                                   |character |Contract x ref.                                                                                                                                                                                                                                                    |
#'    |contract_bird_status                             |integer   |Contract bird status.                                                                                                                                                                                                                                              |
#'    |contract_active                                  |logical   |Contract active.                                                                                                                                                                                                                                                   |
#'    |contract_active_1                                |logical   |Contract active 1.                                                                                                                                                                                                                                                 |
#'    |contract_incoming_trade_value                    |integer   |Contract incoming trade value.                                                                                                                                                                                                                                     |
#'    |contract_outgoing_trade_value                    |integer   |Contract outgoing trade value.                                                                                                                                                                                                                                     |
#'    |contract_minimum_salary_exception                |logical   |Contract minimum salary exception.                                                                                                                                                                                                                                 |
#'    |contract_option_type                             |integer   |Contract option type.                                                                                                                                                                                                                                              |
#'    |contract_salary                                  |integer   |Contract salary.                                                                                                                                                                                                                                                   |
#'    |contract_salary_remaining                        |integer   |Contract salary remaining.                                                                                                                                                                                                                                         |
#'    |contract_years_remaining                         |integer   |Contract years remaining.                                                                                                                                                                                                                                          |
#'    |contract_x_ref_1                                 |character |Contract x ref 1.                                                                                                                                                                                                                                                  |
#'    |contract_x_ref_2                                 |character |Contract x ref 2.                                                                                                                                                                                                                                                  |
#'    |contract_trade_kicker_active                     |logical   |Contract trade kicker active.                                                                                                                                                                                                                                      |
#'    |contract_trade_kicker_percentage                 |numeric   |Contract trade kicker percentage (0-1 decimal).                                                                                                                                                                                                                    |
#'    |contract_trade_kicker_value                      |integer   |Contract trade kicker value.                                                                                                                                                                                                                                       |
#'    |contract_trade_kicker_trade_value                |integer   |Contract trade kicker trade value.                                                                                                                                                                                                                                 |
#'    |contract_trade_restriction                       |logical   |Contract trade restriction.                                                                                                                                                                                                                                        |
#'    |contract_unsigned_foreign_pick                   |logical   |Contract unsigned foreign pick.                                                                                                                                                                                                                                    |
#'    |contract_active_2                                |logical   |Contract active 2.                                                                                                                                                                                                                                                 |
#'    |draft_display_text                               |character |Draft display text.                                                                                                                                                                                                                                                |
#'    |draft_round                                      |integer   |Round of the draft selection.                                                                                                                                                                                                                                      |
#'    |draft_year                                       |integer   |Draft year (4-digit).                                                                                                                                                                                                                                              |
#'    |draft_selection                                  |integer   |Draft selection.                                                                                                                                                                                                                                                   |
#'    |draft_x_ref                                      |character |Draft x ref.                                                                                                                                                                                                                                                       |
#'    |draft_x_ref_1                                    |character |Draft x ref 1.                                                                                                                                                                                                                                                     |
#'    |status_id                                        |integer   |Status identifier.                                                                                                                                                                                                                                                 |
#'    |status_name                                      |character |Status label.                                                                                                                                                                                                                                                      |
#'    |status_type                                      |character |Status type.                                                                                                                                                                                                                                                       |
#'    |status_abbreviation                              |character |Status abbreviation.                                                                                                                                                                                                                                               |
#'    |defensive_blocks                                 |numeric   |Short for blocked shot, number of times when a defensive player legally deflects a field goal attempt from an offensive player.                                                                                                                                    |
#'    |defensive_defensive_rebounds                     |numeric   |The number of times when the defense obtains the possession of the ball after a missed shot by the offense.                                                                                                                                                        |
#'    |defensive_steals                                 |numeric   |The number of times a defensive player forced a turnover by intercepting or deflecting a pass or a dribble of an offensive player.                                                                                                                                 |
#'    |defensive_def_rebound_rate                       |numeric   |The percentage of missed shots that a team rebounds defensively. Rebound Rate = (Defensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Defensive Rebounds + Opponent Defensive Rebounds)).                                                         |
#'    |defensive_avg_defensive_rebounds                 |numeric   |The average defensive rebounds per game.                                                                                                                                                                                                                           |
#'    |defensive_avg_blocks                             |numeric   |The average blocks per game.                                                                                                                                                                                                                                       |
#'    |defensive_avg_steals                             |numeric   |The average steals per game.                                                                                                                                                                                                                                       |
#'    |defensive_avg48defensive_rebounds                |numeric   |The average number of defensive rebounds per 48 minutes.                                                                                                                                                                                                           |
#'    |defensive_avg48blocks                            |numeric   |The average number of blocks per 48 minutes.                                                                                                                                                                                                                       |
#'    |defensive_avg48steals                            |numeric   |The average number of steals per 48 minutes.                                                                                                                                                                                                                       |
#'    |defensive_drpm                                   |numeric   |Defensive Real Plus-Minus.                                                                                                                                                                                                                                         |
#'    |general_disqualifications                        |numeric   |The number of times a player reached the foul limit.                                                                                                                                                                                                               |
#'    |general_flagrant_fouls                           |numeric   |The number of fouls that the officials thought were unnecessary or excessive.                                                                                                                                                                                      |
#'    |general_fouls                                    |numeric   |The number of times a player had illegal contact with the opponent.                                                                                                                                                                                                |
#'    |general_per                                      |numeric   |A numerical value for each of a player's accomplishments per-minute and is pace-adjusted for the team they play on. The league average in PER to 15.00 every season.                                                                                               |
#'    |general_rebound_rate                             |numeric   |The percentage of missed shots that a team rebounds. Rebound Rate = (Rebounds x Team Minutes) divided by (Player Minutes x (Team Rebounds + Opponent Rebounds)).                                                                                                   |
#'    |general_ejections                                |numeric   |The number of times a player or coach is removed from the game as a result of a serious offense.                                                                                                                                                                   |
#'    |general_technical_fouls                          |numeric   |The number of times an player or coach was called for a technical foul (unsportsmanlike conduct or violations).                                                                                                                                                    |
#'    |general_rebounds                                 |numeric   |The total number of rebounds (offensive and defensive).                                                                                                                                                                                                            |
#'    |general_vorp                                     |numeric   |Value Over Replacement Player.                                                                                                                                                                                                                                     |
#'    |general_warp                                     |numeric   |Wins Above Replacement Player.                                                                                                                                                                                                                                     |
#'    |general_rpm                                      |numeric   |Real Plus-Minus.                                                                                                                                                                                                                                                   |
#'    |general_minutes                                  |numeric   |The total number of minutes played.                                                                                                                                                                                                                                |
#'    |general_avg_minutes                              |numeric   |The average number of minutes per game.                                                                                                                                                                                                                            |
#'    |general_nba_rating                               |numeric   |General nba rating.                                                                                                                                                                                                                                                |
#'    |general_plus_minus                               |numeric   |A player's estimated on-court impact on team performance measured in point differential per 100 possessions.                                                                                                                                                       |
#'    |general_avg_rebounds                             |numeric   |The average rebounds per game.                                                                                                                                                                                                                                     |
#'    |general_avg_fouls                                |numeric   |The average fouls committed per game.                                                                                                                                                                                                                              |
#'    |general_avg_flagrant_fouls                       |numeric   |The average number of flagrant fouls per game.                                                                                                                                                                                                                     |
#'    |general_avg_technical_fouls                      |numeric   |The average number of technical fouls per game.                                                                                                                                                                                                                    |
#'    |general_avg_ejections                            |numeric   |The average ejections per game.                                                                                                                                                                                                                                    |
#'    |general_avg_disqualifications                    |numeric   |The average number of disqualifications per game.                                                                                                                                                                                                                  |
#'    |general_assist_turnover_ratio                    |numeric   |The average number of assists a player or team records per turnover.                                                                                                                                                                                               |
#'    |general_steal_foul_ratio                         |numeric   |The average number of steals a player or team records per foul committed.                                                                                                                                                                                          |
#'    |general_block_foul_ratio                         |numeric   |The average number of blocks a player or record per foul committed.                                                                                                                                                                                                |
#'    |general_avg_team_rebounds                        |numeric   |The average number of rebounds for a team per game.                                                                                                                                                                                                                |
#'    |general_total_rebounds                           |numeric   |The total number of rebounds for a team or player.                                                                                                                                                                                                                 |
#'    |general_total_technical_fouls                    |numeric   |The total number of technical fouls for a team or player.                                                                                                                                                                                                          |
#'    |general_team_assist_turnover_ratio               |numeric   |The number of assists per turnover for a team.                                                                                                                                                                                                                     |
#'    |general_steal_turnover_ratio                     |numeric   |The number of steals per turnover.                                                                                                                                                                                                                                 |
#'    |general_avg48rebounds                            |numeric   |The average number of rebounds per 48 minutes.                                                                                                                                                                                                                     |
#'    |general_avg48fouls                               |numeric   |The average number of fouls committed per 48 minutes.                                                                                                                                                                                                              |
#'    |general_avg48flagrant_fouls                      |numeric   |The average number of flagrant fouls committed per 48 minutes.                                                                                                                                                                                                     |
#'    |general_avg48technical_fouls                     |numeric   |The average number of technical fouls committed per 48 minutes.                                                                                                                                                                                                    |
#'    |general_avg48ejections                           |numeric   |The average number of ejections per 48 minutes.                                                                                                                                                                                                                    |
#'    |general_avg48disqualifications                   |numeric   |The average number of disqualifications per 48 minutes.                                                                                                                                                                                                            |
#'    |general_r40                                      |numeric   |Rebounds Per 40 Minutes.                                                                                                                                                                                                                                           |
#'    |general_games_played                             |numeric   |Games Played.                                                                                                                                                                                                                                                      |
#'    |general_games_started                            |numeric   |The number of games started by an athlete.                                                                                                                                                                                                                         |
#'    |general_double_double                            |numeric   |The number of times double digit values were accumulated in 2 of the following categories: points, rebounds, assists, steals, and blocked shots.                                                                                                                   |
#'    |general_triple_double                            |numeric   |The number of times double digit values were accumulated in 3 of the following categories: points, rebounds, assists, steals, and blocked shots.                                                                                                                   |
#'    |offensive_assists                                |numeric   |The number of times a player who passes the ball to a teammate in a way that leads to a score by field goal, meaning that he or she was "assisting" in the basket. There is some judgment involved in deciding whether a passer should be credited with an assist. |
#'    |offensive_effective_fg_pct                       |numeric   |Offensive effective field goals percentage (0-1 decimal).                                                                                                                                                                                                          |
#'    |offensive_field_goals                            |numeric   |Field Goal makes and attempts.                                                                                                                                                                                                                                     |
#'    |offensive_field_goals_attempted                  |numeric   |The number of times a 2pt field goal was attempted.                                                                                                                                                                                                                |
#'    |offensive_field_goals_made                       |numeric   |The number of times a 2pt field goal was made.                                                                                                                                                                                                                     |
#'    |offensive_field_goal_pct                         |numeric   |The ratio of field goals made to field goals attempted: FGM / FGA.                                                                                                                                                                                                 |
#'    |offensive_free_throws                            |numeric   |Free Throw makes and attempts.                                                                                                                                                                                                                                     |
#'    |offensive_free_throw_pct                         |numeric   |The ratio of free throws made to free throws attempted: FTM / FTA.                                                                                                                                                                                                 |
#'    |offensive_free_throws_attempted                  |numeric   |The number of times a free throw was attempted.                                                                                                                                                                                                                    |
#'    |offensive_free_throws_made                       |numeric   |The number of times a free throw was made.                                                                                                                                                                                                                         |
#'    |offensive_offensive_rebounds                     |numeric   |The number of times when the offense obtains the possession of the ball after a missed shot.                                                                                                                                                                       |
#'    |offensive_points                                 |numeric   |The number of points scored.                                                                                                                                                                                                                                       |
#'    |offensive_turnovers                              |numeric   |The number of times a player loses possession to the other team.                                                                                                                                                                                                   |
#'    |offensive_three_point_pct                        |numeric   |The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA.                                                                                                                                                                                         |
#'    |offensive_three_point_field_goals_attempted      |numeric   |The number of times a 3pt field goal was attempted.                                                                                                                                                                                                                |
#'    |offensive_three_point_field_goals_made           |numeric   |The number of times a 3pt field goal was made.                                                                                                                                                                                                                     |
#'    |offensive_true_shooting_pct                      |numeric   |What a team's shooting percentage would be if we accounted for free throws and 3-pointers. True Shooting Percentage = (Total points x 50) divided by ((FGA + (FTA x 0.44)).                                                                                        |
#'    |offensive_total_turnovers                        |numeric   |The number of turnovers plus team turnovers for the team.                                                                                                                                                                                                          |
#'    |offensive_assist_ratio                           |numeric   |The percentage of a team's possessions that ends in an assist. Assist Ratio = (Assists x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers).                                                                                                              |
#'    |offensive_points_in_paint                        |numeric   |The amount of points scored in the area known as "the Paint"(the rectangle between the foul line and the baseline).                                                                                                                                                |
#'    |offensive_off_rebound_rate                       |numeric   |The percentage of missed shots that a team rebounds offensively. Offensive Rebound Rate = (Offensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Offensive Rebounds + Opponent Defensive Rebounds)).                                               |
#'    |offensive_turnover_ratio                         |numeric   |The percentage of a team's possessions that end in a turnover. Turnover Ratio = (Turnover x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers).                                                                                                           |
#'    |offensive_brick_index                            |numeric   |How many points a player costs his team with his shooting compared with the league average on a per-40-minute basis. ((52.8 - TS%) x (FGA + (FTA x 0.44))) / (Min/40) .                                                                                            |
#'    |offensive_usage_rate                             |numeric   |the number of possessions a player uses per 40 minutes. Usage Rate = ((FGA + (FT Att. x 0.44) + (Ast x 0.33) + TO) x 40 x League Pace) divided by (Minutes x Team Pace).                                                                                           |
#'    |offensive_avg_field_goals_made                   |numeric   |The average field goals made per game.                                                                                                                                                                                                                             |
#'    |offensive_avg_field_goals_attempted              |numeric   |The average field goals attempted per game.                                                                                                                                                                                                                        |
#'    |offensive_avg_three_point_field_goals_made       |numeric   |The average three point field goals made per game.                                                                                                                                                                                                                 |
#'    |offensive_avg_three_point_field_goals_attempted  |numeric   |The average three point field goals attempted per game.                                                                                                                                                                                                            |
#'    |offensive_avg_free_throws_made                   |numeric   |The average free throw shots made per game.                                                                                                                                                                                                                        |
#'    |offensive_avg_free_throws_attempted              |numeric   |The average free throw shots attempted per game.                                                                                                                                                                                                                   |
#'    |offensive_avg_points                             |numeric   |The average number of points scored per game.                                                                                                                                                                                                                      |
#'    |offensive_avg_offensive_rebounds                 |numeric   |The average offensive rebounds per game.                                                                                                                                                                                                                           |
#'    |offensive_avg_assists                            |numeric   |The average assists per game.                                                                                                                                                                                                                                      |
#'    |offensive_avg_turnovers                          |numeric   |The average turnovers committed per game.                                                                                                                                                                                                                          |
#'    |offensive_offensive_rebound_pct                  |numeric   |The percentage of the number of times they obtain the possession of the ball after a missed shot.                                                                                                                                                                  |
#'    |offensive_estimated_possessions                  |numeric   |An estimation of the number of possessions for a team or player.                                                                                                                                                                                                   |
#'    |offensive_avg_estimated_possessions              |numeric   |The average number of estimated possessions per game for a team or player.                                                                                                                                                                                         |
#'    |offensive_points_per_estimated_possessions       |numeric   |The number of points per estimated possession for a team or player.                                                                                                                                                                                                |
#'    |offensive_avg_team_turnovers                     |numeric   |The average number of turnovers for a team per game.                                                                                                                                                                                                               |
#'    |offensive_avg_total_turnovers                    |numeric   |The average number of total turnovers for a team per game.                                                                                                                                                                                                         |
#'    |offensive_three_point_field_goal_pct             |numeric   |The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA.                                                                                                                                                                                         |
#'    |offensive_two_point_field_goals_made             |numeric   |The number of 2-point field goals made for a team or player.                                                                                                                                                                                                       |
#'    |offensive_two_point_field_goals_attempted        |numeric   |The number of 2-point field goals attempted for a team or player.                                                                                                                                                                                                  |
#'    |offensive_avg_two_point_field_goals_made         |numeric   |The number of 2-point field goals made per game for a team or player.                                                                                                                                                                                              |
#'    |offensive_avg_two_point_field_goals_attempted    |numeric   |The number of 2-point field goals attempted per game for a team or player.                                                                                                                                                                                         |
#'    |offensive_two_point_field_goal_pct               |numeric   |The percentage of 2-points fields goals made by a team or player.                                                                                                                                                                                                  |
#'    |offensive_shooting_efficiency                    |numeric   |The efficiency with which a team or player shoots the basketball.                                                                                                                                                                                                  |
#'    |offensive_scoring_efficiency                     |numeric   |The efficiency with which a team or player scores the basketball.                                                                                                                                                                                                  |
#'    |offensive_avg48field_goals_made                  |numeric   |The average number of fieldgoals made per 48 minutes.                                                                                                                                                                                                              |
#'    |offensive_avg48field_goals_attempted             |numeric   |The average number of fieldgoals attempted per 48 minutes.                                                                                                                                                                                                         |
#'    |offensive_avg48three_point_field_goals_made      |numeric   |The average per number of 3-Pointers made per 48 minutes.                                                                                                                                                                                                          |
#'    |offensive_avg48three_point_field_goals_attempted |numeric   |The average number of 3-pointers attempted per 48 minutes.                                                                                                                                                                                                         |
#'    |offensive_avg48free_throws_made                  |numeric   |The average number of Free Throws made per 48 minutes.                                                                                                                                                                                                             |
#'    |offensive_avg48free_throws_attempted             |numeric   |The average number of free throws attempted per 48 minutes.                                                                                                                                                                                                        |
#'    |offensive_avg48points                            |numeric   |The average number of points scored per 48 minutes.                                                                                                                                                                                                                |
#'    |offensive_avg48offensive_rebounds                |numeric   |The average number of offenseive rebounds per 48 minutes.                                                                                                                                                                                                          |
#'    |offensive_avg48assists                           |numeric   |The average number of assists per 48 minutes.                                                                                                                                                                                                                      |
#'    |offensive_avg48turnovers                         |numeric   |The average number of turnovers per 48 minutes.                                                                                                                                                                                                                    |
#'    |offensive_p40                                    |numeric   |Points Per 40 Minutes.                                                                                                                                                                                                                                             |
#'    |offensive_a40                                    |numeric   |Assists Per 40 Minutes.                                                                                                                                                                                                                                            |
#'    |offensive_orpm                                   |numeric   |Offensive Real Plus-Minus.                                                                                                                                                                                                                                         |
#'    |team_id                                          |integer   |Unique team identifier.                                                                                                                                                                                                                                            |
#'    |team_guid                                        |character |ESPN team GUID.                                                                                                                                                                                                                                                    |
#'    |team_uid                                         |character |ESPN universal team identifier (UID format 's:40~l:...~t:...').                                                                                                                                                                                                    |
#'    |team_slug                                        |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                                                                                                                                                                                                          |
#'    |team_location                                    |character |Team city or location string.                                                                                                                                                                                                                                      |
#'    |team_name                                        |character |Full team display name (e.g. 'Las Vegas Aces').                                                                                                                                                                                                                    |
#'    |team_abbreviation                                |character |Short team abbreviation (e.g. 'LAS').                                                                                                                                                                                                                              |
#'    |team_display_name                                |character |Full team display name.                                                                                                                                                                                                                                            |
#'    |team_short_display_name                          |character |Short team display name (e.g. 'Aces').                                                                                                                                                                                                                             |
#'    |team_color                                       |character |Team primary color (hex without leading '#').                                                                                                                                                                                                                      |
#'    |team_alternate_color                             |character |Team alternate color (hex without leading '#').                                                                                                                                                                                                                    |
#'    |team_is_active                                   |logical   |TRUE if the team is currently active.                                                                                                                                                                                                                              |
#'    |team_is_all_star                                 |logical   |TRUE if the row represents an All-Star team.                                                                                                                                                                                                                       |
#'    |logo_href                                        |character |Team or league logo URL.                                                                                                                                                                                                                                           |
#'    |logo_dark_href                                   |character |Logo URL for dark backgrounds.                                                                                                                                                                                                                                     |
#'    |logos_href_2                                     |character |Logos href 2.                                                                                                                                                                                                                                                      |
#'    |logos_href_3                                     |character |Logos href 3.                                                                                                                                                                                                                                                      |
#'
#' @export
#' @keywords NBA Player Stats
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_player_stats(athlete_id = 1966, year = 2022))
#' }
espn_nba_player_stats <- function(
    athlete_id,
    year,
    season_type = "regular",
    total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/",
    s_type,
    "/athletes/",
    athlete_id,
    "/statistics/",
    totals
  )
  athlete_url <- paste0(
    base_url,
    year,
    "/athletes/",
    athlete_id
  )
  df <- data.frame()
  tryCatch(
    expr = {
      # Create the GET request and set response as res
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)
      # Create the GET request and set response as res
      athlete_res <- .retry_request(athlete_url)

      # Check the result
      check_status(athlete_res)

      athlete_df <- athlete_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_url <- athlete_df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL

      team_df <- team_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c(
              "logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"
            )
          )
        ) %>%
        janitor::clean_names()
      colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1"
        )

      athlete_df[["links"]] <- NULL
      athlete_df[["injuries"]] <- NULL
      athlete_df[["birthPlace"]] <- NULL

      athlete_df <- athlete_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        tibble::tibble(data = .data$.)
      athlete_df <- athlete_df$data %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "X.ref",
            "X.ref.1",
            "X.ref.2",
            "X.ref.3",
            "X.ref.4",
            "X.ref.5",
            "X.ref.6",
            "X.ref.7",
            "X.ref.8",
            "position.X.ref",
            "position.X.ref.1",
            "contract.x.ref",
            "contract.x.ref.1",
            "contract.x.ref.2",
            "draft.x.ref",
            "draft.x.ref.1"
          ))
        ) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "athlete_id" = "id",
          "athlete_uid" = "uid",
          "athlete_guid" = "guid",
          "athlete_type" = "type"
        )

      # Get the content and return result as data.frame
      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep = "_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = paste0(.data$name, "_", .data$stats_name)
        ) %>%
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first
        ) %>%
        janitor::clean_names()
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        dplyr::mutate_at(
          c(
            "athlete_id",
            "team_id",
            "position_id",
            "status_id",
            "sdr"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Player Season Stats from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player season stats data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(df)
}

#'  **Parse ESPN NBA PBP, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_pbp <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  pbp_source <- game_json[["header"]][["competitions"]][["playByPlaySource"]]

  plays <- game_json %>%
    purrr::pluck("plays") %>%
    dplyr::as_tibble()

  if (pbp_source != "none" && nrow(plays) > 10) {
    homeAway1 <- jsonlite::fromJSON(resp)[["header"]][["competitions"]][[
      "competitors"
    ]][[1]][["homeAway"]][1]

    gameId <- as.integer(game_json[["header"]][["id"]])
    season <- game_json[["header"]][["season"]][["year"]]
    season_type <- game_json[["header"]][["season"]][["type"]]
    game_date_time <- substr(
      game_json[["header"]][["competitions"]][["date"]],
      1,
      nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
    ) %>%
      lubridate::ymd_hm() %>%
      lubridate::with_tz(tzone = "America/New_York")

    game_date <- as.Date(substr(game_date_time, 0, 10))

    id_vars <- data.frame()
    if (homeAway1 == "home") {
      homeTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      homeTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(1, .default = NA_character_)
      )
      homeTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      awayTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      awayTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(2, .default = NA_character_)
      id_vars <- data.frame(
        homeTeamId,
        homeTeamMascot,
        homeTeamName,
        homeTeamAbbrev,
        homeTeamLogo,
        homeTeamLogoDark,
        homeTeamFullName,
        homeTeamColor,
        homeTeamAlternateColor,
        homeTeamScore,
        homeTeamWinner,
        homeTeamRecord,
        awayTeamId,
        awayTeamMascot,
        awayTeamName,
        awayTeamAbbrev,
        awayTeamLogo,
        awayTeamLogoDark,
        awayTeamFullName,
        awayTeamColor,
        awayTeamAlternateColor,
        awayTeamScore,
        awayTeamWinner,
        awayTeamRecord
      )
    } else {
      awayTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      awayTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      awayTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(2, .default = NA_character_)
      id_vars <- data.frame(
        homeTeamId,
        homeTeamMascot,
        homeTeamName,
        homeTeamAbbrev,
        homeTeamLogo,
        homeTeamLogoDark,
        homeTeamFullName,
        homeTeamColor,
        homeTeamAlternateColor,
        homeTeamScore,
        homeTeamWinner,
        homeTeamRecord,
        awayTeamId,
        awayTeamMascot,
        awayTeamName,
        awayTeamAbbrev,
        awayTeamLogo,
        awayTeamLogoDark,
        awayTeamFullName,
        awayTeamColor,
        awayTeamAlternateColor,
        awayTeamScore,
        awayTeamWinner,
        awayTeamRecord
      )
    }

    game_json <- game_json %>%
      jsonlite::toJSON() %>%
      jsonlite::fromJSON(flatten = TRUE)

    plays <- game_json %>%
      purrr::pluck("plays")

    if ("coordinate.x" %in% names(plays) & "coordinate.y" %in% names(plays)) {
      plays <- plays %>%
        dplyr::mutate(
          # convert types
          coordinate.x = as.double(.data$coordinate.x),
          coordinate.y = as.double(.data$coordinate.y),
          # Free throws are adjusted automatically to 19' from baseline, which
          # corresponds to 13.75' from the center of the basket (originally
          # the center of the basket is (25, 0))
          coordinate.y = dplyr::case_when(
            stringr::str_detect(.data$type.text, "Free Throw") ~ 13.75,
            TRUE ~ .data$coordinate.y
          ),
          coordinate.x = dplyr::case_when(
            stringr::str_detect(.data$type.text, "Free Throw") ~ 25,
            TRUE ~ .data$coordinate.x
          ),
          coordinate_x_transformed = dplyr::case_when(
            .data$team.id == homeTeamId ~ -1 * (.data$coordinate.y - 41.75),
            TRUE ~ .data$coordinate.y - 41.75
          ),
          coordinate_y_transformed = dplyr::case_when(
            .data$team.id == homeTeamId ~ -1 * (.data$coordinate.x - 25),
            TRUE ~ .data$coordinate.x - 25
          )
        ) %>%
        dplyr::rename(
          "coordinate.x.raw" = "coordinate.x",
          "coordinate.y.raw" = "coordinate.y",
          "coordinate.x" = "coordinate_x_transformed",
          "coordinate.y" = "coordinate_y_transformed"
        )
    }

    ## Written this way for compliance with data repository processing
    if ("participants" %in% names(plays)) {
      plays <- plays %>%
        tidyr::unnest_wider("participants")
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(
            "id",
            "athlete.id"
          ) %>%
          tidyr::unnest_wider("athlete.id", names_sep = "_")
      )
      names(aths) <- c(
        "play.id",
        "athlete.id.1",
        "athlete.id.2",
        "athlete.id.3"
      )
      plays <- plays %>%
        dplyr::bind_cols(aths) %>%
        janitor::clean_names() %>%
        dplyr::mutate(dplyr::across(
          dplyr::any_of(c(
            "athlete_id_1",
            "athlete_id_2",
            "athlete_id_3"
          )),
          ~ as.integer(.x)
        ))
    }
    ## Written this way for compliance with data repository processing
    if (!("homeTeamName" %in% names(plays))) {
      plays <- plays %>%
        dplyr::bind_cols(id_vars)
    }

    plays <- plays %>%
      dplyr::select(-dplyr::any_of(c("athlete.id", "athlete_id"))) %>%
      janitor::clean_names() %>%
      dplyr::mutate(
        game_id = gameId,
        season = season,
        season_type = season_type,
        game_date = game_date,
        game_date_time = game_date_time
      ) %>%
      dplyr::rename(dplyr::any_of(c(
        "athlete_id_1" = "participants_0_athlete_id",
        "athlete_id_2" = "participants_1_athlete_id",
        "athlete_id_3" = "participants_2_athlete_id"
      )))

    plays <- plays %>%
      dplyr::mutate(dplyr::across(
        dplyr::any_of(c(
          "athlete_id_1",
          "athlete_id_2",
          "athlete_id_3",
          "type_id",
          "team_id"
        )),
        ~ as.integer(.x)
      ))

    plays_df <- plays %>%
      make_hoopR_data(
        "ESPN NBA Play-by-Play Information from ESPN.com",
        Sys.time()
      )

    return(plays_df)
  }
}

#'  **Parse ESPN NBA Team Box, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_team_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  gameId <- as.integer(game_json[["header"]][["id"]])
  game_date_time <- substr(
    game_json[["header"]][["competitions"]][["date"]],
    1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))
  # ESPN's header `boxscoreAvailable` flag is unreliable for archival games
  # (pre-2014 WBB payloads carry full stats while the flag says FALSE -- the
  # same latent gate silently dropped a decade of wehoop boxscores), so
  # availability is derived from the payload itself; the statistics-length
  # check below remains the real gate.
  box_score_available <- length(game_json[["boxscore"]][["teams"]]) > 0
  if (box_score_available == TRUE) {
    teams_box_score_df <- game_json[["boxscore"]][["teams"]] %>%
      jsonlite::toJSON() %>%
      jsonlite::fromJSON(flatten = TRUE)
    if (length(teams_box_score_df[["statistics"]][[1]]) > 0) {
      # Teams info columns and values
      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]][1]
      homeAway1_team.id <- as.integer(teams_df[["id"]][1])
      homeAway1_team.score <- as.integer(teams_df[["score"]][1])
      homeAway1_team.winner <- teams_df[["winner"]][1]

      homeAway2 <- teams_df[["homeAway"]][2]
      homeAway2_team.id <- as.integer(teams_df[["id"]][2])
      homeAway2_team.score <- as.integer(teams_df[["score"]][2])
      homeAway2_team.winner <- teams_df[["winner"]][2]

      # Pivoting the table values for each team from long to wide
      statistics_df_1 <- teams_box_score_df[["statistics"]][[1]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      statistics_df_2 <- teams_box_score_df[["statistics"]][[2]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      # Assigning values to the correct data frame rows - 1
      statistics_df_1$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        homeAway1,
        homeAway2
      )
      statistics_df_1$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      statistics_df_1$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        homeAway1_team.winner,
        homeAway2_team.winner
      )
      statistics_df_1$team.id <- as.integer(teams_box_score_df[["team.id"]][[
        1
      ]])
      statistics_df_1$team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_1$team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_1$team.location <- teams_box_score_df[["team.location"]][[
        1
      ]]
      statistics_df_1$team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_1$team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[1]]
      statistics_df_1$team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[1]]
      statistics_df_1$team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[1]]
      statistics_df_1$team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_1$team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[1]]
      statistics_df_1$team.logo <- teams_box_score_df[["team.logo"]][[1]]
      statistics_df_1$opponent.team.id <- as.integer(teams_box_score_df[[
        "team.id"
      ]][[2]])
      statistics_df_1$opponent.team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_1$opponent.team.slug <- teams_box_score_df[["team.slug"]][[
        2
      ]]
      statistics_df_1$opponent.team.location <- teams_box_score_df[[
        "team.location"
      ]][[2]]
      statistics_df_1$opponent.team.name <- teams_box_score_df[["team.name"]][[
        2
      ]]
      statistics_df_1$opponent.team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[2]]
      statistics_df_1$opponent.team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[2]]
      statistics_df_1$opponent.team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[2]]
      statistics_df_1$opponent.team.color <- teams_box_score_df[[
        "team.color"
      ]][[2]]
      statistics_df_1$opponent.team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[2]]
      statistics_df_1$opponent.team.logo <- teams_box_score_df[["team.logo"]][[
        2
      ]]
      statistics_df_1$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      # Assigning values to the correct data frame rows - 2
      statistics_df_2$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        homeAway2,
        homeAway1
      )
      statistics_df_2$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      statistics_df_2$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        homeAway2_team.winner,
        homeAway1_team.winner
      )
      statistics_df_2$team.id <- as.integer(teams_box_score_df[["team.id"]][[
        2
      ]])
      statistics_df_2$team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_2$team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_2$team.location <- teams_box_score_df[["team.location"]][[
        2
      ]]
      statistics_df_2$team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_2$team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[2]]
      statistics_df_2$team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[2]]
      statistics_df_2$team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[2]]
      statistics_df_2$team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_2$team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[2]]
      statistics_df_2$team.logo <- teams_box_score_df[["team.logo"]][[2]]
      statistics_df_2$opponent.team.id <- as.integer(teams_box_score_df[[
        "team.id"
      ]][[1]])
      statistics_df_2$opponent.team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_2$opponent.team.slug <- teams_box_score_df[["team.slug"]][[
        1
      ]]
      statistics_df_2$opponent.team.location <- teams_box_score_df[[
        "team.location"
      ]][[1]]
      statistics_df_2$opponent.team.name <- teams_box_score_df[["team.name"]][[
        1
      ]]
      statistics_df_2$opponent.team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[1]]
      statistics_df_2$opponent.team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[1]]
      statistics_df_2$opponent.team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[1]]
      statistics_df_2$opponent.team.color <- teams_box_score_df[[
        "team.color"
      ]][[1]]
      statistics_df_2$opponent.team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[1]]
      statistics_df_2$opponent.team.logo <- teams_box_score_df[["team.logo"]][[
        1
      ]]
      statistics_df_2$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      complete_statistics_df <- statistics_df_1 %>%
        dplyr::bind_rows(statistics_df_2)

      # Assigning game/season level data to team box score and converting types
      complete_statistics_df$season <- game_json[["header"]][["season"]][[
        "year"
      ]]
      complete_statistics_df$season_type <- game_json[["header"]][["season"]][[
        "type"
      ]]
      complete_statistics_df$game_date <- as.Date(substr(
        game_json[["header"]][["competitions"]][["date"]],
        0,
        10
      ))
      complete_statistics_df$game_id <- as.integer(gameId)
      complete_statistics_df$game_date_time <- game_date_time
      complete_statistics_df$game_date <- game_date

      suppressWarnings(
        complete_statistics_df <- complete_statistics_df %>%
          tidyr::separate(
            "fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c(
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted"
            ),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(
            c(
              "fieldGoalPct",
              "freeThrowPct",
              "threePointFieldGoalPct"
            ),
            ~ as.numeric(.x)
          )) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "assists",
              "blocks",
              "defensiveRebounds",
              "fieldGoalsMade",
              "fieldGoalsAttempted",
              "flagrantFouls",
              "fouls",
              "freeThrowsMade",
              "freeThrowsAttempted",
              "offensiveRebounds",
              "steals",
              "teamTurnovers",
              "technicalFouls",
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted",
              "totalRebounds",
              "totalTechnicalFouls",
              "totalTurnovers",
              "turnovers"
            )),
            ~ as.integer(.x)
          ))
      )
      team_box_score <- complete_statistics_df %>%
        janitor::clean_names() %>%
        dplyr::select(
          dplyr::any_of(c(
            "game_id",
            "season",
            "season_type",
            "game_date",
            "game_date_time",
            "team_id",
            "team_uid",
            "team_slug",
            "team_location",
            "team_name",
            "team_abbreviation",
            "team_display_name",
            "team_short_display_name",
            "team_color",
            "team_alternate_color",
            "team_logo",
            "team_home_away",
            "team_score",
            "team_winner"
          )),
          tidyr::everything()
        ) %>%
        make_hoopR_data(
          "ESPN NBA Team Box Information from ESPN.com",
          Sys.time()
        )

      return(team_box_score)
    }
  }
}

#'  **Parse ESPN NBA Player Box, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_player_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON(flatten = TRUE)

  players_box_score_df <- game_json[["boxscore"]][["players"]] %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as.data.frame()

  gameId <- as.integer(game_json[["header"]][["id"]])
  season <- game_json[["header"]][["season"]][["year"]]
  season_type <- game_json[["header"]][["season"]][["type"]]
  game_date_time <- substr(
    game_json[["header"]][["competitions"]][["date"]],
    1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))

  boxScoreAvailable <- game_json[["header"]][["competitions"]][[
    "boxscoreAvailable"
  ]]

  boxScoreSource <- game_json[["header"]][["competitions"]][["boxscoreSource"]]

  # This is checking if  [[athletes]][[1]]'s stat rebounds is able to be converted to a numeric value
  #  without introducing NA's
  suppressWarnings(
    valid_stats <- players_box_score_df[["statistics"]][[1]][["athletes"]][[
      1
    ]][["stats"]][[1]] %>%
      purrr::pluck(7) %>%
      as.numeric()
  )
  if (
    # Payload presence replaces ESPN's unreliable header `boxscoreAvailable`
    # flag; the athlete and stat validity conjuncts below remain the real gate.
    length(game_json[["boxscore"]][["players"]]) > 0 &&
      length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]]) >
        1 &&
      !is.na(valid_stats)
  ) {
    players_df <- players_box_score_df %>%
      tidyr::unnest("statistics") %>%
      tidyr::unnest("athletes")
    if (
      length(players_box_score_df[["statistics"]]) > 1 &&
        length(players_df$stats[[1]]) > 0
    ) {
      players_df <- jsonlite::fromJSON(
        jsonlite::toJSON(game_json[["boxscore"]][["players"]]),
        flatten = TRUE
      ) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")

      stat_cols <- players_df$keys[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind, stats))
      colnames(stats_df) <- stat_cols
      suppressWarnings(
        stats_df <- stats_df %>%
          tidyr::separate(
            "fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c(
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted"
            ),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "minutes",
              "fieldGoalPct",
              "freeThrowPct",
              "threePointFieldGoalPct"
            )),
            ~ as.numeric(.x)
          )) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "assists",
              "blocks",
              "defensiveRebounds",
              "fieldGoalsMade",
              "fieldGoalsAttempted",
              "flagrantFouls",
              "fouls",
              "freeThrowsMade",
              "freeThrowsAttempted",
              "offensiveRebounds",
              "steals",
              "teamTurnovers",
              "technicalFouls",
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted",
              "rebounds",
              "totalTechnicalFouls",
              "totalTurnovers",
              "turnovers",
              "points"
            )),
            ~ as.integer(.x)
          ))
      )
      players_df_did_not_play <- players_df %>%
        dplyr::filter(.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- stats_df %>%
        dplyr::bind_cols(players_df) %>%
        dplyr::bind_rows(players_df_did_not_play)

      players_df <- players_df %>%
        dplyr::select(
          dplyr::any_of(c(
            "athlete.displayName",
            "team.shortDisplayName"
          )),
          tidyr::everything()
        ) %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_id = gameId,
          season = season,
          season_type = season_type,
          game_date = game_date,
          game_date_time = game_date_time
        )

      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.id <- as.integer(
        teams_df[["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      homeAway1_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.logos <- teams_df[["team.logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.score <- as.integer(
        teams_df[["score"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )

      homeAway2 <- teams_df[["homeAway"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.id <- as.integer(
        teams_df[["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeAway2_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.logos <- teams_df[["team.logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway2_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.score <- as.integer(
        teams_df[["score"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )

      players_df <- players_df %>%
        dplyr::mutate(
          home_away = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1,
            homeAway2
          ),
          team_winner = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1_team.winner,
            homeAway2_team.winner
          ),
          team_score = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1_team.score,
            homeAway2_team.score
          ),
          opponent_team_id = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.id,
            homeAway1_team.id
          ),
          opponent_team_name = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.name,
            homeAway1_team.name
          ),
          opponent_team_location = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.location,
            homeAway1_team.location
          ),
          opponent_team_display_name = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.displayName,
            homeAway1_team.displayName
          ),
          opponent_team_abbreviation = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.abbreviation,
            homeAway1_team.abbreviation
          ),
          opponent_team_logo = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.logos,
            homeAway1_team.logos
          ),
          opponent_team_color = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.color,
            homeAway1_team.color
          ),
          opponent_team_alternate_color = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.alternateColor,
            homeAway1_team.alternateColor
          ),
          opponent_team_score = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.score,
            homeAway1_team.score
          ),
        ) %>%
        dplyr::arrange(.data$home_away)

      player_box_score <- players_df %>%
        dplyr::select(dplyr::any_of(c(
          "game_id",
          "season",
          "season_type",
          "game_date",
          "game_date_time",
          "athlete_id",
          "athlete_display_name",
          "team_id",
          "team_name",
          "team_location",
          "team_short_display_name",
          "minutes",
          "field_goals_made",
          "field_goals_attempted",
          "three_point_field_goals_made",
          "three_point_field_goals_attempted",
          "free_throws_made",
          "free_throws_attempted",
          "offensive_rebounds",
          "defensive_rebounds",
          "rebounds",
          "assists",
          "steals",
          "blocks",
          "turnovers",
          "fouls",
          "plus_minus",
          "points",
          "starter",
          "ejected",
          "did_not_play",
          "reason",
          "active",
          "athlete_jersey",
          "athlete_short_name",
          "athlete_headshot_href",
          "athlete_position_name",
          "athlete_position_abbreviation",
          "team_display_name",
          "team_uid",
          "team_slug",
          "team_logo",
          "team_abbreviation",
          "team_color",
          "team_alternate_color",
          "home_away",
          "team_winner",
          "team_score",
          "opponent_team_id",
          "opponent_team_name",
          "opponent_team_location",
          "opponent_team_display_name",
          "opponent_team_abbreviation",
          "opponent_team_logo",
          "opponent_team_color",
          "opponent_team_alternate_color",
          "opponent_team_score"
        ))) %>%
        dplyr::mutate_at(
          c(
            "athlete_id",
            "team_id",
            "team_score",
            "opponent_team_score"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Player Box Information from ESPN.com",
          Sys.time()
        )

      return(player_box_score)
    }
  }
}
