

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
