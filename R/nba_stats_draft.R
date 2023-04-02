
#' **Get NBA Stats API Draft Board**
#' @name nba_draftboard
NULL
#' @title
#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftboard
#' @author Saiem Gilani
#' @param season season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Picks, TeamsWithoutPicks, LiveDetails
#'
#'    **Picks**
#'
#'
#'    |col_name                         |types     |
#'    |:--------------------------------|:---------|
#'    |pick_number                      |integer   |
#'    |pick_details                     |character |
#'    |team_id                          |integer   |
#'    |team_type                        |character |
#'    |team_season                      |integer   |
#'    |team_team_id                     |integer   |
#'    |team_permalink                   |character |
#'    |team_app_url                     |character |
#'    |team_trade_details               |list      |
#'    |team_team_name                   |character |
#'    |team_team_abbr                   |character |
#'    |team_picked_first_round          |logical   |
#'    |team_picked_second_round         |logical   |
#'    |team_team_record_season          |character |
#'    |team_team_record_wins_and_losses |character |
#'    |team_team_record_season_finish   |character |
#'    |team_team_record_playoffs_finish |character |
#'    |prospect_id                      |integer   |
#'    |prospect_type                    |character |
#'    |prospect_season                  |integer   |
#'    |prospect_display_name            |character |
#'    |prospect_first_name              |character |
#'    |prospect_last_name               |character |
#'    |prospect_permalink               |character |
#'    |prospect_app_url                 |character |
#'    |prospect_position                |character |
#'    |prospect_weight_lbs              |integer   |
#'    |prospect_school                  |character |
#'    |prospect_status                  |character |
#'    |prospect_birthday                |character |
#'    |prospect_country                 |character |
#'    |prospect_trade_details           |list      |
#'    |prospect_height_feet_and_inches  |character |
#'    |prospect_height_inches_only      |integer   |
#'
#'    **TeamsWithoutPicks**
#'
#'
#'    |col_name            |types      |
#'    |:-------------------|:----------|
#'    |id                  |integer    |
#'    |type                |character  |
#'    |season              |integer    |
#'    |team_id             |integer    |
#'    |team_record         |data.frame |
#'    |permalink           |character  |
#'    |app_url             |character  |
#'    |trade_details       |list       |
#'    |team_name           |character  |
#'    |team_abbr           |character  |
#'    |picked_second_round |logical    |
#'    |picked_first_round  |logical    |
#'
#'    **LiveDetails**
#'
#'
#'    |col_name                       |types   |
#'    |:------------------------------|:-------|
#'    |is_draft_live                  |logical |
#'    |live_draft_current_pick_number |numeric |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' ```r
#'   nba_draftboard(season = most_recent_nba_season() - 1)
#' ```
nba_draftboard <- function(
    season = most_recent_nba_season() - 1,
    ...){

  version <- "draftboard"
  endpoint <- glue::glue("https://content-api-prod.nba.com/public/1/leagues/nba/draft/{season}/board")
  full_url <- endpoint

  params <- list()

  tryCatch(
    expr = {

      res <- httr::RETRY("GET", full_url, query = params)
      resp <-  res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("results")

      first_round_picks <- resp %>%
        purrr::pluck("picks") %>%
        purrr::pluck("firstRound", .default = data.frame()) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names()

      second_round_picks <- resp %>%
        purrr::pluck("picks") %>%
        purrr::pluck("secondRound", .default = data.frame()) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names()

      picks <- first_round_picks %>%
        dplyr::bind_rows(second_round_picks)

      teams_without_picks_first <- resp %>%
        purrr::pluck("teamsWithoutPicks") %>%
        purrr::pluck("firstRound") %>%
        data.frame()

      teams_without_picks_second <- resp %>%
        purrr::pluck("teamsWithoutPicks") %>%
        purrr::pluck("secondRound") %>%
        data.frame()

      teams_without_picks <- teams_without_picks_first %>%
        dplyr::bind_rows(teams_without_picks_second)

      teams_without_picks <- teams_without_picks %>%
        janitor::clean_names()

      live_details <- data.frame(
        is_draft_live = resp$isDraftLive,
        live_draft_current_pick_number = ifelse(
          is.null(resp$liveDraftCurrentPickNumber), 0, resp$liveDraftCurrentPickNumber
        )
      )

      df_list <- c(list(picks), list(teams_without_picks), list(live_details))
      names(df_list) <- c("Picks", "TeamsWithoutPicks","LiveDetails")

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft board data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Stats**
#' @name nba_draftcombinestats
NULL
#' @title
#' **Get NBA Stats API Draft Combine Stats**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftCombineStats
#'
#'    **DraftCombineStats**
#'
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |SEASON                       |character |
#'    |PLAYER_ID                    |character |
#'    |FIRST_NAME                   |character |
#'    |LAST_NAME                    |character |
#'    |PLAYER_NAME                  |character |
#'    |POSITION                     |character |
#'    |HEIGHT_WO_SHOES              |character |
#'    |HEIGHT_WO_SHOES_FT_IN        |character |
#'    |HEIGHT_W_SHOES               |character |
#'    |HEIGHT_W_SHOES_FT_IN         |character |
#'    |WEIGHT                       |character |
#'    |WINGSPAN                     |character |
#'    |WINGSPAN_FT_IN               |character |
#'    |STANDING_REACH               |character |
#'    |STANDING_REACH_FT_IN         |character |
#'    |BODY_FAT_PCT                 |character |
#'    |HAND_LENGTH                  |character |
#'    |HAND_WIDTH                   |character |
#'    |STANDING_VERTICAL_LEAP       |character |
#'    |MAX_VERTICAL_LEAP            |character |
#'    |LANE_AGILITY_TIME            |character |
#'    |MODIFIED_LANE_AGILITY_TIME   |character |
#'    |THREE_QUARTER_SPRINT         |character |
#'    |BENCH_PRESS                  |character |
#'    |SPOT_FIFTEEN_CORNER_LEFT     |character |
#'    |SPOT_FIFTEEN_BREAK_LEFT      |character |
#'    |SPOT_FIFTEEN_TOP_KEY         |character |
#'    |SPOT_FIFTEEN_BREAK_RIGHT     |character |
#'    |SPOT_FIFTEEN_CORNER_RIGHT    |character |
#'    |SPOT_COLLEGE_CORNER_LEFT     |character |
#'    |SPOT_COLLEGE_BREAK_LEFT      |character |
#'    |SPOT_COLLEGE_TOP_KEY         |character |
#'    |SPOT_COLLEGE_BREAK_RIGHT     |character |
#'    |SPOT_COLLEGE_CORNER_RIGHT    |character |
#'    |SPOT_NBA_CORNER_LEFT         |character |
#'    |SPOT_NBA_BREAK_LEFT          |character |
#'    |SPOT_NBA_TOP_KEY             |character |
#'    |SPOT_NBA_BREAK_RIGHT         |character |
#'    |SPOT_NBA_CORNER_RIGHT        |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT  |character |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY     |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT |character |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT  |character |
#'    |OFF_DRIB_COLLEGE_TOP_KEY     |character |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT |character |
#'    |ON_MOVE_FIFTEEN              |character |
#'    |ON_MOVE_COLLEGE              |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' ```r
#'  nba_draftcombinestats(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinestats <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinestats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine stats data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Drill Results**
#' @name nba_draftcombinedrillresults
NULL
#' @title
#' **Get NBA Stats API Draft Combine Drill Results**
#' @rdname nba_draftcombinedrillresults
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    |col_name                   |types     |
#'    |:--------------------------|:---------|
#'    |TEMP_PLAYER_ID             |character |
#'    |PLAYER_ID                  |character |
#'    |FIRST_NAME                 |character |
#'    |LAST_NAME                  |character |
#'    |PLAYER_NAME                |character |
#'    |POSITION                   |character |
#'    |STANDING_VERTICAL_LEAP     |character |
#'    |MAX_VERTICAL_LEAP          |character |
#'    |LANE_AGILITY_TIME          |character |
#'    |MODIFIED_LANE_AGILITY_TIME |character |
#'    |THREE_QUARTER_SPRINT       |character |
#'    |BENCH_PRESS                |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombinedrillresults(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinedrillresults <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinedrillresults"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine drill results data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @name nba_draftcombinenonstationaryshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @rdname nba_draftcombinenonstationaryshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    |col_name                             |types     |
#'    |:------------------------------------|:---------|
#'    |TEMP_PLAYER_ID                       |character |
#'    |PLAYER_ID                            |character |
#'    |FIRST_NAME                           |character |
#'    |LAST_NAME                            |character |
#'    |PLAYER_NAME                          |character |
#'    |POSITION                             |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE     |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT  |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT      |character |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_MADE        |character |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT     |character |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_PCT         |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE    |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT |character |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT     |character |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_MADE     |character |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT  |character |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_PCT      |character |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_MADE        |character |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT     |character |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_PCT         |character |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE    |character |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT |character |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT     |character |
#'    |ON_MOVE_FIFTEEN_MADE                 |character |
#'    |ON_MOVE_FIFTEEN_ATTEMPT              |character |
#'    |ON_MOVE_FIFTEEN_PCT                  |character |
#'    |ON_MOVE_COLLEGE_MADE                 |character |
#'    |ON_MOVE_COLLEGE_ATTEMPT              |character |
#'    |ON_MOVE_COLLEGE_PCT                  |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Non-stationary Shooting](https://www.nba.com/stats/draft/combine-non-stationary)
#' ```r
#'  nba_draftcombinenonstationaryshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinenonstationaryshooting <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinenonstationaryshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine stationary shooting data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @name nba_draftcombineplayeranthro
NULL
#' @title
#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @rdname nba_draftcombineplayeranthro
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |TEMP_PLAYER_ID        |character |
#'    |PLAYER_ID             |character |
#'    |FIRST_NAME            |character |
#'    |LAST_NAME             |character |
#'    |PLAYER_NAME           |character |
#'    |POSITION              |character |
#'    |HEIGHT_WO_SHOES       |character |
#'    |HEIGHT_WO_SHOES_FT_IN |character |
#'    |HEIGHT_W_SHOES        |character |
#'    |HEIGHT_W_SHOES_FT_IN  |character |
#'    |WEIGHT                |character |
#'    |WINGSPAN              |character |
#'    |WINGSPAN_FT_IN        |character |
#'    |STANDING_REACH        |character |
#'    |STANDING_REACH_FT_IN  |character |
#'    |BODY_FAT_PCT          |character |
#'    |HAND_LENGTH           |character |
#'    |HAND_WIDTH            |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Player Anthro](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombineplayeranthro(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombineplayeranthro <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombineplayeranthro"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine player anthropological data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @name nba_draftcombinespotshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @rdname nba_draftcombinespotshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |TEMP_PLAYER_ID               |character |
#'    |PLAYER_ID                    |character |
#'    |FIRST_NAME                   |character |
#'    |LAST_NAME                    |character |
#'    |PLAYER_NAME                  |character |
#'    |POSITION                     |character |
#'    |FIFTEEN_CORNER_LEFT_MADE     |character |
#'    |FIFTEEN_CORNER_LEFT_ATTEMPT  |character |
#'    |FIFTEEN_CORNER_LEFT_PCT      |character |
#'    |FIFTEEN_BREAK_LEFT_MADE      |character |
#'    |FIFTEEN_BREAK_LEFT_ATTEMPT   |character |
#'    |FIFTEEN_BREAK_LEFT_PCT       |character |
#'    |FIFTEEN_TOP_KEY_MADE         |character |
#'    |FIFTEEN_TOP_KEY_ATTEMPT      |character |
#'    |FIFTEEN_TOP_KEY_PCT          |character |
#'    |FIFTEEN_BREAK_RIGHT_MADE     |character |
#'    |FIFTEEN_BREAK_RIGHT_ATTEMPT  |character |
#'    |FIFTEEN_BREAK_RIGHT_PCT      |character |
#'    |FIFTEEN_CORNER_RIGHT_MADE    |character |
#'    |FIFTEEN_CORNER_RIGHT_ATTEMPT |character |
#'    |FIFTEEN_CORNER_RIGHT_PCT     |character |
#'    |COLLEGE_CORNER_LEFT_MADE     |character |
#'    |COLLEGE_CORNER_LEFT_ATTEMPT  |character |
#'    |COLLEGE_CORNER_LEFT_PCT      |character |
#'    |COLLEGE_BREAK_LEFT_MADE      |character |
#'    |COLLEGE_BREAK_LEFT_ATTEMPT   |character |
#'    |COLLEGE_BREAK_LEFT_PCT       |character |
#'    |COLLEGE_TOP_KEY_MADE         |character |
#'    |COLLEGE_TOP_KEY_ATTEMPT      |character |
#'    |COLLEGE_TOP_KEY_PCT          |character |
#'    |COLLEGE_BREAK_RIGHT_MADE     |character |
#'    |COLLEGE_BREAK_RIGHT_ATTEMPT  |character |
#'    |COLLEGE_BREAK_RIGHT_PCT      |character |
#'    |COLLEGE_CORNER_RIGHT_MADE    |character |
#'    |COLLEGE_CORNER_RIGHT_ATTEMPT |character |
#'    |COLLEGE_CORNER_RIGHT_PCT     |character |
#'    |NBA_CORNER_LEFT_MADE         |character |
#'    |NBA_CORNER_LEFT_ATTEMPT      |character |
#'    |NBA_CORNER_LEFT_PCT          |character |
#'    |NBA_BREAK_LEFT_MADE          |character |
#'    |NBA_BREAK_LEFT_ATTEMPT       |character |
#'    |NBA_BREAK_LEFT_PCT           |character |
#'    |NBA_TOP_KEY_MADE             |character |
#'    |NBA_TOP_KEY_ATTEMPT          |character |
#'    |NBA_TOP_KEY_PCT              |character |
#'    |NBA_BREAK_RIGHT_MADE         |character |
#'    |NBA_BREAK_RIGHT_ATTEMPT      |character |
#'    |NBA_BREAK_RIGHT_PCT          |character |
#'    |NBA_CORNER_RIGHT_MADE        |character |
#'    |NBA_CORNER_RIGHT_ATTEMPT     |character |
#'    |NBA_CORNER_RIGHT_PCT         |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Spot Shooting](https://www.nba.com/stats/draft/combine-spot-up)
#' ```r
#'  nba_draftcombinespotshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinespotshooting <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinespotshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine spot shooting data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Draft History**
#' @rdname nba_drafthistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param college college
#' @param overall_pick overall_pick
#' @param round_pick round_pick
#' @param round_num round_num
#' @param season season
#' @param team_id team_id
#' @param top_x top_x
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftHistory
#'
#'    **DraftHistory**
#'
#'
#'    |col_name            |types     |
#'    |:-------------------|:---------|
#'    |PERSON_ID           |character |
#'    |PLAYER_NAME         |character |
#'    |SEASON              |character |
#'    |ROUND_NUMBER        |character |
#'    |ROUND_PICK          |character |
#'    |OVERALL_PICK        |character |
#'    |DRAFT_TYPE          |character |
#'    |TEAM_ID             |character |
#'    |TEAM_CITY           |character |
#'    |TEAM_NAME           |character |
#'    |TEAM_ABBREVIATION   |character |
#'    |ORGANIZATION        |character |
#'    |ORGANIZATION_TYPE   |character |
#'    |PLAYER_PROFILE_FLAG |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft History](https://www.nba.com/stats/draft/history)
#' ```r
#'  nba_drafthistory(season = most_recent_nba_season() - 1)
#' ```
nba_drafthistory <- function(
    league_id = '00',
    college = '',
    overall_pick = '',
    round_pick = '',
    round_num = '',
    season = most_recent_nba_season() - 1,
    team_id = '',
    top_x = '',
    ...){

  version <- "drafthistory"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    College = college,
    LeagueID = league_id,
    OverallPick = overall_pick,
    RoundNum = round_num,
    RoundPick = round_pick,
    Season = season,
    TeamID = team_id,
    TopX = top_x
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft history data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
