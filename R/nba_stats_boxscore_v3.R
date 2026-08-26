#' **Get NBA Stats API Boxscore Traditional V3**
#' @name nba_boxscoretraditionalv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param game_id Game ID - 10-digit zero-padded ID (e.g., '0022200021')
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:
#' home_team_player_traditional, away_team_player_traditional, home_team_totals_traditional,
#' away_team_totals_traditional, home_team_starters_totals, away_team_starters_totals,
#' home_team_bench_totals, away_team_bench_totals
#'
#'    **home_team_player_traditional**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       field_goals_made \tab integer \tab Field goals made (2-pt + 3-pt). \cr
#'       field_goals_attempted \tab integer \tab Field goal attempts (2-pt + 3-pt). \cr
#'       field_goals_percentage \tab numeric \tab Field goal percentage (0-1 decimal). \cr
#'       three_pointers_made \tab integer \tab Three-point field goals made. \cr
#'       three_pointers_attempted \tab integer \tab Three-point field goal attempts. \cr
#'       three_pointers_percentage \tab numeric \tab Three-point field goal percentage (0-1 decimal). \cr
#'       free_throws_made \tab integer \tab Free throws made. \cr
#'       free_throws_attempted \tab integer \tab Free throw attempts. \cr
#'       free_throws_percentage \tab numeric \tab Free throw percentage (0-1 decimal). \cr
#'       rebounds_offensive \tab integer \tab Offensive rebounds. \cr
#'       rebounds_defensive \tab integer \tab Defensive rebounds. \cr
#'       rebounds_total \tab integer \tab Total rebounds. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       steals \tab integer \tab Total steals. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       turnovers \tab integer \tab Total turnovers. \cr
#'       fouls_personal \tab integer \tab Personal fouls. \cr
#'       points \tab integer \tab Points scored. \cr
#'       plus_minus_points \tab numeric \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_traditional**
#'
#'
#'    Same columns as the **home_team_player_traditional** table above.
#'
#'    **home_team_totals_traditional**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       field_goals_made \tab integer \tab Field goals made (2-pt + 3-pt). \cr
#'       field_goals_attempted \tab integer \tab Field goal attempts (2-pt + 3-pt). \cr
#'       field_goals_percentage \tab numeric \tab Field goal percentage (0-1 decimal). \cr
#'       three_pointers_made \tab integer \tab Three-point field goals made. \cr
#'       three_pointers_attempted \tab integer \tab Three-point field goal attempts. \cr
#'       three_pointers_percentage \tab numeric \tab Three-point field goal percentage (0-1 decimal). \cr
#'       free_throws_made \tab integer \tab Free throws made. \cr
#'       free_throws_attempted \tab integer \tab Free throw attempts. \cr
#'       free_throws_percentage \tab numeric \tab Free throw percentage (0-1 decimal). \cr
#'       rebounds_offensive \tab integer \tab Offensive rebounds. \cr
#'       rebounds_defensive \tab integer \tab Defensive rebounds. \cr
#'       rebounds_total \tab integer \tab Total rebounds. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       steals \tab integer \tab Total steals. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       turnovers \tab integer \tab Total turnovers. \cr
#'       fouls_personal \tab integer \tab Personal fouls. \cr
#'       points \tab integer \tab Points scored. \cr
#'       plus_minus_points \tab numeric \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_traditional**
#'
#'
#'    Same columns as the **home_team_totals_traditional** table above.
#'
#'    **home_team_starters_totals**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       field_goals_made \tab integer \tab Field goals made (2-pt + 3-pt). \cr
#'       field_goals_attempted \tab integer \tab Field goal attempts (2-pt + 3-pt). \cr
#'       field_goals_percentage \tab numeric \tab Field goal percentage (0-1 decimal). \cr
#'       three_pointers_made \tab integer \tab Three-point field goals made. \cr
#'       three_pointers_attempted \tab integer \tab Three-point field goal attempts. \cr
#'       three_pointers_percentage \tab numeric \tab Three-point field goal percentage (0-1 decimal). \cr
#'       free_throws_made \tab integer \tab Free throws made. \cr
#'       free_throws_attempted \tab integer \tab Free throw attempts. \cr
#'       free_throws_percentage \tab numeric \tab Free throw percentage (0-1 decimal). \cr
#'       rebounds_offensive \tab integer \tab Offensive rebounds. \cr
#'       rebounds_defensive \tab integer \tab Defensive rebounds. \cr
#'       rebounds_total \tab integer \tab Total rebounds. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       steals \tab integer \tab Total steals. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       turnovers \tab integer \tab Total turnovers. \cr
#'       fouls_personal \tab integer \tab Personal fouls. \cr
#'       points \tab integer \tab Points scored. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_starters_totals**
#'
#'
#'    Same columns as the **home_team_starters_totals** table above.
#'
#'    **home_team_bench_totals**
#'
#'
#'    Same columns as the **home_team_starters_totals** table above.
#'
#'    **away_team_bench_totals**
#'
#'
#'    Same columns as the **home_team_starters_totals** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no traditional boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Advanced V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_advanced, away_team_player_advanced,
#' home_team_totals_advanced, away_team_totals_advanced
#'
#'    **home_team_player_advanced**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       estimated_offensive_rating \tab numeric \tab Estimated offensive rating (points per 100 possessions estimate). \cr
#'       offensive_rating \tab numeric \tab Offensive rating (points per 100 possessions). \cr
#'       estimated_defensive_rating \tab numeric \tab Estimated defensive rating (points allowed per 100 possessions estimate). \cr
#'       defensive_rating \tab numeric \tab Defensive rating (points allowed per 100 possessions). \cr
#'       estimated_net_rating \tab numeric \tab Estimated net rating (off rating - def rating). \cr
#'       net_rating \tab numeric \tab Net rating (off rating - def rating). \cr
#'       assist_percentage \tab numeric \tab Assist percentage (0-1). \cr
#'       assist_to_turnover \tab numeric \tab Assist-to-turnover ratio. \cr
#'       assist_ratio \tab numeric \tab Assist ratio (assists per 100 possessions used). \cr
#'       offensive_rebound_percentage \tab numeric \tab Offensive rebound percentage (0-1). \cr
#'       defensive_rebound_percentage \tab numeric \tab Defensive rebound percentage (0-1). \cr
#'       rebound_percentage \tab numeric \tab Total rebound percentage (0-1). \cr
#'       turnover_ratio \tab numeric \tab Turnover ratio (turnovers per 100 possessions used). \cr
#'       effective_field_goal_percentage \tab numeric \tab Effective field goal percentage (0-1). \cr
#'       true_shooting_percentage \tab numeric \tab True shooting percentage (0-1). \cr
#'       usage_percentage \tab numeric \tab Usage percentage (0-1). \cr
#'       estimated_usage_percentage \tab numeric \tab Estimated usage percentage (0-1). \cr
#'       estimated_pace \tab numeric \tab Estimated possessions per 48 minutes. \cr
#'       pace \tab numeric \tab Possessions per 48 minutes. \cr
#'       pace_per40 \tab numeric \tab Pace per40. \cr
#'       possessions \tab numeric \tab Possessions used. \cr
#'       pie \tab numeric \tab Player Impact Estimate (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_advanced**
#'
#'
#'    Same columns as the **home_team_player_advanced** table above.
#'
#'    **home_team_totals_advanced**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       estimated_offensive_rating \tab numeric \tab Estimated offensive rating (points per 100 possessions estimate). \cr
#'       offensive_rating \tab numeric \tab Offensive rating (points per 100 possessions). \cr
#'       estimated_defensive_rating \tab numeric \tab Estimated defensive rating (points allowed per 100 possessions estimate). \cr
#'       defensive_rating \tab numeric \tab Defensive rating (points allowed per 100 possessions). \cr
#'       estimated_net_rating \tab numeric \tab Estimated net rating (off rating - def rating). \cr
#'       net_rating \tab numeric \tab Net rating (off rating - def rating). \cr
#'       assist_percentage \tab numeric \tab Assist percentage (0-1). \cr
#'       assist_to_turnover \tab numeric \tab Assist-to-turnover ratio. \cr
#'       assist_ratio \tab numeric \tab Assist ratio (assists per 100 possessions used). \cr
#'       offensive_rebound_percentage \tab numeric \tab Offensive rebound percentage (0-1). \cr
#'       defensive_rebound_percentage \tab numeric \tab Defensive rebound percentage (0-1). \cr
#'       rebound_percentage \tab numeric \tab Total rebound percentage (0-1). \cr
#'       estimated_team_turnover_percentage \tab numeric \tab Estimated team turnover percentage (0-1). \cr
#'       turnover_ratio \tab numeric \tab Turnover ratio (turnovers per 100 possessions used). \cr
#'       effective_field_goal_percentage \tab numeric \tab Effective field goal percentage (0-1). \cr
#'       true_shooting_percentage \tab numeric \tab True shooting percentage (0-1). \cr
#'       usage_percentage \tab numeric \tab Usage percentage (0-1). \cr
#'       estimated_usage_percentage \tab numeric \tab Estimated usage percentage (0-1). \cr
#'       estimated_pace \tab numeric \tab Estimated possessions per 48 minutes. \cr
#'       pace \tab numeric \tab Possessions per 48 minutes. \cr
#'       pace_per40 \tab numeric \tab Pace per40. \cr
#'       possessions \tab numeric \tab Possessions used. \cr
#'       pie \tab numeric \tab Player Impact Estimate (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_advanced**
#'
#'
#'    Same columns as the **home_team_totals_advanced** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no advanced boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' @title
#' **Get NBA Stats API Boxscore Misc V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:  home_team_player_misc, away_team_player_misc,
#' home_team_totals_misc, away_team_totals_misc
#'
#'    **home_team_player_misc**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       points_off_turnovers \tab integer \tab Points scored off opponent turnovers. \cr
#'       points_second_chance \tab integer \tab Second-chance points scored. \cr
#'       points_fast_break \tab integer \tab Fast-break points scored. \cr
#'       points_paint \tab integer \tab Points scored in the paint. \cr
#'       opp_points_off_turnovers \tab integer \tab Opponent points off turnovers. \cr
#'       opp_points_second_chance \tab integer \tab Opponent points second chance. \cr
#'       opp_points_fast_break \tab integer \tab Opponent points fast break. \cr
#'       opp_points_paint \tab integer \tab Opponent points paint. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       blocks_against \tab integer \tab Shots blocked by opponents while attempting. \cr
#'       fouls_personal \tab integer \tab Personal fouls. \cr
#'       fouls_drawn \tab integer \tab Personal fouls drawn (by opponent's actions). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_misc**
#'
#'
#'    Same columns as the **home_team_player_misc** table above.
#'
#'    **home_team_totals_misc**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       points_off_turnovers \tab integer \tab Points scored off opponent turnovers. \cr
#'       points_second_chance \tab integer \tab Second-chance points scored. \cr
#'       points_fast_break \tab integer \tab Fast-break points scored. \cr
#'       points_paint \tab integer \tab Points scored in the paint. \cr
#'       opp_points_off_turnovers \tab integer \tab Opponent points off turnovers. \cr
#'       opp_points_second_chance \tab integer \tab Opponent points second chance. \cr
#'       opp_points_fast_break \tab integer \tab Opponent points fast break. \cr
#'       opp_points_paint \tab integer \tab Opponent points paint. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       blocks_against \tab integer \tab Shots blocked by opponents while attempting. \cr
#'       fouls_personal \tab integer \tab Personal fouls. \cr
#'       fouls_drawn \tab integer \tab Personal fouls drawn (by opponent's actions). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_misc**
#'
#'
#'    Same columns as the **home_team_totals_misc** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no misc boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Scoring V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_scoring, away_team_player_scoring,
#' home_team_totals_scoring, away_team_totals_scoring
#'
#'    **home_team_player_scoring**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       percentage_field_goals_attempted2pt \tab numeric \tab Percentage field goals attempted2pt. \cr
#'       percentage_field_goals_attempted3pt \tab numeric \tab Percentage field goals attempted3pt. \cr
#'       percentage_points2pt \tab numeric \tab Percentage points2pt. \cr
#'       percentage_points_midrange2pt \tab numeric \tab Percentage points midrange2pt. \cr
#'       percentage_points3pt \tab numeric \tab Percentage points3pt. \cr
#'       percentage_points_fast_break \tab numeric \tab Percentage points fast break. \cr
#'       percentage_points_free_throw \tab numeric \tab Percentage points free throw. \cr
#'       percentage_points_off_turnovers \tab numeric \tab Percentage points off turnovers. \cr
#'       percentage_points_paint \tab numeric \tab Percentage points paint. \cr
#'       percentage_assisted2pt \tab numeric \tab Percentage assisted2pt. \cr
#'       percentage_unassisted2pt \tab numeric \tab Percentage unassisted2pt. \cr
#'       percentage_assisted3pt \tab numeric \tab Percentage assisted3pt. \cr
#'       percentage_unassisted3pt \tab numeric \tab Percentage unassisted3pt. \cr
#'       percentage_assisted_fgm \tab numeric \tab Percentage assisted fgm. \cr
#'       percentage_unassisted_fgm \tab numeric \tab Percentage unassisted fgm. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_scoring**
#'
#'
#'    Same columns as the **home_team_player_scoring** table above.
#'
#'    **home_team_totals_scoring**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       percentage_field_goals_attempted2pt \tab numeric \tab Percentage field goals attempted2pt. \cr
#'       percentage_field_goals_attempted3pt \tab numeric \tab Percentage field goals attempted3pt. \cr
#'       percentage_points2pt \tab numeric \tab Percentage points2pt. \cr
#'       percentage_points_midrange2pt \tab numeric \tab Percentage points midrange2pt. \cr
#'       percentage_points3pt \tab numeric \tab Percentage points3pt. \cr
#'       percentage_points_fast_break \tab numeric \tab Percentage points fast break. \cr
#'       percentage_points_free_throw \tab numeric \tab Percentage points free throw. \cr
#'       percentage_points_off_turnovers \tab numeric \tab Percentage points off turnovers. \cr
#'       percentage_points_paint \tab numeric \tab Percentage points paint. \cr
#'       percentage_assisted2pt \tab numeric \tab Percentage assisted2pt. \cr
#'       percentage_unassisted2pt \tab numeric \tab Percentage unassisted2pt. \cr
#'       percentage_assisted3pt \tab numeric \tab Percentage assisted3pt. \cr
#'       percentage_unassisted3pt \tab numeric \tab Percentage unassisted3pt. \cr
#'       percentage_assisted_fgm \tab numeric \tab Percentage assisted fgm. \cr
#'       percentage_unassisted_fgm \tab numeric \tab Percentage unassisted fgm. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_scoring**
#'
#'
#'    Same columns as the **home_team_totals_scoring** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoring boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Usage V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:  home_team_player_usage, away_team_player_usage,
#' home_team_totals_usage, away_team_totals_usage
#'
#'    **home_team_player_usage**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       usage_percentage \tab numeric \tab Usage percentage (0-1). \cr
#'       percentage_field_goals_made \tab numeric \tab Number of percentage field goals made. \cr
#'       percentage_field_goals_attempted \tab numeric \tab Number of percentage field goals attempted. \cr
#'       percentage_three_pointers_made \tab numeric \tab Number of percentage three pointers made. \cr
#'       percentage_three_pointers_attempted \tab numeric \tab Number of percentage three pointers attempted. \cr
#'       percentage_free_throws_made \tab numeric \tab Number of percentage free throws made. \cr
#'       percentage_free_throws_attempted \tab numeric \tab Number of percentage free throws attempted. \cr
#'       percentage_rebounds_offensive \tab numeric \tab Percentage rebounds offensive. \cr
#'       percentage_rebounds_defensive \tab numeric \tab Percentage rebounds defensive. \cr
#'       percentage_rebounds_total \tab numeric \tab Percentage rebounds total. \cr
#'       percentage_assists \tab numeric \tab Percentage assists. \cr
#'       percentage_turnovers \tab numeric \tab Percentage turnovers. \cr
#'       percentage_steals \tab numeric \tab Percentage steals. \cr
#'       percentage_blocks \tab numeric \tab Percentage blocks. \cr
#'       percentage_blocks_allowed \tab numeric \tab Percentage blocks allowed. \cr
#'       percentage_personal_fouls \tab numeric \tab Percentage personal fouls. \cr
#'       percentage_personal_fouls_drawn \tab numeric \tab Percentage personal fouls drawn. \cr
#'       percentage_points \tab numeric \tab Percentage points. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_usage**
#'
#'
#'    Same columns as the **home_team_player_usage** table above.
#'
#'    **home_team_totals_usage**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       usage_percentage \tab numeric \tab Usage percentage (0-1). \cr
#'       percentage_field_goals_made \tab numeric \tab Number of percentage field goals made. \cr
#'       percentage_field_goals_attempted \tab numeric \tab Number of percentage field goals attempted. \cr
#'       percentage_three_pointers_made \tab numeric \tab Number of percentage three pointers made. \cr
#'       percentage_three_pointers_attempted \tab numeric \tab Number of percentage three pointers attempted. \cr
#'       percentage_free_throws_made \tab numeric \tab Number of percentage free throws made. \cr
#'       percentage_free_throws_attempted \tab numeric \tab Number of percentage free throws attempted. \cr
#'       percentage_rebounds_offensive \tab numeric \tab Percentage rebounds offensive. \cr
#'       percentage_rebounds_defensive \tab numeric \tab Percentage rebounds defensive. \cr
#'       percentage_rebounds_total \tab numeric \tab Percentage rebounds total. \cr
#'       percentage_assists \tab numeric \tab Percentage assists. \cr
#'       percentage_turnovers \tab numeric \tab Percentage turnovers. \cr
#'       percentage_steals \tab numeric \tab Percentage steals. \cr
#'       percentage_blocks \tab numeric \tab Percentage blocks. \cr
#'       percentage_blocks_allowed \tab numeric \tab Percentage blocks allowed. \cr
#'       percentage_personal_fouls \tab numeric \tab Percentage personal fouls. \cr
#'       percentage_personal_fouls_drawn \tab numeric \tab Percentage personal fouls drawn. \cr
#'       percentage_points \tab numeric \tab Percentage points. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_usage**
#'
#'
#'    Same columns as the **home_team_totals_usage** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no usage boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Four Factors V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:  home_team_player_four_factors,
#' away_team_player_four_factors, home_team_totals_four_factors,
#' away_team_totals_four_factors
#'
#'    **home_team_player_four_factors**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       effective_field_goal_percentage \tab numeric \tab Effective field goal percentage (0-1). \cr
#'       free_throw_attempt_rate \tab numeric \tab Free throw attempt rate (FTA / FGA). \cr
#'       team_turnover_percentage \tab numeric \tab Team turnover percentage (0-1). \cr
#'       offensive_rebound_percentage \tab numeric \tab Offensive rebound percentage (0-1). \cr
#'       opp_effective_field_goal_percentage \tab numeric \tab Opponent effective field goal percentage (0-1 decimal). \cr
#'       opp_free_throw_attempt_rate \tab numeric \tab Opponent free throw attempt rate. \cr
#'       opp_team_turnover_percentage \tab numeric \tab Opponent team turnover percentage (0-1 decimal). \cr
#'       opp_offensive_rebound_percentage \tab numeric \tab Opponent offensive rebound percentage (0-1 decimal). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_four_factors**
#'
#'
#'    Same columns as the **home_team_player_four_factors** table above.
#'
#'    **home_team_totals_four_factors**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       effective_field_goal_percentage \tab numeric \tab Effective field goal percentage (0-1). \cr
#'       free_throw_attempt_rate \tab numeric \tab Free throw attempt rate (FTA / FGA). \cr
#'       team_turnover_percentage \tab numeric \tab Team turnover percentage (0-1). \cr
#'       offensive_rebound_percentage \tab numeric \tab Offensive rebound percentage (0-1). \cr
#'       opp_effective_field_goal_percentage \tab numeric \tab Opponent effective field goal percentage (0-1 decimal). \cr
#'       opp_free_throw_attempt_rate \tab numeric \tab Opponent free throw attempt rate. \cr
#'       opp_team_turnover_percentage \tab numeric \tab Opponent team turnover percentage (0-1 decimal). \cr
#'       opp_offensive_rebound_percentage \tab numeric \tab Opponent offensive rebound percentage (0-1 decimal). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_four_factors**
#'
#'
#'    Same columns as the **home_team_totals_four_factors** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no four factors boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_player_track, away_team_player_player_track,
#' home_team_totals_player_track, away_team_totals_player_track
#'
#'    **home_team_player_player_track**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       speed \tab numeric \tab Speed. \cr
#'       distance \tab numeric \tab Distance value (in feet for shot data; otherwise context-dependent). \cr
#'       rebound_chances_offensive \tab integer \tab Rebound chances offensive. \cr
#'       rebound_chances_defensive \tab integer \tab Rebound chances defensive. \cr
#'       rebound_chances_total \tab integer \tab Rebound chances total. \cr
#'       touches \tab integer \tab Touches. \cr
#'       secondary_assists \tab integer \tab Secondary assists. \cr
#'       free_throw_assists \tab integer \tab Free throw assists (passes that led to a fouled shot attempt). \cr
#'       passes \tab integer \tab Passes. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       contested_field_goals_made \tab integer \tab Contested field goals made. \cr
#'       contested_field_goals_attempted \tab integer \tab Contested field goal attempts. \cr
#'       contested_field_goal_percentage \tab numeric \tab Contested field goal percentage (0-1). \cr
#'       uncontested_field_goals_made \tab integer \tab Number of uncontested field goals made. \cr
#'       uncontested_field_goals_attempted \tab integer \tab Number of uncontested field goals attempted. \cr
#'       uncontested_field_goals_percentage \tab numeric \tab Uncontested field goals percentage (0-1 decimal). \cr
#'       field_goal_percentage \tab numeric \tab Field Goal Percentage. \cr
#'       defended_at_rim_field_goals_made \tab integer \tab Field goals made allowed when defending at the rim. \cr
#'       defended_at_rim_field_goals_attempted \tab integer \tab Field goal attempts allowed when defending at the rim. \cr
#'       defended_at_rim_field_goal_percentage \tab numeric \tab Field goal percentage allowed at the rim (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_player_track**
#'
#'
#'    Same columns as the **home_team_player_player_track** table above.
#'
#'    **home_team_totals_player_track**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       distance \tab numeric \tab Distance value (in feet for shot data; otherwise context-dependent). \cr
#'       rebound_chances_offensive \tab integer \tab Rebound chances offensive. \cr
#'       rebound_chances_defensive \tab integer \tab Rebound chances defensive. \cr
#'       rebound_chances_total \tab integer \tab Rebound chances total. \cr
#'       touches \tab integer \tab Touches. \cr
#'       secondary_assists \tab integer \tab Secondary assists. \cr
#'       free_throw_assists \tab integer \tab Free throw assists (passes that led to a fouled shot attempt). \cr
#'       passes \tab integer \tab Passes. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       contested_field_goals_made \tab integer \tab Contested field goals made. \cr
#'       contested_field_goals_attempted \tab integer \tab Contested field goal attempts. \cr
#'       contested_field_goal_percentage \tab numeric \tab Contested field goal percentage (0-1). \cr
#'       uncontested_field_goals_made \tab integer \tab Number of uncontested field goals made. \cr
#'       uncontested_field_goals_attempted \tab integer \tab Number of uncontested field goals attempted. \cr
#'       uncontested_field_goals_percentage \tab numeric \tab Uncontested field goals percentage (0-1 decimal). \cr
#'       field_goal_percentage \tab numeric \tab Field Goal Percentage. \cr
#'       defended_at_rim_field_goals_made \tab integer \tab Field goals made allowed when defending at the rim. \cr
#'       defended_at_rim_field_goals_attempted \tab integer \tab Field goal attempts allowed when defending at the rim. \cr
#'       defended_at_rim_field_goal_percentage \tab numeric \tab Field goal percentage allowed at the rim (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_player_track**
#'
#'
#'    Same columns as the **home_team_totals_player_track** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player tracking boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Matchups V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_matchups, away_team_player_matchups
#'
#'    **home_team_player_matchups**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       matchups_person_id \tab integer \tab Unique identifier for matchups person. \cr
#'       matchups_first_name \tab character \tab Matchups first name. \cr
#'       matchups_family_name \tab character \tab Matchups family name. \cr
#'       matchups_name_i \tab character \tab Matchups name i. \cr
#'       matchups_player_slug \tab character \tab Matchups player slug. \cr
#'       matchups_jersey_num \tab character \tab Matchups jersey num. \cr
#'       matchup_minutes \tab character \tab Matchup minutes. \cr
#'       matchup_minutes_sort \tab numeric \tab Matchup minutes sort. \cr
#'       partial_possessions \tab numeric \tab Partial possessions. \cr
#'       percentage_defender_total_time \tab numeric \tab Time / clock value. \cr
#'       percentage_offensive_total_time \tab numeric \tab Time / clock value. \cr
#'       percentage_total_time_both_on \tab numeric \tab Percentage total time both on. \cr
#'       switches_on \tab integer \tab Switches on. \cr
#'       player_points \tab integer \tab Player points. \cr
#'       team_points \tab integer \tab Team points. \cr
#'       matchup_assists \tab integer \tab Matchup assists. \cr
#'       matchup_potential_assists \tab integer \tab Matchup potential assists. \cr
#'       matchup_turnovers \tab integer \tab Matchup turnovers. \cr
#'       matchup_blocks \tab integer \tab Matchup blocks. \cr
#'       matchup_field_goals_made \tab integer \tab Number of matchup field goals made. \cr
#'       matchup_field_goals_attempted \tab integer \tab Number of matchup field goals attempted. \cr
#'       matchup_field_goals_percentage \tab numeric \tab Matchup field goals percentage (0-1 decimal). \cr
#'       matchup_three_pointers_made \tab integer \tab Number of matchup three pointers made. \cr
#'       matchup_three_pointers_attempted \tab integer \tab Number of matchup three pointers attempted. \cr
#'       matchup_three_pointers_percentage \tab numeric \tab Matchup three pointers percentage (0-1 decimal). \cr
#'       help_blocks \tab integer \tab Help blocks. \cr
#'       help_field_goals_made \tab integer \tab Number of help field goals made. \cr
#'       help_field_goals_attempted \tab integer \tab Number of help field goals attempted. \cr
#'       help_field_goals_percentage \tab numeric \tab Help field goals percentage (0-1 decimal). \cr
#'       matchup_free_throws_made \tab integer \tab Number of matchup free throws made. \cr
#'       matchup_free_throws_attempted \tab integer \tab Number of matchup free throws attempted. \cr
#'       shooting_fouls \tab integer \tab Shooting fouls. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_matchups**
#'
#'
#'    Same columns as the **home_team_player_matchups** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no matchups boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Hustle V2**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_boxscorehustlev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Hustle V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_hustlestatsboxscore()` instead.
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_hustle, away_team_player_hustle,
#'  home_team_hustle_totals, away_team_hustle_totals
#'
#'    **home_team_player_hustle**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       points \tab integer \tab Points scored. \cr
#'       contested_shots \tab integer \tab Defensively contested shots. \cr
#'       contested_shots2pt \tab integer \tab Contested shots2pt. \cr
#'       contested_shots3pt \tab integer \tab Contested shots3pt. \cr
#'       deflections \tab integer \tab Defensive deflections. \cr
#'       charges_drawn \tab integer \tab Charges drawn. \cr
#'       screen_assists \tab integer \tab Screen assists (resulting in a basket). \cr
#'       screen_assist_points \tab integer \tab Points generated from screen assists. \cr
#'       loose_balls_recovered_offensive \tab integer \tab Loose balls recovered on offense. \cr
#'       loose_balls_recovered_defensive \tab integer \tab Loose balls recovered on defense. \cr
#'       loose_balls_recovered_total \tab integer \tab Loose balls recovered total. \cr
#'       offensive_box_outs \tab integer \tab Offensive box outs. \cr
#'       defensive_box_outs \tab integer \tab Defensive box outs. \cr
#'       box_out_player_team_rebounds \tab integer \tab Box-outs that led to either a player or team rebound. \cr
#'       box_out_player_rebounds \tab integer \tab Box-outs that led to a player rebound. \cr
#'       box_outs \tab integer \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_hustle**
#'
#'
#'    Same columns as the **home_team_player_hustle** table above.
#'
#'    **home_team_totals_hustle**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       points \tab integer \tab Points scored. \cr
#'       contested_shots \tab integer \tab Defensively contested shots. \cr
#'       contested_shots2pt \tab integer \tab Contested shots2pt. \cr
#'       contested_shots3pt \tab integer \tab Contested shots3pt. \cr
#'       deflections \tab integer \tab Defensive deflections. \cr
#'       charges_drawn \tab integer \tab Charges drawn. \cr
#'       screen_assists \tab integer \tab Screen assists (resulting in a basket). \cr
#'       screen_assist_points \tab integer \tab Points generated from screen assists. \cr
#'       loose_balls_recovered_offensive \tab integer \tab Loose balls recovered on offense. \cr
#'       loose_balls_recovered_defensive \tab integer \tab Loose balls recovered on defense. \cr
#'       loose_balls_recovered_total \tab integer \tab Loose balls recovered total. \cr
#'       offensive_box_outs \tab integer \tab Offensive box outs. \cr
#'       defensive_box_outs \tab integer \tab Defensive box outs. \cr
#'       box_out_player_team_rebounds \tab integer \tab Box-outs that led to either a player or team rebound. \cr
#'       box_out_player_rebounds \tab integer \tab Box-outs that led to a player rebound. \cr
#'       box_outs \tab integer \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_hustle**
#'
#'
#'    Same columns as the **home_team_totals_hustle** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorehustlev2()",
    with = "nba_hustlestatsboxscore()",
    details = "Live re-probe (2026-08-24, residential IP) confirms the endpoint still responds, but this wrapper's boxScoreHustle parsing errors on the current payload shape (mismatched row counts across statistics/players); not restored. Tracked as a follow-up parser fix."
  )

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no hustle stats boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Defensive V2**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: home_team_player_defensive, away_team_player_defensive,
#'  home_team_totals_defensive, away_team_totals_defensive
#'
#'    **home_team_player_defensive**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       player_slug \tab character \tab URL-safe player identifier. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       comment \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'       matchup_minutes \tab character \tab Matchup minutes. \cr
#'       partial_possessions \tab numeric \tab Partial possessions. \cr
#'       switches_on \tab integer \tab Switches on. \cr
#'       player_points \tab integer \tab Player points. \cr
#'       defensive_rebounds \tab integer \tab Defensive rebounds. \cr
#'       matchup_assists \tab integer \tab Matchup assists. \cr
#'       matchup_turnovers \tab integer \tab Matchup turnovers. \cr
#'       steals \tab integer \tab Total steals. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       matchup_field_goals_made \tab integer \tab Number of matchup field goals made. \cr
#'       matchup_field_goals_attempted \tab integer \tab Number of matchup field goals attempted. \cr
#'       matchup_field_goal_percentage \tab numeric \tab Matchup field goal percentage (0-1 decimal). \cr
#'       matchup_three_pointers_made \tab integer \tab Number of matchup three pointers made. \cr
#'       matchup_three_pointers_attempted \tab integer \tab Number of matchup three pointers attempted. \cr
#'       matchup_three_pointer_percentage \tab numeric \tab Matchup three pointer percentage (0-1 decimal). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_player_defensive**
#'
#'
#'    Same columns as the **home_team_player_defensive** table above.
#'
#'    **home_team_totals_defensive**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **away_team_totals_defensive**
#'
#'
#'    Same columns as the **home_team_totals_defensive** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defensive boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Game Rotation**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_gamerotation
NULL
#' @title
#' **Get NBA Stats API Game Rotation**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param league_id League ID
#' @param rotation_stat Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AwayTeam, HomeTeam
#'
#'    **AwayTeam**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       PLAYER_FIRST \tab character \tab  \cr
#'       PLAYER_LAST \tab character \tab  \cr
#'       IN_TIME_REAL \tab character \tab  \cr
#'       OUT_TIME_REAL \tab character \tab  \cr
#'       PLAYER_PTS \tab character \tab  \cr
#'       PT_DIFF \tab character \tab  \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **HomeTeam**
#'
#'
#'    Same columns as the **AwayTeam** table above.
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
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "gamerotation"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  # stats.nba.com's edge rejects this endpoint (empty 500 / stall) unless
  # GameID precedes LeagueID in the query string; RotationStat stays last.
  params <- list(
    GameID = pad_id(game_id),
    LeagueID = league_id,
    RotationStat = rotation_stat
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(seq_along(resp$resultSets$name), function(x) {
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game rotation data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_boxscoresummaryv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:
#' GameSummary, GameInfo, ArenaInfo, Officials, LineScore,
#' InactivePlayers, LastFiveMeetings, OtherStats, AvailableVideo
#'
#'    **GameSummary**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_code \tab character \tab ESPN game code (numeric identifier). \cr
#'       game_status \tab integer \tab Game status label. \cr
#'       game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       period \tab integer \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       game_clock \tab character \tab Game clock. \cr
#'       game_time_utc \tab character \tab Game start time in UTC (ISO 8601 timestamp). \cr
#'       game_et \tab character \tab Game et. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       duration \tab integer \tab Duration. \cr
#'       attendance \tab integer \tab Reported attendance. \cr
#'       sellout \tab character \tab Sellout. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **GameInfo**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_date \tab character \tab Game date (YYYY-MM-DD). \cr
#'       attendance \tab integer \tab Reported attendance. \cr
#'       game_duration \tab integer \tab Game duration. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **ArenaInfo**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       arena_id \tab integer \tab Unique identifier for arena. \cr
#'       arena_name \tab character \tab Arena name. \cr
#'       arena_city \tab character \tab Arena city. \cr
#'       arena_state \tab character \tab Arena state. \cr
#'       arena_country \tab character \tab Arena country. \cr
#'       arena_timezone \tab character \tab Arena timezone. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Officials**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       name \tab character \tab Display name. \cr
#'       name_i \tab character \tab Initialed name (e.g. 'A. Wilson'). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **LineScore**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       team_wins \tab integer \tab Team wins. \cr
#'       team_losses \tab integer \tab Team losses. \cr
#'       period1_score \tab integer \tab Period1 score. \cr
#'       period2_score \tab integer \tab Period2 score. \cr
#'       period3_score \tab integer \tab Period3 score. \cr
#'       period4_score \tab integer \tab Period4 score. \cr
#'       score \tab integer \tab Final score. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **InactivePlayers**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       person_id \tab integer \tab Unique player identifier (V3 endpoints). \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       family_name \tab character \tab Player's family / last name. \cr
#'       jersey_num \tab character \tab Jersey number worn by the player. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **LastFiveMeetings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       recency_order \tab integer \tab Recency order. \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_time_utc \tab character \tab Game start time in UTC (ISO 8601 timestamp). \cr
#'       game_et \tab character \tab Game et. \cr
#'       game_status \tab integer \tab Game status label. \cr
#'       game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       away_team_city \tab character \tab Away team city / location. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_tricode \tab character \tab Away team three-letter code. \cr
#'       away_team_score \tab integer \tab Away team's score. \cr
#'       away_team_wins \tab integer \tab Away team's team wins. \cr
#'       away_team_losses \tab integer \tab Away team's team losses. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       home_team_city \tab character \tab Home team city / location. \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_tricode \tab character \tab Home team three-letter code. \cr
#'       home_team_score \tab integer \tab Home team's score. \cr
#'       home_team_wins \tab integer \tab Home team's team wins. \cr
#'       home_team_losses \tab integer \tab Home team's team losses. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **OtherStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_tricode \tab character \tab Three-letter team code (e.g. 'LAS' / 'NYL'). \cr
#'       points \tab integer \tab Points scored. \cr
#'       rebounds_total \tab integer \tab Total rebounds. \cr
#'       assists \tab integer \tab Total assists. \cr
#'       steals \tab integer \tab Total steals. \cr
#'       blocks \tab integer \tab Total blocks. \cr
#'       turnovers \tab integer \tab Total turnovers. \cr
#'       field_goals_percentage \tab numeric \tab Field goal percentage (0-1 decimal). \cr
#'       three_pointers_percentage \tab numeric \tab Three-point field goal percentage (0-1 decimal). \cr
#'       free_throws_percentage \tab numeric \tab Free throw percentage (0-1 decimal). \cr
#'       points_in_the_paint \tab integer \tab Points in the paint. \cr
#'       points_second_chance \tab integer \tab Second-chance points scored. \cr
#'       points_fast_break \tab integer \tab Fast-break points scored. \cr
#'       biggest_lead \tab integer \tab Biggest lead. \cr
#'       lead_changes \tab integer \tab Lead changes. \cr
#'       times_tied \tab integer \tab Times tied. \cr
#'       biggest_scoring_run \tab integer \tab Biggest scoring run. \cr
#'       turnovers_team \tab integer \tab Turnovers team. \cr
#'       turnovers_total \tab integer \tab Turnovers total. \cr
#'       rebounds_team \tab integer \tab Rebounds team. \cr
#'       points_from_turnovers \tab integer \tab Points from turnovers. \cr
#'       bench_points \tab integer \tab Points scored by the bench. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **AvailableVideo**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       video_available_flag \tab integer \tab Video available flag. \cr
#'       pt_available \tab integer \tab Pt available. \cr
#'       pt_xyz_available \tab integer \tab Pt xyz available. \cr
#'       wh_status \tab integer \tab Wh status. \cr
#'       hustle_status \tab integer \tab Hustle status. \cr
#'       historical_status \tab integer \tab Historical status. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoresummaryv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  data <- list()

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
        periods <- team$periods %||% data.frame(stringsAsFactors = FALSE)
        period_scores <- c(NA_integer_, NA_integer_, NA_integer_, NA_integer_)
        if (is.data.frame(periods) && nrow(periods) > 0) {
          for (i in seq_len(nrow(periods))) {
            pnum <- periods$period[[i]] %||% 0
            if (pnum >= 1 && pnum <= 4) {
              period_scores[pnum] <- periods$score[[i]] %||% NA_integer_
            }
          }
        } else if (is.list(periods) && length(periods) > 0) {
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
          period1_score = period_scores[1],
          period2_score = period_scores[2],
          period3_score = period_scores[3],
          period4_score = period_scores[4],
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
        inactives <- team$inactives %||% data.frame(stringsAsFactors = FALSE)

        if (is.data.frame(inactives) && nrow(inactives) > 0) {
          inactive_df <- data.frame(
            gameId = game_id_val,
            teamId = team_id,
            personId = inactives$personId %||% rep(NA_integer_, nrow(inactives)),
            firstName = inactives$firstName %||% rep(NA_character_, nrow(inactives)),
            familyName = inactives$familyName %||% rep(NA_character_, nrow(inactives)),
            jerseyNum = inactives$jerseyNum %||% rep(NA_character_, nrow(inactives)),
            stringsAsFactors = FALSE
          )

          inactive_rows[[length(inactive_rows) + 1]] <- inactive_df
        } else if (is.list(inactives) && length(inactives) > 0) {
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
      meetings <- summary_data$lastFiveMeetings$meetings %||% data.frame(stringsAsFactors = FALSE)
      if (is.data.frame(meetings) && nrow(meetings) > 0) {
        away <- meetings$awayTeam %||% data.frame(stringsAsFactors = FALSE)
        home <- meetings$homeTeam %||% data.frame(stringsAsFactors = FALSE)
        n_meetings <- nrow(meetings)

        last_five_meetings <- data.frame(
          recencyOrder = meetings$recencyOrder %||% rep(NA_integer_, n_meetings),
          gameId = meetings$gameId %||% rep(NA_character_, n_meetings),
          gameTimeUTC = meetings$gameTimeUTC %||% rep(NA_character_, n_meetings),
          gameEt = meetings$gameEt %||% rep(NA_character_, n_meetings),
          gameStatus = meetings$gameStatus %||% rep(NA_integer_, n_meetings),
          gameStatusText = meetings$gameStatusText %||% rep(NA_character_, n_meetings),
          awayTeamId = away$teamId %||% rep(NA_integer_, n_meetings),
          awayTeamCity = away$teamCity %||% rep(NA_character_, n_meetings),
          awayTeamName = away$teamName %||% rep(NA_character_, n_meetings),
          awayTeamTricode = away$teamTricode %||% rep(NA_character_, n_meetings),
          awayTeamScore = away$score %||% rep(NA_integer_, n_meetings),
          awayTeamWins = away$wins %||% rep(NA_integer_, n_meetings),
          awayTeamLosses = away$losses %||% rep(NA_integer_, n_meetings),
          homeTeamId = home$teamId %||% rep(NA_integer_, n_meetings),
          homeTeamCity = home$teamCity %||% rep(NA_character_, n_meetings),
          homeTeamName = home$teamName %||% rep(NA_character_, n_meetings),
          homeTeamTricode = home$teamTricode %||% rep(NA_character_, n_meetings),
          homeTeamScore = home$score %||% rep(NA_integer_, n_meetings),
          homeTeamWins = home$wins %||% rep(NA_integer_, n_meetings),
          homeTeamLosses = home$losses %||% rep(NA_integer_, n_meetings),
          stringsAsFactors = FALSE
        ) %>%
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore summary V3 data for {pad_id(game_id)} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}
