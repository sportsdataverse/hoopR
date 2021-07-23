#' **Get NBA Stats API Boxscores**
#' @name nba_stats_boxscore
NULL
#' @title
#' **Get NBA Stats API Boxscores**
#' @rdname nba_stats_boxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param version Boxscore version (default: 'all')
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @examples
#' nba_boxscore(game_id = 21601112, version = "boxscoretraditionalv2")

nba_boxscore <- function(game_id, version = "boxscoretraditionalv2"){

  if(version=="all"){
    endpoint_list <- c("boxscoretraditionalv2","boxscoreadvancedv2",
                       "boxscorescoringv2", "boxscoremiscv2",
                       "boxscoreusagev2", "boxscorefourfactorsv2",
                       "hustlestatsboxscore","boxscoreplayertrackv2",
                       "winprobabilitypbp", "boxscoredefensive",
                       "boxscorematchups")
    endpoint <- nba_boxscore(game_id=game_id,version=endpoint_list[i])
  } else {
    endpoint <- nba_endpoint(version)
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
  resp <- full_url %>%
    .nba_headers()

  data <-
    resp$resultSets$rowSet[[1]] %>%
    data.frame(stringsAsFactors = F) %>%
    as_tibble()

  json_names <-
    resp$resultSets$headers[[1]]
  colnames(data) <- json_names
  return(data)
}

nba_boxscoretraditionalv2 <- function(game_id){

  version <- "boxscoretraditionalv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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
  return(returndata)
}


nba_boxscoreadvancedv2 <- function(game_id){

  version <- "boxscoreadvancedv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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

nba_boxscoreefensive <- function(game_id){

  version <- "boxscoredefensive"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  resp <- full_url %>%
    .nba_headers()


  data <- resp$resultSets$rowSet[[1]] %>%
    data.frame(stringsAsFactors = F) %>%
    as_tibble()

  json_names <- resp$resultSets$headers[[1]]
  colnames(data) <- json_names

  names(df_list) <- resp$resultSets$name
  return(df_list)
}

nba_boxscorefourfactorsv2 <- function(game_id){

  version <- "boxscorefourfactorsv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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

nba_boxscoremiscv2 <- function(game_id){

  version <- "boxscoremiscv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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

nba_boxscorescoringv2 <- function(game_id){

  version <- "boxscorescoringv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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

nba_boxscoreusagev2 <- function(game_id){

  version <- "boxscoreusagev2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=0",
                     "&EndRange=0",
                     "&GameID=",pad_id(game_id),
                     "&RangeType=0",
                     "&StartPeriod=0",
                     "&StartRange=0")
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



nba_boxscoresummaryv2 <- function(game_id){

  version <- "boxscoresummaryv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
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


nba_boxscorematchups <- function(game_id){

  version <- "boxscorematchups"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
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

nba_boxscoreplayertrackv2 <- function(game_id){

  version <- "boxscoreplayertrackv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
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

nba_boxscoresimilarityscore <- function(
  Person1Id,Person1LeagueId,Person1Season,Person1SeasonType,
  Person2Id,Person2LeagueId,Person2Season,Person2SeasonType){

  version <- "boxscoresimilarityscore"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Person1Id=", Person1Id,
                     "&Person1LeagueId=", Person1LeagueId,
                     "&Person1Season=", Person1Season,
                     "&Person1SeasonType=", Person1SeasonType,
                     "Person2Id=", Person2Id,
                     "&Person2LeagueId=", Person2LeagueId,
                     "&Person2Season=", Person2Season,
                     "&Person2SeasonType=", Person2SeasonType)
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

