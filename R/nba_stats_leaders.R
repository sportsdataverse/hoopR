#' **Get NBA Stats API All-time Leaders Grid**
#' @name nba_alltimeleadersgrids
NULL
#' @title
#' **Get NBA Stats API All-time Leaders Grid**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param top_x Top X
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: ASTLeaders, BLKLeaders, DREBLeaders, FG3ALeaders,
#'  FG3MLeaders, FG3_PCTLeaders, FGALeaders, FGMLeaders,
#'  FG_PCTLeaders, FTALeaders, FTMLeaders, FT_PCTLeaders, GPLeaders,
#'  OREBLeaders, PFLeaders, PTSLeaders, REBLeaders, STLLeaders, TOVLeaders
#'
#'    **GPLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |GP             |character |Games played.             |
#'    |GP_RANK        |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **PTSLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |PTS            |character |Points scored.            |
#'    |PTS_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **ASTLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |AST            |character |Assists.                  |
#'    |AST_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **STLLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |STL            |character |Steals.                   |
#'    |STL_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **OREBLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |OREB           |character |Offensive rebounds.       |
#'    |OREB_RANK      |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **DREBLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |DREB           |character |Defensive rebounds.       |
#'    |DREB_RANK      |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **REBLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |REB            |character |Total rebounds.           |
#'    |REB_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **BLKLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |BLK            |character |Blocks.                   |
#'    |BLK_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FGMLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |FGM            |character |Field goals made.         |
#'    |FGM_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FGALeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |FGA            |character |Field goal attempts.      |
#'    |FGA_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FG_PCTLeaders**
#'
#'
#'    |col_name       |types     |description                  |
#'    |:--------------|:---------|:----------------------------|
#'    |PLAYER_ID      |character |Unique player identifier.    |
#'    |PLAYER_NAME    |character |Player name.                 |
#'    |FG_PCT         |character |Field goal percentage (0-1). |
#'    |FG_PCT_RANK    |character |                             |
#'    |IS_ACTIVE_FLAG |character |                             |
#'
#'    **TOVLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |TOV            |character |Turnovers.                |
#'    |TOV_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FG3MLeaders**
#'
#'
#'    |col_name       |types     |description                   |
#'    |:--------------|:---------|:-----------------------------|
#'    |PLAYER_ID      |character |Unique player identifier.     |
#'    |PLAYER_NAME    |character |Player name.                  |
#'    |FG3M           |character |Three-point field goals made. |
#'    |FG3M_RANK      |character |                              |
#'    |IS_ACTIVE_FLAG |character |                              |
#'
#'    **FG3ALeaders**
#'
#'
#'    |col_name       |types     |description                      |
#'    |:--------------|:---------|:--------------------------------|
#'    |PLAYER_ID      |character |Unique player identifier.        |
#'    |PLAYER_NAME    |character |Player name.                     |
#'    |FG3A           |character |Three-point field goal attempts. |
#'    |FG3A_RANK      |character |                                 |
#'    |IS_ACTIVE_FLAG |character |                                 |
#'
#'    **FG3_PCTLeaders**
#'
#'
#'    |col_name       |types     |description                              |
#'    |:--------------|:---------|:----------------------------------------|
#'    |PLAYER_ID      |character |Unique player identifier.                |
#'    |PLAYER_NAME    |character |Player name.                             |
#'    |FG3_PCT        |character |Three-point field goal percentage (0-1). |
#'    |FG3_PCT_RANK   |character |                                         |
#'    |IS_ACTIVE_FLAG |character |                                         |
#'
#'    **PFLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |PF             |character |Personal fouls.           |
#'    |PF_RANK        |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FTMLeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |FTM            |character |Free throws made.         |
#'    |FTM_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FTALeaders**
#'
#'
#'    |col_name       |types     |description               |
#'    |:--------------|:---------|:-------------------------|
#'    |PLAYER_ID      |character |Unique player identifier. |
#'    |PLAYER_NAME    |character |Player name.              |
#'    |FTA            |character |Free throw attempts.      |
#'    |FTA_RANK       |character |                          |
#'    |IS_ACTIVE_FLAG |character |                          |
#'
#'    **FT_PCTLeaders**
#'
#'
#'    |col_name       |types     |description                  |
#'    |:--------------|:---------|:----------------------------|
#'    |PLAYER_ID      |character |Unique player identifier.    |
#'    |PLAYER_NAME    |character |Player name.                 |
#'    |FT_PCT         |character |Free throw percentage (0-1). |
#'    |FT_PCT_RANK    |character |                             |
#'    |IS_ACTIVE_FLAG |character |                             |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_alltimeleadersgrids(league_id = '00')
#' ```

nba_alltimeleadersgrids <- function(
    league_id = '00',
    per_mode = 'PerGame',
    season_type = 'Regular Season',
    top_x = 10,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "alltimeleadersgrids"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no all-time leaders grid data for {league_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Assist Leaders**
#' @name nba_assistleaders
NULL
#' @title
#' **Get NBA Stats API Assist Leaders**
#' @rdname nba_assistleaders
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param player_or_team Player or Team
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AssistLeaders
#'
#'    **AssistLeaders**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |AST               |character |Assists.                                        |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_assistleaders(league_id = '00', player_or_team = "Player")
#'  nba_assistleaders(league_id = '00', player_or_team = "Team")
#' ```
nba_assistleaders <- function(
    league_id = '00',
    per_mode = 'PerGame',
    player_or_team = 'Team',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ','+',season_type)
  version <- "assistleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    PlayerOrTeam = player_or_team,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no assist leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
#' **Get NBA Stats API Assist Tracker**
#' @name nba_assisttracker
NULL
#' @title
#' **Get NBA Stats API Assist Tracker**
#' @rdname nba_assisttracker
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AssistTracker
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'   nba_assisttracker(league_id = '00')
#' ```
nba_assisttracker <- function(
    league_id = '00',
    per_mode = 'PerGame',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  version <- "assisttracker"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    Season = season,
    SeasonType = season_type)

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no assist tracker data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Homepage Leaders**
#' @name nba_homepageleaders
NULL
#' @title
#' **Get NBA Stats API Homepage Leaders**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead. Note: `stat_category = "Defense"` was
#' never supported upstream by this endpoint even before deprecation (#51).
#' @rdname nba_homepageleaders
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat_category Stat Category: Points, Rebounds, Assists, Defense, Clutch, Playmaking, Efficiency, Fast Break, Scoring Breakdown
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HomePageLeaders, LeagueAverage, LeagueMax
#'
#'    **HomePageLeaders**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |PTS               |character |Points scored.                                  |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).        |
#'    |FT_PCT            |character |Free throw percentage (0-1).                    |
#'    |EFG_PCT           |character |Effective field goal percentage (0-1).          |
#'    |TS_PCT            |character |True shooting percentage (0-1).                 |
#'    |PTS_PER48         |character |                                                |
#'
#'    **LeagueAverage**
#'
#'
#'    |col_name  |types   |description                              |
#'    |:---------|:-------|:----------------------------------------|
#'    |PTS       |numeric |Points scored.                           |
#'    |FG_PCT    |numeric |Field goal percentage (0-1).             |
#'    |FG3_PCT   |numeric |Three-point field goal percentage (0-1). |
#'    |FT_PCT    |numeric |Free throw percentage (0-1).             |
#'    |EFG_PCT   |numeric |Effective field goal percentage (0-1).   |
#'    |TS_PCT    |numeric |True shooting percentage (0-1).          |
#'    |PTS_PER48 |numeric |                                         |
#'
#'    **LeagueMax**
#'
#'
#'    |col_name  |types   |description                              |
#'    |:---------|:-------|:----------------------------------------|
#'    |PTS       |numeric |Points scored.                           |
#'    |FG_PCT    |numeric |Field goal percentage (0-1).             |
#'    |FG3_PCT   |numeric |Three-point field goal percentage (0-1). |
#'    |FT_PCT    |numeric |Free throw percentage (0-1).             |
#'    |EFG_PCT   |numeric |Effective field goal percentage (0-1).   |
#'    |TS_PCT    |numeric |True shooting percentage (0-1).          |
#'    |PTS_PER48 |numeric |                                         |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_homepageleaders(league_id = '00', player_or_team = "Player")
#'  nba_homepageleaders(league_id = '00', player_or_team = "Team")
#' ```
nba_homepageleaders <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    stat_category = 'Points',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_homepageleaders()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple league/season/player_or_team combinations returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # Intentional
  # season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "homepageleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope =  game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    StatCategory = stat_category
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no homepage leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API HomepageV2 Leaders**
#' @name nba_homepagev2
NULL
#' @title
#' **Get NBA Stats API HomepageV2 Leaders**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead.
#' @rdname nba_homepagev2
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat_type Stat Type - Traditional, Advanced, Tracking
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HomePageStat1, HomePageStat2, HomePageStat3,
#'  HomePageStat4, HomePageStat5, HomePageStat6, HomePageStat7, HomePageStat8
#'
#'    **HomePageStat1**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |PTS               |character |Points scored.                                  |
#'
#'    **HomePageStat2**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |REB               |character |Total rebounds.                                 |
#'
#'    **HomePageStat3**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |AST               |character |Assists.                                        |
#'
#'    **HomePageStat4**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |STL               |character |Steals.                                         |
#'
#'    **HomePageStat5**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'
#'    **HomePageStat6**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |FT_PCT            |character |Free throw percentage (0-1).                    |
#'
#'    **HomePageStat7**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).        |
#'
#'    **HomePageStat8**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |BLK               |character |Blocks.                                         |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_homepagev2(league_id = '00', player_or_team = "Player")
#'  nba_homepagev2(league_id = '00', player_or_team = "Team")
#' ```

nba_homepagev2 <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    stat_type = 'Traditional',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_homepagev2()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # Intentional
  # season_type <- gsub(' ','+',season_type)
  stat_type <- gsub(' ','+',stat_type)
  version <- "homepagev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    StatType = stat_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no homepage v2 data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Leaders Tiles**
#' @name nba_leaderstiles
NULL
#' @title
#' **Get NBA Stats API Leaders Tiles**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead.
#' @rdname nba_leaderstiles
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat Stat - PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AllTimeSeasonHigh, LastSeasonHigh, LeadersTiles, LowSeasonHigh,
#'
#'    **LeadersTiles**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |PTS               |character |Points scored.                                  |
#'
#'    **AllTimeSeasonHigh**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |SEASON_YEAR       |character |Season year string ('YYYY-YY' format).          |
#'    |PTS               |character |Points scored.                                  |
#'
#'    **LastSeasonHigh**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |RANK              |character |Rank.                                           |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |PTS               |character |Points scored.                                  |
#'
#'    **LowSeasonHigh**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |SEASON_YEAR       |character |Season year string ('YYYY-YY' format).          |
#'    |PTS               |character |Points scored.                                  |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_leaderstiles(league_id = '00', player_or_team = "Player")
#'  nba_leaderstiles(league_id = '00', player_or_team = "Team")
#' ```

nba_leaderstiles <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    stat = 'PTS',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_leaderstiles()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # season_type <- gsub(' ','+',season_type)
  stat <- gsub(' ','+',stat)
  version <- "leaderstiles"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    Stat = stat
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no leaders tiles data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Defense Hub**
#' @name nba_defensehub
NULL
#' @title
#' **Get NBA Stats API Defense Hub**
#' @rdname nba_defensehub
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DefenseHubStat1, DefenseHubStat10, DefenseHubStat2, DefenseHubStat3, DefenseHubStat4, DefenseHubStat5, DefenseHubStat6,
#' DefenseHubStat7, DefenseHubStat8, DefenseHubStat9
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_defensehub(league_id = '00', player_or_team = "Player")
#'  nba_defensehub(league_id = '00', player_or_team = "Team")
#' ```

nba_defensehub <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  player_scope <- gsub(' ','+',player_scope)
  # season_type <- gsub(' ','+',season_type)
  version <- "defensehub"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defense hub data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API League Leaders**
#' @name nba_leagueleaders
NULL
#' @title
#' **Get NBA Stats API League Leaders**
#' @rdname nba_leagueleaders
#' @author Saiem Gilani
#' @param active_flag Active Flag
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param per_mode Per Mode - Totals, PerGame, Per48
#' @param scope Scope - RS, S, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat_category Stat Category: PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueLeaders
#'
#'    **LeagueLeaders**
#'
#'
#'    |col_name  |types     |description                              |
#'    |:---------|:---------|:----------------------------------------|
#'    |PLAYER_ID |character |Unique player identifier.                |
#'    |RANK      |character |Rank.                                    |
#'    |PLAYER    |character |Player.                                  |
#'    |TEAM_ID   |character |Unique team identifier.                  |
#'    |TEAM      |character |Team-side label or team identifier.      |
#'    |GP        |character |Games played.                            |
#'    |MIN       |character |Minutes played.                          |
#'    |FGM       |character |Field goals made.                        |
#'    |FGA       |character |Field goal attempts.                     |
#'    |FG_PCT    |character |Field goal percentage (0-1).             |
#'    |FG3M      |character |Three-point field goals made.            |
#'    |FG3A      |character |Three-point field goal attempts.         |
#'    |FG3_PCT   |character |Three-point field goal percentage (0-1). |
#'    |FTM       |character |Free throws made.                        |
#'    |FTA       |character |Free throw attempts.                     |
#'    |FT_PCT    |character |Free throw percentage (0-1).             |
#'    |OREB      |character |Offensive rebounds.                      |
#'    |DREB      |character |Defensive rebounds.                      |
#'    |REB       |character |Total rebounds.                          |
#'    |AST       |character |Assists.                                 |
#'    |STL       |character |Steals.                                  |
#'    |BLK       |character |Blocks.                                  |
#'    |TOV       |character |Turnovers.                               |
#'    |PF        |character |Personal fouls.                          |
#'    |PTS       |character |Points scored.                           |
#'    |EFF       |character |Eff.                                     |
#'    |AST_TOV   |character |                                         |
#'    |STL_TOV   |character |                                         |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' [League Leaders](https://www.nba.com/stats/leaders)
#' ```r
#'  nba_leagueleaders(league_id = '00')
#' ```

nba_leagueleaders <- function(
    active_flag = '',
    league_id = '00',
    per_mode = 'Totals',
    scope = 'S',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    stat_category = 'PTS',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  scope <- gsub(' ','+',scope)
  # season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "leagueleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    ActiveFlag = active_flag,
    PerMode = per_mode,
    Scope = scope,
    Season = season,
    SeasonType = season_type,
    StatCategory = stat_category
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
      hint = "Invalid arguments or no league leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Dunk Score Leaders**
#' @name nba_dunkscoreleaders
NULL
#' @title
#' **Get NBA Stats API Dunk Score Leaders**
#' @rdname nba_dunkscoreleaders
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format: '2023-24'
#' @param season_type Season Type - 'Regular Season', 'Playoffs'
#' @param player_id Player ID filter (optional, leave empty for all players)
#' @param team_id Team ID filter (optional, leave empty for all teams)
#' @param game_id Game ID filter (optional, leave empty for all games)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DunkScoreLeaders
#'
#'    **DunkScoreLeaders**
#'
#'
#'    |col_name                   |types     |description                                       |
#'    |:--------------------------|:---------|:-------------------------------------------------|
#'    |game_id                    |character |Unique game identifier.                           |
#'    |game_date                  |character |Game date (YYYY-MM-DD).                           |
#'    |matchup                    |character |Matchup.                                          |
#'    |period                     |character |Period of the game (1-4 quarters; 5+ for OT).     |
#'    |game_clock_time            |character |Time / clock value.                               |
#'    |event_num                  |character |Sequential event number within the game (V2 PBP). |
#'    |player_id                  |character |Unique player identifier.                         |
#'    |player_name                |character |Player name.                                      |
#'    |first_name                 |character |Player's first name.                              |
#'    |last_name                  |character |Player's last name.                               |
#'    |team_id                    |character |Unique team identifier.                           |
#'    |team_name                  |character |Full team display name (e.g. 'Las Vegas Aces').   |
#'    |team_city                  |character |Team city or region (e.g. 'Las Vegas').           |
#'    |team_abbreviation          |character |Short team abbreviation (e.g. 'LAS').             |
#'    |dunk_score                 |character |Dunk score.                                       |
#'    |jump_subscore              |character |Jump subscore.                                    |
#'    |power_subscore             |character |Power subscore.                                   |
#'    |style_subscore             |character |Style subscore.                                   |
#'    |defensive_contest_subscore |character |Defensive contest subscore.                       |
#'    |max_ball_height            |character |Max ball height.                                  |
#'    |ball_speed_through_rim     |character |Ball speed through rim.                           |
#'    |player_vertical            |character |Player vertical.                                  |
#'    |hang_time                  |character |Time / clock value.                               |
#'    |takeoff_distance           |character |Takeoff distance.                                 |
#'    |reverse_dunk               |character |Reverse dunk.                                     |
#'    |dunk360                    |character |Dunk360.                                          |
#'    |through_the_legs           |character |Through the legs.                                 |
#'    |alley_oop                  |character |Alley oop.                                        |
#'    |tip_in                     |character |Tip in.                                           |
#'    |self_oop                   |character |Self oop.                                         |
#'    |player_rotation            |character |Player rotation.                                  |
#'    |player_lateral_speed       |character |Player lateral speed.                             |
#'    |ball_distance_traveled     |character |Ball distance traveled.                           |
#'    |ball_reach_back            |character |Ball reach back.                                  |
#'    |total_ball_acceleration    |character |Total ball acceleration.                          |
#'    |dunking_hand               |character |Dunking hand.                                     |
#'    |jumping_foot               |character |Jumping foot.                                     |
#'    |pass_length                |character |Pass length.                                      |
#'    |catching_hand              |character |Catching hand.                                    |
#'    |catch_distance             |character |Catch distance.                                   |
#'    |lateral_catch_distance     |character |Lateral catch distance.                           |
#'    |passer_id                  |character |Unique identifier for passer.                     |
#'    |passer_name                |character |Passer name.                                      |
#'    |passer_first_name          |character |Passer first name.                                |
#'    |passer_last_name           |character |Passer last name.                                 |
#'    |pass_release_point         |character |Pass release point.                               |
#'    |shooter_id                 |character |Unique identifier for shooter.                    |
#'    |shooter_name               |character |Shooter name (for shot events).                   |
#'    |shooter_first_name         |character |Shooter first name.                               |
#'    |shooter_last_name          |character |Shooter last name.                                |
#'    |shot_release_point         |character |Shot release point.                               |
#'    |shot_length                |character |Shot length.                                      |
#'    |defensive_contest_level    |character |Defensive contest level.                          |
#'    |possible_attempted_charge  |character |Possible attempted charge.                        |
#'    |video_available            |character |Video available.                                  |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_dunkscoreleaders(season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_dunkscoreleaders <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    player_id = '',
    team_id = '',
    game_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "dunkscoreleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type
  )
  if (nchar(player_id) > 0) params[["PlayerID"]] <- player_id
  if (nchar(team_id) > 0) params[["TeamID"]] <- team_id
  if (nchar(game_id) > 0) params[["GameID"]] <- game_id

  df_list <- list()
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      dunks <- resp %>%
        purrr::pluck("dunks")

      if (length(dunks) > 0) {
        data <- dunks %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("Dunk Score Leaders from NBA.com", Sys.time())
      } else {
        data <- dplyr::tibble()
      }

      df_list <- c(list(data))
      names(df_list) <- c("DunkScoreLeaders")

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no dunk score leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Gravity Leaders**
#' @name nba_gravityleaders
NULL
#' @title
#' **Get NBA Stats API Gravity Leaders**
#' @rdname nba_gravityleaders
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format: '2023-24'
#' @param season_type Season Type - 'Regular Season', 'Playoffs'
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: GravityLeaders
#'
#'    **GravityLeaders**
#'
#'
#'    |col_name                        |types     |description                                                                      |
#'    |:-------------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |playerid                        |character |Playerid.                                                                        |
#'    |firstname                       |character |Firstname.                                                                       |
#'    |lastname                        |character |Lastname.                                                                        |
#'    |teamid                          |character |Teamid.                                                                          |
#'    |teamabbreviation                |character |Teamabbreviation.                                                                |
#'    |teamname                        |character |Teamname.                                                                        |
#'    |teamcity                        |character |Teamcity.                                                                        |
#'    |frames                          |character |Frames.                                                                          |
#'    |gravityscore                    |character |Gravityscore.                                                                    |
#'    |avggravityscore                 |character |Avggravityscore.                                                                 |
#'    |onballperimeterframes           |character |Onballperimeterframes.                                                           |
#'    |onballperimetergravityscore     |character |Onballperimetergravityscore.                                                     |
#'    |avgonballperimetergravityscore  |character |Avgonballperimetergravityscore.                                                  |
#'    |offballperimeterframes          |character |Offballperimeterframes.                                                          |
#'    |offballperimetergravityscore    |character |Offballperimetergravityscore.                                                    |
#'    |avgoffballperimetergravityscore |character |Avgoffballperimetergravityscore.                                                 |
#'    |onballinteriorframes            |character |Onballinteriorframes.                                                            |
#'    |onballinteriorgravityscore      |character |Onballinteriorgravityscore.                                                      |
#'    |avgonballinteriorgravityscore   |character |Avgonballinteriorgravityscore.                                                   |
#'    |offballinteriorframes           |character |Offballinteriorframes.                                                           |
#'    |offballinteriorgravityscore     |character |Offballinteriorgravityscore.                                                     |
#'    |avgoffballinteriorgravityscore  |character |Avgoffballinteriorgravityscore.                                                  |
#'    |gamesplayed                     |character |Gamesplayed.                                                                     |
#'    |minutes                         |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |pts                             |character |Points scored.                                                                   |
#'    |reb                             |character |Total rebounds.                                                                  |
#'    |ast                             |character |Assists.                                                                         |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_gravityleaders(season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_gravityleaders <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "gravityleaders"
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

      leaders <- resp %>%
        purrr::pluck("leaders")

      if (length(leaders) > 0) {
        data <- leaders %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("Gravity Leaders from NBA.com", Sys.time())
      } else {
        data <- dplyr::tibble()
      }

      df_list <- c(list(data))
      names(df_list) <- c("GravityLeaders")

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no gravity leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
