#' **Get NBA Stats API Boxscore Traditional V3**
#' @name nba_boxscoretraditionalv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames:
#' home_team_player_traditional, away_team_player_traditional, home_team_totals_traditional,
#' away_team_totals_traditional, home_team_starters_totals, away_team_starters_totals,
#' home_team_bench_totals, away_team_bench_totals
#'
#'    **home_team_player_traditional**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |person_id                 |integer   |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |name_i                    |character |
#'    |player_slug               |character |
#'    |position                  |character |
#'    |comment                   |character |
#'    |jersey_num                |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'    |plus_minus_points         |numeric   |
#'
#'    **away_team_player_traditional**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |person_id                 |integer   |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |name_i                    |character |
#'    |player_slug               |character |
#'    |position                  |character |
#'    |comment                   |character |
#'    |jersey_num                |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'    |plus_minus_points         |numeric   |
#'
#'    **home_team_totals_traditional**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'    |plus_minus_points         |numeric   |
#'
#'    **away_team_totals_traditional**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'    |plus_minus_points         |numeric   |
#'
#'    **home_team_starters_totals**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'
#'    **away_team_starters_totals**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'
#'    **home_team_bench_totals**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'
#'    **away_team_bench_totals**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |away_team_id              |integer   |
#'    |home_team_id              |integer   |
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_slug                 |character |
#'    |minutes                   |character |
#'    |field_goals_made          |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |free_throws_made          |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |assists                   |integer   |
#'    |steals                    |integer   |
#'    |blocks                    |integer   |
#'    |turnovers                 |integer   |
#'    |fouls_personal            |integer   |
#'    |points                    |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoretraditionalv3(game_id = "0022200021")
#' ```
nba_boxscoretraditionalv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoretraditionalv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreTraditional") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_starters <- home_team_data %>%
        purrr::pluck("starters") %>%
        data.frame()

      home_team_bench <- home_team_data %>%
        purrr::pluck("bench") %>%
        data.frame()

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_starters <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_starters) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Starters Boxscore Information from NBA.com", Sys.time())

      home_team_bench <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_bench) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Bench Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_starters <- away_team_data %>%
        purrr::pluck("starters") %>%
        data.frame()

      away_team_bench <- away_team_data %>%
        purrr::pluck("bench") %>%
        data.frame()

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_starters <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_starters) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Starters Boxscore Information from NBA.com", Sys.time())

      away_team_bench <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_bench) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Bench Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals),
        list(home_team_starters),
        list(away_team_starters),
        list(home_team_bench),
        list(away_team_bench)
      )
      names(df_list) <- c(
        "home_team_player_traditional",
        "away_team_player_traditional",
        "home_team_totals_traditional",
        "away_team_totals_traditional",
        "home_team_starters_totals",
        "away_team_starters_totals",
        "home_team_bench_totals",
        "away_team_bench_totals"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no traditional boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Advanced V3**
#' @name nba_boxscoreadvancedv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Advanced V3**
#' @rdname nba_boxscoreadvancedv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: home_team_player_advanced, away_team_player_advanced,
#' home_team_totals_advanced, away_team_totals_advanced
#'
#'    **home_team_player_advanced**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |person_id                       |integer   |
#'    |first_name                      |character |
#'    |family_name                     |character |
#'    |name_i                          |character |
#'    |player_slug                     |character |
#'    |position                        |character |
#'    |comment                         |character |
#'    |jersey_num                      |character |
#'    |minutes                         |character |
#'    |estimated_offensive_rating      |numeric   |
#'    |offensive_rating                |numeric   |
#'    |estimated_defensive_rating      |numeric   |
#'    |defensive_rating                |numeric   |
#'    |estimated_net_rating            |numeric   |
#'    |net_rating                      |numeric   |
#'    |assist_percentage               |numeric   |
#'    |assist_to_turnover              |numeric   |
#'    |assist_ratio                    |numeric   |
#'    |offensive_rebound_percentage    |numeric   |
#'    |defensive_rebound_percentage    |numeric   |
#'    |rebound_percentage              |numeric   |
#'    |turnover_ratio                  |numeric   |
#'    |effective_field_goal_percentage |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |usage_percentage                |numeric   |
#'    |estimated_usage_percentage      |numeric   |
#'    |estimated_pace                  |numeric   |
#'    |pace                            |numeric   |
#'    |pace_per40                      |numeric   |
#'    |possessions                     |numeric   |
#'    |pie                             |numeric   |
#'
#'    **away_team_player_advanced**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |person_id                       |integer   |
#'    |first_name                      |character |
#'    |family_name                     |character |
#'    |name_i                          |character |
#'    |player_slug                     |character |
#'    |position                        |character |
#'    |comment                         |character |
#'    |jersey_num                      |character |
#'    |minutes                         |character |
#'    |estimated_offensive_rating      |numeric   |
#'    |offensive_rating                |numeric   |
#'    |estimated_defensive_rating      |numeric   |
#'    |defensive_rating                |numeric   |
#'    |estimated_net_rating            |numeric   |
#'    |net_rating                      |numeric   |
#'    |assist_percentage               |numeric   |
#'    |assist_to_turnover              |numeric   |
#'    |assist_ratio                    |numeric   |
#'    |offensive_rebound_percentage    |numeric   |
#'    |defensive_rebound_percentage    |numeric   |
#'    |rebound_percentage              |numeric   |
#'    |turnover_ratio                  |numeric   |
#'    |effective_field_goal_percentage |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |usage_percentage                |numeric   |
#'    |estimated_usage_percentage      |numeric   |
#'    |estimated_pace                  |numeric   |
#'    |pace                            |numeric   |
#'    |pace_per40                      |numeric   |
#'    |possessions                     |numeric   |
#'    |pie                             |numeric   |
#'
#'    **home_team_totals_advanced**
#'
#'
#'    |col_name                           |types     |
#'    |:----------------------------------|:---------|
#'    |game_id                            |character |
#'    |away_team_id                       |integer   |
#'    |home_team_id                       |integer   |
#'    |team_id                            |integer   |
#'    |team_name                          |character |
#'    |team_city                          |character |
#'    |team_tricode                       |character |
#'    |team_slug                          |character |
#'    |minutes                            |character |
#'    |estimated_offensive_rating         |numeric   |
#'    |offensive_rating                   |numeric   |
#'    |estimated_defensive_rating         |numeric   |
#'    |defensive_rating                   |numeric   |
#'    |estimated_net_rating               |numeric   |
#'    |net_rating                         |numeric   |
#'    |assist_percentage                  |numeric   |
#'    |assist_to_turnover                 |numeric   |
#'    |assist_ratio                       |numeric   |
#'    |offensive_rebound_percentage       |numeric   |
#'    |defensive_rebound_percentage       |numeric   |
#'    |rebound_percentage                 |numeric   |
#'    |estimated_team_turnover_percentage |numeric   |
#'    |turnover_ratio                     |numeric   |
#'    |effective_field_goal_percentage    |numeric   |
#'    |true_shooting_percentage           |numeric   |
#'    |usage_percentage                   |numeric   |
#'    |estimated_usage_percentage         |numeric   |
#'    |estimated_pace                     |numeric   |
#'    |pace                               |numeric   |
#'    |pace_per40                         |numeric   |
#'    |possessions                        |numeric   |
#'    |pie                                |numeric   |
#'
#'    **away_team_totals_advanced**
#'
#'
#'    |col_name                           |types     |
#'    |:----------------------------------|:---------|
#'    |game_id                            |character |
#'    |away_team_id                       |integer   |
#'    |home_team_id                       |integer   |
#'    |team_id                            |integer   |
#'    |team_name                          |character |
#'    |team_city                          |character |
#'    |team_tricode                       |character |
#'    |team_slug                          |character |
#'    |minutes                            |character |
#'    |estimated_offensive_rating         |numeric   |
#'    |offensive_rating                   |numeric   |
#'    |estimated_defensive_rating         |numeric   |
#'    |defensive_rating                   |numeric   |
#'    |estimated_net_rating               |numeric   |
#'    |net_rating                         |numeric   |
#'    |assist_percentage                  |numeric   |
#'    |assist_to_turnover                 |numeric   |
#'    |assist_ratio                       |numeric   |
#'    |offensive_rebound_percentage       |numeric   |
#'    |defensive_rebound_percentage       |numeric   |
#'    |rebound_percentage                 |numeric   |
#'    |estimated_team_turnover_percentage |numeric   |
#'    |turnover_ratio                     |numeric   |
#'    |effective_field_goal_percentage    |numeric   |
#'    |true_shooting_percentage           |numeric   |
#'    |usage_percentage                   |numeric   |
#'    |estimated_usage_percentage         |numeric   |
#'    |estimated_pace                     |numeric   |
#'    |pace                               |numeric   |
#'    |pace_per40                         |numeric   |
#'    |possessions                        |numeric   |
#'    |pie                                |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreadvancedv3(game_id = "0022200021")
#' ```
nba_boxscoreadvancedv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoreadvancedv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreAdvanced") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_advanced",
        "away_team_player_advanced",
        "home_team_totals_advanced",
        "away_team_totals_advanced"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no advanced boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Misc V3**
#' @name nba_boxscoremiscv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Misc V3**
#' @rdname nba_boxscoremiscv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames:  home_team_player_misc, away_team_player_misc,
#' home_team_totals_misc, away_team_totals_misc
#'
#'    **home_team_player_misc**
#'
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |game_id                  |character |
#'    |away_team_id             |integer   |
#'    |home_team_id             |integer   |
#'    |team_id                  |integer   |
#'    |team_name                |character |
#'    |team_city                |character |
#'    |team_tricode             |character |
#'    |team_slug                |character |
#'    |person_id                |integer   |
#'    |first_name               |character |
#'    |family_name              |character |
#'    |name_i                   |character |
#'    |player_slug              |character |
#'    |position                 |character |
#'    |comment                  |character |
#'    |jersey_num               |character |
#'    |minutes                  |character |
#'    |points_off_turnovers     |integer   |
#'    |points_second_chance     |integer   |
#'    |points_fast_break        |integer   |
#'    |points_paint             |integer   |
#'    |opp_points_off_turnovers |integer   |
#'    |opp_points_second_chance |integer   |
#'    |opp_points_fast_break    |integer   |
#'    |opp_points_paint         |integer   |
#'    |blocks                   |integer   |
#'    |blocks_against           |integer   |
#'    |fouls_personal           |integer   |
#'    |fouls_drawn              |integer   |
#'
#'    **away_team_player_misc**
#'
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |game_id                  |character |
#'    |away_team_id             |integer   |
#'    |home_team_id             |integer   |
#'    |team_id                  |integer   |
#'    |team_name                |character |
#'    |team_city                |character |
#'    |team_tricode             |character |
#'    |team_slug                |character |
#'    |person_id                |integer   |
#'    |first_name               |character |
#'    |family_name              |character |
#'    |name_i                   |character |
#'    |player_slug              |character |
#'    |position                 |character |
#'    |comment                  |character |
#'    |jersey_num               |character |
#'    |minutes                  |character |
#'    |points_off_turnovers     |integer   |
#'    |points_second_chance     |integer   |
#'    |points_fast_break        |integer   |
#'    |points_paint             |integer   |
#'    |opp_points_off_turnovers |integer   |
#'    |opp_points_second_chance |integer   |
#'    |opp_points_fast_break    |integer   |
#'    |opp_points_paint         |integer   |
#'    |blocks                   |integer   |
#'    |blocks_against           |integer   |
#'    |fouls_personal           |integer   |
#'    |fouls_drawn              |integer   |
#'
#'    **home_team_totals_misc**
#'
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |game_id                  |character |
#'    |away_team_id             |integer   |
#'    |home_team_id             |integer   |
#'    |team_id                  |integer   |
#'    |team_name                |character |
#'    |team_city                |character |
#'    |team_tricode             |character |
#'    |team_slug                |character |
#'    |minutes                  |character |
#'    |points_off_turnovers     |integer   |
#'    |points_second_chance     |integer   |
#'    |points_fast_break        |integer   |
#'    |points_paint             |integer   |
#'    |opp_points_off_turnovers |integer   |
#'    |opp_points_second_chance |integer   |
#'    |opp_points_fast_break    |integer   |
#'    |opp_points_paint         |integer   |
#'    |blocks                   |integer   |
#'    |blocks_against           |integer   |
#'    |fouls_personal           |integer   |
#'    |fouls_drawn              |integer   |
#'
#'    **away_team_totals_misc**
#'
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |game_id                  |character |
#'    |away_team_id             |integer   |
#'    |home_team_id             |integer   |
#'    |team_id                  |integer   |
#'    |team_name                |character |
#'    |team_city                |character |
#'    |team_tricode             |character |
#'    |team_slug                |character |
#'    |minutes                  |character |
#'    |points_off_turnovers     |integer   |
#'    |points_second_chance     |integer   |
#'    |points_fast_break        |integer   |
#'    |points_paint             |integer   |
#'    |opp_points_off_turnovers |integer   |
#'    |opp_points_second_chance |integer   |
#'    |opp_points_fast_break    |integer   |
#'    |opp_points_paint         |integer   |
#'    |blocks                   |integer   |
#'    |blocks_against           |integer   |
#'    |fouls_personal           |integer   |
#'    |fouls_drawn              |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoremiscv3(game_id = "0022200021")
#' ```
nba_boxscoremiscv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoremiscv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreMisc") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_misc",
        "away_team_player_misc",
        "home_team_totals_misc",
        "away_team_totals_misc"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no misc boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Scoring V3**
#' @name nba_boxscorescoringv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Scoring V3**
#' @rdname nba_boxscorescoringv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: home_team_player_scoring, away_team_player_scoring,
#' home_team_totals_scoring, away_team_totals_scoring
#'
#'    **home_team_player_scoring**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |percentage_field_goals_attempted2pt |numeric   |
#'    |percentage_field_goals_attempted3pt |numeric   |
#'    |percentage_points2pt                |numeric   |
#'    |percentage_points_midrange2pt       |numeric   |
#'    |percentage_points3pt                |numeric   |
#'    |percentage_points_fast_break        |numeric   |
#'    |percentage_points_free_throw        |numeric   |
#'    |percentage_points_off_turnovers     |numeric   |
#'    |percentage_points_paint             |numeric   |
#'    |percentage_assisted2pt              |numeric   |
#'    |percentage_unassisted2pt            |numeric   |
#'    |percentage_assisted3pt              |numeric   |
#'    |percentage_unassisted3pt            |numeric   |
#'    |percentage_assisted_fgm             |numeric   |
#'    |percentage_unassisted_fgm           |numeric   |
#'
#'    **away_team_player_scoring**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |percentage_field_goals_attempted2pt |numeric   |
#'    |percentage_field_goals_attempted3pt |numeric   |
#'    |percentage_points2pt                |numeric   |
#'    |percentage_points_midrange2pt       |numeric   |
#'    |percentage_points3pt                |numeric   |
#'    |percentage_points_fast_break        |numeric   |
#'    |percentage_points_free_throw        |numeric   |
#'    |percentage_points_off_turnovers     |numeric   |
#'    |percentage_points_paint             |numeric   |
#'    |percentage_assisted2pt              |numeric   |
#'    |percentage_unassisted2pt            |numeric   |
#'    |percentage_assisted3pt              |numeric   |
#'    |percentage_unassisted3pt            |numeric   |
#'    |percentage_assisted_fgm             |numeric   |
#'    |percentage_unassisted_fgm           |numeric   |
#'
#'    **home_team_totals_scoring**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |percentage_field_goals_attempted2pt |numeric   |
#'    |percentage_field_goals_attempted3pt |numeric   |
#'    |percentage_points2pt                |numeric   |
#'    |percentage_points_midrange2pt       |numeric   |
#'    |percentage_points3pt                |numeric   |
#'    |percentage_points_fast_break        |numeric   |
#'    |percentage_points_free_throw        |numeric   |
#'    |percentage_points_off_turnovers     |numeric   |
#'    |percentage_points_paint             |numeric   |
#'    |percentage_assisted2pt              |numeric   |
#'    |percentage_unassisted2pt            |numeric   |
#'    |percentage_assisted3pt              |numeric   |
#'    |percentage_unassisted3pt            |numeric   |
#'    |percentage_assisted_fgm             |numeric   |
#'    |percentage_unassisted_fgm           |numeric   |
#'
#'    **away_team_totals_scoring**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |percentage_field_goals_attempted2pt |numeric   |
#'    |percentage_field_goals_attempted3pt |numeric   |
#'    |percentage_points2pt                |numeric   |
#'    |percentage_points_midrange2pt       |numeric   |
#'    |percentage_points3pt                |numeric   |
#'    |percentage_points_fast_break        |numeric   |
#'    |percentage_points_free_throw        |numeric   |
#'    |percentage_points_off_turnovers     |numeric   |
#'    |percentage_points_paint             |numeric   |
#'    |percentage_assisted2pt              |numeric   |
#'    |percentage_unassisted2pt            |numeric   |
#'    |percentage_assisted3pt              |numeric   |
#'    |percentage_unassisted3pt            |numeric   |
#'    |percentage_assisted_fgm             |numeric   |
#'    |percentage_unassisted_fgm           |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorescoringv3(game_id = "0022200021")
#' ```
nba_boxscorescoringv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscorescoringv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreScoring") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_scoring",
        "away_team_player_scoring",
        "home_team_totals_scoring",
        "away_team_totals_scoring"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoring boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Usage V3**
#' @name nba_boxscoreusagev3
NULL
#' @title
#' **Get NBA Stats API Boxscore Usage V3**
#' @rdname nba_boxscoreusagev3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames:  home_team_player_usage, away_team_player_usage,
#' home_team_totals_usage, away_team_totals_usage
#'
#'    **home_team_player_usage**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |usage_percentage                    |numeric   |
#'    |percentage_field_goals_made         |numeric   |
#'    |percentage_field_goals_attempted    |numeric   |
#'    |percentage_three_pointers_made      |numeric   |
#'    |percentage_three_pointers_attempted |numeric   |
#'    |percentage_free_throws_made         |numeric   |
#'    |percentage_free_throws_attempted    |numeric   |
#'    |percentage_rebounds_offensive       |numeric   |
#'    |percentage_rebounds_defensive       |numeric   |
#'    |percentage_rebounds_total           |numeric   |
#'    |percentage_assists                  |numeric   |
#'    |percentage_turnovers                |numeric   |
#'    |percentage_steals                   |numeric   |
#'    |percentage_blocks                   |numeric   |
#'    |percentage_blocks_allowed           |numeric   |
#'    |percentage_personal_fouls           |numeric   |
#'    |percentage_personal_fouls_drawn     |numeric   |
#'    |percentage_points                   |numeric   |
#'
#'    **away_team_player_usage**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |usage_percentage                    |numeric   |
#'    |percentage_field_goals_made         |numeric   |
#'    |percentage_field_goals_attempted    |numeric   |
#'    |percentage_three_pointers_made      |numeric   |
#'    |percentage_three_pointers_attempted |numeric   |
#'    |percentage_free_throws_made         |numeric   |
#'    |percentage_free_throws_attempted    |numeric   |
#'    |percentage_rebounds_offensive       |numeric   |
#'    |percentage_rebounds_defensive       |numeric   |
#'    |percentage_rebounds_total           |numeric   |
#'    |percentage_assists                  |numeric   |
#'    |percentage_turnovers                |numeric   |
#'    |percentage_steals                   |numeric   |
#'    |percentage_blocks                   |numeric   |
#'    |percentage_blocks_allowed           |numeric   |
#'    |percentage_personal_fouls           |numeric   |
#'    |percentage_personal_fouls_drawn     |numeric   |
#'    |percentage_points                   |numeric   |
#'
#'    **home_team_totals_usage**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |usage_percentage                    |numeric   |
#'    |percentage_field_goals_made         |numeric   |
#'    |percentage_field_goals_attempted    |numeric   |
#'    |percentage_three_pointers_made      |numeric   |
#'    |percentage_three_pointers_attempted |numeric   |
#'    |percentage_free_throws_made         |numeric   |
#'    |percentage_free_throws_attempted    |numeric   |
#'    |percentage_rebounds_offensive       |numeric   |
#'    |percentage_rebounds_defensive       |numeric   |
#'    |percentage_rebounds_total           |numeric   |
#'    |percentage_assists                  |numeric   |
#'    |percentage_turnovers                |numeric   |
#'    |percentage_steals                   |numeric   |
#'    |percentage_blocks                   |numeric   |
#'    |percentage_blocks_allowed           |numeric   |
#'    |percentage_personal_fouls           |numeric   |
#'    |percentage_personal_fouls_drawn     |numeric   |
#'    |percentage_points                   |numeric   |
#'
#'    **away_team_totals_usage**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |usage_percentage                    |numeric   |
#'    |percentage_field_goals_made         |numeric   |
#'    |percentage_field_goals_attempted    |numeric   |
#'    |percentage_three_pointers_made      |numeric   |
#'    |percentage_three_pointers_attempted |numeric   |
#'    |percentage_free_throws_made         |numeric   |
#'    |percentage_free_throws_attempted    |numeric   |
#'    |percentage_rebounds_offensive       |numeric   |
#'    |percentage_rebounds_defensive       |numeric   |
#'    |percentage_rebounds_total           |numeric   |
#'    |percentage_assists                  |numeric   |
#'    |percentage_turnovers                |numeric   |
#'    |percentage_steals                   |numeric   |
#'    |percentage_blocks                   |numeric   |
#'    |percentage_blocks_allowed           |numeric   |
#'    |percentage_personal_fouls           |numeric   |
#'    |percentage_personal_fouls_drawn     |numeric   |
#'    |percentage_points                   |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreusagev3(game_id = "0022200021")
#' ```
nba_boxscoreusagev3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoreusagev3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreUsage") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_usage",
        "away_team_player_usage",
        "home_team_totals_usage",
        "away_team_totals_usage"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no usage boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Four Factors V3**
#' @name nba_boxscorefourfactorsv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Four Factors V3**
#' @rdname nba_boxscorefourfactorsv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames:  home_team_player_four_factors,
#' away_team_player_four_factors, home_team_totals_four_factors,
#' away_team_totals_four_factors
#'
#'    **home_team_player_four_factors**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |effective_field_goal_percentage     |numeric   |
#'    |free_throw_attempt_rate             |numeric   |
#'    |team_turnover_percentage            |numeric   |
#'    |offensive_rebound_percentage        |numeric   |
#'    |opp_effective_field_goal_percentage |numeric   |
#'    |opp_free_throw_attempt_rate         |numeric   |
#'    |opp_team_turnover_percentage        |numeric   |
#'    |opp_offensive_rebound_percentage    |numeric   |
#'
#'    **away_team_player_four_factors**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |person_id                           |integer   |
#'    |first_name                          |character |
#'    |family_name                         |character |
#'    |name_i                              |character |
#'    |player_slug                         |character |
#'    |position                            |character |
#'    |comment                             |character |
#'    |jersey_num                          |character |
#'    |minutes                             |character |
#'    |effective_field_goal_percentage     |numeric   |
#'    |free_throw_attempt_rate             |numeric   |
#'    |team_turnover_percentage            |numeric   |
#'    |offensive_rebound_percentage        |numeric   |
#'    |opp_effective_field_goal_percentage |numeric   |
#'    |opp_free_throw_attempt_rate         |numeric   |
#'    |opp_team_turnover_percentage        |numeric   |
#'    |opp_offensive_rebound_percentage    |numeric   |
#'
#'    **home_team_totals_four_factors**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |effective_field_goal_percentage     |numeric   |
#'    |free_throw_attempt_rate             |numeric   |
#'    |team_turnover_percentage            |numeric   |
#'    |offensive_rebound_percentage        |numeric   |
#'    |opp_effective_field_goal_percentage |numeric   |
#'    |opp_free_throw_attempt_rate         |numeric   |
#'    |opp_team_turnover_percentage        |numeric   |
#'    |opp_offensive_rebound_percentage    |numeric   |
#'
#'    **away_team_totals_four_factors**
#'
#'
#'    |col_name                            |types     |
#'    |:-----------------------------------|:---------|
#'    |game_id                             |character |
#'    |away_team_id                        |integer   |
#'    |home_team_id                        |integer   |
#'    |team_id                             |integer   |
#'    |team_name                           |character |
#'    |team_city                           |character |
#'    |team_tricode                        |character |
#'    |team_slug                           |character |
#'    |minutes                             |character |
#'    |effective_field_goal_percentage     |numeric   |
#'    |free_throw_attempt_rate             |numeric   |
#'    |team_turnover_percentage            |numeric   |
#'    |offensive_rebound_percentage        |numeric   |
#'    |opp_effective_field_goal_percentage |numeric   |
#'    |opp_free_throw_attempt_rate         |numeric   |
#'    |opp_team_turnover_percentage        |numeric   |
#'    |opp_offensive_rebound_percentage    |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorefourfactorsv3(game_id = "0022200021")
#' ```
nba_boxscorefourfactorsv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscorefourfactorsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreFourFactors") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_four_factors",
        "away_team_player_four_factors",
        "home_team_totals_four_factors",
        "away_team_totals_four_factors"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no four factors boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @name nba_boxscoreplayertrackv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @rdname nba_boxscoreplayertrackv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: home_team_player_player_track, away_team_player_player_track,
#' home_team_totals_player_track, away_team_totals_player_track
#'
#'    **home_team_player_player_track**
#'
#'
#'    |col_name                              |types     |
#'    |:-------------------------------------|:---------|
#'    |game_id                               |character |
#'    |away_team_id                          |integer   |
#'    |home_team_id                          |integer   |
#'    |team_id                               |integer   |
#'    |team_name                             |character |
#'    |team_city                             |character |
#'    |team_tricode                          |character |
#'    |team_slug                             |character |
#'    |person_id                             |integer   |
#'    |first_name                            |character |
#'    |family_name                           |character |
#'    |name_i                                |character |
#'    |player_slug                           |character |
#'    |position                              |character |
#'    |comment                               |character |
#'    |jersey_num                            |character |
#'    |minutes                               |character |
#'    |speed                                 |numeric   |
#'    |distance                              |numeric   |
#'    |rebound_chances_offensive             |integer   |
#'    |rebound_chances_defensive             |integer   |
#'    |rebound_chances_total                 |integer   |
#'    |touches                               |integer   |
#'    |secondary_assists                     |integer   |
#'    |free_throw_assists                    |integer   |
#'    |passes                                |integer   |
#'    |assists                               |integer   |
#'    |contested_field_goals_made            |integer   |
#'    |contested_field_goals_attempted       |integer   |
#'    |contested_field_goal_percentage       |numeric   |
#'    |uncontested_field_goals_made          |integer   |
#'    |uncontested_field_goals_attempted     |integer   |
#'    |uncontested_field_goals_percentage    |numeric   |
#'    |field_goal_percentage                 |numeric   |
#'    |defended_at_rim_field_goals_made      |integer   |
#'    |defended_at_rim_field_goals_attempted |integer   |
#'    |defended_at_rim_field_goal_percentage |numeric   |
#'
#'    **away_team_player_player_track**
#'
#'
#'    |col_name                              |types     |
#'    |:-------------------------------------|:---------|
#'    |game_id                               |character |
#'    |away_team_id                          |integer   |
#'    |home_team_id                          |integer   |
#'    |team_id                               |integer   |
#'    |team_name                             |character |
#'    |team_city                             |character |
#'    |team_tricode                          |character |
#'    |team_slug                             |character |
#'    |person_id                             |integer   |
#'    |first_name                            |character |
#'    |family_name                           |character |
#'    |name_i                                |character |
#'    |player_slug                           |character |
#'    |position                              |character |
#'    |comment                               |character |
#'    |jersey_num                            |character |
#'    |minutes                               |character |
#'    |speed                                 |numeric   |
#'    |distance                              |numeric   |
#'    |rebound_chances_offensive             |integer   |
#'    |rebound_chances_defensive             |integer   |
#'    |rebound_chances_total                 |integer   |
#'    |touches                               |integer   |
#'    |secondary_assists                     |integer   |
#'    |free_throw_assists                    |integer   |
#'    |passes                                |integer   |
#'    |assists                               |integer   |
#'    |contested_field_goals_made            |integer   |
#'    |contested_field_goals_attempted       |integer   |
#'    |contested_field_goal_percentage       |numeric   |
#'    |uncontested_field_goals_made          |integer   |
#'    |uncontested_field_goals_attempted     |integer   |
#'    |uncontested_field_goals_percentage    |numeric   |
#'    |field_goal_percentage                 |numeric   |
#'    |defended_at_rim_field_goals_made      |integer   |
#'    |defended_at_rim_field_goals_attempted |integer   |
#'    |defended_at_rim_field_goal_percentage |numeric   |
#'
#'    **home_team_totals_player_track**
#'
#'
#'    |col_name                              |types     |
#'    |:-------------------------------------|:---------|
#'    |game_id                               |character |
#'    |away_team_id                          |integer   |
#'    |home_team_id                          |integer   |
#'    |team_id                               |integer   |
#'    |team_name                             |character |
#'    |team_city                             |character |
#'    |team_tricode                          |character |
#'    |team_slug                             |character |
#'    |minutes                               |character |
#'    |distance                              |numeric   |
#'    |rebound_chances_offensive             |integer   |
#'    |rebound_chances_defensive             |integer   |
#'    |rebound_chances_total                 |integer   |
#'    |touches                               |integer   |
#'    |secondary_assists                     |integer   |
#'    |free_throw_assists                    |integer   |
#'    |passes                                |integer   |
#'    |assists                               |integer   |
#'    |contested_field_goals_made            |integer   |
#'    |contested_field_goals_attempted       |integer   |
#'    |contested_field_goal_percentage       |numeric   |
#'    |uncontested_field_goals_made          |integer   |
#'    |uncontested_field_goals_attempted     |integer   |
#'    |uncontested_field_goals_percentage    |numeric   |
#'    |field_goal_percentage                 |numeric   |
#'    |defended_at_rim_field_goals_made      |integer   |
#'    |defended_at_rim_field_goals_attempted |integer   |
#'    |defended_at_rim_field_goal_percentage |numeric   |
#'
#'    **away_team_totals_player_track**
#'
#'
#'    |col_name                              |types     |
#'    |:-------------------------------------|:---------|
#'    |game_id                               |character |
#'    |away_team_id                          |integer   |
#'    |home_team_id                          |integer   |
#'    |team_id                               |integer   |
#'    |team_name                             |character |
#'    |team_city                             |character |
#'    |team_tricode                          |character |
#'    |team_slug                             |character |
#'    |minutes                               |character |
#'    |distance                              |numeric   |
#'    |rebound_chances_offensive             |integer   |
#'    |rebound_chances_defensive             |integer   |
#'    |rebound_chances_total                 |integer   |
#'    |touches                               |integer   |
#'    |secondary_assists                     |integer   |
#'    |free_throw_assists                    |integer   |
#'    |passes                                |integer   |
#'    |assists                               |integer   |
#'    |contested_field_goals_made            |integer   |
#'    |contested_field_goals_attempted       |integer   |
#'    |contested_field_goal_percentage       |numeric   |
#'    |uncontested_field_goals_made          |integer   |
#'    |uncontested_field_goals_attempted     |integer   |
#'    |uncontested_field_goals_percentage    |numeric   |
#'    |field_goal_percentage                 |numeric   |
#'    |defended_at_rim_field_goals_made      |integer   |
#'    |defended_at_rim_field_goals_attempted |integer   |
#'    |defended_at_rim_field_goal_percentage |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreplayertrackv3(game_id = "0022200021")
#' ```
nba_boxscoreplayertrackv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoreplayertrackv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScorePlayerTrack") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_player_track",
        "away_team_player_player_track",
        "home_team_totals_player_track",
        "away_team_totals_player_track"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player tracking boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Matchups V3**
#' @name nba_boxscorematchupsv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Matchups V3**
#' @rdname nba_boxscorematchupsv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: home_team_player_matchups, away_team_player_matchups
#'
#'    **home_team_player_matchups**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |character |
#'    |away_team_id                      |integer   |
#'    |home_team_id                      |integer   |
#'    |team_id                           |integer   |
#'    |team_name                         |character |
#'    |team_city                         |character |
#'    |team_tricode                      |character |
#'    |team_slug                         |character |
#'    |person_id                         |integer   |
#'    |first_name                        |character |
#'    |family_name                       |character |
#'    |name_i                            |character |
#'    |player_slug                       |character |
#'    |position                          |character |
#'    |comment                           |character |
#'    |jersey_num                        |character |
#'    |matchups_person_id                |integer   |
#'    |matchups_first_name               |character |
#'    |matchups_family_name              |character |
#'    |matchups_name_i                   |character |
#'    |matchups_player_slug              |character |
#'    |matchups_jersey_num               |character |
#'    |matchup_minutes                   |character |
#'    |matchup_minutes_sort              |numeric   |
#'    |partial_possessions               |numeric   |
#'    |percentage_defender_total_time    |numeric   |
#'    |percentage_offensive_total_time   |numeric   |
#'    |percentage_total_time_both_on     |numeric   |
#'    |switches_on                       |integer   |
#'    |player_points                     |integer   |
#'    |team_points                       |integer   |
#'    |matchup_assists                   |integer   |
#'    |matchup_potential_assists         |integer   |
#'    |matchup_turnovers                 |integer   |
#'    |matchup_blocks                    |integer   |
#'    |matchup_field_goals_made          |integer   |
#'    |matchup_field_goals_attempted     |integer   |
#'    |matchup_field_goals_percentage    |numeric   |
#'    |matchup_three_pointers_made       |integer   |
#'    |matchup_three_pointers_attempted  |integer   |
#'    |matchup_three_pointers_percentage |numeric   |
#'    |help_blocks                       |integer   |
#'    |help_field_goals_made             |integer   |
#'    |help_field_goals_attempted        |integer   |
#'    |help_field_goals_percentage       |numeric   |
#'    |matchup_free_throws_made          |integer   |
#'    |matchup_free_throws_attempted     |integer   |
#'    |shooting_fouls                    |integer   |
#'
#'    **away_team_player_matchups**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |character |
#'    |away_team_id                      |integer   |
#'    |home_team_id                      |integer   |
#'    |team_id                           |integer   |
#'    |team_name                         |character |
#'    |team_city                         |character |
#'    |team_tricode                      |character |
#'    |team_slug                         |character |
#'    |person_id                         |integer   |
#'    |first_name                        |character |
#'    |family_name                       |character |
#'    |name_i                            |character |
#'    |player_slug                       |character |
#'    |position                          |character |
#'    |comment                           |character |
#'    |jersey_num                        |character |
#'    |matchups_person_id                |integer   |
#'    |matchups_first_name               |character |
#'    |matchups_family_name              |character |
#'    |matchups_name_i                   |character |
#'    |matchups_player_slug              |character |
#'    |matchups_jersey_num               |character |
#'    |matchup_minutes                   |character |
#'    |matchup_minutes_sort              |numeric   |
#'    |partial_possessions               |numeric   |
#'    |percentage_defender_total_time    |numeric   |
#'    |percentage_offensive_total_time   |numeric   |
#'    |percentage_total_time_both_on     |numeric   |
#'    |switches_on                       |integer   |
#'    |player_points                     |integer   |
#'    |team_points                       |integer   |
#'    |matchup_assists                   |integer   |
#'    |matchup_potential_assists         |integer   |
#'    |matchup_turnovers                 |integer   |
#'    |matchup_blocks                    |integer   |
#'    |matchup_field_goals_made          |integer   |
#'    |matchup_field_goals_attempted     |integer   |
#'    |matchup_field_goals_percentage    |numeric   |
#'    |matchup_three_pointers_made       |integer   |
#'    |matchup_three_pointers_attempted  |integer   |
#'    |matchup_three_pointers_percentage |numeric   |
#'    |help_blocks                       |integer   |
#'    |help_field_goals_made             |integer   |
#'    |help_field_goals_attempted        |integer   |
#'    |help_field_goals_percentage       |numeric   |
#'    |matchup_free_throws_made          |integer   |
#'    |matchup_free_throws_attempted     |integer   |
#'    |shooting_fouls                    |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorematchupsv3(game_id = "0022200021")
#' ```
nba_boxscorematchupsv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscorematchupsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreMatchups") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("matchups", names_sep = "_") %>%
        tidyr::unnest("matchups_statistics")

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("matchups", names_sep = "_") %>%
        tidyr::unnest("matchups_statistics")

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players)
      )
      names(df_list) <- c(
        "home_team_player_matchups",
        "away_team_player_matchups"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no matchups boxscore v3 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Hustle V2**
#' @name nba_boxscorehustlev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Hustle V2**
#' @rdname nba_boxscorehustlev2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_hustle, away_team_player_hustle,
#'  home_team_hustle_totals, away_team_hustle_totals
#'
#'    **home_team_player_hustle**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |person_id                       |integer   |
#'    |first_name                      |character |
#'    |family_name                     |character |
#'    |name_i                          |character |
#'    |player_slug                     |character |
#'    |position                        |character |
#'    |comment                         |character |
#'    |jersey_num                      |character |
#'    |minutes                         |character |
#'    |points                          |integer   |
#'    |contested_shots                 |integer   |
#'    |contested_shots2pt              |integer   |
#'    |contested_shots3pt              |integer   |
#'    |deflections                     |integer   |
#'    |charges_drawn                   |integer   |
#'    |screen_assists                  |integer   |
#'    |screen_assist_points            |integer   |
#'    |loose_balls_recovered_offensive |integer   |
#'    |loose_balls_recovered_defensive |integer   |
#'    |loose_balls_recovered_total     |integer   |
#'    |offensive_box_outs              |integer   |
#'    |defensive_box_outs              |integer   |
#'    |box_out_player_team_rebounds    |integer   |
#'    |box_out_player_rebounds         |integer   |
#'    |box_outs                        |integer   |
#'
#'    **away_team_player_hustle**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |person_id                       |integer   |
#'    |first_name                      |character |
#'    |family_name                     |character |
#'    |name_i                          |character |
#'    |player_slug                     |character |
#'    |position                        |character |
#'    |comment                         |character |
#'    |jersey_num                      |character |
#'    |minutes                         |character |
#'    |points                          |integer   |
#'    |contested_shots                 |integer   |
#'    |contested_shots2pt              |integer   |
#'    |contested_shots3pt              |integer   |
#'    |deflections                     |integer   |
#'    |charges_drawn                   |integer   |
#'    |screen_assists                  |integer   |
#'    |screen_assist_points            |integer   |
#'    |loose_balls_recovered_offensive |integer   |
#'    |loose_balls_recovered_defensive |integer   |
#'    |loose_balls_recovered_total     |integer   |
#'    |offensive_box_outs              |integer   |
#'    |defensive_box_outs              |integer   |
#'    |box_out_player_team_rebounds    |integer   |
#'    |box_out_player_rebounds         |integer   |
#'    |box_outs                        |integer   |
#'
#'    **home_team_totals_hustle**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |minutes                         |character |
#'    |points                          |integer   |
#'    |contested_shots                 |integer   |
#'    |contested_shots2pt              |integer   |
#'    |contested_shots3pt              |integer   |
#'    |deflections                     |integer   |
#'    |charges_drawn                   |integer   |
#'    |screen_assists                  |integer   |
#'    |screen_assist_points            |integer   |
#'    |loose_balls_recovered_offensive |integer   |
#'    |loose_balls_recovered_defensive |integer   |
#'    |loose_balls_recovered_total     |integer   |
#'    |offensive_box_outs              |integer   |
#'    |defensive_box_outs              |integer   |
#'    |box_out_player_team_rebounds    |integer   |
#'    |box_out_player_rebounds         |integer   |
#'    |box_outs                        |integer   |
#'
#'    **away_team_totals_hustle**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |game_id                         |character |
#'    |away_team_id                    |integer   |
#'    |home_team_id                    |integer   |
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_slug                       |character |
#'    |minutes                         |character |
#'    |points                          |integer   |
#'    |contested_shots                 |integer   |
#'    |contested_shots2pt              |integer   |
#'    |contested_shots3pt              |integer   |
#'    |deflections                     |integer   |
#'    |charges_drawn                   |integer   |
#'    |screen_assists                  |integer   |
#'    |screen_assist_points            |integer   |
#'    |loose_balls_recovered_offensive |integer   |
#'    |loose_balls_recovered_defensive |integer   |
#'    |loose_balls_recovered_total     |integer   |
#'    |offensive_box_outs              |integer   |
#'    |defensive_box_outs              |integer   |
#'    |box_out_player_team_rebounds    |integer   |
#'    |box_out_player_rebounds         |integer   |
#'    |box_outs                        |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorehustlev2(game_id = "0022200021")
#' ```
nba_boxscorehustlev2 <- function(
    game_id = "0022200021",
    ...) {
  version <- "boxscorehustlev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )
  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      box_score_hustle <- resp %>%
        purrr::pluck("boxScoreHustle")

      ids_df <- box_score_hustle %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_hustle <- box_score_hustle %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_hustle %>% purrr::pluck("teamId"),
        team_name = home_team_hustle %>% purrr::pluck("teamName"),
        team_city = home_team_hustle %>% purrr::pluck("teamCity"),
        team_tricode = home_team_hustle %>% purrr::pluck("teamTricode"),
        team_slug = home_team_hustle %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_hustle %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_hustle %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Hustle Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Hustle Boxscore Information from NBA.com", Sys.time())

      away_team_hustle <- box_score_hustle %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_hustle %>% purrr::pluck("teamId"),
        team_name = away_team_hustle %>% purrr::pluck("teamName"),
        team_city = away_team_hustle %>% purrr::pluck("teamCity"),
        team_tricode = away_team_hustle %>% purrr::pluck("teamTricode"),
        team_slug = away_team_hustle %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_hustle %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_hustle %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Hustle Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Hustle Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_hustle",
        "away_team_player_hustle",
        "home_team_totals_hustle",
        "away_team_totals_hustle"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no hustle stats boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Defensive V2**
#' @name nba_boxscoredefensivev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive V2**
#' @rdname nba_boxscoredefensivev2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: home_team_player_defensive, away_team_player_defensive,
#'  home_team_totals_defensive, away_team_totals_defensive
#'
#'    **home_team_player_defensive**
#'
#'
#'    |col_name                         |types     |
#'    |:--------------------------------|:---------|
#'    |game_id                          |character |
#'    |away_team_id                     |integer   |
#'    |home_team_id                     |integer   |
#'    |team_id                          |integer   |
#'    |team_name                        |character |
#'    |team_city                        |character |
#'    |team_tricode                     |character |
#'    |team_slug                        |character |
#'    |person_id                        |integer   |
#'    |first_name                       |character |
#'    |family_name                      |character |
#'    |name_i                           |character |
#'    |player_slug                      |character |
#'    |position                         |character |
#'    |comment                          |character |
#'    |jersey_num                       |character |
#'    |matchup_minutes                  |character |
#'    |partial_possessions              |numeric   |
#'    |switches_on                      |integer   |
#'    |player_points                    |integer   |
#'    |defensive_rebounds               |integer   |
#'    |matchup_assists                  |integer   |
#'    |matchup_turnovers                |integer   |
#'    |steals                           |integer   |
#'    |blocks                           |integer   |
#'    |matchup_field_goals_made         |integer   |
#'    |matchup_field_goals_attempted    |integer   |
#'    |matchup_field_goal_percentage    |numeric   |
#'    |matchup_three_pointers_made      |integer   |
#'    |matchup_three_pointers_attempted |integer   |
#'    |matchup_three_pointer_percentage |numeric   |
#'
#'    **away_team_player_defensive**
#'
#'
#'    |col_name                         |types     |
#'    |:--------------------------------|:---------|
#'    |game_id                          |character |
#'    |away_team_id                     |integer   |
#'    |home_team_id                     |integer   |
#'    |team_id                          |integer   |
#'    |team_name                        |character |
#'    |team_city                        |character |
#'    |team_tricode                     |character |
#'    |team_slug                        |character |
#'    |person_id                        |integer   |
#'    |first_name                       |character |
#'    |family_name                      |character |
#'    |name_i                           |character |
#'    |player_slug                      |character |
#'    |position                         |character |
#'    |comment                          |character |
#'    |jersey_num                       |character |
#'    |matchup_minutes                  |character |
#'    |partial_possessions              |numeric   |
#'    |switches_on                      |integer   |
#'    |player_points                    |integer   |
#'    |defensive_rebounds               |integer   |
#'    |matchup_assists                  |integer   |
#'    |matchup_turnovers                |integer   |
#'    |steals                           |integer   |
#'    |blocks                           |integer   |
#'    |matchup_field_goals_made         |integer   |
#'    |matchup_field_goals_attempted    |integer   |
#'    |matchup_field_goal_percentage    |numeric   |
#'    |matchup_three_pointers_made      |integer   |
#'    |matchup_three_pointers_attempted |integer   |
#'    |matchup_three_pointer_percentage |numeric   |
#'
#'    **home_team_totals_defensive**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |game_id      |character |
#'    |away_team_id |integer   |
#'    |home_team_id |integer   |
#'    |team_id      |integer   |
#'    |team_name    |character |
#'    |team_city    |character |
#'    |team_tricode |character |
#'    |team_slug    |character |
#'
#'    **away_team_totals_defensive**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |game_id      |character |
#'    |away_team_id |integer   |
#'    |home_team_id |integer   |
#'    |team_id      |integer   |
#'    |team_name    |character |
#'    |team_city    |character |
#'    |team_tricode |character |
#'    |team_slug    |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoredefensivev2(game_id = "0022200021")
#' ```
nba_boxscoredefensivev2 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  version <- "boxscoredefensivev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreDefensive") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_defensive",
        "away_team_player_defensive",
        "home_team_totals_defensive",
        "away_team_totals_defensive"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no defensive boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Game Rotation**
#' @name nba_gamerotation
NULL
#' @title
#' **Get NBA Stats API Game Rotation**
#' @rdname nba_gamerotation
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param league_id League ID
#' @param rotation_stat Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AwayTeam, HomeTeam
#'
#'    **AwayTeam**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |GAME_ID       |character |
#'    |TEAM_ID       |character |
#'    |TEAM_CITY     |character |
#'    |TEAM_NAME     |character |
#'    |PERSON_ID     |character |
#'    |PLAYER_FIRST  |character |
#'    |PLAYER_LAST   |character |
#'    |IN_TIME_REAL  |character |
#'    |OUT_TIME_REAL |character |
#'    |PLAYER_PTS    |character |
#'    |PT_DIFF       |character |
#'    |USG_PCT       |character |
#'
#'    **HomeTeam**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |GAME_ID       |character |
#'    |TEAM_ID       |character |
#'    |TEAM_CITY     |character |
#'    |TEAM_NAME     |character |
#'    |PERSON_ID     |character |
#'    |PLAYER_FIRST  |character |
#'    |PLAYER_LAST   |character |
#'    |IN_TIME_REAL  |character |
#'    |OUT_TIME_REAL |character |
#'    |PLAYER_PTS    |character |
#'    |PT_DIFF       |character |
#'    |USG_PCT       |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Lineup Functions
#' @details
#' ```r
#'  nba_gamerotation(game_id = "0022200021")
#' ```
nba_gamerotation <- function(
    game_id,
    league_id = "00",
    rotation_stat = "PLAYER_PTS",
    ...) {
  version <- "gamerotation"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id),
    LeagueID = league_id,
    RotationStat = rotation_stat
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x) {
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no game rotation data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Summary V3**
#' @name nba_boxscoresummaryv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoresummaryv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A named list of data frames:
#' GameSummary, GameInfo, ArenaInfo, Officials, LineScore,
#' InactivePlayers, LastFiveMeetings, OtherStats, AvailableVideo
#'
#'    **GameSummary**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |game_code         |character |
#'    |game_status       |integer   |
#'    |game_status_text  |character |
#'    |period            |integer   |
#'    |game_clock        |character |
#'    |game_time_utc     |character |
#'    |game_et           |character |
#'    |away_team_id      |integer   |
#'    |home_team_id      |integer   |
#'    |duration          |integer   |
#'    |attendance        |integer   |
#'    |sellout           |character |
#'
#'    **GameInfo**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |game_date         |character |
#'    |attendance        |integer   |
#'    |game_duration     |integer   |
#'
#'    **ArenaInfo**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |arena_id          |integer   |
#'    |arena_name        |character |
#'    |arena_city        |character |
#'    |arena_state       |character |
#'    |arena_country     |character |
#'    |arena_timezone    |character |
#'
#'    **Officials**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |person_id         |integer   |
#'    |name              |character |
#'    |name_i            |character |
#'    |first_name        |character |
#'    |family_name       |character |
#'    |jersey_num        |character |
#'
#'    **LineScore**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |team_id           |integer   |
#'    |team_city         |character |
#'    |team_name         |character |
#'    |team_tricode      |character |
#'    |team_slug         |character |
#'    |team_wins         |integer   |
#'    |team_losses       |integer   |
#'    |period1_score     |integer   |
#'    |period2_score     |integer   |
#'    |period3_score     |integer   |
#'    |period4_score     |integer   |
#'    |score             |integer   |
#'
#'    **InactivePlayers**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |team_id           |integer   |
#'    |person_id         |integer   |
#'    |first_name        |character |
#'    |family_name       |character |
#'    |jersey_num        |character |
#'
#'    **LastFiveMeetings**
#'
#'
#'    |col_name            |types     |
#'    |:-------------------|:---------|
#'    |recency_order       |integer   |
#'    |game_id             |character |
#'    |game_time_utc       |character |
#'    |game_et             |character |
#'    |game_status         |integer   |
#'    |game_status_text    |character |
#'    |away_team_id        |integer   |
#'    |away_team_city      |character |
#'    |away_team_name      |character |
#'    |away_team_tricode   |character |
#'    |away_team_score     |integer   |
#'    |away_team_wins      |integer   |
#'    |away_team_losses    |integer   |
#'    |home_team_id        |integer   |
#'    |home_team_city      |character |
#'    |home_team_name      |character |
#'    |home_team_tricode   |character |
#'    |home_team_score     |integer   |
#'    |home_team_wins      |integer   |
#'    |home_team_losses    |integer   |
#'
#'    **OtherStats**
#'
#'
#'    |col_name                      |types     |
#'    |:-----------------------------|:---------|
#'    |game_id                       |character |
#'    |team_id                       |integer   |
#'    |team_city                     |character |
#'    |team_name                     |character |
#'    |team_tricode                  |character |
#'    |points                        |integer   |
#'    |rebounds_total                |integer   |
#'    |assists                       |integer   |
#'    |steals                        |integer   |
#'    |blocks                        |integer   |
#'    |turnovers                     |integer   |
#'    |field_goals_percentage        |numeric   |
#'    |three_pointers_percentage     |numeric   |
#'    |free_throws_percentage        |numeric   |
#'    |points_in_the_paint           |integer   |
#'    |points_second_chance          |integer   |
#'    |points_fast_break             |integer   |
#'    |biggest_lead                  |integer   |
#'    |lead_changes                  |integer   |
#'    |times_tied                    |integer   |
#'    |biggest_scoring_run           |integer   |
#'    |turnovers_team                |integer   |
#'    |turnovers_total               |integer   |
#'    |rebounds_team                 |integer   |
#'    |points_from_turnovers         |integer   |
#'    |bench_points                  |integer   |
#'
#'    **AvailableVideo**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |game_id               |character |
#'    |video_available_flag  |integer   |
#'    |pt_available          |integer   |
#'    |pt_xyz_available      |integer   |
#'    |wh_status             |integer   |
#'    |hustle_status         |integer   |
#'    |historical_status     |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoresummaryv3(game_id = "0022200021")
#' ```
nba_boxscoresummaryv3 <- function(
    game_id = "0022200021",
    ...) {
  version <- "boxscoresummaryv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      summary_data <- resp %>%
        purrr::pluck("boxScoreSummary")

      game_id_val <- summary_data$gameId

      # GameSummary
      game_summary <- data.frame(
        gameId = game_id_val,
        gameCode = summary_data$gameCode %||% NA_character_,
        gameStatus = summary_data$gameStatus %||% NA_integer_,
        gameStatusText = summary_data$gameStatusText %||% NA_character_,
        period = summary_data$period %||% NA_integer_,
        gameClock = summary_data$gameClock %||% NA_character_,
        gameTimeUTC = summary_data$gameTimeUTC %||% NA_character_,
        gameEt = summary_data$gameEt %||% NA_character_,
        awayTeamId = summary_data$awayTeamId %||% NA_integer_,
        homeTeamId = summary_data$homeTeamId %||% NA_integer_,
        duration = summary_data$duration %||% NA_integer_,
        attendance = summary_data$attendance %||% NA_integer_,
        sellout = summary_data$sellout %||% NA_character_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Summary from NBA.com", Sys.time())

      # GameInfo
      game_info <- data.frame(
        gameId = game_id_val,
        gameDate = summary_data$gameEt %||% NA_character_,
        attendance = summary_data$attendance %||% NA_integer_,
        gameDuration = summary_data$duration %||% NA_integer_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Info from NBA.com", Sys.time())

      # ArenaInfo
      arena <- summary_data$arena %||% list()
      arena_info <- data.frame(
        gameId = game_id_val,
        arenaId = arena$arenaId %||% NA_integer_,
        arenaName = arena$arenaName %||% NA_character_,
        arenaCity = arena$arenaCity %||% NA_character_,
        arenaState = arena$arenaState %||% NA_character_,
        arenaCountry = arena$arenaCountry %||% NA_character_,
        arenaTimezone = arena$arenaTimezone %||% NA_character_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Arena Info from NBA.com", Sys.time())

      # Officials
      officials_list <- summary_data$officials %||% list()
      if (length(officials_list) > 0) {
        officials <- data.frame(officials_list, stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(gameId = game_id_val) %>%
          dplyr::select("gameId", dplyr::everything()) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Officials from NBA.com", Sys.time())
      } else {
        officials <- dplyr::tibble(
          game_id = character(),
          person_id = integer(),
          name = character(),
          name_i = character(),
          first_name = character(),
          family_name = character(),
          jersey_num = character()
        ) %>%
          make_hoopR_data("NBA Officials from NBA.com", Sys.time())
      }

      # LineScore - extract home and away
      line_score_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- summary_data[[team_key]] %||% list()
        periods <- team$periods %||% list()
        period_scores <- c(NA_integer_, NA_integer_, NA_integer_, NA_integer_)
        if (length(periods) > 0) {
          for (p in periods) {
            pnum <- p$period %||% 0
            if (pnum >= 1 && pnum <= 4) {
              period_scores[pnum] <- p$score %||% NA_integer_
            }
          }
        }
        line_score_rows[[team_key]] <- data.frame(
          gameId = game_id_val,
          teamId = team$teamId %||% NA_integer_,
          teamCity = team$teamCity %||% NA_character_,
          teamName = team$teamName %||% NA_character_,
          teamTricode = team$teamTricode %||% NA_character_,
          teamSlug = team$teamSlug %||% NA_character_,
          teamWins = team$teamWins %||% NA_integer_,
          teamLosses = team$teamLosses %||% NA_integer_,
          period1Score = period_scores[1],
          period2Score = period_scores[2],
          period3Score = period_scores[3],
          period4Score = period_scores[4],
          score = team$score %||% NA_integer_,
          stringsAsFactors = FALSE
        )
      }
      line_score <- dplyr::bind_rows(line_score_rows) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Line Score from NBA.com", Sys.time())

      # InactivePlayers
      inactive_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- summary_data[[team_key]] %||% list()
        team_id <- team$teamId %||% NA_integer_
        inactives <- team$inactives %||% list()
        if (length(inactives) > 0) {
          for (inactive in inactives) {
            inactive_rows[[length(inactive_rows) + 1]] <- data.frame(
              gameId = game_id_val,
              teamId = team_id,
              personId = inactive$personId %||% NA_integer_,
              firstName = inactive$firstName %||% NA_character_,
              familyName = inactive$familyName %||% NA_character_,
              jerseyNum = inactive$jerseyNum %||% NA_character_,
              stringsAsFactors = FALSE
            )
          }
        }
      }
      if (length(inactive_rows) > 0) {
        inactive_players <- dplyr::bind_rows(inactive_rows) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Inactive Players from NBA.com", Sys.time())
      } else {
        inactive_players <- dplyr::tibble(
          game_id = character(),
          team_id = integer(),
          person_id = integer(),
          first_name = character(),
          family_name = character(),
          jersey_num = character()
        ) %>%
          make_hoopR_data("NBA Inactive Players from NBA.com", Sys.time())
      }

      # LastFiveMeetings
      meetings <- summary_data$lastFiveMeetings$meetings %||% list()
      if (length(meetings) > 0) {
        meeting_rows <- lapply(meetings, function(meeting) {
          away <- meeting$awayTeam %||% list()
          home <- meeting$homeTeam %||% list()
          data.frame(
            recencyOrder = meeting$recencyOrder %||% NA_integer_,
            gameId = meeting$gameId %||% NA_character_,
            gameTimeUTC = meeting$gameTimeUTC %||% NA_character_,
            gameEt = meeting$gameEt %||% NA_character_,
            gameStatus = meeting$gameStatus %||% NA_integer_,
            gameStatusText = meeting$gameStatusText %||% NA_character_,
            awayTeamId = away$teamId %||% NA_integer_,
            awayTeamCity = away$teamCity %||% NA_character_,
            awayTeamName = away$teamName %||% NA_character_,
            awayTeamTricode = away$teamTricode %||% NA_character_,
            awayTeamScore = away$score %||% NA_integer_,
            awayTeamWins = away$wins %||% NA_integer_,
            awayTeamLosses = away$losses %||% NA_integer_,
            homeTeamId = home$teamId %||% NA_integer_,
            homeTeamCity = home$teamCity %||% NA_character_,
            homeTeamName = home$teamName %||% NA_character_,
            homeTeamTricode = home$teamTricode %||% NA_character_,
            homeTeamScore = home$score %||% NA_integer_,
            homeTeamWins = home$wins %||% NA_integer_,
            homeTeamLosses = home$losses %||% NA_integer_,
            stringsAsFactors = FALSE
          )
        })
        last_five_meetings <- dplyr::bind_rows(meeting_rows) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Last Five Meetings from NBA.com", Sys.time())
      } else {
        last_five_meetings <- dplyr::tibble() %>%
          make_hoopR_data("NBA Last Five Meetings from NBA.com", Sys.time())
      }

      # OtherStats (postgameCharts)
      postgame <- summary_data$postgameCharts %||% list()
      other_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- postgame[[team_key]] %||% list()
        stats <- team$statistics %||% list()
        other_rows[[team_key]] <- data.frame(
          gameId = game_id_val,
          teamId = team$teamId %||% NA_integer_,
          teamCity = team$teamCity %||% NA_character_,
          teamName = team$teamName %||% NA_character_,
          teamTricode = team$teamTricode %||% NA_character_,
          points = stats$points %||% NA_integer_,
          reboundsTotal = stats$reboundsTotal %||% NA_integer_,
          assists = stats$assists %||% NA_integer_,
          steals = stats$steals %||% NA_integer_,
          blocks = stats$blocks %||% NA_integer_,
          turnovers = stats$turnovers %||% NA_integer_,
          fieldGoalsPercentage = stats$fieldGoalsPercentage %||% NA_real_,
          threePointersPercentage = stats$threePointersPercentage %||% NA_real_,
          freeThrowsPercentage = stats$freeThrowsPercentage %||% NA_real_,
          pointsInThePaint = stats$pointsInThePaint %||% NA_integer_,
          pointsSecondChance = stats$pointsSecondChance %||% NA_integer_,
          pointsFastBreak = stats$pointsFastBreak %||% NA_integer_,
          biggestLead = stats$biggestLead %||% NA_integer_,
          leadChanges = stats$leadChanges %||% NA_integer_,
          timesTied = stats$timesTied %||% NA_integer_,
          biggestScoringRun = stats$biggestScoringRun %||% NA_integer_,
          turnoversTeam = stats$turnoversTeam %||% NA_integer_,
          turnoversTotal = stats$turnoversTotal %||% NA_integer_,
          reboundsTeam = stats$reboundsTeam %||% NA_integer_,
          pointsFromTurnovers = stats$pointsFromTurnovers %||% NA_integer_,
          benchPoints = stats$benchPoints %||% NA_integer_,
          stringsAsFactors = FALSE
        )
      }
      other_stats <- dplyr::bind_rows(other_rows) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Other Stats from NBA.com", Sys.time())

      # AvailableVideo
      available_video <- data.frame(
        gameId = game_id_val,
        videoAvailableFlag = summary_data$videoAvailableFlag %||% NA_integer_,
        ptAvailable = summary_data$ptAvailable %||% NA_integer_,
        ptXYZAvailable = summary_data$ptXYZAvailable %||% NA_integer_,
        whStatus = summary_data$whStatus %||% NA_integer_,
        hustleStatus = summary_data$hustleStatus %||% NA_integer_,
        historicalStatus = summary_data$historicalStatus %||% NA_integer_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Available Video from NBA.com", Sys.time())

      data <- list(
        GameSummary = game_summary,
        GameInfo = game_info,
        ArenaInfo = arena_info,
        Officials = officials,
        LineScore = line_score,
        InactivePlayers = inactive_players,
        LastFiveMeetings = last_five_meetings,
        OtherStats = other_stats,
        AvailableVideo = available_video
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no boxscore summary V3 data for {pad_id(game_id)} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}
