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
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                 |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                |character |Player's first name.                                                             |
#'    |family_name               |character |Player's family / last name.                                                     |
#'    |name_i                    |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug               |character |URL-safe player identifier.                                                      |
#'    |position                  |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                   |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                |character |Jersey number worn by the player.                                                |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'
#'    **away_team_player_traditional**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                 |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                |character |Player's first name.                                                             |
#'    |family_name               |character |Player's family / last name.                                                     |
#'    |name_i                    |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug               |character |URL-safe player identifier.                                                      |
#'    |position                  |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                   |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                |character |Jersey number worn by the player.                                                |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'
#'    **home_team_totals_traditional**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'
#'    **away_team_totals_traditional**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'    |plus_minus_points         |numeric   |Plus/minus point differential while on court.                                    |
#'
#'    **home_team_starters_totals**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'
#'    **away_team_starters_totals**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'
#'    **home_team_bench_totals**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
#'
#'    **away_team_bench_totals**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                                                          |
#'    |away_team_id              |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id              |integer   |Unique identifier for the home team.                                             |
#'    |team_id                   |integer   |Unique team identifier.                                                          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                 |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |field_goals_made          |integer   |Field goals made (2-pt + 3-pt).                                                  |
#'    |field_goals_attempted     |integer   |Field goal attempts (2-pt + 3-pt).                                               |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).                                             |
#'    |three_pointers_made       |integer   |Three-point field goals made.                                                    |
#'    |three_pointers_attempted  |integer   |Three-point field goal attempts.                                                 |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal).                                 |
#'    |free_throws_made          |integer   |Free throws made.                                                                |
#'    |free_throws_attempted     |integer   |Free throw attempts.                                                             |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).                                             |
#'    |rebounds_offensive        |integer   |Offensive rebounds.                                                              |
#'    |rebounds_defensive        |integer   |Defensive rebounds.                                                              |
#'    |rebounds_total            |integer   |Total rebounds.                                                                  |
#'    |assists                   |integer   |Total assists.                                                                   |
#'    |steals                    |integer   |Total steals.                                                                    |
#'    |blocks                    |integer   |Total blocks.                                                                    |
#'    |turnovers                 |integer   |Total turnovers.                                                                 |
#'    |fouls_personal            |integer   |Personal fouls.                                                                  |
#'    |points                    |integer   |Points scored.                                                                   |
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

#' **Get NBA Stats API Boxscore Advanced V3**
#' @name nba_boxscoreadvancedv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Advanced V3**
#' @rdname nba_boxscoreadvancedv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                       |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                      |character |Player's first name.                                                             |
#'    |family_name                     |character |Player's family / last name.                                                     |
#'    |name_i                          |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                     |character |URL-safe player identifier.                                                      |
#'    |position                        |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                         |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                      |character |Jersey number worn by the player.                                                |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |estimated_offensive_rating      |numeric   |Estimated offensive rating (points per 100 possessions estimate).                |
#'    |offensive_rating                |numeric   |Offensive rating (points per 100 possessions).                                   |
#'    |estimated_defensive_rating      |numeric   |Estimated defensive rating (points allowed per 100 possessions estimate).        |
#'    |defensive_rating                |numeric   |Defensive rating (points allowed per 100 possessions).                           |
#'    |estimated_net_rating            |numeric   |Estimated net rating (off rating - def rating).                                  |
#'    |net_rating                      |numeric   |Net rating (off rating - def rating).                                            |
#'    |assist_percentage               |numeric   |Assist percentage (0-1).                                                         |
#'    |assist_to_turnover              |numeric   |Assist-to-turnover ratio.                                                        |
#'    |assist_ratio                    |numeric   |Assist ratio (assists per 100 possessions used).                                 |
#'    |offensive_rebound_percentage    |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |defensive_rebound_percentage    |numeric   |Defensive rebound percentage (0-1).                                              |
#'    |rebound_percentage              |numeric   |Total rebound percentage (0-1).                                                  |
#'    |turnover_ratio                  |numeric   |Turnover ratio (turnovers per 100 possessions used).                             |
#'    |effective_field_goal_percentage |numeric   |Effective field goal percentage (0-1).                                           |
#'    |true_shooting_percentage        |numeric   |True shooting percentage (0-1).                                                  |
#'    |usage_percentage                |numeric   |Usage percentage (0-1).                                                          |
#'    |estimated_usage_percentage      |numeric   |Estimated usage percentage (0-1).                                                |
#'    |estimated_pace                  |numeric   |Estimated possessions per 48 minutes.                                            |
#'    |pace                            |numeric   |Possessions per 48 minutes.                                                      |
#'    |pace_per40                      |numeric   |Pace per40.                                                                      |
#'    |possessions                     |numeric   |Possessions used.                                                                |
#'    |pie                             |numeric   |Player Impact Estimate (0-1).                                                    |
#'
#'    **away_team_player_advanced**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                       |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                      |character |Player's first name.                                                             |
#'    |family_name                     |character |Player's family / last name.                                                     |
#'    |name_i                          |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                     |character |URL-safe player identifier.                                                      |
#'    |position                        |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                         |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                      |character |Jersey number worn by the player.                                                |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |estimated_offensive_rating      |numeric   |Estimated offensive rating (points per 100 possessions estimate).                |
#'    |offensive_rating                |numeric   |Offensive rating (points per 100 possessions).                                   |
#'    |estimated_defensive_rating      |numeric   |Estimated defensive rating (points allowed per 100 possessions estimate).        |
#'    |defensive_rating                |numeric   |Defensive rating (points allowed per 100 possessions).                           |
#'    |estimated_net_rating            |numeric   |Estimated net rating (off rating - def rating).                                  |
#'    |net_rating                      |numeric   |Net rating (off rating - def rating).                                            |
#'    |assist_percentage               |numeric   |Assist percentage (0-1).                                                         |
#'    |assist_to_turnover              |numeric   |Assist-to-turnover ratio.                                                        |
#'    |assist_ratio                    |numeric   |Assist ratio (assists per 100 possessions used).                                 |
#'    |offensive_rebound_percentage    |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |defensive_rebound_percentage    |numeric   |Defensive rebound percentage (0-1).                                              |
#'    |rebound_percentage              |numeric   |Total rebound percentage (0-1).                                                  |
#'    |turnover_ratio                  |numeric   |Turnover ratio (turnovers per 100 possessions used).                             |
#'    |effective_field_goal_percentage |numeric   |Effective field goal percentage (0-1).                                           |
#'    |true_shooting_percentage        |numeric   |True shooting percentage (0-1).                                                  |
#'    |usage_percentage                |numeric   |Usage percentage (0-1).                                                          |
#'    |estimated_usage_percentage      |numeric   |Estimated usage percentage (0-1).                                                |
#'    |estimated_pace                  |numeric   |Estimated possessions per 48 minutes.                                            |
#'    |pace                            |numeric   |Possessions per 48 minutes.                                                      |
#'    |pace_per40                      |numeric   |Pace per40.                                                                      |
#'    |possessions                     |numeric   |Possessions used.                                                                |
#'    |pie                             |numeric   |Player Impact Estimate (0-1).                                                    |
#'
#'    **home_team_totals_advanced**
#'
#'
#'    |col_name                           |types     |description                                                                      |
#'    |:----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                            |character |Unique game identifier.                                                          |
#'    |away_team_id                       |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                       |integer   |Unique identifier for the home team.                                             |
#'    |team_id                            |integer   |Unique team identifier.                                                          |
#'    |team_name                          |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                          |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                       |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                          |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                            |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |estimated_offensive_rating         |numeric   |Estimated offensive rating (points per 100 possessions estimate).                |
#'    |offensive_rating                   |numeric   |Offensive rating (points per 100 possessions).                                   |
#'    |estimated_defensive_rating         |numeric   |Estimated defensive rating (points allowed per 100 possessions estimate).        |
#'    |defensive_rating                   |numeric   |Defensive rating (points allowed per 100 possessions).                           |
#'    |estimated_net_rating               |numeric   |Estimated net rating (off rating - def rating).                                  |
#'    |net_rating                         |numeric   |Net rating (off rating - def rating).                                            |
#'    |assist_percentage                  |numeric   |Assist percentage (0-1).                                                         |
#'    |assist_to_turnover                 |numeric   |Assist-to-turnover ratio.                                                        |
#'    |assist_ratio                       |numeric   |Assist ratio (assists per 100 possessions used).                                 |
#'    |offensive_rebound_percentage       |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |defensive_rebound_percentage       |numeric   |Defensive rebound percentage (0-1).                                              |
#'    |rebound_percentage                 |numeric   |Total rebound percentage (0-1).                                                  |
#'    |estimated_team_turnover_percentage |numeric   |Estimated team turnover percentage (0-1).                                        |
#'    |turnover_ratio                     |numeric   |Turnover ratio (turnovers per 100 possessions used).                             |
#'    |effective_field_goal_percentage    |numeric   |Effective field goal percentage (0-1).                                           |
#'    |true_shooting_percentage           |numeric   |True shooting percentage (0-1).                                                  |
#'    |usage_percentage                   |numeric   |Usage percentage (0-1).                                                          |
#'    |estimated_usage_percentage         |numeric   |Estimated usage percentage (0-1).                                                |
#'    |estimated_pace                     |numeric   |Estimated possessions per 48 minutes.                                            |
#'    |pace                               |numeric   |Possessions per 48 minutes.                                                      |
#'    |pace_per40                         |numeric   |Pace per40.                                                                      |
#'    |possessions                        |numeric   |Possessions used.                                                                |
#'    |pie                                |numeric   |Player Impact Estimate (0-1).                                                    |
#'
#'    **away_team_totals_advanced**
#'
#'
#'    |col_name                           |types     |description                                                                      |
#'    |:----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                            |character |Unique game identifier.                                                          |
#'    |away_team_id                       |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                       |integer   |Unique identifier for the home team.                                             |
#'    |team_id                            |integer   |Unique team identifier.                                                          |
#'    |team_name                          |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                          |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                       |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                          |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                            |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |estimated_offensive_rating         |numeric   |Estimated offensive rating (points per 100 possessions estimate).                |
#'    |offensive_rating                   |numeric   |Offensive rating (points per 100 possessions).                                   |
#'    |estimated_defensive_rating         |numeric   |Estimated defensive rating (points allowed per 100 possessions estimate).        |
#'    |defensive_rating                   |numeric   |Defensive rating (points allowed per 100 possessions).                           |
#'    |estimated_net_rating               |numeric   |Estimated net rating (off rating - def rating).                                  |
#'    |net_rating                         |numeric   |Net rating (off rating - def rating).                                            |
#'    |assist_percentage                  |numeric   |Assist percentage (0-1).                                                         |
#'    |assist_to_turnover                 |numeric   |Assist-to-turnover ratio.                                                        |
#'    |assist_ratio                       |numeric   |Assist ratio (assists per 100 possessions used).                                 |
#'    |offensive_rebound_percentage       |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |defensive_rebound_percentage       |numeric   |Defensive rebound percentage (0-1).                                              |
#'    |rebound_percentage                 |numeric   |Total rebound percentage (0-1).                                                  |
#'    |estimated_team_turnover_percentage |numeric   |Estimated team turnover percentage (0-1).                                        |
#'    |turnover_ratio                     |numeric   |Turnover ratio (turnovers per 100 possessions used).                             |
#'    |effective_field_goal_percentage    |numeric   |Effective field goal percentage (0-1).                                           |
#'    |true_shooting_percentage           |numeric   |True shooting percentage (0-1).                                                  |
#'    |usage_percentage                   |numeric   |Usage percentage (0-1).                                                          |
#'    |estimated_usage_percentage         |numeric   |Estimated usage percentage (0-1).                                                |
#'    |estimated_pace                     |numeric   |Estimated possessions per 48 minutes.                                            |
#'    |pace                               |numeric   |Possessions per 48 minutes.                                                      |
#'    |pace_per40                         |numeric   |Pace per40.                                                                      |
#'    |possessions                        |numeric   |Possessions used.                                                                |
#'    |pie                                |numeric   |Player Impact Estimate (0-1).                                                    |
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


#' **Get NBA Stats API Boxscore Misc V3**
#' @name nba_boxscoremiscv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Misc V3**
#' @rdname nba_boxscoremiscv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                 |types     |description                                                                      |
#'    |:------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                  |character |Unique game identifier.                                                          |
#'    |away_team_id             |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id             |integer   |Unique identifier for the home team.                                             |
#'    |team_id                  |integer   |Unique team identifier.                                                          |
#'    |team_name                |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode             |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name               |character |Player's first name.                                                             |
#'    |family_name              |character |Player's family / last name.                                                     |
#'    |name_i                   |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug              |character |URL-safe player identifier.                                                      |
#'    |position                 |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                  |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num               |character |Jersey number worn by the player.                                                |
#'    |minutes                  |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points_off_turnovers     |integer   |Points scored off opponent turnovers.                                            |
#'    |points_second_chance     |integer   |Second-chance points scored.                                                     |
#'    |points_fast_break        |integer   |Fast-break points scored.                                                        |
#'    |points_paint             |integer   |Points scored in the paint.                                                      |
#'    |opp_points_off_turnovers |integer   |Opponent points off turnovers.                                                   |
#'    |opp_points_second_chance |integer   |Opponent points second chance.                                                   |
#'    |opp_points_fast_break    |integer   |Opponent points fast break.                                                      |
#'    |opp_points_paint         |integer   |Opponent points paint.                                                           |
#'    |blocks                   |integer   |Total blocks.                                                                    |
#'    |blocks_against           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fouls_personal           |integer   |Personal fouls.                                                                  |
#'    |fouls_drawn              |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'
#'    **away_team_player_misc**
#'
#'
#'    |col_name                 |types     |description                                                                      |
#'    |:------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                  |character |Unique game identifier.                                                          |
#'    |away_team_id             |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id             |integer   |Unique identifier for the home team.                                             |
#'    |team_id                  |integer   |Unique team identifier.                                                          |
#'    |team_name                |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode             |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name               |character |Player's first name.                                                             |
#'    |family_name              |character |Player's family / last name.                                                     |
#'    |name_i                   |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug              |character |URL-safe player identifier.                                                      |
#'    |position                 |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                  |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num               |character |Jersey number worn by the player.                                                |
#'    |minutes                  |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points_off_turnovers     |integer   |Points scored off opponent turnovers.                                            |
#'    |points_second_chance     |integer   |Second-chance points scored.                                                     |
#'    |points_fast_break        |integer   |Fast-break points scored.                                                        |
#'    |points_paint             |integer   |Points scored in the paint.                                                      |
#'    |opp_points_off_turnovers |integer   |Opponent points off turnovers.                                                   |
#'    |opp_points_second_chance |integer   |Opponent points second chance.                                                   |
#'    |opp_points_fast_break    |integer   |Opponent points fast break.                                                      |
#'    |opp_points_paint         |integer   |Opponent points paint.                                                           |
#'    |blocks                   |integer   |Total blocks.                                                                    |
#'    |blocks_against           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fouls_personal           |integer   |Personal fouls.                                                                  |
#'    |fouls_drawn              |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'
#'    **home_team_totals_misc**
#'
#'
#'    |col_name                 |types     |description                                                                      |
#'    |:------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                  |character |Unique game identifier.                                                          |
#'    |away_team_id             |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id             |integer   |Unique identifier for the home team.                                             |
#'    |team_id                  |integer   |Unique team identifier.                                                          |
#'    |team_name                |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode             |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                  |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points_off_turnovers     |integer   |Points scored off opponent turnovers.                                            |
#'    |points_second_chance     |integer   |Second-chance points scored.                                                     |
#'    |points_fast_break        |integer   |Fast-break points scored.                                                        |
#'    |points_paint             |integer   |Points scored in the paint.                                                      |
#'    |opp_points_off_turnovers |integer   |Opponent points off turnovers.                                                   |
#'    |opp_points_second_chance |integer   |Opponent points second chance.                                                   |
#'    |opp_points_fast_break    |integer   |Opponent points fast break.                                                      |
#'    |opp_points_paint         |integer   |Opponent points paint.                                                           |
#'    |blocks                   |integer   |Total blocks.                                                                    |
#'    |blocks_against           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fouls_personal           |integer   |Personal fouls.                                                                  |
#'    |fouls_drawn              |integer   |Personal fouls drawn (by opponent's actions).                                    |
#'
#'    **away_team_totals_misc**
#'
#'
#'    |col_name                 |types     |description                                                                      |
#'    |:------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                  |character |Unique game identifier.                                                          |
#'    |away_team_id             |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id             |integer   |Unique identifier for the home team.                                             |
#'    |team_id                  |integer   |Unique team identifier.                                                          |
#'    |team_name                |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode             |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                  |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points_off_turnovers     |integer   |Points scored off opponent turnovers.                                            |
#'    |points_second_chance     |integer   |Second-chance points scored.                                                     |
#'    |points_fast_break        |integer   |Fast-break points scored.                                                        |
#'    |points_paint             |integer   |Points scored in the paint.                                                      |
#'    |opp_points_off_turnovers |integer   |Opponent points off turnovers.                                                   |
#'    |opp_points_second_chance |integer   |Opponent points second chance.                                                   |
#'    |opp_points_fast_break    |integer   |Opponent points fast break.                                                      |
#'    |opp_points_paint         |integer   |Opponent points paint.                                                           |
#'    |blocks                   |integer   |Total blocks.                                                                    |
#'    |blocks_against           |integer   |Shots blocked by opponents while attempting.                                     |
#'    |fouls_personal           |integer   |Personal fouls.                                                                  |
#'    |fouls_drawn              |integer   |Personal fouls drawn (by opponent's actions).                                    |
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

#' **Get NBA Stats API Boxscore Scoring V3**
#' @name nba_boxscorescoringv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Scoring V3**
#' @rdname nba_boxscorescoringv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |percentage_field_goals_attempted2pt |numeric   |Percentage field goals attempted2pt.                                             |
#'    |percentage_field_goals_attempted3pt |numeric   |Percentage field goals attempted3pt.                                             |
#'    |percentage_points2pt                |numeric   |Percentage points2pt.                                                            |
#'    |percentage_points_midrange2pt       |numeric   |Percentage points midrange2pt.                                                   |
#'    |percentage_points3pt                |numeric   |Percentage points3pt.                                                            |
#'    |percentage_points_fast_break        |numeric   |Percentage points fast break.                                                    |
#'    |percentage_points_free_throw        |numeric   |Percentage points free throw.                                                    |
#'    |percentage_points_off_turnovers     |numeric   |Percentage points off turnovers.                                                 |
#'    |percentage_points_paint             |numeric   |Percentage points paint.                                                         |
#'    |percentage_assisted2pt              |numeric   |Percentage assisted2pt.                                                          |
#'    |percentage_unassisted2pt            |numeric   |Percentage unassisted2pt.                                                        |
#'    |percentage_assisted3pt              |numeric   |Percentage assisted3pt.                                                          |
#'    |percentage_unassisted3pt            |numeric   |Percentage unassisted3pt.                                                        |
#'    |percentage_assisted_fgm             |numeric   |Percentage assisted fgm.                                                         |
#'    |percentage_unassisted_fgm           |numeric   |Percentage unassisted fgm.                                                       |
#'
#'    **away_team_player_scoring**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |percentage_field_goals_attempted2pt |numeric   |Percentage field goals attempted2pt.                                             |
#'    |percentage_field_goals_attempted3pt |numeric   |Percentage field goals attempted3pt.                                             |
#'    |percentage_points2pt                |numeric   |Percentage points2pt.                                                            |
#'    |percentage_points_midrange2pt       |numeric   |Percentage points midrange2pt.                                                   |
#'    |percentage_points3pt                |numeric   |Percentage points3pt.                                                            |
#'    |percentage_points_fast_break        |numeric   |Percentage points fast break.                                                    |
#'    |percentage_points_free_throw        |numeric   |Percentage points free throw.                                                    |
#'    |percentage_points_off_turnovers     |numeric   |Percentage points off turnovers.                                                 |
#'    |percentage_points_paint             |numeric   |Percentage points paint.                                                         |
#'    |percentage_assisted2pt              |numeric   |Percentage assisted2pt.                                                          |
#'    |percentage_unassisted2pt            |numeric   |Percentage unassisted2pt.                                                        |
#'    |percentage_assisted3pt              |numeric   |Percentage assisted3pt.                                                          |
#'    |percentage_unassisted3pt            |numeric   |Percentage unassisted3pt.                                                        |
#'    |percentage_assisted_fgm             |numeric   |Percentage assisted fgm.                                                         |
#'    |percentage_unassisted_fgm           |numeric   |Percentage unassisted fgm.                                                       |
#'
#'    **home_team_totals_scoring**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |percentage_field_goals_attempted2pt |numeric   |Percentage field goals attempted2pt.                                             |
#'    |percentage_field_goals_attempted3pt |numeric   |Percentage field goals attempted3pt.                                             |
#'    |percentage_points2pt                |numeric   |Percentage points2pt.                                                            |
#'    |percentage_points_midrange2pt       |numeric   |Percentage points midrange2pt.                                                   |
#'    |percentage_points3pt                |numeric   |Percentage points3pt.                                                            |
#'    |percentage_points_fast_break        |numeric   |Percentage points fast break.                                                    |
#'    |percentage_points_free_throw        |numeric   |Percentage points free throw.                                                    |
#'    |percentage_points_off_turnovers     |numeric   |Percentage points off turnovers.                                                 |
#'    |percentage_points_paint             |numeric   |Percentage points paint.                                                         |
#'    |percentage_assisted2pt              |numeric   |Percentage assisted2pt.                                                          |
#'    |percentage_unassisted2pt            |numeric   |Percentage unassisted2pt.                                                        |
#'    |percentage_assisted3pt              |numeric   |Percentage assisted3pt.                                                          |
#'    |percentage_unassisted3pt            |numeric   |Percentage unassisted3pt.                                                        |
#'    |percentage_assisted_fgm             |numeric   |Percentage assisted fgm.                                                         |
#'    |percentage_unassisted_fgm           |numeric   |Percentage unassisted fgm.                                                       |
#'
#'    **away_team_totals_scoring**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |percentage_field_goals_attempted2pt |numeric   |Percentage field goals attempted2pt.                                             |
#'    |percentage_field_goals_attempted3pt |numeric   |Percentage field goals attempted3pt.                                             |
#'    |percentage_points2pt                |numeric   |Percentage points2pt.                                                            |
#'    |percentage_points_midrange2pt       |numeric   |Percentage points midrange2pt.                                                   |
#'    |percentage_points3pt                |numeric   |Percentage points3pt.                                                            |
#'    |percentage_points_fast_break        |numeric   |Percentage points fast break.                                                    |
#'    |percentage_points_free_throw        |numeric   |Percentage points free throw.                                                    |
#'    |percentage_points_off_turnovers     |numeric   |Percentage points off turnovers.                                                 |
#'    |percentage_points_paint             |numeric   |Percentage points paint.                                                         |
#'    |percentage_assisted2pt              |numeric   |Percentage assisted2pt.                                                          |
#'    |percentage_unassisted2pt            |numeric   |Percentage unassisted2pt.                                                        |
#'    |percentage_assisted3pt              |numeric   |Percentage assisted3pt.                                                          |
#'    |percentage_unassisted3pt            |numeric   |Percentage unassisted3pt.                                                        |
#'    |percentage_assisted_fgm             |numeric   |Percentage assisted fgm.                                                         |
#'    |percentage_unassisted_fgm           |numeric   |Percentage unassisted fgm.                                                       |
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

#' **Get NBA Stats API Boxscore Usage V3**
#' @name nba_boxscoreusagev3
NULL
#' @title
#' **Get NBA Stats API Boxscore Usage V3**
#' @rdname nba_boxscoreusagev3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |usage_percentage                    |numeric   |Usage percentage (0-1).                                                          |
#'    |percentage_field_goals_made         |numeric   |Number of percentage field goals made.                                           |
#'    |percentage_field_goals_attempted    |numeric   |Number of percentage field goals attempted.                                      |
#'    |percentage_three_pointers_made      |numeric   |Number of percentage three pointers made.                                        |
#'    |percentage_three_pointers_attempted |numeric   |Number of percentage three pointers attempted.                                   |
#'    |percentage_free_throws_made         |numeric   |Number of percentage free throws made.                                           |
#'    |percentage_free_throws_attempted    |numeric   |Number of percentage free throws attempted.                                      |
#'    |percentage_rebounds_offensive       |numeric   |Percentage rebounds offensive.                                                   |
#'    |percentage_rebounds_defensive       |numeric   |Percentage rebounds defensive.                                                   |
#'    |percentage_rebounds_total           |numeric   |Percentage rebounds total.                                                       |
#'    |percentage_assists                  |numeric   |Percentage assists.                                                              |
#'    |percentage_turnovers                |numeric   |Percentage turnovers.                                                            |
#'    |percentage_steals                   |numeric   |Percentage steals.                                                               |
#'    |percentage_blocks                   |numeric   |Percentage blocks.                                                               |
#'    |percentage_blocks_allowed           |numeric   |Percentage blocks allowed.                                                       |
#'    |percentage_personal_fouls           |numeric   |Percentage personal fouls.                                                       |
#'    |percentage_personal_fouls_drawn     |numeric   |Percentage personal fouls drawn.                                                 |
#'    |percentage_points                   |numeric   |Percentage points.                                                               |
#'
#'    **away_team_player_usage**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |usage_percentage                    |numeric   |Usage percentage (0-1).                                                          |
#'    |percentage_field_goals_made         |numeric   |Number of percentage field goals made.                                           |
#'    |percentage_field_goals_attempted    |numeric   |Number of percentage field goals attempted.                                      |
#'    |percentage_three_pointers_made      |numeric   |Number of percentage three pointers made.                                        |
#'    |percentage_three_pointers_attempted |numeric   |Number of percentage three pointers attempted.                                   |
#'    |percentage_free_throws_made         |numeric   |Number of percentage free throws made.                                           |
#'    |percentage_free_throws_attempted    |numeric   |Number of percentage free throws attempted.                                      |
#'    |percentage_rebounds_offensive       |numeric   |Percentage rebounds offensive.                                                   |
#'    |percentage_rebounds_defensive       |numeric   |Percentage rebounds defensive.                                                   |
#'    |percentage_rebounds_total           |numeric   |Percentage rebounds total.                                                       |
#'    |percentage_assists                  |numeric   |Percentage assists.                                                              |
#'    |percentage_turnovers                |numeric   |Percentage turnovers.                                                            |
#'    |percentage_steals                   |numeric   |Percentage steals.                                                               |
#'    |percentage_blocks                   |numeric   |Percentage blocks.                                                               |
#'    |percentage_blocks_allowed           |numeric   |Percentage blocks allowed.                                                       |
#'    |percentage_personal_fouls           |numeric   |Percentage personal fouls.                                                       |
#'    |percentage_personal_fouls_drawn     |numeric   |Percentage personal fouls drawn.                                                 |
#'    |percentage_points                   |numeric   |Percentage points.                                                               |
#'
#'    **home_team_totals_usage**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |usage_percentage                    |numeric   |Usage percentage (0-1).                                                          |
#'    |percentage_field_goals_made         |numeric   |Number of percentage field goals made.                                           |
#'    |percentage_field_goals_attempted    |numeric   |Number of percentage field goals attempted.                                      |
#'    |percentage_three_pointers_made      |numeric   |Number of percentage three pointers made.                                        |
#'    |percentage_three_pointers_attempted |numeric   |Number of percentage three pointers attempted.                                   |
#'    |percentage_free_throws_made         |numeric   |Number of percentage free throws made.                                           |
#'    |percentage_free_throws_attempted    |numeric   |Number of percentage free throws attempted.                                      |
#'    |percentage_rebounds_offensive       |numeric   |Percentage rebounds offensive.                                                   |
#'    |percentage_rebounds_defensive       |numeric   |Percentage rebounds defensive.                                                   |
#'    |percentage_rebounds_total           |numeric   |Percentage rebounds total.                                                       |
#'    |percentage_assists                  |numeric   |Percentage assists.                                                              |
#'    |percentage_turnovers                |numeric   |Percentage turnovers.                                                            |
#'    |percentage_steals                   |numeric   |Percentage steals.                                                               |
#'    |percentage_blocks                   |numeric   |Percentage blocks.                                                               |
#'    |percentage_blocks_allowed           |numeric   |Percentage blocks allowed.                                                       |
#'    |percentage_personal_fouls           |numeric   |Percentage personal fouls.                                                       |
#'    |percentage_personal_fouls_drawn     |numeric   |Percentage personal fouls drawn.                                                 |
#'    |percentage_points                   |numeric   |Percentage points.                                                               |
#'
#'    **away_team_totals_usage**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |usage_percentage                    |numeric   |Usage percentage (0-1).                                                          |
#'    |percentage_field_goals_made         |numeric   |Number of percentage field goals made.                                           |
#'    |percentage_field_goals_attempted    |numeric   |Number of percentage field goals attempted.                                      |
#'    |percentage_three_pointers_made      |numeric   |Number of percentage three pointers made.                                        |
#'    |percentage_three_pointers_attempted |numeric   |Number of percentage three pointers attempted.                                   |
#'    |percentage_free_throws_made         |numeric   |Number of percentage free throws made.                                           |
#'    |percentage_free_throws_attempted    |numeric   |Number of percentage free throws attempted.                                      |
#'    |percentage_rebounds_offensive       |numeric   |Percentage rebounds offensive.                                                   |
#'    |percentage_rebounds_defensive       |numeric   |Percentage rebounds defensive.                                                   |
#'    |percentage_rebounds_total           |numeric   |Percentage rebounds total.                                                       |
#'    |percentage_assists                  |numeric   |Percentage assists.                                                              |
#'    |percentage_turnovers                |numeric   |Percentage turnovers.                                                            |
#'    |percentage_steals                   |numeric   |Percentage steals.                                                               |
#'    |percentage_blocks                   |numeric   |Percentage blocks.                                                               |
#'    |percentage_blocks_allowed           |numeric   |Percentage blocks allowed.                                                       |
#'    |percentage_personal_fouls           |numeric   |Percentage personal fouls.                                                       |
#'    |percentage_personal_fouls_drawn     |numeric   |Percentage personal fouls drawn.                                                 |
#'    |percentage_points                   |numeric   |Percentage points.                                                               |
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

#' **Get NBA Stats API Boxscore Four Factors V3**
#' @name nba_boxscorefourfactorsv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Four Factors V3**
#' @rdname nba_boxscorefourfactorsv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |effective_field_goal_percentage     |numeric   |Effective field goal percentage (0-1).                                           |
#'    |free_throw_attempt_rate             |numeric   |Free throw attempt rate (FTA / FGA).                                             |
#'    |team_turnover_percentage            |numeric   |Team turnover percentage (0-1).                                                  |
#'    |offensive_rebound_percentage        |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |opp_effective_field_goal_percentage |numeric   |Opponent effective field goal percentage (0-1 decimal).                          |
#'    |opp_free_throw_attempt_rate         |numeric   |Opponent free throw attempt rate.                                                |
#'    |opp_team_turnover_percentage        |numeric   |Opponent team turnover percentage (0-1 decimal).                                 |
#'    |opp_offensive_rebound_percentage    |numeric   |Opponent offensive rebound percentage (0-1 decimal).                             |
#'
#'    **away_team_player_four_factors**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                           |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                          |character |Player's first name.                                                             |
#'    |family_name                         |character |Player's family / last name.                                                     |
#'    |name_i                              |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                         |character |URL-safe player identifier.                                                      |
#'    |position                            |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                             |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                          |character |Jersey number worn by the player.                                                |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |effective_field_goal_percentage     |numeric   |Effective field goal percentage (0-1).                                           |
#'    |free_throw_attempt_rate             |numeric   |Free throw attempt rate (FTA / FGA).                                             |
#'    |team_turnover_percentage            |numeric   |Team turnover percentage (0-1).                                                  |
#'    |offensive_rebound_percentage        |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |opp_effective_field_goal_percentage |numeric   |Opponent effective field goal percentage (0-1 decimal).                          |
#'    |opp_free_throw_attempt_rate         |numeric   |Opponent free throw attempt rate.                                                |
#'    |opp_team_turnover_percentage        |numeric   |Opponent team turnover percentage (0-1 decimal).                                 |
#'    |opp_offensive_rebound_percentage    |numeric   |Opponent offensive rebound percentage (0-1 decimal).                             |
#'
#'    **home_team_totals_four_factors**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |effective_field_goal_percentage     |numeric   |Effective field goal percentage (0-1).                                           |
#'    |free_throw_attempt_rate             |numeric   |Free throw attempt rate (FTA / FGA).                                             |
#'    |team_turnover_percentage            |numeric   |Team turnover percentage (0-1).                                                  |
#'    |offensive_rebound_percentage        |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |opp_effective_field_goal_percentage |numeric   |Opponent effective field goal percentage (0-1 decimal).                          |
#'    |opp_free_throw_attempt_rate         |numeric   |Opponent free throw attempt rate.                                                |
#'    |opp_team_turnover_percentage        |numeric   |Opponent team turnover percentage (0-1 decimal).                                 |
#'    |opp_offensive_rebound_percentage    |numeric   |Opponent offensive rebound percentage (0-1 decimal).                             |
#'
#'    **away_team_totals_four_factors**
#'
#'
#'    |col_name                            |types     |description                                                                      |
#'    |:-----------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                             |character |Unique game identifier.                                                          |
#'    |away_team_id                        |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                        |integer   |Unique identifier for the home team.                                             |
#'    |team_id                             |integer   |Unique team identifier.                                                          |
#'    |team_name                           |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                           |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                        |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                           |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                             |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |effective_field_goal_percentage     |numeric   |Effective field goal percentage (0-1).                                           |
#'    |free_throw_attempt_rate             |numeric   |Free throw attempt rate (FTA / FGA).                                             |
#'    |team_turnover_percentage            |numeric   |Team turnover percentage (0-1).                                                  |
#'    |offensive_rebound_percentage        |numeric   |Offensive rebound percentage (0-1).                                              |
#'    |opp_effective_field_goal_percentage |numeric   |Opponent effective field goal percentage (0-1 decimal).                          |
#'    |opp_free_throw_attempt_rate         |numeric   |Opponent free throw attempt rate.                                                |
#'    |opp_team_turnover_percentage        |numeric   |Opponent team turnover percentage (0-1 decimal).                                 |
#'    |opp_offensive_rebound_percentage    |numeric   |Opponent offensive rebound percentage (0-1 decimal).                             |
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

#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @name nba_boxscoreplayertrackv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @rdname nba_boxscoreplayertrackv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                              |types     |description                                                                      |
#'    |:-------------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                               |character |Unique game identifier.                                                          |
#'    |away_team_id                          |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                          |integer   |Unique identifier for the home team.                                             |
#'    |team_id                               |integer   |Unique team identifier.                                                          |
#'    |team_name                             |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                             |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                          |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                             |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                             |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                            |character |Player's first name.                                                             |
#'    |family_name                           |character |Player's family / last name.                                                     |
#'    |name_i                                |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                           |character |URL-safe player identifier.                                                      |
#'    |position                              |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                               |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                            |character |Jersey number worn by the player.                                                |
#'    |minutes                               |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |speed                                 |numeric   |Speed.                                                                           |
#'    |distance                              |numeric   |Distance value (in feet for shot data; otherwise context-dependent).             |
#'    |rebound_chances_offensive             |integer   |Rebound chances offensive.                                                       |
#'    |rebound_chances_defensive             |integer   |Rebound chances defensive.                                                       |
#'    |rebound_chances_total                 |integer   |Rebound chances total.                                                           |
#'    |touches                               |integer   |Touches.                                                                         |
#'    |secondary_assists                     |integer   |Secondary assists.                                                               |
#'    |free_throw_assists                    |integer   |Free throw assists (passes that led to a fouled shot attempt).                   |
#'    |passes                                |integer   |Passes.                                                                          |
#'    |assists                               |integer   |Total assists.                                                                   |
#'    |contested_field_goals_made            |integer   |Contested field goals made.                                                      |
#'    |contested_field_goals_attempted       |integer   |Contested field goal attempts.                                                   |
#'    |contested_field_goal_percentage       |numeric   |Contested field goal percentage (0-1).                                           |
#'    |uncontested_field_goals_made          |integer   |Number of uncontested field goals made.                                          |
#'    |uncontested_field_goals_attempted     |integer   |Number of uncontested field goals attempted.                                     |
#'    |uncontested_field_goals_percentage    |numeric   |Uncontested field goals percentage (0-1 decimal).                                |
#'    |field_goal_percentage                 |numeric   |Field Goal Percentage.                                                           |
#'    |defended_at_rim_field_goals_made      |integer   |Field goals made allowed when defending at the rim.                              |
#'    |defended_at_rim_field_goals_attempted |integer   |Field goal attempts allowed when defending at the rim.                           |
#'    |defended_at_rim_field_goal_percentage |numeric   |Field goal percentage allowed at the rim (0-1).                                  |
#'
#'    **away_team_player_player_track**
#'
#'
#'    |col_name                              |types     |description                                                                      |
#'    |:-------------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                               |character |Unique game identifier.                                                          |
#'    |away_team_id                          |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                          |integer   |Unique identifier for the home team.                                             |
#'    |team_id                               |integer   |Unique team identifier.                                                          |
#'    |team_name                             |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                             |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                          |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                             |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                             |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                            |character |Player's first name.                                                             |
#'    |family_name                           |character |Player's family / last name.                                                     |
#'    |name_i                                |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                           |character |URL-safe player identifier.                                                      |
#'    |position                              |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                               |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                            |character |Jersey number worn by the player.                                                |
#'    |minutes                               |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |speed                                 |numeric   |Speed.                                                                           |
#'    |distance                              |numeric   |Distance value (in feet for shot data; otherwise context-dependent).             |
#'    |rebound_chances_offensive             |integer   |Rebound chances offensive.                                                       |
#'    |rebound_chances_defensive             |integer   |Rebound chances defensive.                                                       |
#'    |rebound_chances_total                 |integer   |Rebound chances total.                                                           |
#'    |touches                               |integer   |Touches.                                                                         |
#'    |secondary_assists                     |integer   |Secondary assists.                                                               |
#'    |free_throw_assists                    |integer   |Free throw assists (passes that led to a fouled shot attempt).                   |
#'    |passes                                |integer   |Passes.                                                                          |
#'    |assists                               |integer   |Total assists.                                                                   |
#'    |contested_field_goals_made            |integer   |Contested field goals made.                                                      |
#'    |contested_field_goals_attempted       |integer   |Contested field goal attempts.                                                   |
#'    |contested_field_goal_percentage       |numeric   |Contested field goal percentage (0-1).                                           |
#'    |uncontested_field_goals_made          |integer   |Number of uncontested field goals made.                                          |
#'    |uncontested_field_goals_attempted     |integer   |Number of uncontested field goals attempted.                                     |
#'    |uncontested_field_goals_percentage    |numeric   |Uncontested field goals percentage (0-1 decimal).                                |
#'    |field_goal_percentage                 |numeric   |Field Goal Percentage.                                                           |
#'    |defended_at_rim_field_goals_made      |integer   |Field goals made allowed when defending at the rim.                              |
#'    |defended_at_rim_field_goals_attempted |integer   |Field goal attempts allowed when defending at the rim.                           |
#'    |defended_at_rim_field_goal_percentage |numeric   |Field goal percentage allowed at the rim (0-1).                                  |
#'
#'    **home_team_totals_player_track**
#'
#'
#'    |col_name                              |types     |description                                                                      |
#'    |:-------------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                               |character |Unique game identifier.                                                          |
#'    |away_team_id                          |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                          |integer   |Unique identifier for the home team.                                             |
#'    |team_id                               |integer   |Unique team identifier.                                                          |
#'    |team_name                             |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                             |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                          |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                             |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                               |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |distance                              |numeric   |Distance value (in feet for shot data; otherwise context-dependent).             |
#'    |rebound_chances_offensive             |integer   |Rebound chances offensive.                                                       |
#'    |rebound_chances_defensive             |integer   |Rebound chances defensive.                                                       |
#'    |rebound_chances_total                 |integer   |Rebound chances total.                                                           |
#'    |touches                               |integer   |Touches.                                                                         |
#'    |secondary_assists                     |integer   |Secondary assists.                                                               |
#'    |free_throw_assists                    |integer   |Free throw assists (passes that led to a fouled shot attempt).                   |
#'    |passes                                |integer   |Passes.                                                                          |
#'    |assists                               |integer   |Total assists.                                                                   |
#'    |contested_field_goals_made            |integer   |Contested field goals made.                                                      |
#'    |contested_field_goals_attempted       |integer   |Contested field goal attempts.                                                   |
#'    |contested_field_goal_percentage       |numeric   |Contested field goal percentage (0-1).                                           |
#'    |uncontested_field_goals_made          |integer   |Number of uncontested field goals made.                                          |
#'    |uncontested_field_goals_attempted     |integer   |Number of uncontested field goals attempted.                                     |
#'    |uncontested_field_goals_percentage    |numeric   |Uncontested field goals percentage (0-1 decimal).                                |
#'    |field_goal_percentage                 |numeric   |Field Goal Percentage.                                                           |
#'    |defended_at_rim_field_goals_made      |integer   |Field goals made allowed when defending at the rim.                              |
#'    |defended_at_rim_field_goals_attempted |integer   |Field goal attempts allowed when defending at the rim.                           |
#'    |defended_at_rim_field_goal_percentage |numeric   |Field goal percentage allowed at the rim (0-1).                                  |
#'
#'    **away_team_totals_player_track**
#'
#'
#'    |col_name                              |types     |description                                                                      |
#'    |:-------------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                               |character |Unique game identifier.                                                          |
#'    |away_team_id                          |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                          |integer   |Unique identifier for the home team.                                             |
#'    |team_id                               |integer   |Unique team identifier.                                                          |
#'    |team_name                             |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                             |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                          |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                             |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                               |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |distance                              |numeric   |Distance value (in feet for shot data; otherwise context-dependent).             |
#'    |rebound_chances_offensive             |integer   |Rebound chances offensive.                                                       |
#'    |rebound_chances_defensive             |integer   |Rebound chances defensive.                                                       |
#'    |rebound_chances_total                 |integer   |Rebound chances total.                                                           |
#'    |touches                               |integer   |Touches.                                                                         |
#'    |secondary_assists                     |integer   |Secondary assists.                                                               |
#'    |free_throw_assists                    |integer   |Free throw assists (passes that led to a fouled shot attempt).                   |
#'    |passes                                |integer   |Passes.                                                                          |
#'    |assists                               |integer   |Total assists.                                                                   |
#'    |contested_field_goals_made            |integer   |Contested field goals made.                                                      |
#'    |contested_field_goals_attempted       |integer   |Contested field goal attempts.                                                   |
#'    |contested_field_goal_percentage       |numeric   |Contested field goal percentage (0-1).                                           |
#'    |uncontested_field_goals_made          |integer   |Number of uncontested field goals made.                                          |
#'    |uncontested_field_goals_attempted     |integer   |Number of uncontested field goals attempted.                                     |
#'    |uncontested_field_goals_percentage    |numeric   |Uncontested field goals percentage (0-1 decimal).                                |
#'    |field_goal_percentage                 |numeric   |Field Goal Percentage.                                                           |
#'    |defended_at_rim_field_goals_made      |integer   |Field goals made allowed when defending at the rim.                              |
#'    |defended_at_rim_field_goals_attempted |integer   |Field goal attempts allowed when defending at the rim.                           |
#'    |defended_at_rim_field_goal_percentage |numeric   |Field goal percentage allowed at the rim (0-1).                                  |
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

#' **Get NBA Stats API Boxscore Matchups V3**
#' @name nba_boxscorematchupsv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Matchups V3**
#' @rdname nba_boxscorematchupsv3
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                          |types     |description                                                                  |
#'    |:---------------------------------|:---------|:----------------------------------------------------------------------------|
#'    |game_id                           |character |Unique game identifier.                                                      |
#'    |away_team_id                      |integer   |Unique identifier for the away team.                                         |
#'    |home_team_id                      |integer   |Unique identifier for the home team.                                         |
#'    |team_id                           |integer   |Unique team identifier.                                                      |
#'    |team_name                         |character |Full team display name (e.g. 'Las Vegas Aces').                              |
#'    |team_city                         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |team_tricode                      |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                 |
#'    |team_slug                         |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                    |
#'    |person_id                         |integer   |Unique player identifier (V3 endpoints).                                     |
#'    |first_name                        |character |Player's first name.                                                         |
#'    |family_name                       |character |Player's family / last name.                                                 |
#'    |name_i                            |character |Initialed name (e.g. 'A. Wilson').                                           |
#'    |player_slug                       |character |URL-safe player identifier.                                                  |
#'    |position                          |character |Listed roster position (G, F, C, etc.).                                      |
#'    |comment                           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |jersey_num                        |character |Jersey number worn by the player.                                            |
#'    |matchups_person_id                |integer   |Unique identifier for matchups person.                                       |
#'    |matchups_first_name               |character |Matchups first name.                                                         |
#'    |matchups_family_name              |character |Matchups family name.                                                        |
#'    |matchups_name_i                   |character |Matchups name i.                                                             |
#'    |matchups_player_slug              |character |Matchups player slug.                                                        |
#'    |matchups_jersey_num               |character |Matchups jersey num.                                                         |
#'    |matchup_minutes                   |character |Matchup minutes.                                                             |
#'    |matchup_minutes_sort              |numeric   |Matchup minutes sort.                                                        |
#'    |partial_possessions               |numeric   |Partial possessions.                                                         |
#'    |percentage_defender_total_time    |numeric   |Time / clock value.                                                          |
#'    |percentage_offensive_total_time   |numeric   |Time / clock value.                                                          |
#'    |percentage_total_time_both_on     |numeric   |Percentage total time both on.                                               |
#'    |switches_on                       |integer   |Switches on.                                                                 |
#'    |player_points                     |integer   |Player points.                                                               |
#'    |team_points                       |integer   |Team points.                                                                 |
#'    |matchup_assists                   |integer   |Matchup assists.                                                             |
#'    |matchup_potential_assists         |integer   |Matchup potential assists.                                                   |
#'    |matchup_turnovers                 |integer   |Matchup turnovers.                                                           |
#'    |matchup_blocks                    |integer   |Matchup blocks.                                                              |
#'    |matchup_field_goals_made          |integer   |Number of matchup field goals made.                                          |
#'    |matchup_field_goals_attempted     |integer   |Number of matchup field goals attempted.                                     |
#'    |matchup_field_goals_percentage    |numeric   |Matchup field goals percentage (0-1 decimal).                                |
#'    |matchup_three_pointers_made       |integer   |Number of matchup three pointers made.                                       |
#'    |matchup_three_pointers_attempted  |integer   |Number of matchup three pointers attempted.                                  |
#'    |matchup_three_pointers_percentage |numeric   |Matchup three pointers percentage (0-1 decimal).                             |
#'    |help_blocks                       |integer   |Help blocks.                                                                 |
#'    |help_field_goals_made             |integer   |Number of help field goals made.                                             |
#'    |help_field_goals_attempted        |integer   |Number of help field goals attempted.                                        |
#'    |help_field_goals_percentage       |numeric   |Help field goals percentage (0-1 decimal).                                   |
#'    |matchup_free_throws_made          |integer   |Number of matchup free throws made.                                          |
#'    |matchup_free_throws_attempted     |integer   |Number of matchup free throws attempted.                                     |
#'    |shooting_fouls                    |integer   |Shooting fouls.                                                              |
#'
#'    **away_team_player_matchups**
#'
#'
#'    |col_name                          |types     |description                                                                  |
#'    |:---------------------------------|:---------|:----------------------------------------------------------------------------|
#'    |game_id                           |character |Unique game identifier.                                                      |
#'    |away_team_id                      |integer   |Unique identifier for the away team.                                         |
#'    |home_team_id                      |integer   |Unique identifier for the home team.                                         |
#'    |team_id                           |integer   |Unique team identifier.                                                      |
#'    |team_name                         |character |Full team display name (e.g. 'Las Vegas Aces').                              |
#'    |team_city                         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |team_tricode                      |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                 |
#'    |team_slug                         |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                    |
#'    |person_id                         |integer   |Unique player identifier (V3 endpoints).                                     |
#'    |first_name                        |character |Player's first name.                                                         |
#'    |family_name                       |character |Player's family / last name.                                                 |
#'    |name_i                            |character |Initialed name (e.g. 'A. Wilson').                                           |
#'    |player_slug                       |character |URL-safe player identifier.                                                  |
#'    |position                          |character |Listed roster position (G, F, C, etc.).                                      |
#'    |comment                           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |jersey_num                        |character |Jersey number worn by the player.                                            |
#'    |matchups_person_id                |integer   |Unique identifier for matchups person.                                       |
#'    |matchups_first_name               |character |Matchups first name.                                                         |
#'    |matchups_family_name              |character |Matchups family name.                                                        |
#'    |matchups_name_i                   |character |Matchups name i.                                                             |
#'    |matchups_player_slug              |character |Matchups player slug.                                                        |
#'    |matchups_jersey_num               |character |Matchups jersey num.                                                         |
#'    |matchup_minutes                   |character |Matchup minutes.                                                             |
#'    |matchup_minutes_sort              |numeric   |Matchup minutes sort.                                                        |
#'    |partial_possessions               |numeric   |Partial possessions.                                                         |
#'    |percentage_defender_total_time    |numeric   |Time / clock value.                                                          |
#'    |percentage_offensive_total_time   |numeric   |Time / clock value.                                                          |
#'    |percentage_total_time_both_on     |numeric   |Percentage total time both on.                                               |
#'    |switches_on                       |integer   |Switches on.                                                                 |
#'    |player_points                     |integer   |Player points.                                                               |
#'    |team_points                       |integer   |Team points.                                                                 |
#'    |matchup_assists                   |integer   |Matchup assists.                                                             |
#'    |matchup_potential_assists         |integer   |Matchup potential assists.                                                   |
#'    |matchup_turnovers                 |integer   |Matchup turnovers.                                                           |
#'    |matchup_blocks                    |integer   |Matchup blocks.                                                              |
#'    |matchup_field_goals_made          |integer   |Number of matchup field goals made.                                          |
#'    |matchup_field_goals_attempted     |integer   |Number of matchup field goals attempted.                                     |
#'    |matchup_field_goals_percentage    |numeric   |Matchup field goals percentage (0-1 decimal).                                |
#'    |matchup_three_pointers_made       |integer   |Number of matchup three pointers made.                                       |
#'    |matchup_three_pointers_attempted  |integer   |Number of matchup three pointers attempted.                                  |
#'    |matchup_three_pointers_percentage |numeric   |Matchup three pointers percentage (0-1 decimal).                             |
#'    |help_blocks                       |integer   |Help blocks.                                                                 |
#'    |help_field_goals_made             |integer   |Number of help field goals made.                                             |
#'    |help_field_goals_attempted        |integer   |Number of help field goals attempted.                                        |
#'    |help_field_goals_percentage       |numeric   |Help field goals percentage (0-1 decimal).                                   |
#'    |matchup_free_throws_made          |integer   |Number of matchup free throws made.                                          |
#'    |matchup_free_throws_attempted     |integer   |Number of matchup free throws attempted.                                     |
#'    |shooting_fouls                    |integer   |Shooting fouls.                                                              |
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
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                       |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                      |character |Player's first name.                                                             |
#'    |family_name                     |character |Player's family / last name.                                                     |
#'    |name_i                          |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                     |character |URL-safe player identifier.                                                      |
#'    |position                        |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                         |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                      |character |Jersey number worn by the player.                                                |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |contested_shots                 |integer   |Defensively contested shots.                                                     |
#'    |contested_shots2pt              |integer   |Contested shots2pt.                                                              |
#'    |contested_shots3pt              |integer   |Contested shots3pt.                                                              |
#'    |deflections                     |integer   |Defensive deflections.                                                           |
#'    |charges_drawn                   |integer   |Charges drawn.                                                                   |
#'    |screen_assists                  |integer   |Screen assists (resulting in a basket).                                          |
#'    |screen_assist_points            |integer   |Points generated from screen assists.                                            |
#'    |loose_balls_recovered_offensive |integer   |Loose balls recovered on offense.                                                |
#'    |loose_balls_recovered_defensive |integer   |Loose balls recovered on defense.                                                |
#'    |loose_balls_recovered_total     |integer   |Loose balls recovered total.                                                     |
#'    |offensive_box_outs              |integer   |Offensive box outs.                                                              |
#'    |defensive_box_outs              |integer   |Defensive box outs.                                                              |
#'    |box_out_player_team_rebounds    |integer   |Box-outs that led to either a player or team rebound.                            |
#'    |box_out_player_rebounds         |integer   |Box-outs that led to a player rebound.                                           |
#'    |box_outs                        |integer   |Box-outs executed.                                                               |
#'
#'    **away_team_player_hustle**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |person_id                       |integer   |Unique player identifier (V3 endpoints).                                         |
#'    |first_name                      |character |Player's first name.                                                             |
#'    |family_name                     |character |Player's family / last name.                                                     |
#'    |name_i                          |character |Initialed name (e.g. 'A. Wilson').                                               |
#'    |player_slug                     |character |URL-safe player identifier.                                                      |
#'    |position                        |character |Listed roster position (G, F, C, etc.).                                          |
#'    |comment                         |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |jersey_num                      |character |Jersey number worn by the player.                                                |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |contested_shots                 |integer   |Defensively contested shots.                                                     |
#'    |contested_shots2pt              |integer   |Contested shots2pt.                                                              |
#'    |contested_shots3pt              |integer   |Contested shots3pt.                                                              |
#'    |deflections                     |integer   |Defensive deflections.                                                           |
#'    |charges_drawn                   |integer   |Charges drawn.                                                                   |
#'    |screen_assists                  |integer   |Screen assists (resulting in a basket).                                          |
#'    |screen_assist_points            |integer   |Points generated from screen assists.                                            |
#'    |loose_balls_recovered_offensive |integer   |Loose balls recovered on offense.                                                |
#'    |loose_balls_recovered_defensive |integer   |Loose balls recovered on defense.                                                |
#'    |loose_balls_recovered_total     |integer   |Loose balls recovered total.                                                     |
#'    |offensive_box_outs              |integer   |Offensive box outs.                                                              |
#'    |defensive_box_outs              |integer   |Defensive box outs.                                                              |
#'    |box_out_player_team_rebounds    |integer   |Box-outs that led to either a player or team rebound.                            |
#'    |box_out_player_rebounds         |integer   |Box-outs that led to a player rebound.                                           |
#'    |box_outs                        |integer   |Box-outs executed.                                                               |
#'
#'    **home_team_totals_hustle**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |contested_shots                 |integer   |Defensively contested shots.                                                     |
#'    |contested_shots2pt              |integer   |Contested shots2pt.                                                              |
#'    |contested_shots3pt              |integer   |Contested shots3pt.                                                              |
#'    |deflections                     |integer   |Defensive deflections.                                                           |
#'    |charges_drawn                   |integer   |Charges drawn.                                                                   |
#'    |screen_assists                  |integer   |Screen assists (resulting in a basket).                                          |
#'    |screen_assist_points            |integer   |Points generated from screen assists.                                            |
#'    |loose_balls_recovered_offensive |integer   |Loose balls recovered on offense.                                                |
#'    |loose_balls_recovered_defensive |integer   |Loose balls recovered on defense.                                                |
#'    |loose_balls_recovered_total     |integer   |Loose balls recovered total.                                                     |
#'    |offensive_box_outs              |integer   |Offensive box outs.                                                              |
#'    |defensive_box_outs              |integer   |Defensive box outs.                                                              |
#'    |box_out_player_team_rebounds    |integer   |Box-outs that led to either a player or team rebound.                            |
#'    |box_out_player_rebounds         |integer   |Box-outs that led to a player rebound.                                           |
#'    |box_outs                        |integer   |Box-outs executed.                                                               |
#'
#'    **away_team_totals_hustle**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |game_id                         |character |Unique game identifier.                                                          |
#'    |away_team_id                    |integer   |Unique identifier for the away team.                                             |
#'    |home_team_id                    |integer   |Unique identifier for the home team.                                             |
#'    |team_id                         |integer   |Unique team identifier.                                                          |
#'    |team_name                       |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |team_city                       |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |team_tricode                    |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                     |
#'    |team_slug                       |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                        |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |points                          |integer   |Points scored.                                                                   |
#'    |contested_shots                 |integer   |Defensively contested shots.                                                     |
#'    |contested_shots2pt              |integer   |Contested shots2pt.                                                              |
#'    |contested_shots3pt              |integer   |Contested shots3pt.                                                              |
#'    |deflections                     |integer   |Defensive deflections.                                                           |
#'    |charges_drawn                   |integer   |Charges drawn.                                                                   |
#'    |screen_assists                  |integer   |Screen assists (resulting in a basket).                                          |
#'    |screen_assist_points            |integer   |Points generated from screen assists.                                            |
#'    |loose_balls_recovered_offensive |integer   |Loose balls recovered on offense.                                                |
#'    |loose_balls_recovered_defensive |integer   |Loose balls recovered on defense.                                                |
#'    |loose_balls_recovered_total     |integer   |Loose balls recovered total.                                                     |
#'    |offensive_box_outs              |integer   |Offensive box outs.                                                              |
#'    |defensive_box_outs              |integer   |Defensive box outs.                                                              |
#'    |box_out_player_team_rebounds    |integer   |Box-outs that led to either a player or team rebound.                            |
#'    |box_out_player_rebounds         |integer   |Box-outs that led to a player rebound.                                           |
#'    |box_outs                        |integer   |Box-outs executed.                                                               |
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

#' **Get NBA Stats API Boxscore Defensive V2**
#' @name nba_boxscoredefensivev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive V2**
#' @rdname nba_boxscoredefensivev2
#' @author Saiem Gilani
#' @param game_id Game ID
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
#'    |col_name                         |types     |description                                                                  |
#'    |:--------------------------------|:---------|:----------------------------------------------------------------------------|
#'    |game_id                          |character |Unique game identifier.                                                      |
#'    |away_team_id                     |integer   |Unique identifier for the away team.                                         |
#'    |home_team_id                     |integer   |Unique identifier for the home team.                                         |
#'    |team_id                          |integer   |Unique team identifier.                                                      |
#'    |team_name                        |character |Full team display name (e.g. 'Las Vegas Aces').                              |
#'    |team_city                        |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |team_tricode                     |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                 |
#'    |team_slug                        |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                    |
#'    |person_id                        |integer   |Unique player identifier (V3 endpoints).                                     |
#'    |first_name                       |character |Player's first name.                                                         |
#'    |family_name                      |character |Player's family / last name.                                                 |
#'    |name_i                           |character |Initialed name (e.g. 'A. Wilson').                                           |
#'    |player_slug                      |character |URL-safe player identifier.                                                  |
#'    |position                         |character |Listed roster position (G, F, C, etc.).                                      |
#'    |comment                          |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |jersey_num                       |character |Jersey number worn by the player.                                            |
#'    |matchup_minutes                  |character |Matchup minutes.                                                             |
#'    |partial_possessions              |numeric   |Partial possessions.                                                         |
#'    |switches_on                      |integer   |Switches on.                                                                 |
#'    |player_points                    |integer   |Player points.                                                               |
#'    |defensive_rebounds               |integer   |Defensive rebounds.                                                          |
#'    |matchup_assists                  |integer   |Matchup assists.                                                             |
#'    |matchup_turnovers                |integer   |Matchup turnovers.                                                           |
#'    |steals                           |integer   |Total steals.                                                                |
#'    |blocks                           |integer   |Total blocks.                                                                |
#'    |matchup_field_goals_made         |integer   |Number of matchup field goals made.                                          |
#'    |matchup_field_goals_attempted    |integer   |Number of matchup field goals attempted.                                     |
#'    |matchup_field_goal_percentage    |numeric   |Matchup field goal percentage (0-1 decimal).                                 |
#'    |matchup_three_pointers_made      |integer   |Number of matchup three pointers made.                                       |
#'    |matchup_three_pointers_attempted |integer   |Number of matchup three pointers attempted.                                  |
#'    |matchup_three_pointer_percentage |numeric   |Matchup three pointer percentage (0-1 decimal).                              |
#'
#'    **away_team_player_defensive**
#'
#'
#'    |col_name                         |types     |description                                                                  |
#'    |:--------------------------------|:---------|:----------------------------------------------------------------------------|
#'    |game_id                          |character |Unique game identifier.                                                      |
#'    |away_team_id                     |integer   |Unique identifier for the away team.                                         |
#'    |home_team_id                     |integer   |Unique identifier for the home team.                                         |
#'    |team_id                          |integer   |Unique team identifier.                                                      |
#'    |team_name                        |character |Full team display name (e.g. 'Las Vegas Aces').                              |
#'    |team_city                        |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |team_tricode                     |character |Three-letter team code (e.g. 'LAS' / 'NYL').                                 |
#'    |team_slug                        |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces').                    |
#'    |person_id                        |integer   |Unique player identifier (V3 endpoints).                                     |
#'    |first_name                       |character |Player's first name.                                                         |
#'    |family_name                      |character |Player's family / last name.                                                 |
#'    |name_i                           |character |Initialed name (e.g. 'A. Wilson').                                           |
#'    |player_slug                      |character |URL-safe player identifier.                                                  |
#'    |position                         |character |Listed roster position (G, F, C, etc.).                                      |
#'    |comment                          |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |jersey_num                       |character |Jersey number worn by the player.                                            |
#'    |matchup_minutes                  |character |Matchup minutes.                                                             |
#'    |partial_possessions              |numeric   |Partial possessions.                                                         |
#'    |switches_on                      |integer   |Switches on.                                                                 |
#'    |player_points                    |integer   |Player points.                                                               |
#'    |defensive_rebounds               |integer   |Defensive rebounds.                                                          |
#'    |matchup_assists                  |integer   |Matchup assists.                                                             |
#'    |matchup_turnovers                |integer   |Matchup turnovers.                                                           |
#'    |steals                           |integer   |Total steals.                                                                |
#'    |blocks                           |integer   |Total blocks.                                                                |
#'    |matchup_field_goals_made         |integer   |Number of matchup field goals made.                                          |
#'    |matchup_field_goals_attempted    |integer   |Number of matchup field goals attempted.                                     |
#'    |matchup_field_goal_percentage    |numeric   |Matchup field goal percentage (0-1 decimal).                                 |
#'    |matchup_three_pointers_made      |integer   |Number of matchup three pointers made.                                       |
#'    |matchup_three_pointers_attempted |integer   |Number of matchup three pointers attempted.                                  |
#'    |matchup_three_pointer_percentage |numeric   |Matchup three pointer percentage (0-1 decimal).                              |
#'
#'    **home_team_totals_defensive**
#'
#'
#'    |col_name     |types     |description                                               |
#'    |:------------|:---------|:---------------------------------------------------------|
#'    |game_id      |character |Unique game identifier.                                   |
#'    |away_team_id |integer   |Unique identifier for the away team.                      |
#'    |home_team_id |integer   |Unique identifier for the home team.                      |
#'    |team_id      |integer   |Unique team identifier.                                   |
#'    |team_name    |character |Full team display name (e.g. 'Las Vegas Aces').           |
#'    |team_city    |character |Team city or region (e.g. 'Las Vegas').                   |
#'    |team_tricode |character |Three-letter team code (e.g. 'LAS' / 'NYL').              |
#'    |team_slug    |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
#'
#'    **away_team_totals_defensive**
#'
#'
#'    |col_name     |types     |description                                               |
#'    |:------------|:---------|:---------------------------------------------------------|
#'    |game_id      |character |Unique game identifier.                                   |
#'    |away_team_id |integer   |Unique identifier for the away team.                      |
#'    |home_team_id |integer   |Unique identifier for the home team.                      |
#'    |team_id      |integer   |Unique team identifier.                                   |
#'    |team_name    |character |Full team display name (e.g. 'Las Vegas Aces').           |
#'    |team_city    |character |Team city or region (e.g. 'Las Vegas').                   |
#'    |team_tricode |character |Three-letter team code (e.g. 'LAS' / 'NYL').              |
#'    |team_slug    |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
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
#'    |col_name      |types     |description                                     |
#'    |:-------------|:---------|:-----------------------------------------------|
#'    |GAME_ID       |character |Unique game identifier.                         |
#'    |TEAM_ID       |character |Unique team identifier.                         |
#'    |TEAM_CITY     |character |Team city or region (e.g. 'Las Vegas').         |
#'    |TEAM_NAME     |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |PERSON_ID     |character |Unique player identifier (V3 endpoints).        |
#'    |PLAYER_FIRST  |character |                                                |
#'    |PLAYER_LAST   |character |                                                |
#'    |IN_TIME_REAL  |character |                                                |
#'    |OUT_TIME_REAL |character |                                                |
#'    |PLAYER_PTS    |character |                                                |
#'    |PT_DIFF       |character |                                                |
#'    |USG_PCT       |character |Usage percentage (0-1).                         |
#'
#'    **HomeTeam**
#'
#'
#'    |col_name      |types     |description                                     |
#'    |:-------------|:---------|:-----------------------------------------------|
#'    |GAME_ID       |character |Unique game identifier.                         |
#'    |TEAM_ID       |character |Unique team identifier.                         |
#'    |TEAM_CITY     |character |Team city or region (e.g. 'Las Vegas').         |
#'    |TEAM_NAME     |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |PERSON_ID     |character |Unique player identifier (V3 endpoints).        |
#'    |PLAYER_FIRST  |character |                                                |
#'    |PLAYER_LAST   |character |                                                |
#'    |IN_TIME_REAL  |character |                                                |
#'    |OUT_TIME_REAL |character |                                                |
#'    |PLAYER_PTS    |character |                                                |
#'    |PT_DIFF       |character |                                                |
#'    |USG_PCT       |character |Usage percentage (0-1).                         |
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

  params <- list(
    LeagueID = league_id,
    GameID = pad_id(game_id),
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
#' @name nba_boxscoresummaryv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoresummaryv3
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames:
#' GameSummary, GameInfo, ArenaInfo, Officials, LineScore,
#' InactivePlayers, LastFiveMeetings, OtherStats, AvailableVideo
#'
#'    **GameSummary**
#'
#'
#'    |col_name         |types     |description                                            |
#'    |:----------------|:---------|:------------------------------------------------------|
#'    |game_id          |character |Unique game identifier.                                |
#'    |game_code        |character |ESPN game code (numeric identifier).                   |
#'    |game_status      |integer   |Game status label.                                     |
#'    |game_status_text |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |period           |integer   |Period of the game (1-4 quarters; 5+ for OT).          |
#'    |game_clock       |character |Game clock.                                            |
#'    |game_time_utc    |character |Game start time in UTC (ISO 8601 timestamp).           |
#'    |game_et          |character |Game et.                                               |
#'    |away_team_id     |integer   |Unique identifier for the away team.                   |
#'    |home_team_id     |integer   |Unique identifier for the home team.                   |
#'    |duration         |integer   |Duration.                                              |
#'    |attendance       |integer   |Reported attendance.                                   |
#'    |sellout          |character |Sellout.                                               |
#'
#'    **GameInfo**
#'
#'
#'    |col_name      |types     |description             |
#'    |:-------------|:---------|:-----------------------|
#'    |game_id       |character |Unique game identifier. |
#'    |game_date     |character |Game date (YYYY-MM-DD). |
#'    |attendance    |integer   |Reported attendance.    |
#'    |game_duration |integer   |Game duration.          |
#'
#'    **ArenaInfo**
#'
#'
#'    |col_name       |types     |description                  |
#'    |:--------------|:---------|:----------------------------|
#'    |game_id        |character |Unique game identifier.      |
#'    |arena_id       |integer   |Unique identifier for arena. |
#'    |arena_name     |character |Arena name.                  |
#'    |arena_city     |character |Arena city.                  |
#'    |arena_state    |character |Arena state.                 |
#'    |arena_country  |character |Arena country.               |
#'    |arena_timezone |character |Arena timezone.              |
#'
#'    **Officials**
#'
#'
#'    |col_name    |types     |description                              |
#'    |:-----------|:---------|:----------------------------------------|
#'    |game_id     |character |Unique game identifier.                  |
#'    |person_id   |integer   |Unique player identifier (V3 endpoints). |
#'    |name        |character |Display name.                            |
#'    |name_i      |character |Initialed name (e.g. 'A. Wilson').       |
#'    |first_name  |character |Player's first name.                     |
#'    |family_name |character |Player's family / last name.             |
#'    |jersey_num  |character |Jersey number worn by the player.        |
#'
#'    **LineScore**
#'
#'
#'    |col_name      |types     |description                                               |
#'    |:-------------|:---------|:---------------------------------------------------------|
#'    |game_id       |character |Unique game identifier.                                   |
#'    |team_id       |integer   |Unique team identifier.                                   |
#'    |team_city     |character |Team city or region (e.g. 'Las Vegas').                   |
#'    |team_name     |character |Full team display name (e.g. 'Las Vegas Aces').           |
#'    |team_tricode  |character |Three-letter team code (e.g. 'LAS' / 'NYL').              |
#'    |team_slug     |character |URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
#'    |team_wins     |integer   |Team wins.                                                |
#'    |team_losses   |integer   |Team losses.                                              |
#'    |period1_score |integer   |Period1 score.                                            |
#'    |period2_score |integer   |Period2 score.                                            |
#'    |period3_score |integer   |Period3 score.                                            |
#'    |period4_score |integer   |Period4 score.                                            |
#'    |score         |integer   |Final score.                                              |
#'
#'    **InactivePlayers**
#'
#'
#'    |col_name    |types     |description                              |
#'    |:-----------|:---------|:----------------------------------------|
#'    |game_id     |character |Unique game identifier.                  |
#'    |team_id     |integer   |Unique team identifier.                  |
#'    |person_id   |integer   |Unique player identifier (V3 endpoints). |
#'    |first_name  |character |Player's first name.                     |
#'    |family_name |character |Player's family / last name.             |
#'    |jersey_num  |character |Jersey number worn by the player.        |
#'
#'    **LastFiveMeetings**
#'
#'
#'    |col_name          |types     |description                                            |
#'    |:-----------------|:---------|:------------------------------------------------------|
#'    |recency_order     |integer   |Recency order.                                         |
#'    |game_id           |character |Unique game identifier.                                |
#'    |game_time_utc     |character |Game start time in UTC (ISO 8601 timestamp).           |
#'    |game_et           |character |Game et.                                               |
#'    |game_status       |integer   |Game status label.                                     |
#'    |game_status_text  |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |away_team_id      |integer   |Unique identifier for the away team.                   |
#'    |away_team_city    |character |Away team city / location.                             |
#'    |away_team_name    |character |Away team name.                                        |
#'    |away_team_tricode |character |Away team three-letter code.                           |
#'    |away_team_score   |integer   |Away team's score.                                     |
#'    |away_team_wins    |integer   |Away team's team wins.                                 |
#'    |away_team_losses  |integer   |Away team's team losses.                               |
#'    |home_team_id      |integer   |Unique identifier for the home team.                   |
#'    |home_team_city    |character |Home team city / location.                             |
#'    |home_team_name    |character |Home team name.                                        |
#'    |home_team_tricode |character |Home team three-letter code.                           |
#'    |home_team_score   |integer   |Home team's score.                                     |
#'    |home_team_wins    |integer   |Home team's team wins.                                 |
#'    |home_team_losses  |integer   |Home team's team losses.                               |
#'
#'    **OtherStats**
#'
#'
#'    |col_name                  |types     |description                                      |
#'    |:-------------------------|:---------|:------------------------------------------------|
#'    |game_id                   |character |Unique game identifier.                          |
#'    |team_id                   |integer   |Unique team identifier.                          |
#'    |team_city                 |character |Team city or region (e.g. 'Las Vegas').          |
#'    |team_name                 |character |Full team display name (e.g. 'Las Vegas Aces').  |
#'    |team_tricode              |character |Three-letter team code (e.g. 'LAS' / 'NYL').     |
#'    |points                    |integer   |Points scored.                                   |
#'    |rebounds_total            |integer   |Total rebounds.                                  |
#'    |assists                   |integer   |Total assists.                                   |
#'    |steals                    |integer   |Total steals.                                    |
#'    |blocks                    |integer   |Total blocks.                                    |
#'    |turnovers                 |integer   |Total turnovers.                                 |
#'    |field_goals_percentage    |numeric   |Field goal percentage (0-1 decimal).             |
#'    |three_pointers_percentage |numeric   |Three-point field goal percentage (0-1 decimal). |
#'    |free_throws_percentage    |numeric   |Free throw percentage (0-1 decimal).             |
#'    |points_in_the_paint       |integer   |Points in the paint.                             |
#'    |points_second_chance      |integer   |Second-chance points scored.                     |
#'    |points_fast_break         |integer   |Fast-break points scored.                        |
#'    |biggest_lead              |integer   |Biggest lead.                                    |
#'    |lead_changes              |integer   |Lead changes.                                    |
#'    |times_tied                |integer   |Times tied.                                      |
#'    |biggest_scoring_run       |integer   |Biggest scoring run.                             |
#'    |turnovers_team            |integer   |Turnovers team.                                  |
#'    |turnovers_total           |integer   |Turnovers total.                                 |
#'    |rebounds_team             |integer   |Rebounds team.                                   |
#'    |points_from_turnovers     |integer   |Points from turnovers.                           |
#'    |bench_points              |integer   |Points scored by the bench.                      |
#'
#'    **AvailableVideo**
#'
#'
#'    |col_name             |types     |description             |
#'    |:--------------------|:---------|:-----------------------|
#'    |game_id              |character |Unique game identifier. |
#'    |video_available_flag |integer   |Video available flag.   |
#'    |pt_available         |integer   |Pt available.           |
#'    |pt_xyz_available     |integer   |Pt xyz available.       |
#'    |wh_status            |integer   |Wh status.              |
#'    |hustle_status        |integer   |Hustle status.          |
#'    |historical_status    |integer   |Historical status.      |
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
