
#' **Get NBA Stats API Boxscore Traditional V2**
#' @name nba_boxscoretraditionalv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoretraditionalv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
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
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoretraditionalv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no traditional boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Advanced V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreadvancedv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' League-scoped: as of a 2026-08-24 residential-IP probe sweep this V2
#' endpoint returns HTTP 200 with zero rows for NBA (LeagueID '00') game IDs
#' -- use [nba_boxscoreadvancedv3()] for NBA instead. It still serves real
#' rows for WNBA (LeagueID '10') and G-League (LeagueID '20') game IDs, so
#' the wrapper stays exported/active rather than deprecated.
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
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoreadvancedv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no advanced boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Defensive**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_boxscoredefensive
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerDefensiveStats, Table1
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_boxscoredefensive(game_id = "0022200021")
#' ```
nba_boxscoredefensive <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoredefensive"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defensive boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Four Factors V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorefourfactorsv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorefourfactorsv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
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
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorefourfactorsv2()",
    with = "nba_boxscorefourfactorsv3()"
  )

  version <- "boxscorefourfactorsv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no four factors boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Misc V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoremiscv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoremiscv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
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
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoremiscv2()",
    with = "nba_boxscoremiscv3()"
  )

  version <- "boxscoremiscv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no miscellaneous boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Scoring V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorescoringv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorescoringv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
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
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorescoringv2()",
    with = "nba_boxscorescoringv3()"
  )

  version <- "boxscorescoringv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoring boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Usage V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreusagev3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreusagev2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
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
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoreusagev2()",
    with = "nba_boxscoreusagev3()"
  )

  version <- "boxscoreusagev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no usage boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Summary V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoresummaryv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscoresummaryv2(game_id = "0022200021")
#' ```
nba_boxscoresummaryv2 <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoresummaryv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no summary boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Matchups**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerMatchupsStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_boxscorematchups(game_id = "0022200021")
#' ```
nba_boxscorematchups <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  endpoint <- nba_endpoint('boxscorematchups')
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no matchups boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreplayertrackv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreplayertrackv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Player Tracking Functions
#' @details
#' ```r
#'  nba_boxscoreplayertrackv2(game_id = "0022200021")
#' ```
nba_boxscoreplayertrackv2 <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoreplayertrackv2()",
    with = "nba_boxscoreplayertrackv3()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple game IDs returned an empty response body; confirmed defunct upstream."
  )

  version <- "boxscoreplayertrackv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no  player tracking boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Hustle Stats Boxscore**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_hustlestatsboxscore", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Hustle Functions
#' @details
#' ```r
#'  nba_hustlestatsboxscore(game_id = "0022200021")
#' ```
nba_hustlestatsboxscore <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "hustlestatsboxscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no hustle stats boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_boxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
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
#' @family NBA Boxscore Similarity Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#' z <- nba_commonallplayers()$CommonAllPlayers
#' klay <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Klay Thompson')
#' book <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Devin Booker')
#' nba_boxscoresimilarityscore(person_1_id = klay$PERSON_ID,
#'   person_1_league_id = '00',
#'   person_1_season = year_to_season(most_recent_nba_season() - 2),
#'   person_1_season_type = 'Regular Season',
#'   person_2_id = book$PERSON_ID,
#'   person_2_league_id = '00',
#'   person_2_season = year_to_season(most_recent_nba_season() - 2),
#'   person_2_season_type = 'Regular Season'
#' )
#' ```
nba_boxscoresimilarityscore <- function(
    person_1_id = '202691',
    person_1_league_id = '00',
    person_1_season = most_recent_nba_season() - 3,
    person_1_season_type = 'Regular Season',
    person_2_id = '1626164',
    person_2_league_id = '00',
    person_2_season = most_recent_nba_season() - 3,
    person_2_season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  person_1_season_type <- gsub(' ', '+', person_1_season_type)
  person_2_season_type <- gsub(' ', '+', person_2_season_type)
  version <- "boxscoresimilarityscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Person1Id = person_1_id,
    Person1LeagueId = person_1_league_id,
    Person1Season = person_1_season,
    Person1SeasonType = person_1_season_type,
    Person2Id = person_2_id,
    Person2LeagueId = person_2_league_id,
    Person2Season = person_2_season,
    Person2SeasonType = person_2_season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore similarity data for given parameters available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_glalumboxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
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
#' @family NBA Boxscore Similarity Functions
#' @details
#' (Possibly Deprecated)
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
  .args <- mget(setdiff(names(formals()), "..."))

  person_1_season_type <- gsub(' ', '+', person_1_season_type)
  person_2_season_type <- gsub(' ', '+', person_2_season_type)
  version <- "glalumboxscoresimilarityscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Person1Id = person_1_id,
    Person1LeagueId = person_1_league_id,
    Person1Season = person_1_season,
    Person1SeasonType = person_1_season_type,
    Person2Id = person_2_id,
    Person2LeagueId = person_2_league_id,
    Person2Season = person_2_season,
    Person2SeasonType = person_2_season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no G-League alum boxscore similarity data for given parameters available!",
      args = .args
    ),
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
