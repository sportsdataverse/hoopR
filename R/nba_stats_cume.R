#' **Get NBA Stats API Cumulative Player Stats**
#' @name cumestatsplayer
NULL
#' @title
#' **Get NBA Stats API Cumulative Player Stats**
#' @rdname cumestatsplayer
#' @author Saiem Gilani
#' @param game_ids game_ids
#' @param league_id league_id
#' @param player_id player_id
#' @param season season
#' @param season_type season_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_cumestatsplayer <- function(
  game_ids='0022000756',
  league_id='00',
  player_id='1629611',
  season='2020-21',
  season_type){
  season_type <- gsub(' ','+',season_type)
  version <- "cumestatsplayer"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameIDs=",game_ids,
                     "&LeagueID=",league_id,
                     "&PlayerID=",player_id,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&TeamID=",team_id)

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
  return(df_list)
}

#' **Get NBA Stats API Cumulative Player Game Stats**
#' @name cumestatsplayergames
NULL
#' @title
#' **Get NBA Stats API Cumulative Player Game Stats**
#' @rdname cumestatsplayergames
#' @author Saiem Gilani
#' @param league_id league_id
#' @param location location
#' @param outcome outcome
#' @param player_id player_id
#' @param season season
#' @param season_type season_type
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_cumestatsplayergames <- function(
  league_id='00',
  location = '',
  outcome = '',
  player_id = '2544',
  season = '2020-21',
  season_type = 'Regular Season',
  vs_conference='',
  vs_division='',
  vs_team_id=''){
  season_type <- gsub(' ','+',season_type)
  version <- "cumestatsplayergames"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&Location=", location,
                     "&Outcome=", outcome,
                     "&PlayerID=", player_id,
                     "&Season=", season,
                     "&SeasonType=", season_type,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&VsTeamID=", vs_team_id)

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
  return(df_list)
}

#' **Get NBA Stats API Cumulative Team Stats**
#' @name cumestatsteam
NULL
#' @title
#' **Get NBA Stats API Cumulative Team Stats**
#' @rdname cumestatsteam
#' @author Saiem Gilani
#' @param game_ids game_ids
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param team_id team_id
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_cumestatsteam <- function(
  game_ids='0022000756',
  league_id='00',
  season='2020-21',
  season_type='Regular Season',
  team_id = ''){

  season_type <- gsub(' ','+',season_type)
  version <- "cumestatsteam"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameIDs=",game_ids,
                     "&LeagueID=",league_id,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&TeamID=",team_id)

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
  return(df_list)
}
#' **Get NBA Stats API Cumulative Team Game Stats**
#' @name cumestatsteamgames
NULL
#' @title
#' **Get NBA Stats API Cumulative Team Game Stats**
#' @rdname cumestatsteamgames
#' @author Saiem Gilani
#' @param league_id league_id
#' @param location location
#' @param outcome outcome
#' @param season season
#' @param season_id season_id
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_cumestatsteamgames <- function(
  league_id='00',
  location = '',
  outcome = '',
  season = '2020-21',
  season_id = '',
  season_type = 'Regular Season',
  team_id=1610612739,
  vs_conference='',
  vs_division='',
  vs_team_id=''){
  season_type <- gsub(' ','+',season_type)
  version <- "cumestatsteamgames"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&Location=", location,
                     "&Outcome=", outcome,
                     "&Season=", season,
                     "&SeasonID=", season_id,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&VsTeamID=", vs_team_id)

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
  return(df_list)
}
