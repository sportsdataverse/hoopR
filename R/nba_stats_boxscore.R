
#' **Get NBA Stats API Boxscore Traditional V2**
#' @name bs_trad_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V2**
#' @rdname bs_trad_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: PlayerStats, TeamStarterBenchStats, TeamStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoretraditionalv2(game_id = "0022200021")
#' ```
nba_boxscoretraditionalv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_adv_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Advanced V2**
#' @rdname bs_adv_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerStats, TeamStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoreadvancedv2(game_id = "0022200021")
#' ```
nba_boxscoreadvancedv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerDefensiveStats, Table1
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoredefensive(game_id = "0022200021")
#' ```
nba_boxscoredefensive <- function(
    game_id,
    ...){

  version <- "boxscoredefensive"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_ff_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Four Factors V2**
#' @rdname bs_ff_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersFourFactors, sqlTeamFourFactors
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscorefourfactorsv2(game_id = "0022200021")
#' ```
nba_boxscorefourfactorsv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_misc_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Misc V2**
#' @rdname bs_misc_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersMisc, sqlTeamsMisc
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoremiscv2(game_id = "0022200021")
#' ```
nba_boxscoremiscv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_scoring_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Scoring V2**
#' @rdname bs_scoring_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersScoring, sqlTeamsScoring
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscorescoringv2(game_id = "0022200021")
#' ```
nba_boxscorescoringv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_usage_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Usage V2**
#' @rdname bs_usage_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersUsage, sqlTeamsUsage
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoreusagev2(game_id = "0022200021")
#' ```
nba_boxscoreusagev2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @name bs_summary_v2
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V2**
#' @rdname bs_summary_v2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AvailableVideo, GameInfo, GameSummary, InactivePlayers, LastMeeting, LineScore, Officials, OtherStats, SeasonSeries
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoresummaryv2(game_id = "0022200021")
#' ```
nba_boxscoresummaryv2 <- function(
    game_id,
    ...){

  version <- "boxscoresummaryv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @param version Boxscore Matchups version ("v2" available from 2016-17 onwards)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerMatchupsStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscorematchups(game_id = "0022200021", version = "v1")
#' ```
nba_boxscorematchups <- function(
    game_id,
    version = "v2",
    ...){

  if (version == "v2") {
    endpoint <- nba_endpoint('boxscorematchupsv2')
  } else {
    endpoint <- nba_endpoint('boxscorematchups')
  }

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerStats, TeamStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_boxscoreplayertrackv2(game_id = "0022200021")
#' ```
nba_boxscoreplayertrackv2 <- function(
    game_id,
    ...){

  version <- "boxscoreplayertrackv2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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

#' **Get NBA Stats API Hustle Stats Boxscore**
#' @name hustle_bs
NULL
#' @title
#' **Get NBA Stats API Hustle Stats Boxscore**
#' @rdname hustle_bs
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HustleStatsAvailable, PlayerStats, TeamStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_hustlestatsboxscore(game_id = "0022200021")
#' ```
nba_hustlestatsboxscore <- function(
    game_id,
    ...){

  version <- "hustlestatsboxscore"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id))
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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

#' **Get NBA Stats API Game Rotation**
#' @name game_rotation
NULL
#' @title
#' **Get NBA Stats API Game Rotation**
#' @rdname game_rotation
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param league_id League ID
#' @param rotation_stat Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AwayTeam, HomeTeam
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_gamerotation(game_id = "0022200021")
#' ```
nba_gamerotation <- function(
    game_id,
    league_id = '00',
    rotation_stat = 'PLAYER_PTS',
    ...){

  version <- "gamerotation"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=",pad_id(game_id),
                     "&LeagueID=",league_id,
                     "&RotationStat=", rotation_stat)
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no game rotation data for {game_id} available!"))
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: BoxScoreSimilarityScores
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_boxscoresimilarityscore <- function(
    person_1_id,
    person_1_league_id,
    person_1_season,
    person_1_season_type,
    person_2_id,
    person_2_league_id,
    person_2_season,
    person_2_season_type,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: GLeagueAlumBoxScoreSimilarityScores
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_glalumboxscoresimilarityscore <- function(
    person_1_id,
    person_1_league_id,
    person_1_season,
    person_1_season_type,
    person_2_id,
    person_2_league_id,
    person_2_season,
    person_2_season_type,
    ...){

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
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

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
