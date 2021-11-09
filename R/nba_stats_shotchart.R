#' **Get NBA Stats API Shot Chart Detail**
#' @name sc
NULL
#' @title
#' **Get NBA Stats API Shot Chart Detail**
#' @rdname sc
#' @author Saiem Gilani
#' @param context_measure context_measure
#' @param date_from date_from
#' @param date_to date_to
#' @param game_id game_id
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param period period
#' @param player_id player_id
#' @param player_position player_position
#' @param rookie_year rookie_year
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: LeagueAverages, Shot_Chart_Detail
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_shotchartdetail <- function(
  context_measure='FGA',
  date_from='',
  date_to='',
  game_id='',
  game_segment='',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  period=0,
  player_id='202696',
  player_position='',
  rookie_year = '',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id=0,
  vs_conference='',
  vs_division=''){


  season_type <- gsub(' ','+',season_type)
  version <- "shotchartdetail"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?ContextMeasure=", context_measure,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameID=", game_id,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&Period=", period,
                     "&PlayerID=", player_id,
                     "&PlayerPosition=", player_position,
                     "&RookieYear=", rookie_year,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no shot chart detail data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Shot Chart League-Wide**
#' @name sc_lw
NULL
#' @title
#' **Get NBA Stats API Shot Chart League-Wide**
#' @rdname sc_lw
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season season
#' @return Return a named list of data frames: League_Wide
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_shotchartleaguewide <- function(
  league_id='00',
  season='2020-21'){

  version <- "shotchartleaguewide"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&Season=", season)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no league-wide shot chart data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


# nba_shotchartlineupdetail <- function(
#   context_filter = '',
#   context_measure = 'FGA',
#   date_from = '',
#   date_to = '',
#   group_id='0',
#   game_id=0042000305,
#   game_segment = '',
#   last_n_games=0,
#   league_id='00',
#   location='',
#   month=0,
#   opponent_team_id=0,
#   outcome='',
#   period=0,
#   season='2020-21',
#   season_segment='',
#   season_type='Regular Season',
#   team_id='1610612749',
#   vs_conference='',
#   vs_division=''){
#   season_type <- gsub(' ','+',season_type)
#   version <- "shotchartlineupdetail"
#   endpoint <- nba_endpoint(version)
#
#   full_url <- paste0(endpoint,
#                      "?ContextFilter=", context_filter,
#                      "&ContextMeasure=", context_measure,
#                      "&DateFrom=", date_from,
#                      "&DateTo=", date_to,
#                      "&GameID=", pad_id(game_id),
#                      "&GROUP_ID=", group_id,
#                      "&GameSegment=", game_segment,
#                      "&LastNGames=", last_n_games,
#                      "&LeagueID=", league_id,
#                      "&Location=", location,
#                      "&Month=", month,
#                      "&OpponentTeamID=", opponent_team_id,
#                      "&Outcome=", outcome,
#                      "&Period=", period,
#                      "&Season=", season,
#                      "&SeasonSegment=", season_segment,
#                      "&SeasonType=", season_type,
#                      "&TeamID=", team_id,
#                      "&VsConference=", vs_conference,
#                      "&VsDivision=", vs_division)
#
#   resp <- full_url %>%
#     .nba_headers()
#
#   df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
#     data <- resp$resultSets$rowSet[[x]] %>%
#       data.frame(stringsAsFactors = F) %>%
#       as_tibble()
#
#     json_names <- resp$resultSets$headers[[x]]
#     colnames(data) <- json_names
#     return(data)
#   })
#   names(df_list) <- resp$resultSets$name
#   return(df_list)
# }

