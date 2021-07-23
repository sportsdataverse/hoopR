

nba_alltimeleadersgrids <- function(league_id='00',
                                per_mode = 'PerGame',
                                season_type = 'Regular Season',
                                top_x = 10){
  season_type <- gsub(' ','+',season_type)
  version <- "alltimeleadersgrids"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&SeasonType=",season_type,
                     "&TopX=",top_x)

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



nba_assistleaders <- function(league_id='00',
                              per_mode = 'PerGame',
                              player_or_team ='Team',
                              season = '2020-21',
                              season_type = 'Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "assistleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&PlayerOrTeam=",player_or_team,
                     "&Season=",season,
                     "&SeasonType=",season_type)

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

nba_assisttracker <- function(league_id='00',
                              per_mode = 'PerGame',
                              season = '2020-21',
                              season_type = 'Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "assisttracker"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&Season=",season,
                     "&SeasonType=",season_type)

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
