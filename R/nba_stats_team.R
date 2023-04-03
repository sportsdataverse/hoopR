#' **Get NBA Stats API Teams**
#' @name nba_teams
NULL
#' @title
#' **Get NBA Stats API Teams**
#' @rdname nba_teams
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a data frame with the following columns:
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |league_id         |character |
#'    |season_id         |character |
#'    |team_id           |character |
#'    |team_city         |character |
#'    |team_name         |character |
#'    |team_slug         |character |
#'    |conference        |character |
#'    |division          |character |
#'    |team_abbreviation |character |
#'    |team_name_full    |character |
#'    |season            |character |
#'    |espn_team_id      |integer   |
#'    |abbreviation      |character |
#'    |display_name      |character |
#'    |mascot            |character |
#'    |nickname          |character |
#'    |team              |character |
#'    |color             |character |
#'    |alternate_color   |character |
#'    |logo              |character |
#'    |logo_dark         |character |
#'    |logos_href_3      |character |
#'    |logos_href_4      |character |
#'    |nba_logo_svg      |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teams()
#' ```
nba_teams <- function(...){

  tryCatch(
    expr = {

      standings <- nba_leaguestandingsv3(season = year_to_season(most_recent_nba_season() - 1), ...) %>%
        purrr::pluck("Standings")

      league_gamelog <- nba_leaguegamelog(league_id = '00',
                                           season = year_to_season(most_recent_nba_season() - 1), ...) %>%
        purrr::pluck("LeagueGameLog") %>%
        dplyr::rename("team_name_full" = "TEAM_NAME") %>%
        dplyr::select(
          "TEAM_ID",
          "TEAM_ABBREVIATION",
          "team_name_full") %>%
        dplyr::distinct()

      standings <- standings %>%
        dplyr::left_join(league_gamelog, by = c("TeamID" = "TEAM_ID"))

      nba_teams <- standings %>%
        dplyr::select(dplyr::any_of(c(
          "LeagueID",
          "SeasonID",
          "TeamID",
          "TeamCity",
          "TeamName",
          "TeamSlug",
          "Conference",
          "Division",
          "TEAM_ABBREVIATION",
          "team_name_full"))) %>%
        dplyr::mutate(
          Season = paste0('', year_to_season(most_recent_nba_season() - 1))) %>%
        dplyr::arrange(.data$team_name_full)

      espn_nba_teams <- espn_nba_teams() %>%
        dplyr::rename("espn_team_id" = "team_id")
      nba_teams <- nba_teams %>%
        dplyr::left_join(espn_nba_teams, by = c("TeamName" = "short_name"))

      nba_teams <- nba_teams %>%
        dplyr::mutate(
          espn_team_id = as.integer(.data$espn_team_id),
          nba_logo_svg = paste0("https://cdn.nba.com/logos/nba/", .data$TeamID, "/primary/L/logo.svg")) %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team details data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(nba_teams)
}


#' **Get NBA Stats API Team Details**
#' @name nba_teamdetails
NULL
#' @title
#' **Get NBA Stats API Team Details**
#' @rdname nba_teamdetails
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamAwardsChampionships,
#' TeamAwardsConf, TeamAwardsDiv, TeamBackground,
#' TeamHistory, TeamHof, TeamRetired, TeamSocialSites
#'
#'    **TeamBackground**
#'
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |TEAM_ID            |character |
#'    |ABBREVIATION       |character |
#'    |NICKNAME           |character |
#'    |YEARFOUNDED        |character |
#'    |CITY               |character |
#'    |ARENA              |character |
#'    |ARENACAPACITY      |character |
#'    |OWNER              |character |
#'    |GENERALMANAGER     |character |
#'    |HEADCOACH          |character |
#'    |DLEAGUEAFFILIATION |character |
#'
#'    **TeamHistory**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |TEAM_ID        |character |
#'    |CITY           |character |
#'    |NICKNAME       |character |
#'    |YEARFOUNDED    |character |
#'    |YEARACTIVETILL |character |
#'
#'    **TeamSocialSites**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |ACCOUNTTYPE  |character |
#'    |WEBSITE_LINK |character |
#'
#'    **TeamAwardsChampionships**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |YEARAWARDED  |character |
#'    |OPPOSITETEAM |character |
#'
#'    **TeamAwardsConf**
#'
#'
#'    |col_name     |types   |
#'    |:------------|:-------|
#'    |YEARAWARDED  |integer |
#'    |OPPOSITETEAM |integer |
#'
#'    **TeamAwardsDiv**
#'
#'
#'    |col_name     |types   |
#'    |:------------|:-------|
#'    |YEARAWARDED  |integer |
#'    |OPPOSITETEAM |integer |
#'
#'    **TeamHof**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |PLAYERID        |character |
#'    |PLAYER          |character |
#'    |POSITION        |character |
#'    |JERSEY          |character |
#'    |SEASONSWITHTEAM |character |
#'    |YEAR            |character |
#'
#'    **TeamRetired**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |PLAYERID        |character |
#'    |PLAYER          |character |
#'    |POSITION        |character |
#'    |JERSEY          |character |
#'    |SEASONSWITHTEAM |character |
#'    |YEAR            |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamdetails(team_id = '1610612749')
#' ```
nba_teamdetails <- function(
    team_id = '1610612749',
    ...){

  version <- "teamdetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team details data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Estimated Metrics**
#' @name nba_teamestimatedmetrics
NULL
#' @title
#' **Get NBA Stats API Team Estimated Metrics**
#' @rdname nba_teamestimatedmetrics
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamEstimatedMetrics
#'
#'    **TeamEstimatedMetrics**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |TEAM_NAME         |character |
#'    |TEAM_ID           |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |E_OFF_RATING      |character |
#'    |E_DEF_RATING      |character |
#'    |E_NET_RATING      |character |
#'    |E_PACE            |character |
#'    |E_AST_RATIO       |character |
#'    |E_OREB_PCT        |character |
#'    |E_DREB_PCT        |character |
#'    |E_REB_PCT         |character |
#'    |E_TM_TOV_PCT      |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |E_OFF_RATING_RANK |character |
#'    |E_DEF_RATING_RANK |character |
#'    |E_NET_RATING_RANK |character |
#'    |E_AST_RATIO_RANK  |character |
#'    |E_OREB_PCT_RANK   |character |
#'    |E_DREB_PCT_RANK   |character |
#'    |E_REB_PCT_RANK    |character |
#'    |E_TM_TOV_PCT_RANK |character |
#'    |E_PACE_RANK       |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Estimated Metrics](https://www.nba.com/stats/teams/estimated-advanced)
#' ```r
#'  nba_teamestimatedmetrics()
#' ```
nba_teamestimatedmetrics <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamestimatedmetrics"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team estimated metrics data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API Team Game Log**
#' @name nba_teamgamelog
NULL
#' @title
#' **Get NBA Stats API Team Game Log**
#' @rdname nba_teamgamelog
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param team_id Team ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamGameLog
#'
#'    **TeamGameLog**
#'
#'
#'    |col_name  |types     |
#'    |:---------|:---------|
#'    |Team_ID   |character |
#'    |Game_ID   |character |
#'    |GAME_DATE |character |
#'    |MATCHUP   |character |
#'    |WL        |character |
#'    |W         |character |
#'    |L         |character |
#'    |W_PCT     |character |
#'    |MIN       |character |
#'    |FGM       |character |
#'    |FGA       |character |
#'    |FG_PCT    |character |
#'    |FG3M      |character |
#'    |FG3A      |character |
#'    |FG3_PCT   |character |
#'    |FTM       |character |
#'    |FTA       |character |
#'    |FT_PCT    |character |
#'    |OREB      |character |
#'    |DREB      |character |
#'    |REB       |character |
#'    |AST       |character |
#'    |STL       |character |
#'    |BLK       |character |
#'    |TOV       |character |
#'    |PF        |character |
#'    |PTS       |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Teams Game Log](https://www.nba.com/stats/team/1610612749/boxscores)
#' ```r
#'  nba_teamgamelog(team_id = '1610612749')
#' ```
nba_teamgamelog <- function(
    date_from = '',
    date_to = '',
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    team_id = '1610612749',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamelog"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team game log data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Game Logs**
#' @name nba_teamgamelogs
NULL
#' @title
#' **Get NBA Stats API Team Game Logs**
#' @rdname nba_teamgamelogs
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_id Player ID
#' @param season Season - format 2020-21
#' @param season_segment season_segment
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamGameLogs
#'
#'    **TeamGameLogs**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |SEASON_YEAR       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |GAME_ID           |character |
#'    |GAME_DATE         |character |
#'    |MATCHUP           |character |
#'    |WL                |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Teams Game Log](https://www.nba.com/stats/team/1610612749/boxscores)
#' ```r
#'  nba_teamgamelogs(team_id = '1610612749')
#' ```
nba_teamgamelogs <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    player_id = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamelogs"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team game logs for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Historical Leaders**
#' @name nba_teamhistoricalleaders
NULL
#' @title
#' **Get NBA Stats API Team Historical Leaders**
#' @rdname nba_teamhistoricalleaders
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_id season_id
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: CareerLeadersByTeam
#'
#'    **CareerLeadersByTeam**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |TEAM_ID       |character |
#'    |PTS           |character |
#'    |PTS_PERSON_ID |character |
#'    |PTS_PLAYER    |character |
#'    |AST           |character |
#'    |AST_PERSON_ID |character |
#'    |AST_PLAYER    |character |
#'    |REB           |character |
#'    |REB_PERSON_ID |character |
#'    |REB_PLAYER    |character |
#'    |BLK           |character |
#'    |BLK_PERSON_ID |character |
#'    |BLK_PLAYER    |character |
#'    |STL           |character |
#'    |STL_PERSON_ID |character |
#'    |STL_PLAYER    |character |
#'    |SEASON_YEAR   |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamhistoricalleaders(team_id = '1610612749')
#' ```
nba_teamhistoricalleaders <- function(
    league_id = '00',
    season_id = '22022',
    team_id = '1610612749',
    ...){

  version <- "teamhistoricalleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonID = season_id,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team historical leaders data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Common Info**
#' @name nba_teaminfocommon
NULL
#' @title
#' **Get NBA Stats API Team Common Info**
#' @rdname nba_teaminfocommon
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param team_id Team ID
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: AvailableSeasons, TeamInfoCommon,
#' TeamSeasonRanks
#'
#'    **TeamInfoCommon**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |TEAM_ID           |character |
#'    |SEASON_YEAR       |character |
#'    |TEAM_CITY         |character |
#'    |TEAM_NAME         |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_CONFERENCE   |character |
#'    |TEAM_DIVISION     |character |
#'    |TEAM_CODE         |character |
#'    |TEAM_SLUG         |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |PCT               |character |
#'    |CONF_RANK         |character |
#'    |DIV_RANK          |character |
#'    |MIN_YEAR          |character |
#'    |MAX_YEAR          |character |
#'
#'    **TeamSeasonRanks**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |LEAGUE_ID    |character |
#'    |SEASON_ID    |character |
#'    |TEAM_ID      |character |
#'    |PTS_RANK     |character |
#'    |PTS_PG       |character |
#'    |REB_RANK     |character |
#'    |REB_PG       |character |
#'    |AST_RANK     |character |
#'    |AST_PG       |character |
#'    |OPP_PTS_RANK |character |
#'    |OPP_PTS_PG   |character |
#'
#'    **AvailableSeasons**
#'
#'
#'    |col_name  |types     |
#'    |:---------|:---------|
#'    |SEASON_ID |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teaminfocommon(team_id = '1610612749')
#' ```
nba_teaminfocommon <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    team_id = '1610612749',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teaminfocommon"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team common info data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Player On/Off Details**
#' @name nba_teamplayeronoffdetails
NULL
#' @title
#' **Get NBA Stats API Team Player On/Off Details**
#' @rdname nba_teamplayeronoffdetails
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: OverallTeamPlayerOnOffDetails,
#' PlayersOffCourtTeamPlayerOnOffDetails, PlayersOnCourtTeamPlayerOnOffDetails
#'
#'    **OverallTeamPlayerOnOffDetails**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PlayersOnCourtTeamPlayerOnOffDetails**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PlayersOffCourtTeamPlayerOnOffDetails**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamplayeronoffdetails(team_id = '1610612749')
#' ```
nba_teamplayeronoffdetails <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayeronoffdetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team player on off details data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Player On/Off Summary**
#' @name nba_teamplayeronoffsummary
NULL
#' @title
#' **Get NBA Stats API Team Player On/Off Summary**
#' @rdname nba_teamplayeronoffsummary
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: OverallTeamPlayerOnOffSummary,
#' PlayersOffCourtTeamPlayerOnOffSummary, PlayersOnCourtTeamPlayerOnOffSummary
#'
#'    **OverallTeamPlayerOnOffSummary**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PlayersOnCourtTeamPlayerOnOffSummary**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GP                |character |
#'    |MIN               |character |
#'    |PLUS_MINUS        |character |
#'    |OFF_RATING        |character |
#'    |DEF_RATING        |character |
#'    |NET_RATING        |character |
#'
#'    **PlayersOffCourtTeamPlayerOnOffSummary**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GP                |character |
#'    |MIN               |character |
#'    |PLUS_MINUS        |character |
#'    |OFF_RATING        |character |
#'    |DEF_RATING        |character |
#'    |NET_RATING        |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamplayeronoffsummary(team_id = '1610612749')
#' ```
nba_teamplayeronoffsummary <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayeronoffsummary"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team player on off summary data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Player Dashboard**
#' @name nba_teamplayerdashboard
NULL
#' @title
#' **Get NBA Stats API Team Player Dashboard**
#' @rdname nba_teamplayerdashboard
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: PlayersSeasonTotals, TeamOverall
#'
#'    **TeamOverall**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |TEAM_ID         |character |
#'    |TEAM_NAME       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **PlayersSeasonTotals**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |PLAYER_ID             |character |
#'    |PLAYER_NAME           |character |
#'    |NICKNAME              |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamplayerdashboard(team_id = '1610612749')
#' ```
nba_teamplayerdashboard <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayerdashboard"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team player dashboard data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Year by Year Stats**
#' @name nba_teamyearbyyearstats
NULL
#' @title
#' **Get NBA Stats API Team Year by Year Stats**
#' @rdname nba_teamyearbyyearstats
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param per_mode Per Mode
#' @param team_id Team ID
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamStats
#'
#'    **TeamStats**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |TEAM_ID               |character |
#'    |TEAM_CITY             |character |
#'    |TEAM_NAME             |character |
#'    |YEAR                  |character |
#'    |GP                    |character |
#'    |WINS                  |character |
#'    |LOSSES                |character |
#'    |WIN_PCT               |character |
#'    |CONF_RANK             |character |
#'    |DIV_RANK              |character |
#'    |PO_WINS               |character |
#'    |PO_LOSSES             |character |
#'    |CONF_COUNT            |character |
#'    |DIV_COUNT             |character |
#'    |NBA_FINALS_APPEARANCE |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |PF                    |character |
#'    |STL                   |character |
#'    |TOV                   |character |
#'    |BLK                   |character |
#'    |PTS                   |character |
#'    |PTS_RANK              |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Year by Year Stats](https://www.nba.com/stats/team/1610612756/seasons)
#' ```r
#'  nba_teamyearbyyearstats(team_id = '1610612749')
#' ```
nba_teamyearbyyearstats <- function(
    league_id = '00',
    per_mode = 'Totals',
    season_type = 'Regular Season',
    team_id = '1610612749',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamyearbyyearstats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    SeasonType = season_type,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team year-by-year stats data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team vs Player**
#' @name nba_teamvsplayer
NULL
#' @title
#' **Get NBA Stats API Team vs Player**
#' @rdname nba_teamvsplayer
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id Player ID
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id vs_player_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: OnOffCourt, Overall, ShotAreaOffCourt,
#' ShotAreaOnCourt, ShotAreaOverall, ShotDistanceOffCourt, ShotDistanceOnCourt,
#' ShotDistanceOverall, vsPlayerOverall
#'
#'    **Overall**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **vsPlayerOverall**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |PLAYER_ID             |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **OnOffCourt**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **ShotDistanceOverall**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#'    **ShotDistanceOnCourt**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#'    **ShotDistanceOffCourt**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#'    **ShotAreaOverall**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#'    **ShotAreaOnCourt**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#'    **ShotAreaOffCourt**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |VS_PLAYER_ID      |character |
#'    |VS_PLAYER_NAME    |character |
#'    |COURT_STATUS      |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamvsplayer(team_id = '1610612749', vs_player_id = '2544')
#' ```
nba_teamvsplayer <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    vs_player_id = '2544',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamvsplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PaceAdjust = pace_adjust,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsPlayerID = vs_player_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team vs player data for {team_id} and {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}





#' **Get NBA Stats API Team Game Streak Finder**
#' @name nba_teamgamestreakfinder
NULL
#' @title
#' **Get NBA Stats API Team Game Streak Finder**
#' @rdname nba_teamgamestreakfinder
#' @author Saiem Gilani
#' @param active_streaks_only active_streaks_only
#' @param active_teams_only active_teams_only
#' @param btr_opp_ast btr_opp_ast
#' @param btr_opp_blk btr_opp_blk
#' @param btr_opp_dreb btr_opp_dreb
#' @param btr_opp_fg3a btr_opp_fg3a
#' @param btr_opp_fg3m btr_opp_fg3m
#' @param btr_opp_fg3_pct btr_opp_fg3_pct
#' @param btr_opp_fga btr_opp_fga
#' @param btr_opp_fgm btr_opp_fgm
#' @param btr_opp_fg_pct btr_opp_fg_pct
#' @param btr_opp_fta btr_opp_fta
#' @param btr_opp_ftm btr_opp_ftm
#' @param btr_opp_ft_pct btr_opp_ft_pct
#' @param btr_opp_oreb btr_opp_oreb
#' @param btr_opp_pf btr_opp_pf
#' @param btr_opp_pts btr_opp_pts
#' @param btr_opp_pts2nd_chance btr_opp_pts2nd_chance
#' @param btr_opp_pts_fb btr_opp_pts_fb
#' @param btr_opp_pts_off_tov btr_opp_pts_off_tov
#' @param btr_opp_pts_paint btr_opp_pts_paint
#' @param btr_opp_reb btr_opp_reb
#' @param btr_opp_stl btr_opp_stl
#' @param btr_opp_tov btr_opp_tov
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param et_ast et_ast
#' @param et_blk et_blk
#' @param et_dd et_dd
#' @param et_dreb et_dreb
#' @param et_fg3a et_fg3a
#' @param et_fg3m et_fg3m
#' @param et_fg3_pct et_fg3_pct
#' @param et_fga et_fga
#' @param et_fgm et_fgm
#' @param et_fg_pct et_fg_pct
#' @param et_fta et_fta
#' @param et_ftm et_ftm
#' @param et_ft_pct et_ft_pct
#' @param et_minutes et_minutes
#' @param eq_opp_pts2nd_chance eq_opp_pts2nd_chance
#' @param eq_opp_pts_fb eq_opp_pts_fb
#' @param eq_opp_pts_off_tov eq_opp_pts_off_tov
#' @param eq_opp_pts_paint eq_opp_pts_paint
#' @param et_oreb et_oreb
#' @param et_pf et_pf
#' @param et_pts et_pts
#' @param eq_pts2nd_chance eq_pts2nd_chance
#' @param eq_pts_fb eq_pts_fb
#' @param eq_pts_off_tov eq_pts_off_tov
#' @param eq_pts_paint eq_pts_paint
#' @param et_reb et_reb
#' @param et_stl et_stl
#' @param et_td et_td
#' @param et_tov et_tov
#' @param game_id game_id
#' @param gt_ast gt_ast
#' @param gt_blk gt_blk
#' @param gt_dd gt_dd
#' @param gt_dreb gt_dreb
#' @param gt_fg3a gt_fg3a
#' @param gt_fg3m gt_fg3m
#' @param gt_fg3_pct gt_fg3_pct
#' @param gt_fga gt_fga
#' @param gt_fgm gt_fgm
#' @param gt_fg_pct gt_fg_pct
#' @param gt_fta gt_fta
#' @param gt_ftm gt_ftm
#' @param gt_ft_pct gt_ft_pct
#' @param gt_minutes gt_minutes
#' @param gt_opp_ast gt_opp_ast
#' @param gt_opp_blk gt_opp_blk
#' @param gt_opp_dreb gt_opp_dreb
#' @param gt_opp_fg3a gt_opp_fg3a
#' @param gt_opp_fg3m gt_opp_fg3m
#' @param gt_opp_fg3_pct gt_opp_fg3_pct
#' @param gt_opp_fga gt_opp_fga
#' @param gt_opp_fgm gt_opp_fgm
#' @param gt_opp_fg_pct gt_opp_fg_pct
#' @param gt_opp_fta gt_opp_fta
#' @param gt_opp_ftm gt_opp_ftm
#' @param gt_opp_ft_pct gt_opp_ft_pct
#' @param gt_opp_oreb gt_opp_oreb
#' @param gt_opp_pf gt_opp_pf
#' @param gt_opp_pts gt_opp_pts
#' @param gt_opp_pts2nd_chance gt_opp_pts2nd_chance
#' @param gt_opp_pts_fb gt_opp_pts_fb
#' @param gt_opp_pts_off_tov gt_opp_pts_off_tov
#' @param gt_opp_pts_paint gt_opp_pts_paint
#' @param gt_opp_reb gt_opp_reb
#' @param gt_opp_stl gt_opp_stl
#' @param gt_opp_tov gt_opp_tov
#' @param gt_oreb gt_oreb
#' @param gt_pf gt_pf
#' @param gt_pts gt_pts
#' @param gt_pts2nd_chance gt_pts2nd_chance
#' @param gt_pts_fb gt_pts_fb
#' @param gt_pts_off_tov gt_pts_off_tov
#' @param gt_pts_paint gt_pts_paint
#' @param gt_reb gt_reb
#' @param gt_stl gt_stl
#' @param gt_td gt_td
#' @param gt_tov gt_tov
#' @param lstreak lstreak
#' @param league_id league_id
#' @param location location
#' @param lt_ast lt_ast
#' @param lt_blk lt_blk
#' @param lt_dd lt_dd
#' @param lt_dreb lt_dreb
#' @param lt_fg3a lt_fg3a
#' @param lt_fg3m lt_fg3m
#' @param lt_fg3_pct lt_fg3_pct
#' @param lt_fga lt_fga
#' @param lt_fgm lt_fgm
#' @param lt_fg_pct lt_fg_pct
#' @param lt_fta lt_fta
#' @param lt_ftm lt_ftm
#' @param lt_ft_pct lt_ft_pct
#' @param lt_minutes lt_minutes
#' @param lt_opp_ast lt_opp_ast
#' @param lt_opp_blk lt_opp_blk
#' @param lt_opp_dreb lt_opp_dreb
#' @param lt_opp_fg3a lt_opp_fg3a
#' @param lt_opp_fg3m lt_opp_fg3m
#' @param lt_opp_fg3_pct lt_opp_fg3_pct
#' @param lt_opp_fga lt_opp_fga
#' @param lt_opp_fgm lt_opp_fgm
#' @param lt_opp_fg_pct lt_opp_fg_pct
#' @param lt_opp_fta lt_opp_fta
#' @param lt_opp_ftm lt_opp_ftm
#' @param lt_opp_ft_pct lt_opp_ft_pct
#' @param lt_opp_oreb lt_opp_oreb
#' @param lt_opp_pf lt_opp_pf
#' @param lt_opp_pts lt_opp_pts
#' @param lt_opp_pts2nd_chance lt_opp_pts2nd_chance
#' @param lt_opp_pts_fb lt_opp_pts_fb
#' @param lt_opp_pts_off_tov lt_opp_pts_off_tov
#' @param lt_opp_pts_paint lt_opp_pts_paint
#' @param lt_opp_reb lt_opp_reb
#' @param lt_opp_stl lt_opp_stl
#' @param lt_opp_tov lt_opp_tov
#' @param lt_oreb lt_oreb
#' @param lt_pf lt_pf
#' @param lt_pts lt_pts
#' @param lt_pts2nd_chance lt_pts2nd_chance
#' @param lt_pts_fb lt_pts_fb
#' @param lt_pts_off_tov lt_pts_off_tov
#' @param lt_pts_paint lt_pts_paint
#' @param lt_reb lt_reb
#' @param lt_stl lt_stl
#' @param lt_td lt_td
#' @param lt_tov lt_tov
#' @param min_games min_games
#' @param outcome outcome
#' @param po_round po_round
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param wstreak wstreak
#' @param wrs_opp_ast wrs_opp_ast
#' @param wrs_opp_blk wrs_opp_blk
#' @param wrs_opp_dreb wrs_opp_dreb
#' @param wrs_opp_fg3a wrs_opp_fg3a
#' @param wrs_opp_fg3m wrs_opp_fg3m
#' @param wrs_opp_fg3_pct wrs_opp_fg3_pct
#' @param wrs_opp_fga wrs_opp_fga
#' @param wrs_opp_fgm wrs_opp_fgm
#' @param wrs_opp_fg_pct wrs_opp_fg_pct
#' @param wrs_opp_fta wrs_opp_fta
#' @param wrs_opp_ftm wrs_opp_ftm
#' @param wrs_opp_ft_pct wrs_opp_ft_pct
#' @param wrs_opp_oreb wrs_opp_oreb
#' @param wrs_opp_pf wrs_opp_pf
#' @param wrs_opp_pts wrs_opp_pts
#' @param wrs_opp_pts2nd_chance wrs_opp_pts2nd_chance
#' @param wrs_opp_pts_fb wrs_opp_pts_fb
#' @param wrs_opp_pts_off_tov wrs_opp_pts_off_tov
#' @param wrs_opp_pts_paint wrs_opp_pts_paint
#' @param wrs_opp_reb wrs_opp_reb
#' @param wrs_opp_stl wrs_opp_stl
#' @param wrs_opp_tov wrs_opp_tov
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: TeamGameStreakFinderParametersResults
#'
#'    **TeamGameStreakFinderParametersResults**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |TEAM_NAME    |character |
#'    |TEAM_ID      |character |
#'    |GAMESTREAK   |character |
#'    |STARTDATE    |character |
#'    |ENDDATE      |character |
#'    |ACTIVESTREAK |character |
#'    |NUMSEASONS   |character |
#'    |LASTSEASON   |character |
#'    |FIRSTSEASON  |character |
#'    |ABBREVIATION |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Game Finder Functions
#' @details
#' ```r
#'  nba_teamgamestreakfinder()
#' ```

nba_teamgamestreakfinder <- function(
    active_streaks_only = '',
    active_teams_only = '',
    btr_opp_ast = '',
    btr_opp_blk = '',
    btr_opp_dreb = '',
    btr_opp_fg3a = '',
    btr_opp_fg3m = '',
    btr_opp_fg3_pct = '',
    btr_opp_fga = '',
    btr_opp_fgm = '',
    btr_opp_fg_pct = '',
    btr_opp_fta = '',
    btr_opp_ftm = '',
    btr_opp_ft_pct = '',
    btr_opp_oreb = '',
    btr_opp_pf = '',
    btr_opp_pts = '',
    btr_opp_pts2nd_chance = '',
    btr_opp_pts_fb = '',
    btr_opp_pts_off_tov = '',
    btr_opp_pts_paint = '',
    btr_opp_reb = '',
    btr_opp_stl = '',
    btr_opp_tov = '',
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    et_ast = '',
    et_blk = '',
    et_dd = '',
    et_dreb = '',
    et_fg3a = '',
    et_fg3m = '',
    et_fg3_pct = '',
    et_fga = '',
    et_fgm = '',
    et_fg_pct = '',
    et_fta = '',
    et_ftm = '',
    et_ft_pct = '',
    et_minutes = '',
    eq_opp_pts2nd_chance = '',
    eq_opp_pts_fb = '',
    eq_opp_pts_off_tov = '',
    eq_opp_pts_paint = '',
    et_oreb = '',
    et_pf = '',
    et_pts = '',
    eq_pts2nd_chance = '',
    eq_pts_fb = '',
    eq_pts_off_tov = '',
    eq_pts_paint = '',
    et_reb = '',
    et_stl = '',
    et_td = '',
    et_tov = '',
    game_id = '',
    gt_ast = '',
    gt_blk = '',
    gt_dd = '',
    gt_dreb = '',
    gt_fg3a = '',
    gt_fg3m = '',
    gt_fg3_pct = '',
    gt_fga = '',
    gt_fgm = '',
    gt_fg_pct = '',
    gt_fta = '',
    gt_ftm = '',
    gt_ft_pct = '',
    gt_minutes = '',
    gt_opp_ast = '',
    gt_opp_blk = '',
    gt_opp_dreb = '',
    gt_opp_fg3a = '',
    gt_opp_fg3m = '',
    gt_opp_fg3_pct = '',
    gt_opp_fga = '',
    gt_opp_fgm = '',
    gt_opp_fg_pct = '',
    gt_opp_fta = '',
    gt_opp_ftm = '',
    gt_opp_ft_pct = '',
    gt_opp_oreb = '',
    gt_opp_pf = '',
    gt_opp_pts = '',
    gt_opp_pts2nd_chance = '',
    gt_opp_pts_fb = '',
    gt_opp_pts_off_tov = '',
    gt_opp_pts_paint = '',
    gt_opp_reb = '',
    gt_opp_stl = '',
    gt_opp_tov = '',
    gt_oreb = '',
    gt_pf = '',
    gt_pts = '',
    gt_pts2nd_chance = '',
    gt_pts_fb = '',
    gt_pts_off_tov = '',
    gt_pts_paint = '',
    gt_reb = '',
    gt_stl = '',
    gt_td = '',
    gt_tov = '',
    lstreak = '',
    league_id = '00',
    location = '',
    lt_ast = '',
    lt_blk = '',
    lt_dd = '',
    lt_dreb = '',
    lt_fg3a = '',
    lt_fg3m = '',
    lt_fg3_pct = '',
    lt_fga = '',
    lt_fgm = '',
    lt_fg_pct = '',
    lt_fta = '',
    lt_ftm = '',
    lt_ft_pct = '',
    lt_minutes = '',
    lt_opp_ast = '',
    lt_opp_blk = '',
    lt_opp_dreb = '',
    lt_opp_fg3a = '',
    lt_opp_fg3m = '',
    lt_opp_fg3_pct = '',
    lt_opp_fga = '',
    lt_opp_fgm = '',
    lt_opp_fg_pct = '',
    lt_opp_fta = '',
    lt_opp_ftm = '',
    lt_opp_ft_pct = '',
    lt_opp_oreb = '',
    lt_opp_pf = '',
    lt_opp_pts = '',
    lt_opp_pts2nd_chance = '',
    lt_opp_pts_fb = '',
    lt_opp_pts_off_tov = '',
    lt_opp_pts_paint = '',
    lt_opp_reb = '',
    lt_opp_stl = '',
    lt_opp_tov = '',
    lt_oreb = '',
    lt_pf = '',
    lt_pts = '',
    lt_pts2nd_chance = '',
    lt_pts_fb = '',
    lt_pts_off_tov = '',
    lt_pts_paint = '',
    lt_reb = '',
    lt_stl = '',
    lt_td = '',
    lt_tov = '',
    min_games = '',
    outcome = '',
    po_round = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    vs_team_id = '',
    wstreak = '',
    wrs_opp_ast = '',
    wrs_opp_blk = '',
    wrs_opp_dreb = '',
    wrs_opp_fg3a = '',
    wrs_opp_fg3m = '',
    wrs_opp_fg3_pct = '',
    wrs_opp_fga = '',
    wrs_opp_fgm = '',
    wrs_opp_fg_pct = '',
    wrs_opp_fta = '',
    wrs_opp_ftm = '',
    wrs_opp_ft_pct = '',
    wrs_opp_oreb = '',
    wrs_opp_pf = '',
    wrs_opp_pts = '',
    wrs_opp_pts2nd_chance = '',
    wrs_opp_pts_fb = '',
    wrs_opp_pts_off_tov = '',
    wrs_opp_pts_paint = '',
    wrs_opp_reb = '',
    wrs_opp_stl = '',
    wrs_opp_tov = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamestreakfinder"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    ActiveStreaksOnly = active_streaks_only,
    ActiveTeamsOnly = active_teams_only,
    BtrOPPAST = btr_opp_ast,
    BtrOPPBLK = btr_opp_blk,
    BtrOPPDREB = btr_opp_dreb,
    BtrOPPFG3A = btr_opp_fg3a,
    BtrOPPFG3M = btr_opp_fg3m,
    BtrOPPFG3PCT = btr_opp_fg3_pct,
    BtrOPPFGA = btr_opp_fga,
    BtrOPPFGM = btr_opp_fgm,
    BtrOPPFG_PCT = btr_opp_fg_pct,
    BtrOPPFTA = btr_opp_fta,
    BtrOPPFTM = btr_opp_ftm,
    BtrOPPFT_PCT = btr_opp_ft_pct,
    BtrOPPOREB = btr_opp_oreb,
    BtrOPPPF = btr_opp_pf,
    BtrOPPPTS = btr_opp_pts,
    BtrOPPPTS2NDCHANCE = btr_opp_pts2nd_chance,
    BtrOPPPTSFB = btr_opp_pts_fb,
    BtrOPPPTSOFFTOV = btr_opp_pts_off_tov,
    BtrOPPPTSPAINT = btr_opp_pts_paint,
    BtrOPPREB = btr_opp_reb,
    BtrOPPSTL = btr_opp_stl,
    BtrOPPTOV = btr_opp_tov,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    EqAST = et_ast,
    EqBLK = et_blk,
    EqDD = et_dd,
    EqDREB = et_dreb,
    EqFG3A = et_fg3a,
    EqFG3M = et_fg3m,
    EqFG3_PCT = et_fg3_pct,
    EqFGA = et_fga,
    EqFGM = et_fgm,
    EqFG_PCT = et_fg_pct,
    EqFTA = et_fta,
    EqFTM = et_ftm,
    EqFT_PCT = et_ft_pct,
    EqMINUTES = et_minutes,
    EqOPPPTS2NDCHANCE = eq_opp_pts2nd_chance,
    EqOPPPTSFB = eq_opp_pts_fb,
    EqOPPPTSOFFTOV = eq_opp_pts_off_tov,
    EqOPPPTSPAINT = eq_opp_pts_paint,
    EqOREB = et_oreb,
    EqPF = et_pf,
    EqPTS = et_pts,
    EqPTS2NDCHANCE = eq_pts2nd_chance,
    EqPTSFB = eq_pts_fb,
    EqPTSOFFTOV = eq_pts_off_tov,
    EqPTSPAINT = eq_pts_paint,
    EqREB = et_reb,
    EqSTL = et_stl,
    EqTD = et_td,
    EqTOV = et_tov,
    GameID = game_id,
    GtAST = gt_ast,
    GtBLK = gt_blk,
    GtDD = gt_dd,
    GtDREB = gt_dreb,
    GtFG3A = gt_fg3a,
    GtFG3M = gt_fg3m,
    GtFG3_PCT = gt_fg3_pct,
    GtFGA = gt_fga,
    GtFGM = gt_fgm,
    GtFG_PCT = gt_fg_pct,
    GtFTA = gt_fta,
    GtFTM = gt_ftm,
    GtFT_PCT = gt_ft_pct,
    GtMINUTES = gt_minutes,
    GtOPPAST = gt_opp_ast,
    GtOPPBLK = gt_opp_blk,
    GtOPPDREB = gt_opp_dreb,
    GtOPPFG3A = gt_opp_fg3a,
    GtOPPFG3M = gt_opp_fg3m,
    GtOPPFG3PCT = gt_opp_fg3_pct,
    GtOPPFGA = gt_opp_fga,
    GtOPPFGM = gt_opp_fgm,
    GtOPPFG_PCT = gt_opp_fg_pct,
    GtOPPFTA = gt_opp_fta,
    GtOPPFTM = gt_opp_ftm,
    GtOPPFT_PCT = gt_opp_ft_pct,
    GtOPPOREB = gt_opp_oreb,
    GtOPPPF = gt_opp_pf,
    GtOPPPTS = gt_opp_pts,
    GtOPPPTS2NDCHANCE = gt_opp_pts2nd_chance,
    GtOPPPTSFB = gt_opp_pts_fb,
    GtOPPPTSOFFTOV = gt_opp_pts_off_tov,
    GtOPPPTSPAINT = gt_opp_pts_paint,
    GtOPPREB = gt_opp_reb,
    GtOPPSTL = gt_opp_stl,
    GtOPPTOV = gt_opp_tov,
    GtOREB = gt_oreb,
    GtPF = gt_pf,
    GtPTS = gt_pts,
    GtPTS2NDCHANCE = gt_pts2nd_chance,
    GtPTSFB = gt_pts_fb,
    GtPTSOFFTOV = gt_pts_off_tov,
    GtPTSPAINT = gt_pts_paint,
    GtREB = gt_reb,
    GtSTL = gt_stl,
    GtTD = gt_td,
    GtTOV = gt_tov,
    LeagueID = league_id,
    Location = location,
    LStreak = lstreak,
    LtAST = lt_ast,
    LtBLK = lt_blk,
    LtDD = lt_dd,
    LtDREB = lt_dreb,
    LtFG3A = lt_fg3a,
    LtFG3M = lt_fg3m,
    LtFG3_PCT = lt_fg3_pct,
    LtFGA = lt_fga,
    LtFGM = lt_fgm,
    LtFG_PCT = lt_fg_pct,
    LtFTA = lt_fta,
    LtFTM = lt_ftm,
    LtFT_PCT = lt_ft_pct,
    LtMINUTES = lt_minutes,
    LtOPPAST = lt_opp_ast,
    LtOPPBLK = lt_opp_blk,
    LtOPPDREB = lt_opp_dreb,
    LtOPPFG3A = lt_opp_fg3a,
    LtOPPFG3M = lt_opp_fg3m,
    LtOPPFG3PCT = lt_opp_fg3_pct,
    LtOPPFGA = lt_opp_fga,
    LtOPPFGM = lt_opp_fgm,
    LtOPPFG_PCT = lt_opp_fg_pct,
    LtOPPFTA = lt_opp_fta,
    LtOPPFTM = lt_opp_ftm,
    LtOPPFT_PCT = lt_opp_ft_pct,
    LtOPPOREB = lt_opp_oreb,
    LtOPPPF = lt_opp_pf,
    LtOPPPTS = lt_opp_pts,
    LtOPPPTS2NDCHANCE = lt_opp_pts2nd_chance,
    LtOPPPTSFB = lt_opp_pts_fb,
    LtOPPPTSOFFTOV = lt_opp_pts_off_tov,
    LtOPPPTSPAINT = lt_opp_pts_paint,
    LtOPPREB = lt_opp_reb,
    LtOPPSTL = lt_opp_stl,
    LtOPPTOV = lt_opp_tov,
    LtOREB = lt_oreb,
    LtPF = lt_pf,
    LtPTS = lt_pts,
    LtPTS2NDCHANCE = lt_pts2nd_chance,
    LtPTSFB = lt_pts_fb,
    LtPTSOFFTOV = lt_pts_off_tov,
    LtPTSPAINT = lt_pts_paint,
    LtREB = lt_reb,
    LtSTL = lt_stl,
    LtTD = lt_td,
    LtTOV = lt_tov,
    MinGames = min_games,
    Outcome = outcome,
    PORound = po_round,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id,
    WStreak = wstreak,
    WrsOPPAST = wrs_opp_ast,
    WrsOPPBLK = wrs_opp_blk,
    WrsOPPDREB = wrs_opp_dreb,
    WrsOPPFG3A = wrs_opp_fg3a,
    WrsOPPFG3M = wrs_opp_fg3m,
    WrsOPPFG3PCT = wrs_opp_fg3_pct,
    WrsOPPFGA = wrs_opp_fga,
    WrsOPPFGM = wrs_opp_fgm,
    WrsOPPFG_PCT = wrs_opp_fg_pct,
    WrsOPPFTA = wrs_opp_fta,
    WrsOPPFTM = wrs_opp_ftm,
    WrsOPPFT_PCT = wrs_opp_ft_pct,
    WrsOPPOREB = wrs_opp_oreb,
    WrsOPPPF = wrs_opp_pf,
    WrsOPPPTS = wrs_opp_pts,
    WrsOPPPTS2NDCHANCE = wrs_opp_pts2nd_chance,
    WrsOPPPTSFB = wrs_opp_pts_fb,
    WrsOPPPTSOFFTOV = wrs_opp_pts_off_tov,
    WrsOPPPTSPAINT = wrs_opp_pts_paint,
    WrsOPPREB = wrs_opp_reb,
    WrsOPPSTL = wrs_opp_stl,
    WrsOPPTOV = wrs_opp_tov
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team streak finder data for the given parameters available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


