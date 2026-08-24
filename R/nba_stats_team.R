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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'       season_id \tab character \tab Unique season identifier. \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       conference \tab character \tab Conference. \cr
#'       division \tab character \tab Team division. \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       team_name_full \tab character \tab Team name full. \cr
#'       season \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       espn_team_id \tab integer \tab Unique identifier for espn team. \cr
#'       abbreviation \tab character \tab Short abbreviation. \cr
#'       display_name \tab character \tab Display name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       nickname \tab character \tab Team or athlete nickname. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       color \tab character \tab Primary color (hex without leading '#'). \cr
#'       alternate_color \tab character \tab Alternate color (hex without leading '#'). \cr
#'       logo \tab character \tab Team or league logo URL. \cr
#'       logo_dark \tab character \tab Logo dark. \cr
#'       logos_href_3 \tab character \tab Logos href 3. \cr
#'       logos_href_4 \tab character \tab Logos href 4. \cr
#'       nba_logo_svg \tab character \tab Nba logo svg. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
nba_teams <- function(...) {
  .args <- mget(setdiff(names(formals()), "..."))
  tryCatch(
    expr = {
      standings <- nba_leaguestandingsv3(season = year_to_season(most_recent_nba_season() - 1), ...) %>%
        purrr::pluck("Standings")

      league_gamelog <- nba_leaguegamelog(
        league_id = "00",
        season = year_to_season(most_recent_nba_season() - 1), ...
      ) %>%
        purrr::pluck("LeagueGameLog")
      if (nrow(league_gamelog) == 0) {
        league_gamelog <- nba_leaguegamelog(
          league_id = "00",
          season = year_to_season(most_recent_nba_season() - 2), ...
        ) %>%
          purrr::pluck("LeagueGameLog")
      }

      league_gamelog <- league_gamelog %>%
        dplyr::rename(dplyr::any_of(c("team_name_full" = "TEAM_NAME"))) %>%
        dplyr::select(dplyr::any_of(c(
          "TEAM_ID",
          "TEAM_ABBREVIATION",
          "team_name_full"
        ))) %>%
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
          "team_name_full"
        ))) %>%
        dplyr::mutate(
          Season = paste0("", year_to_season(most_recent_nba_season() - 1))
        ) %>%
        dplyr::arrange(.data$team_name_full)

      espn_nba_teams <- espn_nba_teams() %>%
        dplyr::rename(dplyr::any_of(c("espn_team_id" = "team_id")))
      nba_teams <- nba_teams %>%
        dplyr::left_join(espn_nba_teams, by = c("TeamName" = "short_name"))

      nba_teams <- nba_teams %>%
        dplyr::mutate(
          espn_team_id = as.integer(.data$espn_team_id),
          nba_logo_svg = paste0("https://cdn.nba.com/logos/nba/", .data$TeamID, "/primary/L/logo.svg")
        ) %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team details data available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       ABBREVIATION \tab character \tab Short abbreviation. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       YEARFOUNDED \tab character \tab  \cr
#'       CITY \tab character \tab City. \cr
#'       ARENA \tab character \tab Arena. \cr
#'       ARENACAPACITY \tab character \tab  \cr
#'       OWNER \tab character \tab  \cr
#'       GENERALMANAGER \tab character \tab  \cr
#'       HEADCOACH \tab character \tab  \cr
#'       DLEAGUEAFFILIATION \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamHistory**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |TEAM_ID        |character |Unique team identifier.   |
#'    |CITY           |character |City.                     |
#'    |NICKNAME       |character |Team or athlete nickname. |
#'    |YEARFOUNDED    |character |                          |
#'    |YEARACTIVETILL |character |                          |
#'
#'    **TeamSocialSites**
#'
#'
#'    |col_name     |types     |description |
#'    |:------------|:---------|:-----------|
#'    |ACCOUNTTYPE  |character |            |
#'    |WEBSITE_LINK |character |            |
#'
#'    **TeamAwardsChampionships**
#'
#'
#'    |col_name     |types     |description |
#'    |:------------|:---------|:-----------|
#'    |YEARAWARDED  |character |            |
#'    |OPPOSITETEAM |character |            |
#'
#'    **TeamAwardsConf**
#'
#'
#'    |col_name     |types   |description |
#'    |:------------|:-------|:-----------|
#'    |YEARAWARDED  |integer |            |
#'    |OPPOSITETEAM |integer |            |
#'
#'    **TeamAwardsDiv**
#'
#'
#'    Same columns as the **TeamAwardsConf** table above.
#'
#'    **TeamHof**
#'
#'
#'    |col_name        |types     |description                             |
#'    |:---------------|:---------|:---------------------------------------|
#'    |PLAYERID        |character |Playerid.                               |
#'    |PLAYER          |character |Player.                                 |
#'    |POSITION        |character |Listed roster position (G, F, C, etc.). |
#'    |JERSEY          |character |Jersey number worn by the player.       |
#'    |SEASONSWITHTEAM |character |                                        |
#'    |YEAR            |character |4-digit year.                           |
#'
#'    **TeamRetired**
#'
#'
#'    Same columns as the **TeamHof** table above.
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
    team_id = "1610612749",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "teamdetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    TeamID = team_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team details data for {team_id} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       GP \tab character \tab Games played. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       W_PCT \tab character \tab  \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       E_OFF_RATING \tab character \tab  \cr
#'       E_DEF_RATING \tab character \tab  \cr
#'       E_NET_RATING \tab character \tab  \cr
#'       E_PACE \tab character \tab  \cr
#'       E_AST_RATIO \tab character \tab  \cr
#'       E_OREB_PCT \tab character \tab  \cr
#'       E_DREB_PCT \tab character \tab  \cr
#'       E_REB_PCT \tab character \tab  \cr
#'       E_TM_TOV_PCT \tab character \tab  \cr
#'       GP_RANK \tab character \tab  \cr
#'       W_RANK \tab character \tab  \cr
#'       L_RANK \tab character \tab  \cr
#'       W_PCT_RANK \tab character \tab  \cr
#'       MIN_RANK \tab character \tab  \cr
#'       E_OFF_RATING_RANK \tab character \tab  \cr
#'       E_DEF_RATING_RANK \tab character \tab  \cr
#'       E_NET_RATING_RANK \tab character \tab  \cr
#'       E_AST_RATIO_RANK \tab character \tab  \cr
#'       E_OREB_PCT_RANK \tab character \tab  \cr
#'       E_DREB_PCT_RANK \tab character \tab  \cr
#'       E_REB_PCT_RANK \tab character \tab  \cr
#'       E_TM_TOV_PCT_RANK \tab character \tab  \cr
#'       E_PACE_RANK \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x) {
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team estimated metrics data for {season} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       Team_ID \tab character \tab Unique team identifier. \cr
#'       Game_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       MATCHUP \tab character \tab Matchup. \cr
#'       WL \tab character \tab Wl. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       W_PCT \tab character \tab  \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PTS \tab character \tab Points scored. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    date_from = "",
    date_to = "",
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    team_id = "1610612749",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamelog"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team game log data for {team_id} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       SEASON_YEAR \tab character \tab Season year string ('YYYY-YY' format). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       MATCHUP \tab character \tab Matchup. \cr
#'       WL \tab character \tab Wl. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'       GP_RANK \tab character \tab  \cr
#'       W_RANK \tab character \tab  \cr
#'       L_RANK \tab character \tab  \cr
#'       W_PCT_RANK \tab character \tab  \cr
#'       MIN_RANK \tab character \tab  \cr
#'       FGM_RANK \tab character \tab  \cr
#'       FGA_RANK \tab character \tab  \cr
#'       FG_PCT_RANK \tab character \tab  \cr
#'       FG3M_RANK \tab character \tab  \cr
#'       FG3A_RANK \tab character \tab  \cr
#'       FG3_PCT_RANK \tab character \tab  \cr
#'       FTM_RANK \tab character \tab  \cr
#'       FTA_RANK \tab character \tab  \cr
#'       FT_PCT_RANK \tab character \tab  \cr
#'       OREB_RANK \tab character \tab  \cr
#'       DREB_RANK \tab character \tab  \cr
#'       REB_RANK \tab character \tab  \cr
#'       AST_RANK \tab character \tab  \cr
#'       TOV_RANK \tab character \tab  \cr
#'       STL_RANK \tab character \tab  \cr
#'       BLK_RANK \tab character \tab  \cr
#'       BLKA_RANK \tab character \tab  \cr
#'       PF_RANK \tab character \tab  \cr
#'       PFD_RANK \tab character \tab  \cr
#'       PTS_RANK \tab character \tab  \cr
#'       PLUS_MINUS_RANK \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    po_round = "",
    per_mode = "Totals",
    period = 0,
    player_id = "",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    team_id = "1610612749",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamelogs"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team game logs for {team_id} available!",
      args = .args
    ),
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
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_franchiseleaders()` instead.
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PTS_PERSON_ID \tab character \tab  \cr
#'       PTS_PLAYER \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       AST_PERSON_ID \tab character \tab  \cr
#'       AST_PLAYER \tab character \tab  \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       REB_PERSON_ID \tab character \tab  \cr
#'       REB_PLAYER \tab character \tab  \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLK_PERSON_ID \tab character \tab  \cr
#'       BLK_PLAYER \tab character \tab  \cr
#'       STL \tab character \tab Steals. \cr
#'       STL_PERSON_ID \tab character \tab  \cr
#'       STL_PLAYER \tab character \tab  \cr
#'       SEASON_YEAR \tab character \tab Season year string ('YYYY-YY' format). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    season_id = "22022",
    team_id = "1610612749",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_teamhistoricalleaders()",
    with = "nba_franchiseleaders()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple season IDs returned an empty response body; confirmed defunct upstream."
  )

  version <- "teamhistoricalleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonID = season_id,
    TeamID = team_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team historical leaders data for {team_id} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       SEASON_YEAR \tab character \tab Season year string ('YYYY-YY' format). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CONFERENCE \tab character \tab  \cr
#'       TEAM_DIVISION \tab character \tab  \cr
#'       TEAM_CODE \tab character \tab  \cr
#'       TEAM_SLUG \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       PCT \tab character \tab Pct. \cr
#'       CONF_RANK \tab character \tab  \cr
#'       DIV_RANK \tab character \tab  \cr
#'       MIN_YEAR \tab character \tab  \cr
#'       MAX_YEAR \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamSeasonRanks**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LEAGUE_ID \tab character \tab League identifier ('10' = WNBA). \cr
#'       SEASON_ID \tab character \tab Unique season identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       PTS_RANK \tab character \tab  \cr
#'       PTS_PG \tab character \tab  \cr
#'       REB_RANK \tab character \tab  \cr
#'       REB_PG \tab character \tab  \cr
#'       AST_RANK \tab character \tab  \cr
#'       AST_PG \tab character \tab  \cr
#'       OPP_PTS_RANK \tab character \tab  \cr
#'       OPP_PTS_PG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **AvailableSeasons**
#'
#'
#'    |col_name  |types     |description               |
#'    |:---------|:---------|:-------------------------|
#'    |SEASON_ID |character |Unique season identifier. |
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
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    team_id = "1610612749",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team common info data for {team_id} available!",
      args = .args
    ),
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
#'    Columns as documented in the shared [nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema] table.
#'
#'    **PlayersOnCourtTeamPlayerOnOffDetails**
#'
#'
#'    Columns as documented in the shared [nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema] table.
#'
#'    **PlayersOffCourtTeamPlayerOnOffDetails**
#'
#'
#'    Columns as documented in the shared [nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema] table.
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
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    pace_adjust = "N",
    plus_minus = "N",
    po_round = "",
    per_mode = "Totals",
    period = 0,
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    shot_clock_range = "",
    team_id = "1610612749",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayeronoffdetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team player on off details data for {team_id} available!",
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
#' **Get NBA Stats API Team Player On/Off Summary**
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
#' @return Return a named list of data frames: OverallTeamPlayerOnOffSummary,
#' PlayersOffCourtTeamPlayerOnOffSummary, PlayersOnCourtTeamPlayerOnOffSummary
#'
#'    **OverallTeamPlayerOnOffSummary**
#'
#'
#'    Columns as documented in the shared [nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema] table.
#'
#'    **PlayersOnCourtTeamPlayerOnOffSummary**
#'
#'
#'    |col_name          |types     |description                                             |
#'    |:-----------------|:---------|:-------------------------------------------------------|
#'    |GROUP_SET         |character |                                                        |
#'    |TEAM_ID           |character |Unique team identifier.                                 |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                   |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces').         |
#'    |VS_PLAYER_ID      |character |                                                        |
#'    |VS_PLAYER_NAME    |character |                                                        |
#'    |COURT_STATUS      |character |                                                        |
#'    |GP                |character |Games played.                                           |
#'    |MIN               |character |Minutes played.                                         |
#'    |PLUS_MINUS        |character |Plus/minus point differential while on court.           |
#'    |OFF_RATING        |character |Offensive rating (points produced per 100 possessions). |
#'    |DEF_RATING        |character |Defensive rating (points allowed per 100 possessions).  |
#'    |NET_RATING        |character |Net rating (off rating - def rating).                   |
#'
#'    **PlayersOffCourtTeamPlayerOnOffSummary**
#'
#'
#'    Same columns as the **PlayersOnCourtTeamPlayerOnOffSummary** table above.
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
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    pace_adjust = "N",
    plus_minus = "N",
    po_round = "",
    per_mode = "Totals",
    period = 0,
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    shot_clock_range = "",
    team_id = "1610612749",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayeronoffsummary"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team player on off summary data for {team_id} available!",
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
#' **Get NBA Stats API Team Player Dashboard**
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
#' @return Return a named list of data frames: PlayersSeasonTotals, TeamOverall
#'
#'    **TeamOverall**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GROUP_SET \tab character \tab  \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       GROUP_VALUE \tab character \tab  \cr
#'       GP \tab character \tab Games played. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       W_PCT \tab character \tab  \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'       GP_RANK \tab character \tab  \cr
#'       W_RANK \tab character \tab  \cr
#'       L_RANK \tab character \tab  \cr
#'       W_PCT_RANK \tab character \tab  \cr
#'       MIN_RANK \tab character \tab  \cr
#'       FGM_RANK \tab character \tab  \cr
#'       FGA_RANK \tab character \tab  \cr
#'       FG_PCT_RANK \tab character \tab  \cr
#'       FG3M_RANK \tab character \tab  \cr
#'       FG3A_RANK \tab character \tab  \cr
#'       FG3_PCT_RANK \tab character \tab  \cr
#'       FTM_RANK \tab character \tab  \cr
#'       FTA_RANK \tab character \tab  \cr
#'       FT_PCT_RANK \tab character \tab  \cr
#'       OREB_RANK \tab character \tab  \cr
#'       DREB_RANK \tab character \tab  \cr
#'       REB_RANK \tab character \tab  \cr
#'       AST_RANK \tab character \tab  \cr
#'       TOV_RANK \tab character \tab  \cr
#'       STL_RANK \tab character \tab  \cr
#'       BLK_RANK \tab character \tab  \cr
#'       BLKA_RANK \tab character \tab  \cr
#'       PF_RANK \tab character \tab  \cr
#'       PFD_RANK \tab character \tab  \cr
#'       PTS_RANK \tab character \tab  \cr
#'       PLUS_MINUS_RANK \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayersSeasonTotals**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GROUP_SET \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       GP \tab character \tab Games played. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       W_PCT \tab character \tab  \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'       NBA_FANTASY_PTS \tab character \tab  \cr
#'       DD2 \tab character \tab  \cr
#'       TD3 \tab character \tab  \cr
#'       WNBA_FANTASY_PTS \tab character \tab  \cr
#'       GP_RANK \tab character \tab  \cr
#'       W_RANK \tab character \tab  \cr
#'       L_RANK \tab character \tab  \cr
#'       W_PCT_RANK \tab character \tab  \cr
#'       MIN_RANK \tab character \tab  \cr
#'       FGM_RANK \tab character \tab  \cr
#'       FGA_RANK \tab character \tab  \cr
#'       FG_PCT_RANK \tab character \tab  \cr
#'       FG3M_RANK \tab character \tab  \cr
#'       FG3A_RANK \tab character \tab  \cr
#'       FG3_PCT_RANK \tab character \tab  \cr
#'       FTM_RANK \tab character \tab  \cr
#'       FTA_RANK \tab character \tab  \cr
#'       FT_PCT_RANK \tab character \tab  \cr
#'       OREB_RANK \tab character \tab  \cr
#'       DREB_RANK \tab character \tab  \cr
#'       REB_RANK \tab character \tab  \cr
#'       AST_RANK \tab character \tab  \cr
#'       TOV_RANK \tab character \tab  \cr
#'       STL_RANK \tab character \tab  \cr
#'       BLK_RANK \tab character \tab  \cr
#'       BLKA_RANK \tab character \tab  \cr
#'       PF_RANK \tab character \tab  \cr
#'       PFD_RANK \tab character \tab  \cr
#'       PTS_RANK \tab character \tab  \cr
#'       PLUS_MINUS_RANK \tab character \tab  \cr
#'       NBA_FANTASY_PTS_RANK \tab character \tab  \cr
#'       DD2_RANK \tab character \tab  \cr
#'       TD3_RANK \tab character \tab  \cr
#'       WNBA_FANTASY_PTS_RANK \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    pace_adjust = "N",
    plus_minus = "N",
    po_round = "",
    per_mode = "Totals",
    period = 0,
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    shot_clock_range = "",
    team_id = "1610612749",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamplayerdashboard"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team player dashboard data for {team_id} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       YEAR \tab character \tab 4-digit year. \cr
#'       GP \tab character \tab Games played. \cr
#'       WINS \tab character \tab Total wins. \cr
#'       LOSSES \tab character \tab Total losses. \cr
#'       WIN_PCT \tab character \tab  \cr
#'       CONF_RANK \tab character \tab  \cr
#'       DIV_RANK \tab character \tab  \cr
#'       PO_WINS \tab character \tab  \cr
#'       PO_LOSSES \tab character \tab  \cr
#'       CONF_COUNT \tab character \tab  \cr
#'       DIV_COUNT \tab character \tab  \cr
#'       NBA_FINALS_APPEARANCE \tab character \tab  \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       STL \tab character \tab Steals. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PTS_RANK \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    league_id = "00",
    per_mode = "Totals",
    season_type = "Regular Season",
    team_id = "1610612749",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team year-by-year stats data for {team_id} available!",
      args = .args
    ),
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
#'    |col_name          |types     |description                                   |
#'    |:-----------------|:---------|:---------------------------------------------|
#'    |GROUP_SET         |character |                                              |
#'    |GROUP_VALUE       |character |                                              |
#'    |TEAM_ID           |character |Unique team identifier.                       |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').         |
#'    |GP                |character |Games played.                                 |
#'    |W                 |character |Wins.                                         |
#'    |L                 |character |Losses.                                       |
#'    |W_PCT             |character |                                              |
#'    |MIN               |character |Minutes played.                               |
#'    |FGM               |character |Field goals made.                             |
#'    |FGA               |character |Field goal attempts.                          |
#'    |FG_PCT            |character |Field goal percentage (0-1).                  |
#'    |FG3M              |character |Three-point field goals made.                 |
#'    |FG3A              |character |Three-point field goal attempts.              |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).      |
#'    |FTM               |character |Free throws made.                             |
#'    |FTA               |character |Free throw attempts.                          |
#'    |FT_PCT            |character |Free throw percentage (0-1).                  |
#'    |OREB              |character |Offensive rebounds.                           |
#'    |DREB              |character |Defensive rebounds.                           |
#'    |REB               |character |Total rebounds.                               |
#'    |AST               |character |Assists.                                      |
#'    |TOV               |character |Turnovers.                                    |
#'    |STL               |character |Steals.                                       |
#'    |BLK               |character |Blocks.                                       |
#'    |BLKA              |character |                                              |
#'    |PF                |character |Personal fouls.                               |
#'    |PFD               |character |                                              |
#'    |PTS               |character |Points scored.                                |
#'    |PLUS_MINUS        |character |Plus/minus point differential while on court. |
#'    |GP_RANK           |character |                                              |
#'    |W_RANK            |character |                                              |
#'    |L_RANK            |character |                                              |
#'    |W_PCT_RANK        |character |                                              |
#'    |MIN_RANK          |character |                                              |
#'    |FGM_RANK          |character |                                              |
#'    |FGA_RANK          |character |                                              |
#'    |FG_PCT_RANK       |character |                                              |
#'    |FG3M_RANK         |character |                                              |
#'    |FG3A_RANK         |character |                                              |
#'    |FG3_PCT_RANK      |character |                                              |
#'    |FTM_RANK          |character |                                              |
#'    |FTA_RANK          |character |                                              |
#'    |FT_PCT_RANK       |character |                                              |
#'    |OREB_RANK         |character |                                              |
#'    |DREB_RANK         |character |                                              |
#'    |REB_RANK          |character |                                              |
#'    |AST_RANK          |character |                                              |
#'    |TOV_RANK          |character |                                              |
#'    |STL_RANK          |character |                                              |
#'    |BLK_RANK          |character |                                              |
#'    |BLKA_RANK         |character |                                              |
#'    |PF_RANK           |character |                                              |
#'    |PFD_RANK          |character |                                              |
#'    |PTS_RANK          |character |                                              |
#'    |PLUS_MINUS_RANK   |character |                                              |
#'
#'    **vsPlayerOverall**
#'
#'
#'    |col_name              |types     |description                                   |
#'    |:---------------------|:---------|:---------------------------------------------|
#'    |GROUP_SET             |character |                                              |
#'    |GROUP_VALUE           |character |                                              |
#'    |PLAYER_ID             |character |Unique player identifier.                     |
#'    |GP                    |character |Games played.                                 |
#'    |W                     |character |Wins.                                         |
#'    |L                     |character |Losses.                                       |
#'    |W_PCT                 |character |                                              |
#'    |MIN                   |character |Minutes played.                               |
#'    |FGM                   |character |Field goals made.                             |
#'    |FGA                   |character |Field goal attempts.                          |
#'    |FG_PCT                |character |Field goal percentage (0-1).                  |
#'    |FG3M                  |character |Three-point field goals made.                 |
#'    |FG3A                  |character |Three-point field goal attempts.              |
#'    |FG3_PCT               |character |Three-point field goal percentage (0-1).      |
#'    |FTM                   |character |Free throws made.                             |
#'    |FTA                   |character |Free throw attempts.                          |
#'    |FT_PCT                |character |Free throw percentage (0-1).                  |
#'    |OREB                  |character |Offensive rebounds.                           |
#'    |DREB                  |character |Defensive rebounds.                           |
#'    |REB                   |character |Total rebounds.                               |
#'    |AST                   |character |Assists.                                      |
#'    |TOV                   |character |Turnovers.                                    |
#'    |STL                   |character |Steals.                                       |
#'    |BLK                   |character |Blocks.                                       |
#'    |BLKA                  |character |                                              |
#'    |PF                    |character |Personal fouls.                               |
#'    |PFD                   |character |                                              |
#'    |PTS                   |character |Points scored.                                |
#'    |PLUS_MINUS            |character |Plus/minus point differential while on court. |
#'    |NBA_FANTASY_PTS       |character |                                              |
#'    |DD2                   |character |                                              |
#'    |TD3                   |character |                                              |
#'    |WNBA_FANTASY_PTS      |character |                                              |
#'    |GP_RANK               |character |                                              |
#'    |W_RANK                |character |                                              |
#'    |L_RANK                |character |                                              |
#'    |W_PCT_RANK            |character |                                              |
#'    |MIN_RANK              |character |                                              |
#'    |FGM_RANK              |character |                                              |
#'    |FGA_RANK              |character |                                              |
#'    |FG_PCT_RANK           |character |                                              |
#'    |FG3M_RANK             |character |                                              |
#'    |FG3A_RANK             |character |                                              |
#'    |FG3_PCT_RANK          |character |                                              |
#'    |FTM_RANK              |character |                                              |
#'    |FTA_RANK              |character |                                              |
#'    |FT_PCT_RANK           |character |                                              |
#'    |OREB_RANK             |character |                                              |
#'    |DREB_RANK             |character |                                              |
#'    |REB_RANK              |character |                                              |
#'    |AST_RANK              |character |                                              |
#'    |TOV_RANK              |character |                                              |
#'    |STL_RANK              |character |                                              |
#'    |BLK_RANK              |character |                                              |
#'    |BLKA_RANK             |character |                                              |
#'    |PF_RANK               |character |                                              |
#'    |PFD_RANK              |character |                                              |
#'    |PTS_RANK              |character |                                              |
#'    |PLUS_MINUS_RANK       |character |                                              |
#'    |NBA_FANTASY_PTS_RANK  |character |                                              |
#'    |DD2_RANK              |character |                                              |
#'    |TD3_RANK              |character |                                              |
#'    |WNBA_FANTASY_PTS_RANK |character |                                              |
#'
#'    **OnOffCourt**
#'
#'
#'    Columns as documented in the shared [nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema] table.
#'
#'    **ShotDistanceOverall**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GROUP_SET         |character |                                                |
#'    |GROUP_VALUE       |character |                                                |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |FGM               |character |Field goals made.                               |
#'    |FGA               |character |Field goal attempts.                            |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'
#'    **ShotDistanceOnCourt**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GROUP_SET         |character |                                                |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |VS_PLAYER_ID      |character |                                                |
#'    |VS_PLAYER_NAME    |character |                                                |
#'    |COURT_STATUS      |character |                                                |
#'    |GROUP_VALUE       |character |                                                |
#'    |FGM               |character |Field goals made.                               |
#'    |FGA               |character |Field goal attempts.                            |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'
#'    **ShotDistanceOffCourt**
#'
#'
#'    Same columns as the **ShotDistanceOnCourt** table above.
#'
#'    **ShotAreaOverall**
#'
#'
#'    Same columns as the **ShotDistanceOverall** table above.
#'
#'    **ShotAreaOnCourt**
#'
#'
#'    Same columns as the **ShotDistanceOnCourt** table above.
#'
#'    **ShotAreaOffCourt**
#'
#'
#'    Same columns as the **ShotDistanceOnCourt** table above.
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
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    po_round = "",
    pace_adjust = "N",
    per_mode = "Totals",
    period = 0,
    player_id = "",
    plus_minus = "N",
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    shot_clock_range = "",
    team_id = "1610612749",
    vs_conference = "",
    vs_division = "",
    vs_player_id = "2544",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamvsplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team vs player data for {team_id} and {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team and Players vs Players**
#' @name nba_teamandplayersvsplayers
NULL
#' @title
#' **Get NBA Stats API Team and Players vs Players**
#' @rdname nba_teamandplayersvsplayers
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param vs_team_id Opponent Team ID to compare against
#' @param player_id1 Player ID 1 for team lineup
#' @param player_id2 Player ID 2 for team lineup
#' @param player_id3 Player ID 3 for team lineup
#' @param player_id4 Player ID 4 for team lineup
#' @param player_id5 Player ID 5 for team lineup
#' @param vs_player_id1 Opponent Player ID 1 for comparison lineup
#' @param vs_player_id2 Opponent Player ID 2 for comparison lineup
#' @param vs_player_id3 Opponent Player ID 3 for comparison lineup
#' @param vs_player_id4 Opponent Player ID 4 for comparison lineup
#' @param vs_player_id5 Opponent Player ID 5 for comparison lineup
#' @param season Season - format: '2023-24'
#' @param season_type Season Type - 'Regular Season', 'Playoffs'
#' @param measure_type Measure Type - 'Base', 'Advanced', 'Misc', 'Scoring', 'Usage'
#' @param per_mode Per Mode - 'Totals', 'PerGame', 'Per36', 'Per48'
#' @param plus_minus Plus Minus - 'Y' or 'N'
#' @param pace_adjust Pace Adjust - 'Y' or 'N'
#' @param rank Rank - 'Y' or 'N'
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param last_n_games Last N Games filter
#' @param month Month filter (0 for all)
#' @param opponent_team_id Opponent Team ID filter
#' @param period Period filter (0 for all)
#' @param conference Conference filter - 'East', 'West', or ''
#' @param date_from Date From filter - format: 'MM/DD/YYYY'
#' @param date_to Date To filter - format: 'MM/DD/YYYY'
#' @param division Division filter
#' @param game_segment Game Segment - 'First Half', 'Second Half', 'Overtime', or ''
#' @param location Location filter - 'Home', 'Road', or ''
#' @param outcome Outcome filter - 'W', 'L', or ''
#' @param season_segment Season Segment - 'Pre All-Star', 'Post All-Star', or ''
#' @param shot_clock_range Shot Clock Range filter
#' @param vs_conference Opponent Conference filter
#' @param vs_division Opponent Division filter
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayersVsPlayers,
#'  TeamPlayersVsPlayersOff, TeamPlayersVsPlayersOn, TeamVsPlayers, TeamVsPlayersOff
#'
#'    **PlayersVsPlayers**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GROUP_SET \tab character \tab  \cr
#'       TITLE_DESCRIPTION \tab character \tab  \cr
#'       DESCRIPTION \tab character \tab Long-form description text. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamPlayersVsPlayersOn**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GROUP_SET \tab character \tab  \cr
#'       TITLE_DESCRIPTION \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamPlayersVsPlayersOff**
#'
#'
#'    Same columns as the **TeamPlayersVsPlayersOn** table above.
#'
#'    **TeamVsPlayers**
#'
#'
#'    Same columns as the **PlayersVsPlayers** table above.
#'
#'    **TeamVsPlayersOff**
#'
#'
#'    Same columns as the **PlayersVsPlayers** table above.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' ```r
#'  nba_teamandplayersvsplayers(
#'    team_id = '1610612739',
#'    vs_team_id = '1610612765',
#'    player_id1 = '202681', player_id2 = '203078',
#'    player_id3 = '203507', player_id4 = '201567',
#'    player_id5 = '203954',
#'    vs_player_id1 = '201566', vs_player_id2 = '201939',
#'    vs_player_id3 = '201935', vs_player_id4 = '201142',
#'    vs_player_id5 = '203076',
#'    season = '2019-20')
#' ```
nba_teamandplayersvsplayers <- function(
    team_id,
    vs_team_id,
    player_id1,
    player_id2,
    player_id3,
    player_id4,
    player_id5,
    vs_player_id1,
    vs_player_id2,
    vs_player_id3,
    vs_player_id4,
    vs_player_id5,
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    measure_type = "Base",
    per_mode = "Totals",
    plus_minus = "N",
    pace_adjust = "N",
    rank = "N",
    league_id = "00",
    last_n_games = 0,
    month = 0,
    opponent_team_id = 0,
    period = 0,
    conference = "",
    date_from = "",
    date_to = "",
    division = "",
    game_segment = "",
    location = "",
    outcome = "",
    season_segment = "",
    shot_clock_range = "",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Pass SeasonType verbatim ("Regular Season"); the HTTP layer URL-encodes
  # the space. Manually substituting "+" double-encodes to %2B, which the
  # NBA Stats API rejects with {"SeasonType":"Invalid parameters"}.
  version <- "teamandplayersvsplayers"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    TeamID = team_id,
    VsTeamID = vs_team_id,
    PlayerID1 = player_id1,
    PlayerID2 = player_id2,
    PlayerID3 = player_id3,
    PlayerID4 = player_id4,
    PlayerID5 = player_id5,
    VsPlayerID1 = vs_player_id1,
    VsPlayerID2 = vs_player_id2,
    VsPlayerID3 = vs_player_id3,
    VsPlayerID4 = vs_player_id4,
    VsPlayerID5 = vs_player_id5,
    Season = season,
    SeasonType = season_type,
    MeasureType = measure_type,
    PerMode = per_mode,
    PlusMinus = plus_minus,
    PaceAdjust = pace_adjust,
    Rank = rank,
    LastNGames = last_n_games,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Period = period,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    GameSegment = game_segment,
    Location = location,
    Outcome = outcome,
    SeasonSegment = season_segment,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  df_list <- list()
  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team and players vs players data for {team_id} vs {vs_team_id} available!",
      args = .args
    ),
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
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_teamgamelogs()` instead.
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       GAMESTREAK \tab character \tab  \cr
#'       STARTDATE \tab character \tab  \cr
#'       ENDDATE \tab character \tab  \cr
#'       ACTIVESTREAK \tab character \tab  \cr
#'       NUMSEASONS \tab character \tab  \cr
#'       LASTSEASON \tab character \tab  \cr
#'       FIRSTSEASON \tab character \tab  \cr
#'       ABBREVIATION \tab character \tab Short abbreviation. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    active_streaks_only = "",
    active_teams_only = "",
    btr_opp_ast = "",
    btr_opp_blk = "",
    btr_opp_dreb = "",
    btr_opp_fg3a = "",
    btr_opp_fg3m = "",
    btr_opp_fg3_pct = "",
    btr_opp_fga = "",
    btr_opp_fgm = "",
    btr_opp_fg_pct = "",
    btr_opp_fta = "",
    btr_opp_ftm = "",
    btr_opp_ft_pct = "",
    btr_opp_oreb = "",
    btr_opp_pf = "",
    btr_opp_pts = "",
    btr_opp_pts2nd_chance = "",
    btr_opp_pts_fb = "",
    btr_opp_pts_off_tov = "",
    btr_opp_pts_paint = "",
    btr_opp_reb = "",
    btr_opp_stl = "",
    btr_opp_tov = "",
    conference = "",
    date_from = "",
    date_to = "",
    division = "",
    et_ast = "",
    et_blk = "",
    et_dd = "",
    et_dreb = "",
    et_fg3a = "",
    et_fg3m = "",
    et_fg3_pct = "",
    et_fga = "",
    et_fgm = "",
    et_fg_pct = "",
    et_fta = "",
    et_ftm = "",
    et_ft_pct = "",
    et_minutes = "",
    eq_opp_pts2nd_chance = "",
    eq_opp_pts_fb = "",
    eq_opp_pts_off_tov = "",
    eq_opp_pts_paint = "",
    et_oreb = "",
    et_pf = "",
    et_pts = "",
    eq_pts2nd_chance = "",
    eq_pts_fb = "",
    eq_pts_off_tov = "",
    eq_pts_paint = "",
    et_reb = "",
    et_stl = "",
    et_td = "",
    et_tov = "",
    game_id = "",
    gt_ast = "",
    gt_blk = "",
    gt_dd = "",
    gt_dreb = "",
    gt_fg3a = "",
    gt_fg3m = "",
    gt_fg3_pct = "",
    gt_fga = "",
    gt_fgm = "",
    gt_fg_pct = "",
    gt_fta = "",
    gt_ftm = "",
    gt_ft_pct = "",
    gt_minutes = "",
    gt_opp_ast = "",
    gt_opp_blk = "",
    gt_opp_dreb = "",
    gt_opp_fg3a = "",
    gt_opp_fg3m = "",
    gt_opp_fg3_pct = "",
    gt_opp_fga = "",
    gt_opp_fgm = "",
    gt_opp_fg_pct = "",
    gt_opp_fta = "",
    gt_opp_ftm = "",
    gt_opp_ft_pct = "",
    gt_opp_oreb = "",
    gt_opp_pf = "",
    gt_opp_pts = "",
    gt_opp_pts2nd_chance = "",
    gt_opp_pts_fb = "",
    gt_opp_pts_off_tov = "",
    gt_opp_pts_paint = "",
    gt_opp_reb = "",
    gt_opp_stl = "",
    gt_opp_tov = "",
    gt_oreb = "",
    gt_pf = "",
    gt_pts = "",
    gt_pts2nd_chance = "",
    gt_pts_fb = "",
    gt_pts_off_tov = "",
    gt_pts_paint = "",
    gt_reb = "",
    gt_stl = "",
    gt_td = "",
    gt_tov = "",
    lstreak = "",
    league_id = "00",
    location = "",
    lt_ast = "",
    lt_blk = "",
    lt_dd = "",
    lt_dreb = "",
    lt_fg3a = "",
    lt_fg3m = "",
    lt_fg3_pct = "",
    lt_fga = "",
    lt_fgm = "",
    lt_fg_pct = "",
    lt_fta = "",
    lt_ftm = "",
    lt_ft_pct = "",
    lt_minutes = "",
    lt_opp_ast = "",
    lt_opp_blk = "",
    lt_opp_dreb = "",
    lt_opp_fg3a = "",
    lt_opp_fg3m = "",
    lt_opp_fg3_pct = "",
    lt_opp_fga = "",
    lt_opp_fgm = "",
    lt_opp_fg_pct = "",
    lt_opp_fta = "",
    lt_opp_ftm = "",
    lt_opp_ft_pct = "",
    lt_opp_oreb = "",
    lt_opp_pf = "",
    lt_opp_pts = "",
    lt_opp_pts2nd_chance = "",
    lt_opp_pts_fb = "",
    lt_opp_pts_off_tov = "",
    lt_opp_pts_paint = "",
    lt_opp_reb = "",
    lt_opp_stl = "",
    lt_opp_tov = "",
    lt_oreb = "",
    lt_pf = "",
    lt_pts = "",
    lt_pts2nd_chance = "",
    lt_pts_fb = "",
    lt_pts_off_tov = "",
    lt_pts_paint = "",
    lt_reb = "",
    lt_stl = "",
    lt_td = "",
    lt_tov = "",
    min_games = "",
    outcome = "",
    po_round = "",
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = "",
    season_type = "Regular Season",
    team_id = "",
    vs_conference = "",
    vs_division = "",
    vs_team_id = "",
    wstreak = "",
    wrs_opp_ast = "",
    wrs_opp_blk = "",
    wrs_opp_dreb = "",
    wrs_opp_fg3a = "",
    wrs_opp_fg3m = "",
    wrs_opp_fg3_pct = "",
    wrs_opp_fga = "",
    wrs_opp_fgm = "",
    wrs_opp_fg_pct = "",
    wrs_opp_fta = "",
    wrs_opp_ftm = "",
    wrs_opp_ft_pct = "",
    wrs_opp_oreb = "",
    wrs_opp_pf = "",
    wrs_opp_pts = "",
    wrs_opp_pts2nd_chance = "",
    wrs_opp_pts_fb = "",
    wrs_opp_pts_off_tov = "",
    wrs_opp_pts_paint = "",
    wrs_opp_reb = "",
    wrs_opp_stl = "",
    wrs_opp_tov = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_teamgamestreakfinder()",
    with = "nba_teamgamelogs()"
  )

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamgamestreakfinder"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
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

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team streak finder data for the given parameters available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
