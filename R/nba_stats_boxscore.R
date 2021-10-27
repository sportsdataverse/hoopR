
#' **Get NBA Stats API Boxscore Traditional V2**
#' @name bs_tradv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V2**
#' @rdname bs_tradv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoretraditionalv2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscoretraditionalv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no traditional boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Advanced V2**
#' @name bs_advv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Advanced V2**
#' @rdname bs_advv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoreadvancedv2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscoreadvancedv2"
  endpoint <- nba_endpoint(version)


  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)

  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no advanced boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Defensive**
#' @name bs_defensive
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive**
#' @rdname bs_defensive
#' @author Saiem Gilani
#' @param game_id Game ID
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoredefensive <- function(game_id){

  version <- "boxscoredefensive"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no defensive boxscore data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Four Factors V2**
#' @name bs_ffv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Four Factors V2**
#' @rdname bs_ffv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscorefourfactorsv2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscorefourfactorsv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no four factors boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Misc V2**
#' @name bs_miscv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Misc V2**
#' @rdname bs_miscv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoremiscv2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscoremiscv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no miscellaneous boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Scoring V2**
#' @name bs_scoringv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Scoring V2**
#' @rdname bs_scoringv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscorescoringv2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscorescoringv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoring boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Usage V2**
#' @name bs_usagev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Usage V2**
#' @rdname bs_usagev2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoreusagev2 <- function(
  game_id,
  start_period=0,
  end_period=14,
  start_range=0,
  end_range=0,
  range_type=0){

  version <- "boxscoreusagev2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=",pad_id(game_id),
                     "&RangeType=", range_type,
                     "&StartPeriod=",start_period,
                     "&StartRange=", start_range)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no usage boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Summary V2**
#' @name bs_summaryv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V2**
#' @rdname bs_summaryv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoresummaryv2 <- function(game_id){

  version <- "boxscoresummaryv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no summary boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Matchups**
#' @name bs_match
NULL
#' @title
#' **Get NBA Stats API Boxscore Matchups**
#' @rdname bs_match
#' @author Saiem Gilani
#' @param game_id Game ID
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscorematchups <- function(game_id){

  version <- "boxscorematchups"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no matchups boxscore data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @name bs_pt_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @rdname bs_pt_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoreplayertrackv2 <- function(game_id){

  version <- "boxscoreplayertrackv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no  player tracking boxscore v2 data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Similarity Score**
#' @name bs_similarity
NULL
#' @title
#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname bs_similarity
#' @author Saiem Gilani
#' @param person_1_id person_1_id
#' @param person_1_league_id person_1_league_id
#' @param person_1_season person_1_season
#' @param person_1_season_type person_1_season_type
#' @param person_2_id person_2_id
#' @param person_2_league_id person_2_league_id
#' @param person_2_season person_2_season
#' @param person_2_season_type person_2_season_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_boxscoresimilarityscore <- function(
  person_1_id,person_1_league_id,person_1_season,person_1_season_type,
  person_2_id,person_2_league_id,person_2_season,person_2_season_type){

  version <- "boxscoresimilarityscore"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Person1Id=", person_1_id,
                     "&Person1LeagueId=", person_1_league_id,
                     "&Person1Season=", person_1_season,
                     "&Person1SeasonType=", person_1_season_type,
                     "Person2Id=", person_2_id,
                     "&Person2LeagueId=", person_2_league_id,
                     "&Person2Season=", person_2_season,
                     "&Person2SeasonType=", person_2_season_type)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no boxscore similarity data for given parameters available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @name gl_bs_similarity
NULL
#' @title
#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname gl_bs_similarity
#' @author Saiem Gilani
#' @param person_1_id person_1_id
#' @param person_1_league_id person_1_league_id
#' @param person_1_season person_1_season
#' @param person_1_season_type person_1_season_type
#' @param person_2_id person_2_id
#' @param person_2_league_id person_2_league_id
#' @param person_2_season person_2_season
#' @param person_2_season_type person_2_season_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_glalumboxscoresimilarityscore <- function(
  person_1_id,person_1_league_id,person_1_season,person_1_season_type,
  person_2_id,person_2_league_id,person_2_season,person_2_season_type){

  version <- "glalumboxscoresimilarityscore"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Person1Id=", person_1_id,
                     "&Person1LeagueId=", person_1_league_id,
                     "&Person1Season=", person_1_season,
                     "&Person1SeasonType=", person_1_season_type,
                     "Person2Id=", person_2_id,
                     "&Person2LeagueId=", person_2_league_id,
                     "&Person2Season=", person_2_season,
                     "&Person2SeasonType=", person_2_season_type)
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no G-League alum boxscore similarity data for given parameters available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Hustle Stats Boxscore**
#' @name hustle_bs
NULL
#' @title
#' **Get NBA Stats API Hustle Stats Boxscore**
#' @rdname hustle_bs
#' @author Saiem Gilani
#' @param game_id Game ID
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_hustlestatsboxscore <- function(game_id){

  version <- "hustlestatsboxscore"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr={
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no hustle stats boxscore data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#
# nba_boxscore <- function(game_id, version = "boxscoretraditionalv2"){
#
#   if(version=="all"){
#     endpoint_list <- c("boxscoretraditionalv2","boxscoreadvancedv2",
#                        "boxscorescoringv2", "boxscoremiscv2",
#                        "boxscoreusagev2", "boxscorefourfactorsv2",
#                        "hustlestatsboxscore","boxscoreplayertrackv2",
#                        "winprobabilitypbp", "boxscoredefensive",
#                        "boxscorematchups")
#     endpoint <- nba_boxscore(game_id=game_id,version=endpoint_list[i])
#   } else {
#     endpoint <- nba_endpoint(version)
#   }
#
#   full_url <- paste0(endpoint,
#                      "?EndPeriod=0",
#                      "&EndRange=0",
#                      "&GameID=",pad_id(game_id),
#                      "&RangeType=0",
#                      "&StartPeriod=0",
#                      "&StartRange=0")
#   resp <- full_url %>%
#     .nba_headers()
#
#   data <-
#     resp$resultSets$rowSet[[1]] %>%
#     data.frame(stringsAsFactors = F) %>%
#     as_tibble()
#
#   json_names <-
#     resp$resultSets$headers[[1]]
#   colnames(data) <- json_names
#   return(data)
# }
