

nba_franchiseleaders <- function(league_id='00',
                                 team_id = '1610612739'){
  season_type <- gsub(' ','+',season_type)
  version <- "franchiseleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
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

nba_franchiseplayers <- function(league_id='00',
                                 per_mode = 'Totals',
                                 season_type = 'Regular Season',
                                 team_id = '1610612739'){
  season_type <- gsub(' ','+',season_type)
  version <- "franchiseplayers"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=", per_mode,
                     "&SeasonType=", season_type,
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

nba_franchisehistory <- function(league_id='00'){

  version <- "franchisehistory"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id)

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
