

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
#' @details
#' ```r
#'  nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_schedule <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    ...){

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
          game_date = lubridate::ymd(substring(.data$game_date,1,10)))

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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_scoreboard(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboard <- function(
    league_id = '00',
    game_date = '2021-07-20',
    day_offset = 0,
    ...){

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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
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
#' @return Return a named list of data frames:
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')
#' ```
nba_winprobabilitypbp <- function(
    game_id = '0021700807',
    run_type = 'each second',
    ...){

  run_type <- gsub(' ', '+', run_type)
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
