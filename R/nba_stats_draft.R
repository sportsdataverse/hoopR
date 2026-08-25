#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftcombinestats
#' @name nba_draftboard
NULL
#' @title
#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param season season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Picks, TeamsWithoutPicks, LiveDetails
#'
#'    **Picks**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       pick_number \tab integer \tab Pick number. \cr
#'       pick_details \tab character \tab Pick details. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_type \tab character \tab Team type. \cr
#'       team_season \tab integer \tab Team season. \cr
#'       team_team_id \tab integer \tab Unique identifier for team team. \cr
#'       team_permalink \tab character \tab Team permalink. \cr
#'       team_app_url \tab character \tab URL for team app. \cr
#'       team_trade_details \tab list \tab Team trade details. \cr
#'       team_team_name \tab character \tab Team team name. \cr
#'       team_team_abbr \tab character \tab Team team abbr. \cr
#'       team_picked_first_round \tab logical \tab Team picked first round. \cr
#'       team_picked_second_round \tab logical \tab Team picked second round. \cr
#'       team_team_record_season \tab character \tab Team team record season. \cr
#'       team_team_record_wins_and_losses \tab character \tab Team team record wins and losses. \cr
#'       team_team_record_season_finish \tab character \tab Team team record season finish. \cr
#'       team_team_record_playoffs_finish \tab character \tab Team team record playoffs finish. \cr
#'       prospect_id \tab integer \tab Unique identifier for prospect. \cr
#'       prospect_type \tab character \tab Prospect type. \cr
#'       prospect_season \tab integer \tab Prospect season. \cr
#'       prospect_display_name \tab character \tab Prospect display name. \cr
#'       prospect_first_name \tab character \tab Prospect first name. \cr
#'       prospect_last_name \tab character \tab Prospect last name. \cr
#'       prospect_permalink \tab character \tab Prospect permalink. \cr
#'       prospect_app_url \tab character \tab URL for prospect app. \cr
#'       prospect_position \tab character \tab Prospect position. \cr
#'       prospect_weight_lbs \tab integer \tab Prospect weight lbs. \cr
#'       prospect_school \tab character \tab Prospect school. \cr
#'       prospect_status \tab character \tab Prospect status. \cr
#'       prospect_birthday \tab character \tab Prospect birthday. \cr
#'       prospect_country \tab character \tab Prospect country. \cr
#'       prospect_trade_details \tab list \tab Prospect trade details. \cr
#'       prospect_height_feet_and_inches \tab character \tab Prospect height feet and inches. \cr
#'       prospect_height_inches_only \tab integer \tab Prospect height inches only. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamsWithoutPicks**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Id. \cr
#'       type \tab character \tab Record type / category. \cr
#'       season \tab integer \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_record \tab data.frame \tab Team record string (e.g. '8-3' or '8-3 Overall'). \cr
#'       permalink \tab character \tab Permalink. \cr
#'       app_url \tab character \tab URL for app. \cr
#'       trade_details \tab list \tab Trade details. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_abbr \tab character \tab Team abbr. \cr
#'       picked_second_round \tab logical \tab Picked second round. \cr
#'       picked_first_round \tab logical \tab Picked first round. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **LiveDetails**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       is_draft_live \tab logical \tab Is draft live. \cr
#'       live_draft_current_pick_number \tab numeric \tab Live draft current pick number. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftboard"
  endpoint <- sprintf("https://content-api-prod.nba.com/public/1/leagues/nba/draft/%s/board", season)
  full_url <- endpoint

  params <- list()

  df_list <- list()

  tryCatch(
    expr = {
      res <- .retry_request(full_url, params = params)
      resp <- res %>%
        .resp_text() %>%
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
      names(df_list) <- c("Picks", "TeamsWithoutPicks", "LiveDetails")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft board data available for {season}!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       SEASON \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       HEIGHT_WO_SHOES \tab character \tab  \cr
#'       HEIGHT_WO_SHOES_FT_IN \tab character \tab  \cr
#'       HEIGHT_W_SHOES \tab character \tab  \cr
#'       HEIGHT_W_SHOES_FT_IN \tab character \tab  \cr
#'       WEIGHT \tab character \tab Player weight in pounds. \cr
#'       WINGSPAN \tab character \tab  \cr
#'       WINGSPAN_FT_IN \tab character \tab  \cr
#'       STANDING_REACH \tab character \tab  \cr
#'       STANDING_REACH_FT_IN \tab character \tab  \cr
#'       BODY_FAT_PCT \tab character \tab  \cr
#'       HAND_LENGTH \tab character \tab  \cr
#'       HAND_WIDTH \tab character \tab  \cr
#'       STANDING_VERTICAL_LEAP \tab character \tab  \cr
#'       MAX_VERTICAL_LEAP \tab character \tab  \cr
#'       LANE_AGILITY_TIME \tab character \tab  \cr
#'       MODIFIED_LANE_AGILITY_TIME \tab character \tab  \cr
#'       THREE_QUARTER_SPRINT \tab character \tab  \cr
#'       BENCH_PRESS \tab character \tab  \cr
#'       SPOT_FIFTEEN_CORNER_LEFT \tab character \tab  \cr
#'       SPOT_FIFTEEN_BREAK_LEFT \tab character \tab  \cr
#'       SPOT_FIFTEEN_TOP_KEY \tab character \tab  \cr
#'       SPOT_FIFTEEN_BREAK_RIGHT \tab character \tab  \cr
#'       SPOT_FIFTEEN_CORNER_RIGHT \tab character \tab  \cr
#'       SPOT_COLLEGE_CORNER_LEFT \tab character \tab  \cr
#'       SPOT_COLLEGE_BREAK_LEFT \tab character \tab  \cr
#'       SPOT_COLLEGE_TOP_KEY \tab character \tab  \cr
#'       SPOT_COLLEGE_BREAK_RIGHT \tab character \tab  \cr
#'       SPOT_COLLEGE_CORNER_RIGHT \tab character \tab  \cr
#'       SPOT_NBA_CORNER_LEFT \tab character \tab  \cr
#'       SPOT_NBA_BREAK_LEFT \tab character \tab  \cr
#'       SPOT_NBA_TOP_KEY \tab character \tab  \cr
#'       SPOT_NBA_BREAK_RIGHT \tab character \tab  \cr
#'       SPOT_NBA_CORNER_RIGHT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_LEFT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_TOP_KEY \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_RIGHT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_LEFT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_TOP_KEY \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_RIGHT \tab character \tab  \cr
#'       ON_MOVE_FIFTEEN \tab character \tab  \cr
#'       ON_MOVE_COLLEGE \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinestats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine stats data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Drill Results**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEMP_PLAYER_ID \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       STANDING_VERTICAL_LEAP \tab character \tab  \cr
#'       MAX_VERTICAL_LEAP \tab character \tab  \cr
#'       LANE_AGILITY_TIME \tab character \tab  \cr
#'       MODIFIED_LANE_AGILITY_TIME \tab character \tab  \cr
#'       THREE_QUARTER_SPRINT \tab character \tab  \cr
#'       BENCH_PRESS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinedrillresults"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine drill results data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEMP_PLAYER_ID \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_TOP_KEY_MADE \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_TOP_KEY_PCT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_LEFT_MADE \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_LEFT_PCT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_TOP_KEY_MADE \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_TOP_KEY_PCT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT \tab character \tab  \cr
#'       OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT \tab character \tab  \cr
#'       ON_MOVE_FIFTEEN_MADE \tab character \tab  \cr
#'       ON_MOVE_FIFTEEN_ATTEMPT \tab character \tab  \cr
#'       ON_MOVE_FIFTEEN_PCT \tab character \tab  \cr
#'       ON_MOVE_COLLEGE_MADE \tab character \tab  \cr
#'       ON_MOVE_COLLEGE_ATTEMPT \tab character \tab  \cr
#'       ON_MOVE_COLLEGE_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinenonstationaryshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine stationary shooting data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEMP_PLAYER_ID \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       HEIGHT_WO_SHOES \tab character \tab  \cr
#'       HEIGHT_WO_SHOES_FT_IN \tab character \tab  \cr
#'       HEIGHT_W_SHOES \tab character \tab  \cr
#'       HEIGHT_W_SHOES_FT_IN \tab character \tab  \cr
#'       WEIGHT \tab character \tab Player weight in pounds. \cr
#'       WINGSPAN \tab character \tab  \cr
#'       WINGSPAN_FT_IN \tab character \tab  \cr
#'       STANDING_REACH \tab character \tab  \cr
#'       STANDING_REACH_FT_IN \tab character \tab  \cr
#'       BODY_FAT_PCT \tab character \tab  \cr
#'       HAND_LENGTH \tab character \tab  \cr
#'       HAND_WIDTH \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombineplayeranthro"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine player anthropological data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#'
#'    **Results**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEMP_PLAYER_ID \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       FIFTEEN_CORNER_LEFT_MADE \tab character \tab  \cr
#'       FIFTEEN_CORNER_LEFT_ATTEMPT \tab character \tab  \cr
#'       FIFTEEN_CORNER_LEFT_PCT \tab character \tab  \cr
#'       FIFTEEN_BREAK_LEFT_MADE \tab character \tab  \cr
#'       FIFTEEN_BREAK_LEFT_ATTEMPT \tab character \tab  \cr
#'       FIFTEEN_BREAK_LEFT_PCT \tab character \tab  \cr
#'       FIFTEEN_TOP_KEY_MADE \tab character \tab  \cr
#'       FIFTEEN_TOP_KEY_ATTEMPT \tab character \tab  \cr
#'       FIFTEEN_TOP_KEY_PCT \tab character \tab  \cr
#'       FIFTEEN_BREAK_RIGHT_MADE \tab character \tab  \cr
#'       FIFTEEN_BREAK_RIGHT_ATTEMPT \tab character \tab  \cr
#'       FIFTEEN_BREAK_RIGHT_PCT \tab character \tab  \cr
#'       FIFTEEN_CORNER_RIGHT_MADE \tab character \tab  \cr
#'       FIFTEEN_CORNER_RIGHT_ATTEMPT \tab character \tab  \cr
#'       FIFTEEN_CORNER_RIGHT_PCT \tab character \tab  \cr
#'       COLLEGE_CORNER_LEFT_MADE \tab character \tab  \cr
#'       COLLEGE_CORNER_LEFT_ATTEMPT \tab character \tab  \cr
#'       COLLEGE_CORNER_LEFT_PCT \tab character \tab  \cr
#'       COLLEGE_BREAK_LEFT_MADE \tab character \tab  \cr
#'       COLLEGE_BREAK_LEFT_ATTEMPT \tab character \tab  \cr
#'       COLLEGE_BREAK_LEFT_PCT \tab character \tab  \cr
#'       COLLEGE_TOP_KEY_MADE \tab character \tab  \cr
#'       COLLEGE_TOP_KEY_ATTEMPT \tab character \tab  \cr
#'       COLLEGE_TOP_KEY_PCT \tab character \tab  \cr
#'       COLLEGE_BREAK_RIGHT_MADE \tab character \tab  \cr
#'       COLLEGE_BREAK_RIGHT_ATTEMPT \tab character \tab  \cr
#'       COLLEGE_BREAK_RIGHT_PCT \tab character \tab  \cr
#'       COLLEGE_CORNER_RIGHT_MADE \tab character \tab  \cr
#'       COLLEGE_CORNER_RIGHT_ATTEMPT \tab character \tab  \cr
#'       COLLEGE_CORNER_RIGHT_PCT \tab character \tab  \cr
#'       NBA_CORNER_LEFT_MADE \tab character \tab  \cr
#'       NBA_CORNER_LEFT_ATTEMPT \tab character \tab  \cr
#'       NBA_CORNER_LEFT_PCT \tab character \tab  \cr
#'       NBA_BREAK_LEFT_MADE \tab character \tab  \cr
#'       NBA_BREAK_LEFT_ATTEMPT \tab character \tab  \cr
#'       NBA_BREAK_LEFT_PCT \tab character \tab  \cr
#'       NBA_TOP_KEY_MADE \tab character \tab  \cr
#'       NBA_TOP_KEY_ATTEMPT \tab character \tab  \cr
#'       NBA_TOP_KEY_PCT \tab character \tab  \cr
#'       NBA_BREAK_RIGHT_MADE \tab character \tab  \cr
#'       NBA_BREAK_RIGHT_ATTEMPT \tab character \tab  \cr
#'       NBA_BREAK_RIGHT_PCT \tab character \tab  \cr
#'       NBA_CORNER_RIGHT_MADE \tab character \tab  \cr
#'       NBA_CORNER_RIGHT_ATTEMPT \tab character \tab  \cr
#'       NBA_CORNER_RIGHT_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinespotshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine spot shooting data available for {season_year}!",
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
#' **Get NBA Stats API Draft History**
#' @rdname nba_draftcombinestats
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       SEASON \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       ROUND_NUMBER \tab character \tab Numeric round. \cr
#'       ROUND_PICK \tab character \tab  \cr
#'       OVERALL_PICK \tab character \tab  \cr
#'       DRAFT_TYPE \tab character \tab  \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       ORGANIZATION \tab character \tab  \cr
#'       ORGANIZATION_TYPE \tab character \tab  \cr
#'       PLAYER_PROFILE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    college = "",
    overall_pick = "",
    round_pick = "",
    round_num = "",
    season = most_recent_nba_season() - 1,
    team_id = "",
    top_x = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "drafthistory"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    OverallPick = overall_pick,
    RoundNum = round_num,
    RoundPick = round_pick,
    Season = season,
    TeamID = team_id,
    TopX = top_x
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft history data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
