#' **Get NBA Data API Play-by-Play for G-League Games**
#' @name nbagl_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play for G-League Games**
#' @description Retrieves G-League play-by-play using the NBA Stats play-by-play pipeline.
#' @rdname nbagl_pbp
#' @author Billy Fryer
#' @param game_id Game ID - 10 digits, i.e. 0021900001
#' @param on_court If TRUE (default), on-court player IDs are added for each play event.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame of play-by-play with core columns:
#' When `on_court = TRUE`, lineup columns are included and may be `NA` when lineup
#' inference data is unavailable for a given game.
#'
#'    |col_name        |types     |description                                                    |
#'    |:---------------|:---------|:--------------------------------------------------------------|
#'    |game_id         |character |Unique game identifier.                                        |
#'    |action_number   |integer   |Sequential action number within a game (V3 PBP).               |
#'    |clock           |character |Game clock value.                                              |
#'    |period          |integer   |Period of the game (1-4 quarters; 5+ for OT).                  |
#'    |team_id         |integer   |Unique team identifier.                                        |
#'    |person_id       |integer   |Unique player identifier (V3 endpoints).                       |
#'    |player_name     |character |Player name.                                                   |
#'    |x_legacy        |integer   |V2-format X coordinate (preserved for V3-to-V2 compatibility). |
#'    |y_legacy        |integer   |V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
#'    |shot_distance   |numeric   |Shot distance from the basket, in feet.                        |
#'    |shot_result     |character |Shot result ('Made' / 'Missed').                               |
#'    |is_field_goal   |integer   |1 if the action was a field goal; 0 otherwise.                 |
#'    |score_home      |character |Score home.                                                    |
#'    |score_away      |character |Score away.                                                    |
#'    |points_total    |integer   |Running total of points scored.                                |
#'    |location        |character |Location.                                                      |
#'    |description     |character |Long-form description text.                                    |
#'    |action_type     |character |Action type label (e.g. 'Made Shot', 'Substitution').          |
#'    |sub_type        |character |Action sub-type label.                                         |
#'    |video_available |logical   |Video available.                                               |
#'    |shot_value      |integer   |Point value of the shot (2 or 3).                              |
#'    |action_id       |integer   |Unique action identifier within a game (V3 PBP).               |
#'    |away_player1    |numeric   |Away team's player1.                                           |
#'    |away_player2    |numeric   |Away team's player2.                                           |
#'    |away_player3    |numeric   |Away team's player3.                                           |
#'    |away_player4    |numeric   |Away team's player4.                                           |
#'    |away_player5    |numeric   |Away team's player5.                                           |
#'    |home_player1    |numeric   |Home team's player1.                                           |
#'    |home_player2    |numeric   |Home team's player2.                                           |
#'    |home_player3    |numeric   |Home team's player3.                                           |
#'    |home_player4    |numeric   |Home team's player4.                                           |
#'    |home_player5    |numeric   |Home team's player5.                                           |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_pbp(game_id = "2052500034")
#' ```

nbagl_pbp <- function(
    game_id,
    on_court = TRUE,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  plays_df <- data.frame()

  tryCatch(
    expr = {
      plays_df <- nba_pbp(game_id = {{ game_id }}, on_court = on_court)

      if (on_court) {
        on_court_cols <- c(
          "away_player1", "away_player2", "away_player3", "away_player4", "away_player5",
          "home_player1", "home_player2", "home_player3", "home_player4", "home_player5"
        )
        missing_cols <- setdiff(on_court_cols, colnames(plays_df))
        if (length(missing_cols) > 0) {
          plays_df[missing_cols] <- NA_real_
        }
      }

      plays_df <- plays_df |>
        make_hoopR_data("NBA G-League Play-by-Play Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )

  return(plays_df)
}


#' **Get NBA G-League Stats API Live play-by-play**
#' @name nbagl_live_pbp
NULL
#' @title
#' **Get NBA G-League Stats API Live play-by-play**
#' @rdname nbagl_live_pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                     |types     |description                                                    |
#'    |:----------------------------|:---------|:--------------------------------------------------------------|
#'    |event_num                    |integer   |Sequential event number within the game (V2 PBP).              |
#'    |clock                        |character |Game clock value.                                              |
#'    |time_actual                  |character |Time actual.                                                   |
#'    |period                       |integer   |Period of the game (1-4 quarters; 5+ for OT).                  |
#'    |period_type                  |character |Period type.                                                   |
#'    |action_type                  |character |Action type label (e.g. 'Made Shot', 'Substitution').          |
#'    |sub_type                     |character |Action sub-type label.                                         |
#'    |qualifiers                   |list      |Qualifiers.                                                    |
#'    |player1_id                   |integer   |V2 PBP primary player ID (e.g. shooter / fouler).              |
#'    |x                            |numeric   |X.                                                             |
#'    |y                            |numeric   |Y.                                                             |
#'    |offense_team_id              |integer   |Unique identifier for offense team.                            |
#'    |home_score                   |character |Home team score at the time of the play.                       |
#'    |away_score                   |character |Away team score at the time of the play.                       |
#'    |edited                       |character |Edited.                                                        |
#'    |order                        |integer   |Display order within the result set.                           |
#'    |is_target_score_last_period  |logical   |Is target score last period.                                   |
#'    |x_legacy                     |integer   |V2-format X coordinate (preserved for V3-to-V2 compatibility). |
#'    |y_legacy                     |integer   |V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
#'    |is_field_goal                |integer   |1 if the action was a field goal; 0 otherwise.                 |
#'    |side                         |character |Side label (e.g. 'home', 'away', or 'overUnder').              |
#'    |description                  |character |Long-form description text.                                    |
#'    |person_ids_filter            |list      |Person ids filter.                                             |
#'    |team_id                      |integer   |Unique team identifier.                                        |
#'    |team_tricode                 |character |Three-letter team code (e.g. 'LAS' / 'NYL').                   |
#'    |descriptor                   |character |Descriptor.                                                    |
#'    |jump_ball_recovered_name     |character |Jump ball recovered name.                                      |
#'    |jump_ball_recoverd_person_id |integer   |Unique identifier for jump ball recoverd person.               |
#'    |player_name                  |character |Player name.                                                   |
#'    |player_name_i                |character |Player name i.                                                 |
#'    |jump_ball_won_player_name    |character |Jump ball won player name.                                     |
#'    |jump_ball_won_person_id      |integer   |Unique identifier for jump ball won person.                    |
#'    |jump_ball_lost_player_name   |character |Jump ball lost player name.                                    |
#'    |jump_ball_lost_person_id     |integer   |Unique identifier for jump ball lost person.                   |
#'    |area                         |character |Area.                                                          |
#'    |area_detail                  |character |Area detail.                                                   |
#'    |shot_distance                |numeric   |Shot distance from the basket, in feet.                        |
#'    |shot_result                  |character |Shot result ('Made' / 'Missed').                               |
#'    |points_total                 |integer   |Running total of points scored.                                |
#'    |assist_player_name_initial   |character |Assist player name initial.                                    |
#'    |assist_person_id             |integer   |Unique identifier for assist person.                           |
#'    |assist_total                 |integer   |Assist total.                                                  |
#'    |shot_action_number           |integer   |Shot action number.                                            |
#'    |rebound_total                |integer   |Rebound total.                                                 |
#'    |rebound_defensive_total      |integer   |Rebound defensive total.                                       |
#'    |rebound_offensive_total      |integer   |Rebound offensive total.                                       |
#'    |official_id                  |integer   |Unique official / referee identifier.                          |
#'    |foul_personal_total          |integer   |Foul personal total.                                           |
#'    |foul_technical_total         |integer   |Foul technical total.                                          |
#'    |foul_drawn_player_name       |character |Foul drawn player name.                                        |
#'    |foul_drawn_person_id         |integer   |Unique identifier for foul drawn person.                       |
#'    |block_player_name            |character |Block player name.                                             |
#'    |block_person_id              |integer   |Unique identifier for block person.                            |
#'    |turnover_total               |integer   |Turnover total.                                                |
#'    |steal_player_name            |character |Steal player name.                                             |
#'    |steal_person_id              |integer   |Unique identifier for steal person.                            |
#'    |player2_id                   |integer   |V2 PBP secondary player ID (e.g. assister / fouled-by).        |
#'    |player3_id                   |integer   |V2 PBP tertiary player ID (e.g. blocker).                      |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_live_pbp(game_id = '2052500034')
#' ```
nbagl_live_pbp <- function(
    game_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  data <- data.frame()

  endpoint <- nbagl_live_endpoint("playbyplay")

  full_url <- paste0(
    endpoint,
    "/playbyplay_",
    pad_id(game_id),
    ".json"
  )

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game") %>%
        purrr::pluck("actions") %>%
        janitor::clean_names()

      data <- data %>%
        dplyr::rename(dplyr::any_of(c(
          "period" = "period",
          "event_num" = "action_number",
          "clock" = "clock",
          "description" = "description",
          "locX" = "xLegacy",
          "locY" = "yLegacy",
          "action_type" = "action_type",
          "sub_type" = "sub_type",
          "descriptor" = "descriptor",
          "shot_result" = "shot_result",
          "shot_action_number" = "shot_action_number",
          "qualifiers" = "qualifiers",
          "team_id" = "team_id",
          "player1_id" = "person_id",
          "home_score" = "score_home",
          "away_score" = "score_away",
          "offense_team_id" = "possession",
          "order" = "order_number"
        ))) %>%
        dplyr::mutate(
          player2_id = dplyr::case_when(
            !is.na(.data$assist_person_id) ~ .data$assist_person_id,
            TRUE ~ NA_integer_
          ),
          player3_id = dplyr::case_when(
            !is.na(.data$block_person_id) ~ .data$block_person_id,
            !is.na(.data$steal_person_id) ~ .data$steal_person_id,
            !is.na(.data$foul_drawn_person_id) ~ .data$foul_drawn_person_id,
            TRUE ~ NA_integer_
          )
        ) %>%
        make_hoopR_data("NBA G-League Game Play-by-Play Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}



#' **Get NBA G-League Stats API Live Boxscore**
#' @name nbagl_live_boxscore
NULL
#' @title
#' **Get NBA G-League Stats API Live Boxscore**
#' @rdname nbagl_live_boxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: game_details, arena, officials, home_team_boxscore,
#' away_team_boxscore, home_team_player_boxscore, away_team_player_boxscore, home_team_linescores,
#' away_team_linescores
#'
#'    **game_details**
#'
#'
#'    |col_name                     |types     |description                                            |
#'    |:----------------------------|:---------|:------------------------------------------------------|
#'    |game_id                      |character |Unique game identifier.                                |
#'    |game_time_local              |character |Game time local.                                       |
#'    |game_time_utc                |character |Game start time in UTC (ISO 8601 timestamp).           |
#'    |game_time_home               |character |Game time home.                                        |
#'    |game_time_away               |character |Game time away.                                        |
#'    |game_et                      |character |Game et.                                               |
#'    |duration                     |integer   |Duration.                                              |
#'    |game_code                    |character |ESPN game code (numeric identifier).                   |
#'    |game_status_text             |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |game_status                  |integer   |Game status label.                                     |
#'    |regulation_periods           |integer   |Regulation periods.                                    |
#'    |period                       |integer   |Period of the game (1-4 quarters; 5+ for OT).          |
#'    |game_clock                   |character |Game clock.                                            |
#'    |attendance                   |integer   |Reported attendance.                                   |
#'    |sellout                      |character |Sellout.                                               |
#'    |home_team_id                 |integer   |Unique identifier for the home team.                   |
#'    |home_team_name               |character |Home team name.                                        |
#'    |home_team_city               |character |Home team city / location.                             |
#'    |home_team_tricode            |character |Home team three-letter code.                           |
#'    |home_team_score              |integer   |Home team's score.                                     |
#'    |home_team_in_bonus           |character |Home team's team in bonus.                             |
#'    |home_team_timeouts_remaining |integer   |Home team's team timeouts remaining.                   |
#'    |away_team_id                 |integer   |Unique identifier for the away team.                   |
#'    |away_team_name               |character |Away team name.                                        |
#'    |away_team_city               |character |Away team city / location.                             |
#'    |away_team_tricode            |character |Away team three-letter code.                           |
#'    |away_team_score              |integer   |Away team's score.                                     |
#'    |away_team_in_bonus           |character |Away team's team in bonus.                             |
#'    |away_team_timeouts_remaining |integer   |Away team's team timeouts remaining.                   |
#'
#'    **arena**
#'
#'
#'    |col_name       |types     |description                  |
#'    |:--------------|:---------|:----------------------------|
#'    |arena_id       |integer   |Unique identifier for arena. |
#'    |arena_name     |character |Arena name.                  |
#'    |arena_city     |character |Arena city.                  |
#'    |arena_state    |character |Arena state.                 |
#'    |arena_country  |character |Arena country.               |
#'    |arena_timezone |character |Arena timezone.              |
#'
#'    **officials**
#'
#'
#'    |col_name    |types     |description                              |
#'    |:-----------|:---------|:----------------------------------------|
#'    |person_id   |integer   |Unique player identifier (V3 endpoints). |
#'    |name        |character |Display name.                            |
#'    |name_i      |character |Initialed name (e.g. 'A. Wilson').       |
#'    |first_name  |character |Player's first name.                     |
#'    |family_name |character |Player's family / last name.             |
#'    |jersey_num  |character |Jersey number worn by the player.        |
#'    |assignment  |character |Assignment.                              |
#'
#'    **home_team_boxscore**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_score                      |integer   |Team's score / final score.                                                      |
#'    |team_in_bonus                   |character |Team in bonus.                                                                   |
#'    |team_timeouts_remaining         |integer   |Team timeouts remaining.                                                         |
#'    |assists                         |integer   |Total assists.                                                                   |
#'    |assists_turnover_ratio          |numeric   |Assists turnover ratio.                                                          |
#'    |bench_points                    |integer   |Points scored by the bench.                                                      |
#'    |biggest_lead                    |integer   |Biggest lead.                                                                    |
#'    |biggest_lead_score              |character |Biggest lead score.                                                              |
#'    |biggest_scoring_run             |integer   |Biggest scoring run.                                                             |
#'    |biggest_scoring_run_score       |character |Biggest scoring run score.                                                       |
#'    |blocks                          |integer   |Total blocks.                                                                    |
#'    |blocks_received                 |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fast_break_points_attempted     |integer   |Number of fast break points attempted.                                           |
#'    |fast_break_points_made          |integer   |Number of fast break points made.                                                |
#'    |fast_break_points_percentage    |numeric   |Fast break points percentage (0-1 decimal).                                      |
#'    |field_goals_attempted           |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_effective_adjusted  |numeric   |Field goals effective adjusted.                                                  |
#'    |field_goals_made                |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_percentage          |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |fouls_offensive                 |integer   |Offensive fouls.                                                                 |
#'    |fouls_drawn                     |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'    |fouls_personal                  |integer   |Personal fouls.                                                                  |
#'    |fouls_team                      |integer   |Fouls team.                                                                      |
#'    |fouls_technical                 |integer   |Technical fouls.                                                                 |
#'    |fouls_team_technical            |integer   |Fouls team technical.                                                            |
#'    |free_throws_attempted           |integer   |Free throw attempts.                                                             |
#'    |free_throws_made                |integer   |Free throws made.                                                                |
#'    |free_throws_percentage          |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |lead_changes                    |integer   |Lead changes.                                                                    |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |minutes_calculated              |character |Minutes calculated from game-clock differences.                                  |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |points_against                  |integer   |Points allowed.                                                                  |
#'    |points_fast_break               |integer   |Fast-break points scored.                                                        |
#'    |points_from_turnovers           |integer   |Points from turnovers.                                                           |
#'    |points_in_the_paint             |integer   |Points in the paint.                                                             |
#'    |points_in_the_paint_attempted   |integer   |Number of points in the paint attempted.                                         |
#'    |points_in_the_paint_made        |integer   |Number of points in the paint made.                                              |
#'    |points_in_the_paint_percentage  |numeric   |Points in the paint percentage (0-1 decimal).                                    |
#'    |points_second_chance            |integer   |Second-chance points scored.                                                     |
#'    |rebounds_defensive              |integer   |Defensive rebounds.                                                              |
#'    |rebounds_offensive              |integer   |Offensive rebounds.                                                              |
#'    |rebounds_personal               |integer   |Rebounds personal.                                                               |
#'    |rebounds_team                   |integer   |Rebounds team.                                                                   |
#'    |rebounds_team_defensive         |integer   |Rebounds team defensive.                                                         |
#'    |rebounds_team_offensive         |integer   |Rebounds team offensive.                                                         |
#'    |rebounds_total                  |integer   |Total rebounds.                                                                  |
#'    |second_chance_points_attempted  |integer   |Number of second chance points attempted.                                        |
#'    |second_chance_points_made       |integer   |Number of second chance points made.                                             |
#'    |second_chance_points_percentage |numeric   |Second chance points percentage (0-1 decimal).                                   |
#'    |steals                          |integer   |Total steals.                                                                    |
#'    |three_pointers_attempted        |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_made             |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_percentage       |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |time_leading                    |character |Time leading.                                                                    |
#'    |times_tied                      |integer   |Times tied.                                                                      |
#'    |true_shooting_attempts          |numeric   |Number of true shooting attempted.                                               |
#'    |true_shooting_percentage        |numeric   |True shooting percentage (0-1).                                                  |
#'    |turnovers                       |integer   |Total turnovers.                                                                 |
#'    |turnovers_team                  |integer   |Turnovers team.                                                                  |
#'    |turnovers_total                 |integer   |Turnovers total.                                                                 |
#'    |two_pointers_attempted          |integer   |Number of two pointers attempted.                                                |
#'    |two_pointers_made               |integer   |Number of two pointers made.                                                     |
#'    |two_pointers_percentage         |numeric   |Two pointers percentage (0-1 decimal).                                           |
#'
#'    **away_team_boxscore**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_score                      |integer   |Team's score / final score.                                                      |
#'    |team_in_bonus                   |character |Team in bonus.                                                                   |
#'    |team_timeouts_remaining         |integer   |Team timeouts remaining.                                                         |
#'    |assists                         |integer   |Total assists.                                                                   |
#'    |assists_turnover_ratio          |numeric   |Assists turnover ratio.                                                          |
#'    |bench_points                    |integer   |Points scored by the bench.                                                      |
#'    |biggest_lead                    |integer   |Biggest lead.                                                                    |
#'    |biggest_lead_score              |character |Biggest lead score.                                                              |
#'    |biggest_scoring_run             |integer   |Biggest scoring run.                                                             |
#'    |biggest_scoring_run_score       |character |Biggest scoring run score.                                                       |
#'    |blocks                          |integer   |Total blocks.                                                                    |
#'    |blocks_received                 |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fast_break_points_attempted     |integer   |Number of fast break points attempted.                                           |
#'    |fast_break_points_made          |integer   |Number of fast break points made.                                                |
#'    |fast_break_points_percentage    |numeric   |Fast break points percentage (0-1 decimal).                                      |
#'    |field_goals_attempted           |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_effective_adjusted  |numeric   |Field goals effective adjusted.                                                  |
#'    |field_goals_made                |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_percentage          |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |fouls_offensive                 |integer   |Offensive fouls.                                                                 |
#'    |fouls_drawn                     |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'    |fouls_personal                  |integer   |Personal fouls.                                                                  |
#'    |fouls_team                      |integer   |Fouls team.                                                                      |
#'    |fouls_technical                 |integer   |Technical fouls.                                                                 |
#'    |fouls_team_technical            |integer   |Fouls team technical.                                                            |
#'    |free_throws_attempted           |integer   |Free throw attempts.                                                             |
#'    |free_throws_made                |integer   |Free throws made.                                                                |
#'    |free_throws_percentage          |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |lead_changes                    |integer   |Lead changes.                                                                    |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |minutes_calculated              |character |Minutes calculated from game-clock differences.                                  |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |points_against                  |integer   |Points allowed.                                                                  |
#'    |points_fast_break               |integer   |Fast-break points scored.                                                        |
#'    |points_from_turnovers           |integer   |Points from turnovers.                                                           |
#'    |points_in_the_paint             |integer   |Points in the paint.                                                             |
#'    |points_in_the_paint_attempted   |integer   |Number of points in the paint attempted.                                         |
#'    |points_in_the_paint_made        |integer   |Number of points in the paint made.                                              |
#'    |points_in_the_paint_percentage  |numeric   |Points in the paint percentage (0-1 decimal).                                    |
#'    |points_second_chance            |integer   |Second-chance points scored.                                                     |
#'    |rebounds_defensive              |integer   |Defensive rebounds.                                                              |
#'    |rebounds_offensive              |integer   |Offensive rebounds.                                                              |
#'    |rebounds_personal               |integer   |Rebounds personal.                                                               |
#'    |rebounds_team                   |integer   |Rebounds team.                                                                   |
#'    |rebounds_team_defensive         |integer   |Rebounds team defensive.                                                         |
#'    |rebounds_team_offensive         |integer   |Rebounds team offensive.                                                         |
#'    |rebounds_total                  |integer   |Total rebounds.                                                                  |
#'    |second_chance_points_attempted  |integer   |Number of second chance points attempted.                                        |
#'    |second_chance_points_made       |integer   |Number of second chance points made.                                             |
#'    |second_chance_points_percentage |numeric   |Second chance points percentage (0-1 decimal).                                   |
#'    |steals                          |integer   |Total steals.                                                                    |
#'    |three_pointers_attempted        |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_made             |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_percentage       |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |time_leading                    |character |Time leading.                                                                    |
#'    |times_tied                      |integer   |Times tied.                                                                      |
#'    |true_shooting_attempts          |numeric   |Number of true shooting attempted.                                               |
#'    |true_shooting_percentage        |numeric   |True shooting percentage (0-1).                                                  |
#'    |turnovers                       |integer   |Total turnovers.                                                                 |
#'    |turnovers_team                  |integer   |Turnovers team.                                                                  |
#'    |turnovers_total                 |integer   |Turnovers total.                                                                 |
#'    |two_pointers_attempted          |integer   |Number of two pointers attempted.                                                |
#'    |two_pointers_made               |integer   |Number of two pointers made.                                                     |
#'    |two_pointers_percentage         |numeric   |Two pointers percentage (0-1 decimal).                                           |
#'
#'    **home_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_score                |integer   |Team's score / final score.                                                      |
#'    |team_in_bonus             |character |Team in bonus.                                                                   |
#'    |team_timeouts_remaining   |integer   |Team timeouts remaining.                                                         |
#'    |status                    |character |Status label.                                                                    |
#'    |order                     |integer   |Display order within the result set.                                             |
#'    |person_id                 |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |jersey_num                |character |Jersey number worn by the player.                                                |
#'    |position                  |character |Listed roster position (G, F, C, etc.).                                          |
#'    |starter                   |character |TRUE if the player was in the starting lineup; FALSE otherwise.                  |
#'    |oncourt                   |character |Oncourt.                                                                         |
#'    |played                    |character |Played.                                                                          |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |blocks_received           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |fouls_offensive           |integer   |Offensive fouls.                                                                 |
#'    |fouls_drawn               |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |fouls_technical           |integer   |Technical fouls.                                                                 |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |minus                     |numeric   |Minus.                                                                           |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |minutes_calculated        |character |Minutes calculated from game-clock differences.                                  |
#'    |plus                      |numeric   |Plus.                                                                            |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |points_fast_break         |integer   |Fast-break points scored.                                                        |
#'    |points_in_the_paint       |integer   |Points in the paint.                                                             |
#'    |points_second_chance      |integer   |Second-chance points scored.                                                     |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |two_pointers_attempted    |integer   |Number of two pointers attempted.                                                |
#'    |two_pointers_made         |integer   |Number of two pointers made.                                                     |
#'    |two_pointers_percentage   |numeric   |Two pointers percentage (0-1 decimal).                                           |
#'    |name                      |character |Display name.                                                                    |
#'    |name_i                    |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |first_name                |character |Player's first name.                                                             |
#'    |family_name               |character |Player's family / last name.                                                     |
#'    |not_playing_reason        |character |Not playing reason.                                                              |
#'    |not_playing_description   |character |Not playing description.                                                         |
#'
#'    **away_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_score                |integer   |Team's score / final score.                                                      |
#'    |team_in_bonus             |character |Team in bonus.                                                                   |
#'    |team_timeouts_remaining   |integer   |Team timeouts remaining.                                                         |
#'    |status                    |character |Status label.                                                                    |
#'    |order                     |integer   |Display order within the result set.                                             |
#'    |person_id                 |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |jersey_num                |character |Jersey number worn by the player.                                                |
#'    |position                  |character |Listed roster position (G, F, C, etc.).                                          |
#'    |starter                   |character |TRUE if the player was in the starting lineup; FALSE otherwise.                  |
#'    |oncourt                   |character |Oncourt.                                                                         |
#'    |played                    |character |Played.                                                                          |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |blocks_received           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |fouls_offensive           |integer   |Offensive fouls.                                                                 |
#'    |fouls_drawn               |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |fouls_technical           |integer   |Technical fouls.                                                                 |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |minus                     |numeric   |Minus.                                                                           |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |minutes_calculated        |character |Minutes calculated from game-clock differences.                                  |
#'    |plus                      |numeric   |Plus.                                                                            |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |points_fast_break         |integer   |Fast-break points scored.                                                        |
#'    |points_in_the_paint       |integer   |Points in the paint.                                                             |
#'    |points_second_chance      |integer   |Second-chance points scored.                                                     |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |two_pointers_attempted    |integer   |Number of two pointers attempted.                                                |
#'    |two_pointers_made         |integer   |Number of two pointers made.                                                     |
#'    |two_pointers_percentage   |numeric   |Two pointers percentage (0-1 decimal).                                           |
#'    |name                      |character |Display name.                                                                    |
#'    |name_i                    |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |first_name                |character |Player's first name.                                                             |
#'    |family_name               |character |Player's family / last name.                                                     |
#'    |not_playing_reason        |character |Not playing reason.                                                              |
#'    |not_playing_description   |character |Not playing description.                                                         |
#'
#'    **home_team_linescores**
#'
#'
#'    |col_name    |types     |description                                   |
#'    |:-----------|:---------|:---------------------------------------------|
#'    |period      |integer   |Period of the game (1-4 quarters; 5+ for OT). |
#'    |period_type |character |Period type.                                  |
#'    |score       |integer   |Final score.                                  |
#'
#'    **away_team_linescores**
#'
#'
#'    |col_name    |types     |description                                   |
#'    |:-----------|:---------|:---------------------------------------------|
#'    |period      |integer   |Period of the game (1-4 quarters; 5+ for OT). |
#'    |period_type |character |Period type.                                  |
#'    |score       |integer   |Final score.                                  |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_live_boxscore(game_id = "2052500034")
#' ```
nbagl_live_boxscore <- function(
    game_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nbagl_live_endpoint("boxscore")

  full_url <- paste0(
    endpoint,
    "/boxscore_",
    pad_id(game_id),
    ".json"
  )

  df_list <- list()

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game")

      game_details <- data.frame(
        game_id = data %>% purrr::pluck("gameId"),
        game_time_local = data %>% purrr::pluck("gameTimeLocal"),
        game_time_utc = data %>% purrr::pluck("gameTimeUTC"),
        game_time_home = data %>% purrr::pluck("gameTimeHome"),
        game_time_away = data %>% purrr::pluck("gameTimeAway"),
        game_et = data %>% purrr::pluck("gameEt"),
        duration = data %>% purrr::pluck("duration"),
        game_code = data %>% purrr::pluck("gameCode"),
        game_status_text = data %>% purrr::pluck("gameStatusText"),
        game_status = data %>% purrr::pluck("gameStatus"),
        regulation_periods = data %>% purrr::pluck("regulationPeriods"),
        period = data %>% purrr::pluck("period"),
        game_clock = data %>% purrr::pluck("gameClock"),
        attendance = data %>% purrr::pluck("attendance"),
        sellout = data %>% purrr::pluck("sellout")
      )

      arena <- data %>%
        purrr::pluck("arena") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA G-League Game Arena Information from NBA.com", Sys.time())

      officials <- data %>%
        purrr::pluck("officials") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA G-League Game Officials Information from NBA.com", Sys.time())

      if ("homeTeam" %in% names(data)) {
        home_team <- data %>%
          purrr::pluck("homeTeam")

        home_team_info <- data.frame(
          team_id = home_team %>% purrr::pluck("teamId"),
          team_name = home_team %>% purrr::pluck("teamName"),
          team_city = home_team %>% purrr::pluck("teamCity"),
          team_tricode = home_team %>% purrr::pluck("teamTricode"),
          team_score = home_team %>% purrr::pluck("score"),
          team_in_bonus = home_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = home_team %>% purrr::pluck("timeoutsRemaining")
        )

        home_team_box <- home_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        home_team_linescores <- home_team$periods %>%
          janitor::clean_names()

        home_team_players <- home_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        home_team_player_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Player Boxscore Information from NBA.com", Sys.time())

        home_team_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Team Boxscore Information from NBA.com", Sys.time())
      }

      if ("awayTeam" %in% names(data)) {
        away_team <- data %>%
          purrr::pluck("awayTeam")

        away_team_info <- data.frame(
          team_id = away_team %>% purrr::pluck("teamId"),
          team_name = away_team %>% purrr::pluck("teamName"),
          team_city = away_team %>% purrr::pluck("teamCity"),
          team_tricode = away_team %>% purrr::pluck("teamTricode"),
          team_score = away_team %>% purrr::pluck("score"),
          team_in_bonus = away_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = away_team %>% purrr::pluck("timeoutsRemaining")
        )

        away_team_box <- away_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        away_team_linescores <- away_team$periods %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Linescore Information from NBA.com", Sys.time())

        away_team_players <- away_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        away_team_player_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Player Boxscore Information from NBA.com", Sys.time())

        away_team_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())
      }

      colnames(home_team_info) <- paste0("home_", colnames(home_team_info))
      colnames(away_team_info) <- paste0("away_", colnames(away_team_info))

      game_details <- game_details %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(away_team_info) %>%
        make_hoopR_data("NBA G-League Game Linescore Information from NBA.com", Sys.time())

      df_list <- c(
        list(game_details),
        list(arena),
        list(officials),
        list(home_team_boxscore),
        list(away_team_boxscore),
        list(home_team_player_boxscore),
        list(away_team_player_boxscore),
        list(home_team_linescores),
        list(away_team_linescores)
      )

      names(df_list) <- c(
        "game_details",
        "arena",
        "officials",
        "home_team_boxscore",
        "away_team_boxscore",
        "home_team_player_boxscore",
        "away_team_player_boxscore",
        "home_team_linescores",
        "away_team_linescores"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


### Variables included

# evt = Event number
# cl = Time Remaining in Quarter
# de = description
# locX = X location of action
# locY = Y location of action
# opt1 = ???
# opt2 = ???
# mtype = ???
# etype = ???
# opid = ???
# tid = Team ID, 0 for events not relating to a team (such as end of Q)
# pid = Player ID
# hs = Home Score
# vs = Visitor Score
# epid = Secondary Person ID (such as assister)
# oftid = Offensive Team ID? This is equal to tid in my test case
# ord = ???
