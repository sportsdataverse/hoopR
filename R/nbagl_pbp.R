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
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |game_id        |character |
#'    |action_number  |integer   |
#'    |clock          |character |
#'    |period         |integer   |
#'    |team_id        |integer   |
#'    |person_id      |integer   |
#'    |player_name    |character |
#'    |x_legacy       |integer   |
#'    |y_legacy       |integer   |
#'    |shot_distance  |numeric   |
#'    |shot_result    |character |
#'    |is_field_goal  |integer   |
#'    |score_home     |character |
#'    |score_away     |character |
#'    |points_total   |integer   |
#'    |location       |character |
#'    |description    |character |
#'    |action_type    |character |
#'    |sub_type       |character |
#'    |video_available|logical   |
#'    |shot_value     |integer   |
#'    |action_id      |integer   |
#'    |away_player1   |numeric   |
#'    |away_player2   |numeric   |
#'    |away_player3   |numeric   |
#'    |away_player4   |numeric   |
#'    |away_player5   |numeric   |
#'    |home_player1   |numeric   |
#'    |home_player2   |numeric   |
#'    |home_player3   |numeric   |
#'    |home_player4   |numeric   |
#'    |home_player5   |numeric   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows
#' @importFrom glue glue
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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
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
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |event_num                    |integer   |
#'    |clock                        |character |
#'    |time_actual                  |character |
#'    |period                       |integer   |
#'    |period_type                  |character |
#'    |action_type                  |character |
#'    |sub_type                     |character |
#'    |qualifiers                   |list      |
#'    |player1_id                   |integer   |
#'    |x                            |numeric   |
#'    |y                            |numeric   |
#'    |offense_team_id              |integer   |
#'    |home_score                   |character |
#'    |away_score                   |character |
#'    |edited                       |character |
#'    |order                        |integer   |
#'    |is_target_score_last_period  |logical   |
#'    |x_legacy                     |integer   |
#'    |y_legacy                     |integer   |
#'    |is_field_goal                |integer   |
#'    |side                         |character |
#'    |description                  |character |
#'    |person_ids_filter            |list      |
#'    |team_id                      |integer   |
#'    |team_tricode                 |character |
#'    |descriptor                   |character |
#'    |jump_ball_recovered_name     |character |
#'    |jump_ball_recoverd_person_id |integer   |
#'    |player_name                  |character |
#'    |player_name_i                |character |
#'    |jump_ball_won_player_name    |character |
#'    |jump_ball_won_person_id      |integer   |
#'    |jump_ball_lost_player_name   |character |
#'    |jump_ball_lost_person_id     |integer   |
#'    |area                         |character |
#'    |area_detail                  |character |
#'    |shot_distance                |numeric   |
#'    |shot_result                  |character |
#'    |points_total                 |integer   |
#'    |assist_player_name_initial   |character |
#'    |assist_person_id             |integer   |
#'    |assist_total                 |integer   |
#'    |shot_action_number           |integer   |
#'    |rebound_total                |integer   |
#'    |rebound_defensive_total      |integer   |
#'    |rebound_offensive_total      |integer   |
#'    |official_id                  |integer   |
#'    |foul_personal_total          |integer   |
#'    |foul_technical_total         |integer   |
#'    |foul_drawn_player_name       |character |
#'    |foul_drawn_person_id         |integer   |
#'    |block_player_name            |character |
#'    |block_person_id              |integer   |
#'    |turnover_total               |integer   |
#'    |steal_player_name            |character |
#'    |steal_person_id              |integer   |
#'    |player2_id                   |integer   |
#'    |player3_id                   |integer   |
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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
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
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |game_id                      |character |
#'    |game_time_local              |character |
#'    |game_time_utc                |character |
#'    |game_time_home               |character |
#'    |game_time_away               |character |
#'    |game_et                      |character |
#'    |duration                     |integer   |
#'    |game_code                    |character |
#'    |game_status_text             |character |
#'    |game_status                  |integer   |
#'    |regulation_periods           |integer   |
#'    |period                       |integer   |
#'    |game_clock                   |character |
#'    |attendance                   |integer   |
#'    |sellout                      |character |
#'    |home_team_id                 |integer   |
#'    |home_team_name               |character |
#'    |home_team_city               |character |
#'    |home_team_tricode            |character |
#'    |home_team_score              |integer   |
#'    |home_team_in_bonus           |character |
#'    |home_team_timeouts_remaining |integer   |
#'    |away_team_id                 |integer   |
#'    |away_team_name               |character |
#'    |away_team_city               |character |
#'    |away_team_tricode            |character |
#'    |away_team_score              |integer   |
#'    |away_team_in_bonus           |character |
#'    |away_team_timeouts_remaining |integer   |
#'
#'    **arena**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |arena_id       |integer   |
#'    |arena_name     |character |
#'    |arena_city     |character |
#'    |arena_state    |character |
#'    |arena_country  |character |
#'    |arena_timezone |character |
#'
#'    **officials**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |person_id   |integer   |
#'    |name        |character |
#'    |name_i      |character |
#'    |first_name  |character |
#'    |family_name |character |
#'    |jersey_num  |character |
#'    |assignment  |character |
#'
#'    **home_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **away_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **home_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **away_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **home_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
#'
#'    **away_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no boxscore data for {game_id} available!"))
    },
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
