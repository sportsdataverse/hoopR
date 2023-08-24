

#' **Get NBA Stats API Season Schedule**
#' @name nba_schedule
NULL
#' @title
#' **Get NBA Stats API Season Schedule**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @return Returns a tibble with the following columns:
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |game_date          |character |
#'    |game_id            |character |
#'    |game_code          |character |
#'    |game_status        |integer   |
#'    |game_status_text   |character |
#'    |game_sequence      |integer   |
#'    |game_date_est      |character |
#'    |game_time_est      |character |
#'    |game_date_time_est |character |
#'    |game_date_utc      |character |
#'    |game_time_utc      |character |
#'    |game_date_time_utc |character |
#'    |away_team_time     |character |
#'    |home_team_time     |character |
#'    |day                |character |
#'    |month_num          |integer   |
#'    |week_number        |integer   |
#'    |week_name          |character |
#'    |if_necessary       |character |
#'    |series_game_number |character |
#'    |series_text        |character |
#'    |arena_name         |character |
#'    |arena_state        |character |
#'    |arena_city         |character |
#'    |postponed_status   |character |
#'    |branch_link        |character |
#'    |game_subtype       |character |
#'    |home_team_id       |integer   |
#'    |home_team_name     |character |
#'    |home_team_city     |character |
#'    |home_team_tricode  |character |
#'    |home_team_slug     |character |
#'    |home_team_wins     |integer   |
#'    |home_team_losses   |integer   |
#'    |home_team_score    |integer   |
#'    |home_team_seed     |integer   |
#'    |away_team_id       |integer   |
#'    |away_team_name     |character |
#'    |away_team_city     |character |
#'    |away_team_tricode  |character |
#'    |away_team_slug     |character |
#'    |away_team_wins     |integer   |
#'    |away_team_losses   |integer   |
#'    |away_team_score    |integer   |
#'    |away_team_seed     |integer   |
#'    |season             |character |
#'    |league_id          |character |
#'
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#'  nba_schedule(league_id = '20', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_schedule <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scheduleleaguev2"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    Season = season
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      league_sched <- resp %>%
        purrr::pluck("leagueSchedule")
      games <- league_sched %>%
        purrr::pluck("gameDates") %>%
        tidyr::unnest("games") %>%
        tidyr::unnest("awayTeam", names_sep = "_") %>%
        tidyr::unnest("homeTeam", names_sep = "_") %>%
        dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
        janitor::clean_names()
      colnames(games) <- gsub('team_team', 'team', colnames(games))
      games$game_id <- unlist(purrr::map(games$game_id,function(x){
        pad_id(x)
      }))
      games$season <- league_sched$seasonYear
      games$league_id <- league_sched$leagueId
      games <- games %>%
        dplyr::mutate(
          season_type_id = substr(.data$game_id, 3, 3),
          season_type_description = dplyr::case_when(
            .data$season_type_id == 1 ~ "Pre-Season",
            .data$season_type_id == 2 ~ "Regular Season",
            .data$season_type_id == 3 ~ "All-Star",
            .data$season_type_id == 4 ~ "Playoffs",
            .data$season_type_id == 5 ~ "Play-In Game"),
          game_date = lubridate::mdy(substring(.data$game_date,1,10)))

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league schedule data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Scoreboard**
#' @name nba_scoreboard
NULL
#' @title
#' **Get NBA Stats API Scoreboard**
#' @rdname nba_scoreboard
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Available, EastConfStandingsByDay,
#' GameHeader, LastMeeting, LineScore, SeriesStandings, WestConfStandingsByDay
#'
#'    **GameHeader**
#'
#'
#'    |col_name                         |types     |
#'    |:--------------------------------|:---------|
#'    |GAME_DATE_EST                    |character |
#'    |GAME_SEQUENCE                    |character |
#'    |GAME_ID                          |character |
#'    |GAME_STATUS_ID                   |character |
#'    |GAME_STATUS_TEXT                 |character |
#'    |GAMECODE                         |character |
#'    |HOME_TEAM_ID                     |character |
#'    |VISITOR_TEAM_ID                  |character |
#'    |SEASON                           |character |
#'    |LIVE_PERIOD                      |character |
#'    |LIVE_PC_TIME                     |character |
#'    |NATL_TV_BROADCASTER_ABBREVIATION |character |
#'    |LIVE_PERIOD_TIME_BCAST           |character |
#'    |WH_STATUS                        |character |
#'
#'    **LineScore**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GAME_DATE_EST     |character |
#'    |GAME_SEQUENCE     |character |
#'    |GAME_ID           |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_CITY_NAME    |character |
#'    |TEAM_WINS_LOSSES  |character |
#'    |PTS_QTR1          |character |
#'    |PTS_QTR2          |character |
#'    |PTS_QTR3          |character |
#'    |PTS_QTR4          |character |
#'    |PTS_OT1           |character |
#'    |PTS_OT2           |character |
#'    |PTS_OT3           |character |
#'    |PTS_OT4           |character |
#'    |PTS_OT5           |character |
#'    |PTS_OT6           |character |
#'    |PTS_OT7           |character |
#'    |PTS_OT8           |character |
#'    |PTS_OT9           |character |
#'    |PTS_OT10          |character |
#'    |PTS               |character |
#'    |FG_PCT            |character |
#'    |FT_PCT            |character |
#'    |FG3_PCT           |character |
#'    |AST               |character |
#'    |REB               |character |
#'    |TOV               |character |
#'
#'    **SeriesStandings**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |GAME_ID          |character |
#'    |HOME_TEAM_ID     |character |
#'    |VISITOR_TEAM_ID  |character |
#'    |GAME_DATE_EST    |character |
#'    |HOME_TEAM_WINS   |character |
#'    |HOME_TEAM_LOSSES |character |
#'    |SERIES_LEADER    |character |
#'
#'    **LastMeeting**
#'
#'
#'    |col_name                         |types     |
#'    |:--------------------------------|:---------|
#'    |GAME_ID                          |character |
#'    |LAST_GAME_ID                     |character |
#'    |LAST_GAME_DATE_EST               |character |
#'    |LAST_GAME_HOME_TEAM_ID           |character |
#'    |LAST_GAME_HOME_TEAM_CITY         |character |
#'    |LAST_GAME_HOME_TEAM_NAME         |character |
#'    |LAST_GAME_HOME_TEAM_ABBREVIATION |character |
#'    |LAST_GAME_HOME_TEAM_POINTS       |character |
#'    |LAST_GAME_VISITOR_TEAM_ID        |character |
#'    |LAST_GAME_VISITOR_TEAM_CITY      |character |
#'    |LAST_GAME_VISITOR_TEAM_NAME      |character |
#'    |LAST_GAME_VISITOR_TEAM_CITY1     |character |
#'    |LAST_GAME_VISITOR_TEAM_POINTS    |character |
#'
#'    **EastConfStandingsByDay**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |TEAM_ID       |character |
#'    |LEAGUE_ID     |character |
#'    |SEASON_ID     |character |
#'    |STANDINGSDATE |character |
#'    |CONFERENCE    |character |
#'    |TEAM          |character |
#'    |G             |character |
#'    |W             |character |
#'    |L             |character |
#'    |W_PCT         |character |
#'    |HOME_RECORD   |character |
#'    |ROAD_RECORD   |character |
#'
#'    **WestConfStandingsByDay**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |TEAM_ID       |character |
#'    |LEAGUE_ID     |character |
#'    |SEASON_ID     |character |
#'    |STANDINGSDATE |character |
#'    |CONFERENCE    |character |
#'    |TEAM          |character |
#'    |G             |character |
#'    |W             |character |
#'    |L             |character |
#'    |W_PCT         |character |
#'    |HOME_RECORD   |character |
#'    |ROAD_RECORD   |character |
#'
#'    **Available**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |GAME_ID      |character |
#'    |PT_AVAILABLE |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboard(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboard <- function(
    league_id = '00',
    game_date = '2021-07-20',
    day_offset = 0,
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scoreboard"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoreboard data for {game_date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Scoreboard V2**
#' @name nba_scoreboardv2
NULL
#' @title
#' **Get NBA Stats API Scoreboard V2**
#' @rdname nba_scoreboardv2
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Available, EastConfStandingsByDay,
#' GameHeader, LastMeeting, LineScore, SeriesStandings, TeamLeaders,
#' TicketLinks, WestConfStandingsByDay, WinProbability
#'
#'
#'   **GameHeader**
#'
#'
#'   |col_name                         |types     |
#'   |:--------------------------------|:---------|
#'   |GAME_DATE_EST                    |character |
#'   |GAME_SEQUENCE                    |character |
#'   |GAME_ID                          |character |
#'   |GAME_STATUS_ID                   |character |
#'   |GAME_STATUS_TEXT                 |character |
#'   |GAMECODE                         |character |
#'   |HOME_TEAM_ID                     |character |
#'   |VISITOR_TEAM_ID                  |character |
#'   |SEASON                           |character |
#'   |LIVE_PERIOD                      |character |
#'   |LIVE_PC_TIME                     |character |
#'   |NATL_TV_BROADCASTER_ABBREVIATION |character |
#'   |HOME_TV_BROADCASTER_ABBREVIATION |character |
#'   |AWAY_TV_BROADCASTER_ABBREVIATION |character |
#'   |LIVE_PERIOD_TIME_BCAST           |character |
#'   |ARENA_NAME                       |character |
#'   |WH_STATUS                        |character |
#'   |WNBA_COMMISSIONER_FLAG           |character |
#'
#'   **LineScore**
#'
#'
#'   |col_name          |types     |
#'   |:-----------------|:---------|
#'   |GAME_DATE_EST     |character |
#'   |GAME_SEQUENCE     |character |
#'   |GAME_ID           |character |
#'   |TEAM_ID           |character |
#'   |TEAM_ABBREVIATION |character |
#'   |TEAM_CITY_NAME    |character |
#'   |TEAM_NAME         |character |
#'   |TEAM_WINS_LOSSES  |character |
#'   |PTS_QTR1          |character |
#'   |PTS_QTR2          |character |
#'   |PTS_QTR3          |character |
#'   |PTS_QTR4          |character |
#'   |PTS_OT1           |character |
#'   |PTS_OT2           |character |
#'   |PTS_OT3           |character |
#'   |PTS_OT4           |character |
#'   |PTS_OT5           |character |
#'   |PTS_OT6           |character |
#'   |PTS_OT7           |character |
#'   |PTS_OT8           |character |
#'   |PTS_OT9           |character |
#'   |PTS_OT10          |character |
#'   |PTS               |character |
#'   |FG_PCT            |character |
#'   |FT_PCT            |character |
#'   |FG3_PCT           |character |
#'   |AST               |character |
#'   |REB               |character |
#'   |TOV               |character |
#'
#'   **SeriesStandings**
#'
#'
#'   |col_name         |types     |
#'   |:----------------|:---------|
#'   |GAME_ID          |character |
#'   |HOME_TEAM_ID     |character |
#'   |VISITOR_TEAM_ID  |character |
#'   |GAME_DATE_EST    |character |
#'   |HOME_TEAM_WINS   |character |
#'   |HOME_TEAM_LOSSES |character |
#'   |SERIES_LEADER    |character |
#'
#'   **LastMeeting**
#'
#'
#'   |col_name                         |types     |
#'   |:--------------------------------|:---------|
#'   |GAME_ID                          |character |
#'   |LAST_GAME_ID                     |character |
#'   |LAST_GAME_DATE_EST               |character |
#'   |LAST_GAME_HOME_TEAM_ID           |character |
#'   |LAST_GAME_HOME_TEAM_CITY         |character |
#'   |LAST_GAME_HOME_TEAM_NAME         |character |
#'   |LAST_GAME_HOME_TEAM_ABBREVIATION |character |
#'   |LAST_GAME_HOME_TEAM_POINTS       |character |
#'   |LAST_GAME_VISITOR_TEAM_ID        |character |
#'   |LAST_GAME_VISITOR_TEAM_CITY      |character |
#'   |LAST_GAME_VISITOR_TEAM_NAME      |character |
#'   |LAST_GAME_VISITOR_TEAM_CITY1     |character |
#'   |LAST_GAME_VISITOR_TEAM_POINTS    |character |
#'
#'   **EastConfStandingsByDay**
#'
#'
#'   |col_name      |types     |
#'   |:-------------|:---------|
#'   |TEAM_ID       |character |
#'   |LEAGUE_ID     |character |
#'   |SEASON_ID     |character |
#'   |STANDINGSDATE |character |
#'   |CONFERENCE    |character |
#'   |TEAM          |character |
#'   |G             |character |
#'   |W             |character |
#'   |L             |character |
#'   |W_PCT         |character |
#'   |HOME_RECORD   |character |
#'   |ROAD_RECORD   |character |
#'
#'   **WestConfStandingsByDay**
#'
#'
#'   |col_name      |types     |
#'   |:-------------|:---------|
#'   |TEAM_ID       |character |
#'   |LEAGUE_ID     |character |
#'   |SEASON_ID     |character |
#'   |STANDINGSDATE |character |
#'   |CONFERENCE    |character |
#'   |TEAM          |character |
#'   |G             |character |
#'   |W             |character |
#'   |L             |character |
#'   |W_PCT         |character |
#'   |HOME_RECORD   |character |
#'   |ROAD_RECORD   |character |
#'
#'   **Available**
#'
#'
#'   |col_name     |types     |
#'   |:------------|:---------|
#'   |GAME_ID      |character |
#'   |PT_AVAILABLE |character |
#'
#'   **TeamLeaders**
#'
#'
#'   |col_name          |types     |
#'   |:-----------------|:---------|
#'   |GAME_ID           |character |
#'   |TEAM_ID           |character |
#'   |TEAM_CITY         |character |
#'   |TEAM_NICKNAME     |character |
#'   |TEAM_ABBREVIATION |character |
#'   |PTS_PLAYER_ID     |character |
#'   |PTS_PLAYER_NAME   |character |
#'   |PTS               |character |
#'   |REB_PLAYER_ID     |character |
#'   |REB_PLAYER_NAME   |character |
#'   |REB               |character |
#'   |AST_PLAYER_ID     |character |
#'   |AST_PLAYER_NAME   |character |
#'   |AST               |character |
#'
#'   **TicketLinks**
#'
#'   **WinProbability**
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv2(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboardv2 <- function(
    league_id = '00',
    game_date = '2021-07-20',
    day_offset = 0,
    ...){

  version <- "scoreboardv2"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoreboardv2 data for {game_date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Scoreboard V3**
#' @name nba_scoreboardv3
NULL
#' @title
#' **Get NBA Stats API Scoreboard V3**
#' @rdname nba_scoreboardv3
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a tibble with the following scoreboard data:
#'
#'    |col_name                       |types      |
#'    |:------------------------------|:----------|
#'    |game_id                        |character  |
#'    |game_code                      |character  |
#'    |game_status                    |integer    |
#'    |game_status_text               |character  |
#'    |game_date                      |character  |
#'    |game_time_utc                  |character  |
#'    |game_et                        |character  |
#'    |home_team_id                   |integer    |
#'    |home_team_name                 |character  |
#'    |home_team_city                 |character  |
#'    |home_team_tricode              |character  |
#'    |home_team_slug                 |character  |
#'    |away_team_id                   |integer    |
#'    |away_team_name                 |character  |
#'    |away_team_city                 |character  |
#'    |away_team_tricode              |character  |
#'    |away_team_slug                 |character  |
#'    |period                         |integer    |
#'    |game_clock                     |character  |
#'    |regulation_periods             |integer    |
#'    |series_game_number             |character  |
#'    |series_text                    |character  |
#'    |if_necessary                   |logical    |
#'    |series_conference              |character  |
#'    |po_round_desc                  |character  |
#'    |game_subtype                   |character  |
#'    |game_home_leaders_person_id    |integer    |
#'    |game_home_leaders_name         |character  |
#'    |game_home_leaders_player_slug  |character  |
#'    |game_home_leaders_jersey_num   |character  |
#'    |game_home_leaders_position     |character  |
#'    |game_home_leaders_team_tricode |character  |
#'    |game_home_leaders_points       |integer    |
#'    |game_home_leaders_rebounds     |integer    |
#'    |game_home_leaders_assists      |integer    |
#'    |game_away_leaders_person_id    |integer    |
#'    |game_away_leaders_name         |character  |
#'    |game_away_leaders_player_slug  |character  |
#'    |game_away_leaders_jersey_num   |character  |
#'    |game_away_leaders_position     |character  |
#'    |game_away_leaders_team_tricode |character  |
#'    |game_away_leaders_points       |integer    |
#'    |game_away_leaders_rebounds     |integer    |
#'    |game_away_leaders_assists      |integer    |
#'    |team_home_leaders_person_id    |integer    |
#'    |team_home_leaders_name         |character  |
#'    |team_home_leaders_player_slug  |character  |
#'    |team_home_leaders_jersey_num   |character  |
#'    |team_home_leaders_position     |character  |
#'    |team_home_leaders_team_tricode |character  |
#'    |team_home_leaders_points       |numeric    |
#'    |team_home_leaders_rebounds     |numeric    |
#'    |team_home_leaders_assists      |numeric    |
#'    |team_away_leaders_person_id    |integer    |
#'    |team_away_leaders_name         |character  |
#'    |team_away_leaders_player_slug  |character  |
#'    |team_away_leaders_jersey_num   |character  |
#'    |team_away_leaders_position     |character  |
#'    |team_away_leaders_team_tricode |character  |
#'    |team_away_leaders_points       |numeric    |
#'    |team_away_leaders_rebounds     |numeric    |
#'    |team_away_leaders_assists      |numeric    |
#'    |team_season_leaders_flag       |integer    |
#'    |home_wins                      |integer    |
#'    |home_losses                    |integer    |
#'    |home_score                     |integer    |
#'    |home_seed                      |integer    |
#'    |home_in_bonus                  |logical    |
#'    |home_timeouts_remaining        |integer    |
#'    |home_periods                   |list       |
#'    |away_wins                      |integer    |
#'    |away_losses                    |integer    |
#'    |away_score                     |integer    |
#'    |away_seed                      |integer    |
#'    |away_in_bonus                  |logical    |
#'    |away_timeouts_remaining        |integer    |
#'    |away_periods                   |list       |
#'    |league_id                      |character  |
#'    |league                         |character  |
#'    |broadcasters                   |data.frame |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv3(league_id = '00', game_date = '2023-03-26')
#' ```
nba_scoreboardv3 <- function(
    league_id = '00',
    game_date = '2023-03-26',
    ...){

  version <- "scoreboardv3"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      games <- scoreboard %>%
        purrr::pluck("games") %>%
        tidyr::unnest("homeTeam", names_sep = '_') %>%
        tidyr::unnest("awayTeam", names_sep = '_') %>%
        tidyr::unnest("gameLeaders", names_sep = '_') %>%
        tidyr::unnest("gameLeaders_homeLeaders", names_sep = '_') %>%
        tidyr::unnest("gameLeaders_awayLeaders", names_sep = '_')  %>%
        tidyr::unnest("teamLeaders", names_sep = '_') %>%
        tidyr::unnest("teamLeaders_homeLeaders", names_sep = '_') %>%
        tidyr::unnest("teamLeaders_awayLeaders", names_sep = '_')


      colnames(games) <- gsub("gameLeaders","game", colnames(games))
      colnames(games) <- gsub("teamLeaders","team", colnames(games))
      colnames(games) <- gsub("homeTeam","home", colnames(games))
      colnames(games) <- gsub("awayTeam","away", colnames(games))



      games <- games %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_date = game_date,
          league_id = league_id,
          league = dplyr::case_when(
            league_id == '00' ~ 'NBA',
            league_id == '10' ~ 'WNBA',
            league_id == '20' ~ 'G-League',
            TRUE ~ 'NBA')) %>%
        dplyr::select(
          "game_id",
          "game_code",
          "game_status",
          "game_status_text",
          "game_date",
          "game_time_utc",
          "game_et",
          dplyr::starts_with("home_team"),
          dplyr::starts_with("away_team"),
          tidyr::everything()) %>%
        dplyr::relocate("broadcasters", .after = dplyr::last_col()) %>%
      make_hoopR_data("NBA Scoreboard V3 Information from NBA.com", Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoreboard v3 data for {game_date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Today's Scoreboard**
#' @name nba_todays_scoreboard
NULL
#' @title
#' **Get NBA Stats API Today's Scoreboard**
#' @rdname nba_todays_scoreboard
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a data frame with the following columns:
#'
#'   |col_name                  |types     |
#'   |:-------------------------|:---------|
#'   |game_id                   |character |
#'   |game_code                 |character |
#'   |game_status               |integer   |
#'   |game_status_text          |character |
#'   |period                    |integer   |
#'   |game_clock                |character |
#'   |game_time_utc             |character |
#'   |game_et                   |character |
#'   |regulation_periods        |integer   |
#'   |if_necessary              |logical   |
#'   |series_game_number        |character |
#'   |series_text               |character |
#'   |series_conference         |character |
#'   |po_round_desc             |character |
#'   |game_subtype              |character |
#'   |home_team_id              |integer   |
#'   |home_team_name            |character |
#'   |home_team_city            |character |
#'   |home_team_tricode         |character |
#'   |home_wins                 |integer   |
#'   |home_losses               |integer   |
#'   |home_score                |integer   |
#'   |home_seed                 |logical   |
#'   |home_in_bonus             |character |
#'   |home_timeouts_remaining   |integer   |
#'   |home_periods              |list      |
#'   |away_team_id              |integer   |
#'   |away_team_name            |character |
#'   |away_team_city            |character |
#'   |away_team_tricode         |character |
#'   |away_wins                 |integer   |
#'   |away_losses               |integer   |
#'   |away_score                |integer   |
#'   |away_seed                 |logical   |
#'   |away_in_bonus             |character |
#'   |away_timeouts_remaining   |integer   |
#'   |away_periods              |list      |
#'   |home_leaders_person_id    |integer   |
#'   |home_leaders_name         |character |
#'   |home_leaders_jersey_num   |character |
#'   |home_leaders_position     |character |
#'   |home_leaders_team_tricode |character |
#'   |home_leaders_player_slug  |character |
#'   |home_leaders_points       |integer   |
#'   |home_leaders_rebounds     |integer   |
#'   |home_leaders_assists      |integer   |
#'   |away_leaders_person_id    |integer   |
#'   |away_leaders_name         |character |
#'   |away_leaders_jersey_num   |character |
#'   |away_leaders_position     |character |
#'   |away_leaders_team_tricode |character |
#'   |away_leaders_player_slug  |character |
#'   |away_leaders_points       |integer   |
#'   |away_leaders_rebounds     |integer   |
#'   |away_leaders_assists      |integer   |
#'   |pb_odds_team              |logical   |
#'   |pb_odds_odds              |numeric   |
#'   |pb_odds_suspended         |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_todays_scoreboard()
#' ```
nba_todays_scoreboard <- function(
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  tryCatch(
    expr = {
      full_url <- "https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json"
      res <- rvest::session(url = full_url, ...,  httr::timeout(60))

      resp <- res$response %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON()

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      games <- scoreboard %>%
        purrr::pluck("games") %>%
        tidyr::unnest("homeTeam", names_sep = '_') %>%
        tidyr::unnest("awayTeam", names_sep = '_') %>%
        tidyr::unnest("gameLeaders") %>%
        tidyr::unnest("homeLeaders", names_sep = '_') %>%
        tidyr::unnest("awayLeaders", names_sep = '_') %>%
        tidyr::unnest("pbOdds", names_sep = '_')

      colnames(games) <- gsub("homeTeam","home", colnames(games))
      colnames(games) <- gsub("awayTeam","away", colnames(games))

      games <- games %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Today's Scoreboard Information from NBA.com", Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no today's scoreboard data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}



#' **Get NBA Stats API Win Probability PBP**
#' @name nba_winprobabilitypbp
NULL
#' @title
#' **Get NBA Stats API Win Probability PBP**
#' @rdname nba_winprobabilitypbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param run_type Run Type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: WinProbPBP, GameInfo
#'
#'    **WinProbPBP**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GAME_ID           |character |
#'    |EVENT_NUM         |character |
#'    |HOME_PCT          |character |
#'    |VISITOR_PCT       |character |
#'    |HOME_PTS          |character |
#'    |VISITOR_PTS       |character |
#'    |HOME_SCORE_MARGIN |character |
#'    |PERIOD            |character |
#'    |SECONDS_REMAINING |character |
#'    |HOME_POSS_IND     |character |
#'    |HOME_G            |character |
#'    |DESCRIPTION       |character |
#'    |LOCATION          |character |
#'    |PCTIMESTRING      |character |
#'    |ISVISIBLE         |character |
#'
#'    **GameInfo**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |GAME_ID          |character |
#'    |GAME_DATE        |character |
#'    |HOME_TEAM_ID     |character |
#'    |HOME_TEAM_ABR    |character |
#'    |HOME_TEAM_PTS    |character |
#'    |VISITOR_TEAM_ID  |character |
#'    |VISITOR_TEAM_ABR |character |
#'    |VISITOR_TEAM_PTS |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')
#' ```
nba_winprobabilitypbp <- function(
    game_id = '0021700807',
    run_type = 'each second',
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # run_type <- gsub(' ', '+', run_type)
  version <- "winprobabilitypbp"
  full_url <- nba_endpoint(version)

  params <- list(
    GameID = game_id,
    RunType = run_type
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no win probability pbp data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
