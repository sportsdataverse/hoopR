


#' **Get NBA Stats API Scoreboard**
#' @name scoreboard
NULL
#' @title
#' **Get NBA Stats API Scoreboard**
#' @rdname scoreboard
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
nba_scoreboard <- function(
    league_id = '00',
    game_date='2021-07-20',
    day_offset=0,
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

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
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
#' @name scoreboardv2
NULL
#' @title
#' **Get NBA Stats API Scoreboard V2**
#' @rdname scoreboardv2
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
nba_scoreboardv2 <- function(
    league_id = '00',
    game_date='2021-07-20',
    day_offset=0,
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

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
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
#' @name winprobabilitypbp
NULL
#' @title
#' **Get NBA Stats API Win Probability PBP**
#' @rdname winprobabilitypbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param run_type Run Type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames:
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_winprobabilitypbp <- function(
    game_id = '0021700807',
    run_type='each second',
    ...){

  run_type <- gsub(' ','+',run_type)
  version <- "winprobabilitypbp"
  full_url <- nba_endpoint(version)

  params <- list(
    GameID = game_id,
    RunType = run_type
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
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
