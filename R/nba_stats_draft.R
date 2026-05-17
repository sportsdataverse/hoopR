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
#'    |col_name                         |types     |description                       |
#'    |:--------------------------------|:---------|:---------------------------------|
#'    |pick_number                      |integer   |Pick number.                      |
#'    |pick_details                     |character |Pick details.                     |
#'    |team_id                          |integer   |Unique team identifier.           |
#'    |team_type                        |character |Team type.                        |
#'    |team_season                      |integer   |Team season.                      |
#'    |team_team_id                     |integer   |Unique identifier for team team.  |
#'    |team_permalink                   |character |Team permalink.                   |
#'    |team_app_url                     |character |URL for team app.                 |
#'    |team_trade_details               |list      |Team trade details.               |
#'    |team_team_name                   |character |Team team name.                   |
#'    |team_team_abbr                   |character |Team team abbr.                   |
#'    |team_picked_first_round          |logical   |Team picked first round.          |
#'    |team_picked_second_round         |logical   |Team picked second round.         |
#'    |team_team_record_season          |character |Team team record season.          |
#'    |team_team_record_wins_and_losses |character |Team team record wins and losses. |
#'    |team_team_record_season_finish   |character |Team team record season finish.   |
#'    |team_team_record_playoffs_finish |character |Team team record playoffs finish. |
#'    |prospect_id                      |integer   |Unique identifier for prospect.   |
#'    |prospect_type                    |character |Prospect type.                    |
#'    |prospect_season                  |integer   |Prospect season.                  |
#'    |prospect_display_name            |character |Prospect display name.            |
#'    |prospect_first_name              |character |Prospect first name.              |
#'    |prospect_last_name               |character |Prospect last name.               |
#'    |prospect_permalink               |character |Prospect permalink.               |
#'    |prospect_app_url                 |character |URL for prospect app.             |
#'    |prospect_position                |character |Prospect position.                |
#'    |prospect_weight_lbs              |integer   |Prospect weight lbs.              |
#'    |prospect_school                  |character |Prospect school.                  |
#'    |prospect_status                  |character |Prospect status.                  |
#'    |prospect_birthday                |character |Prospect birthday.                |
#'    |prospect_country                 |character |Prospect country.                 |
#'    |prospect_trade_details           |list      |Prospect trade details.           |
#'    |prospect_height_feet_and_inches  |character |Prospect height feet and inches.  |
#'    |prospect_height_inches_only      |integer   |Prospect height inches only.      |
#'
#'    **TeamsWithoutPicks**
#'
#'
#'    |col_name            |types      |description                                           |
#'    |:-------------------|:----------|:-----------------------------------------------------|
#'    |id                  |integer    |Id.                                                   |
#'    |type                |character  |Record type / category.                               |
#'    |season              |integer    |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |team_id             |integer    |Unique team identifier.                               |
#'    |team_record         |data.frame |Team record string (e.g. '8-3' or '8-3 Overall').     |
#'    |permalink           |character  |Permalink.                                            |
#'    |app_url             |character  |URL for app.                                          |
#'    |trade_details       |list       |Trade details.                                        |
#'    |team_name           |character  |Full team display name (e.g. 'Las Vegas Aces').       |
#'    |team_abbr           |character  |Team abbr.                                            |
#'    |picked_second_round |logical    |Picked second round.                                  |
#'    |picked_first_round  |logical    |Picked first round.                                   |
#'
#'    **LiveDetails**
#'
#'
#'    |col_name                       |types   |description                     |
#'    |:------------------------------|:-------|:-------------------------------|
#'    |is_draft_live                  |logical |Is draft live.                  |
#'    |live_draft_current_pick_number |numeric |Live draft current pick number. |
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
#'    |col_name                     |types     |description                                           |
#'    |:----------------------------|:---------|:-----------------------------------------------------|
#'    |SEASON                       |character |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |PLAYER_ID                    |character |Unique player identifier.                             |
#'    |FIRST_NAME                   |character |Player's first name.                                  |
#'    |LAST_NAME                    |character |Player's last name.                                   |
#'    |PLAYER_NAME                  |character |Player name.                                          |
#'    |POSITION                     |character |Listed roster position (G, F, C, etc.).               |
#'    |HEIGHT_WO_SHOES              |character |                                                      |
#'    |HEIGHT_WO_SHOES_FT_IN        |character |                                                      |
#'    |HEIGHT_W_SHOES               |character |                                                      |
#'    |HEIGHT_W_SHOES_FT_IN         |character |                                                      |
#'    |WEIGHT                       |character |Player weight in pounds.                              |
#'    |WINGSPAN                     |character |                                                      |
#'    |WINGSPAN_FT_IN               |character |                                                      |
#'    |STANDING_REACH               |character |                                                      |
#'    |STANDING_REACH_FT_IN         |character |                                                      |
#'    |BODY_FAT_PCT                 |character |                                                      |
#'    |HAND_LENGTH                  |character |                                                      |
#'    |HAND_WIDTH                   |character |                                                      |
#'    |STANDING_VERTICAL_LEAP       |character |                                                      |
#'    |MAX_VERTICAL_LEAP            |character |                                                      |
#'    |LANE_AGILITY_TIME            |character |                                                      |
#'    |MODIFIED_LANE_AGILITY_TIME   |character |                                                      |
#'    |THREE_QUARTER_SPRINT         |character |                                                      |
#'    |BENCH_PRESS                  |character |                                                      |
#'    |SPOT_FIFTEEN_CORNER_LEFT     |character |                                                      |
#'    |SPOT_FIFTEEN_BREAK_LEFT      |character |                                                      |
#'    |SPOT_FIFTEEN_TOP_KEY         |character |                                                      |
#'    |SPOT_FIFTEEN_BREAK_RIGHT     |character |                                                      |
#'    |SPOT_FIFTEEN_CORNER_RIGHT    |character |                                                      |
#'    |SPOT_COLLEGE_CORNER_LEFT     |character |                                                      |
#'    |SPOT_COLLEGE_BREAK_LEFT      |character |                                                      |
#'    |SPOT_COLLEGE_TOP_KEY         |character |                                                      |
#'    |SPOT_COLLEGE_BREAK_RIGHT     |character |                                                      |
#'    |SPOT_COLLEGE_CORNER_RIGHT    |character |                                                      |
#'    |SPOT_NBA_CORNER_LEFT         |character |                                                      |
#'    |SPOT_NBA_BREAK_LEFT          |character |                                                      |
#'    |SPOT_NBA_TOP_KEY             |character |                                                      |
#'    |SPOT_NBA_BREAK_RIGHT         |character |                                                      |
#'    |SPOT_NBA_CORNER_RIGHT        |character |                                                      |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT  |character |                                                      |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY     |character |                                                      |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT |character |                                                      |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT  |character |                                                      |
#'    |OFF_DRIB_COLLEGE_TOP_KEY     |character |                                                      |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT |character |                                                      |
#'    |ON_MOVE_FIFTEEN              |character |                                                      |
#'    |ON_MOVE_COLLEGE              |character |                                                      |
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
#'    |col_name                   |types     |description                             |
#'    |:--------------------------|:---------|:---------------------------------------|
#'    |TEMP_PLAYER_ID             |character |                                        |
#'    |PLAYER_ID                  |character |Unique player identifier.               |
#'    |FIRST_NAME                 |character |Player's first name.                    |
#'    |LAST_NAME                  |character |Player's last name.                     |
#'    |PLAYER_NAME                |character |Player name.                            |
#'    |POSITION                   |character |Listed roster position (G, F, C, etc.). |
#'    |STANDING_VERTICAL_LEAP     |character |                                        |
#'    |MAX_VERTICAL_LEAP          |character |                                        |
#'    |LANE_AGILITY_TIME          |character |                                        |
#'    |MODIFIED_LANE_AGILITY_TIME |character |                                        |
#'    |THREE_QUARTER_SPRINT       |character |                                        |
#'    |BENCH_PRESS                |character |                                        |
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
#'    |col_name                             |types     |description                             |
#'    |:------------------------------------|:---------|:---------------------------------------|
#'    |TEMP_PLAYER_ID                       |character |                                        |
#'    |PLAYER_ID                            |character |Unique player identifier.               |
#'    |FIRST_NAME                           |character |Player's first name.                    |
#'    |LAST_NAME                            |character |Player's last name.                     |
#'    |PLAYER_NAME                          |character |Player name.                            |
#'    |POSITION                             |character |Listed roster position (G, F, C, etc.). |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE     |character |                                        |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT  |character |                                        |
#'    |OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT      |character |                                        |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_MADE        |character |                                        |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT     |character |                                        |
#'    |OFF_DRIB_FIFTEEN_TOP_KEY_PCT         |character |                                        |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE    |character |                                        |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT |character |                                        |
#'    |OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT     |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_MADE     |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT  |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_LEFT_PCT      |character |                                        |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_MADE        |character |                                        |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT     |character |                                        |
#'    |OFF_DRIB_COLLEGE_TOP_KEY_PCT         |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE    |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT |character |                                        |
#'    |OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT     |character |                                        |
#'    |ON_MOVE_FIFTEEN_MADE                 |character |                                        |
#'    |ON_MOVE_FIFTEEN_ATTEMPT              |character |                                        |
#'    |ON_MOVE_FIFTEEN_PCT                  |character |                                        |
#'    |ON_MOVE_COLLEGE_MADE                 |character |                                        |
#'    |ON_MOVE_COLLEGE_ATTEMPT              |character |                                        |
#'    |ON_MOVE_COLLEGE_PCT                  |character |                                        |
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
#'    |col_name              |types     |description                             |
#'    |:---------------------|:---------|:---------------------------------------|
#'    |TEMP_PLAYER_ID        |character |                                        |
#'    |PLAYER_ID             |character |Unique player identifier.               |
#'    |FIRST_NAME            |character |Player's first name.                    |
#'    |LAST_NAME             |character |Player's last name.                     |
#'    |PLAYER_NAME           |character |Player name.                            |
#'    |POSITION              |character |Listed roster position (G, F, C, etc.). |
#'    |HEIGHT_WO_SHOES       |character |                                        |
#'    |HEIGHT_WO_SHOES_FT_IN |character |                                        |
#'    |HEIGHT_W_SHOES        |character |                                        |
#'    |HEIGHT_W_SHOES_FT_IN  |character |                                        |
#'    |WEIGHT                |character |Player weight in pounds.                |
#'    |WINGSPAN              |character |                                        |
#'    |WINGSPAN_FT_IN        |character |                                        |
#'    |STANDING_REACH        |character |                                        |
#'    |STANDING_REACH_FT_IN  |character |                                        |
#'    |BODY_FAT_PCT          |character |                                        |
#'    |HAND_LENGTH           |character |                                        |
#'    |HAND_WIDTH            |character |                                        |
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
#'    |col_name                     |types     |description                             |
#'    |:----------------------------|:---------|:---------------------------------------|
#'    |TEMP_PLAYER_ID               |character |                                        |
#'    |PLAYER_ID                    |character |Unique player identifier.               |
#'    |FIRST_NAME                   |character |Player's first name.                    |
#'    |LAST_NAME                    |character |Player's last name.                     |
#'    |PLAYER_NAME                  |character |Player name.                            |
#'    |POSITION                     |character |Listed roster position (G, F, C, etc.). |
#'    |FIFTEEN_CORNER_LEFT_MADE     |character |                                        |
#'    |FIFTEEN_CORNER_LEFT_ATTEMPT  |character |                                        |
#'    |FIFTEEN_CORNER_LEFT_PCT      |character |                                        |
#'    |FIFTEEN_BREAK_LEFT_MADE      |character |                                        |
#'    |FIFTEEN_BREAK_LEFT_ATTEMPT   |character |                                        |
#'    |FIFTEEN_BREAK_LEFT_PCT       |character |                                        |
#'    |FIFTEEN_TOP_KEY_MADE         |character |                                        |
#'    |FIFTEEN_TOP_KEY_ATTEMPT      |character |                                        |
#'    |FIFTEEN_TOP_KEY_PCT          |character |                                        |
#'    |FIFTEEN_BREAK_RIGHT_MADE     |character |                                        |
#'    |FIFTEEN_BREAK_RIGHT_ATTEMPT  |character |                                        |
#'    |FIFTEEN_BREAK_RIGHT_PCT      |character |                                        |
#'    |FIFTEEN_CORNER_RIGHT_MADE    |character |                                        |
#'    |FIFTEEN_CORNER_RIGHT_ATTEMPT |character |                                        |
#'    |FIFTEEN_CORNER_RIGHT_PCT     |character |                                        |
#'    |COLLEGE_CORNER_LEFT_MADE     |character |                                        |
#'    |COLLEGE_CORNER_LEFT_ATTEMPT  |character |                                        |
#'    |COLLEGE_CORNER_LEFT_PCT      |character |                                        |
#'    |COLLEGE_BREAK_LEFT_MADE      |character |                                        |
#'    |COLLEGE_BREAK_LEFT_ATTEMPT   |character |                                        |
#'    |COLLEGE_BREAK_LEFT_PCT       |character |                                        |
#'    |COLLEGE_TOP_KEY_MADE         |character |                                        |
#'    |COLLEGE_TOP_KEY_ATTEMPT      |character |                                        |
#'    |COLLEGE_TOP_KEY_PCT          |character |                                        |
#'    |COLLEGE_BREAK_RIGHT_MADE     |character |                                        |
#'    |COLLEGE_BREAK_RIGHT_ATTEMPT  |character |                                        |
#'    |COLLEGE_BREAK_RIGHT_PCT      |character |                                        |
#'    |COLLEGE_CORNER_RIGHT_MADE    |character |                                        |
#'    |COLLEGE_CORNER_RIGHT_ATTEMPT |character |                                        |
#'    |COLLEGE_CORNER_RIGHT_PCT     |character |                                        |
#'    |NBA_CORNER_LEFT_MADE         |character |                                        |
#'    |NBA_CORNER_LEFT_ATTEMPT      |character |                                        |
#'    |NBA_CORNER_LEFT_PCT          |character |                                        |
#'    |NBA_BREAK_LEFT_MADE          |character |                                        |
#'    |NBA_BREAK_LEFT_ATTEMPT       |character |                                        |
#'    |NBA_BREAK_LEFT_PCT           |character |                                        |
#'    |NBA_TOP_KEY_MADE             |character |                                        |
#'    |NBA_TOP_KEY_ATTEMPT          |character |                                        |
#'    |NBA_TOP_KEY_PCT              |character |                                        |
#'    |NBA_BREAK_RIGHT_MADE         |character |                                        |
#'    |NBA_BREAK_RIGHT_ATTEMPT      |character |                                        |
#'    |NBA_BREAK_RIGHT_PCT          |character |                                        |
#'    |NBA_CORNER_RIGHT_MADE        |character |                                        |
#'    |NBA_CORNER_RIGHT_ATTEMPT     |character |                                        |
#'    |NBA_CORNER_RIGHT_PCT         |character |                                        |
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
#'    |col_name            |types     |description                                           |
#'    |:-------------------|:---------|:-----------------------------------------------------|
#'    |PERSON_ID           |character |Unique player identifier (V3 endpoints).              |
#'    |PLAYER_NAME         |character |Player name.                                          |
#'    |SEASON              |character |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |ROUND_NUMBER        |character |Numeric round.                                        |
#'    |ROUND_PICK          |character |                                                      |
#'    |OVERALL_PICK        |character |                                                      |
#'    |DRAFT_TYPE          |character |                                                      |
#'    |TEAM_ID             |character |Unique team identifier.                               |
#'    |TEAM_CITY           |character |Team city or region (e.g. 'Las Vegas').               |
#'    |TEAM_NAME           |character |Full team display name (e.g. 'Las Vegas Aces').       |
#'    |TEAM_ABBREVIATION   |character |Short team abbreviation (e.g. 'LAS').                 |
#'    |ORGANIZATION        |character |                                                      |
#'    |ORGANIZATION_TYPE   |character |                                                      |
#'    |PLAYER_PROFILE_FLAG |character |                                                      |
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
    College = college,
    LeagueID = league_id,
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
