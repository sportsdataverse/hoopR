
#' **Get NBA Stats API play-by-play**
#' @name nba_stats_pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname nba_stats_pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @examples
#' nba_pbp(game_id = 21601112, version = "v2")

nba_pbp <- function(game_id, version = "v2"){

  if(version=="v2"){
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0&",
                     "GameID=",pad_id(game_id),
                     "&StartPeriod=0")
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

#' **Get NBA Stats API Schedule**
#' @name nba_stats_schedule
NULL
#' @title
#' **Get NBA Stats API Schedule**
#' @rdname nba_stats_schedule
#' @author Saiem Gilani
#' @param season Season - 4 digit integer corresponding to the first year in the season format 2020-21
#' @param league League - default: 'NBA'. Other options include 'all'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @examples
#' nba_schedule(season = 2020)
nba_schedule <- function(season = 2020, league = 'NBA'){

  full_url <- glue::glue("https://data.nba.com/prod/v1/{season}/schedule.json")
  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")


  data <- jsonlite::fromJSON(resp)[["league"]]

  if(tolower(league) != 'all'){
    data <- data[["standard"]]
  }
  return(data)
}

