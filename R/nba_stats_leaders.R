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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       GP \tab character \tab Games played. \cr
#'       GP_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PTSLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PTS_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **ASTLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       AST \tab character \tab Assists. \cr
#'       AST_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **STLLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       STL \tab character \tab Steals. \cr
#'       STL_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **OREBLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       OREB_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **DREBLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       DREB_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **REBLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       REB_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **BLKLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLK_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FGMLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGM_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FGALeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FGA_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FG_PCTLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG_PCT_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TOVLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       TOV_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FG3MLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3M_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FG3ALeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3A_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FG3_PCTLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FG3_PCT_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PFLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PF_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FTMLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTM_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FTALeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FTA_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **FT_PCTLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       FT_PCT_RANK \tab character \tab  \cr
#'       IS_ACTIVE_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_assistleaders
NULL
#' @title
#' **Get NBA Stats API Assist Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param player_or_team Player or Team
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AssistLeaders
#'
#'    **AssistLeaders**
#'
#'
#'    Columns as documented in the shared [nba_assistleaders_assistleaders_schema] table.
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_assisttracker
NULL
#' @title
#' **Get NBA Stats API Assist Tracker**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
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
#' @rdname nba_alltimeleadersgrids
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
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       RANK \tab character \tab Rank. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       PTS \tab character \tab Points scored. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       TS_PCT \tab character \tab True shooting percentage (0-1). \cr
#'       PTS_PER48 \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **LeagueAverage**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PTS \tab numeric \tab Points scored. \cr
#'       FG_PCT \tab numeric \tab Field goal percentage (0-1). \cr
#'       FG3_PCT \tab numeric \tab Three-point field goal percentage (0-1). \cr
#'       FT_PCT \tab numeric \tab Free throw percentage (0-1). \cr
#'       EFG_PCT \tab numeric \tab Effective field goal percentage (0-1). \cr
#'       TS_PCT \tab numeric \tab True shooting percentage (0-1). \cr
#'       PTS_PER48 \tab numeric \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **LeagueMax**
#'
#'
#'    Same columns as the **LeagueAverage** table above.
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
#' @rdname nba_alltimeleadersgrids
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
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
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
#'    Columns as documented in the shared [nba_homepagev2_homepagestat1_schema] table.
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
#'    Columns as documented in the shared [nba_assistleaders_assistleaders_schema] table.
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
#' @rdname nba_alltimeleadersgrids
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
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
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
#'    Columns as documented in the shared [nba_homepagev2_homepagestat1_schema] table.
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
#'    Columns as documented in the shared [nba_homepagev2_homepagestat1_schema] table.
#'
#'    **LowSeasonHigh**
#'
#'
#'    Same columns as the **AllTimeSeasonHigh** table above.
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_defensehub
NULL
#' @title
#' **Get NBA Stats API Defense Hub**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_leagueleaders
NULL
#' @title
#' **Get NBA Stats API League Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param active_flag Active Flag
#' @param scope Scope - RS, S, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueLeaders
#'
#'    **LeagueLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       RANK \tab character \tab Rank. \cr
#'       PLAYER \tab character \tab Player. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM \tab character \tab Team-side label or team identifier. \cr
#'       GP \tab character \tab Games played. \cr
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
#'       EFF \tab character \tab Eff. \cr
#'       AST_TOV \tab character \tab  \cr
#'       STL_TOV \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_dunkscoreleaders
NULL
#' @title
#' **Get NBA Stats API Dunk Score Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param player_id Player ID filter (optional, leave empty for all players)
#' @param team_id Team ID filter (optional, leave empty for all teams)
#' @param game_id Game ID filter (optional, leave empty for all games)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DunkScoreLeaders
#'
#'    **DunkScoreLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_date \tab character \tab Game date (YYYY-MM-DD). \cr
#'       matchup \tab character \tab Matchup. \cr
#'       period \tab character \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       game_clock_time \tab character \tab Time / clock value. \cr
#'       event_num \tab character \tab Sequential event number within the game (V2 PBP). \cr
#'       player_id \tab character \tab Unique player identifier. \cr
#'       player_name \tab character \tab Player name. \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       last_name \tab character \tab Player's last name. \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       dunk_score \tab character \tab Dunk score. \cr
#'       jump_subscore \tab character \tab Jump subscore. \cr
#'       power_subscore \tab character \tab Power subscore. \cr
#'       style_subscore \tab character \tab Style subscore. \cr
#'       defensive_contest_subscore \tab character \tab Defensive contest subscore. \cr
#'       max_ball_height \tab character \tab Max ball height. \cr
#'       ball_speed_through_rim \tab character \tab Ball speed through rim. \cr
#'       player_vertical \tab character \tab Player vertical. \cr
#'       hang_time \tab character \tab Time / clock value. \cr
#'       takeoff_distance \tab character \tab Takeoff distance. \cr
#'       reverse_dunk \tab character \tab Reverse dunk. \cr
#'       dunk360 \tab character \tab Dunk360. \cr
#'       through_the_legs \tab character \tab Through the legs. \cr
#'       alley_oop \tab character \tab Alley oop. \cr
#'       tip_in \tab character \tab Tip in. \cr
#'       self_oop \tab character \tab Self oop. \cr
#'       player_rotation \tab character \tab Player rotation. \cr
#'       player_lateral_speed \tab character \tab Player lateral speed. \cr
#'       ball_distance_traveled \tab character \tab Ball distance traveled. \cr
#'       ball_reach_back \tab character \tab Ball reach back. \cr
#'       total_ball_acceleration \tab character \tab Total ball acceleration. \cr
#'       dunking_hand \tab character \tab Dunking hand. \cr
#'       jumping_foot \tab character \tab Jumping foot. \cr
#'       pass_length \tab character \tab Pass length. \cr
#'       catching_hand \tab character \tab Catching hand. \cr
#'       catch_distance \tab character \tab Catch distance. \cr
#'       lateral_catch_distance \tab character \tab Lateral catch distance. \cr
#'       passer_id \tab character \tab Unique identifier for passer. \cr
#'       passer_name \tab character \tab Passer name. \cr
#'       passer_first_name \tab character \tab Passer first name. \cr
#'       passer_last_name \tab character \tab Passer last name. \cr
#'       pass_release_point \tab character \tab Pass release point. \cr
#'       shooter_id \tab character \tab Unique identifier for shooter. \cr
#'       shooter_name \tab character \tab Shooter name (for shot events). \cr
#'       shooter_first_name \tab character \tab Shooter first name. \cr
#'       shooter_last_name \tab character \tab Shooter last name. \cr
#'       shot_release_point \tab character \tab Shot release point. \cr
#'       shot_length \tab character \tab Shot length. \cr
#'       defensive_contest_level \tab character \tab Defensive contest level. \cr
#'       possible_attempted_charge \tab character \tab Possible attempted charge. \cr
#'       video_available \tab character \tab Video available. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname nba_alltimeleadersgrids
#' @name nba_gravityleaders
NULL
#' @title
#' **Get NBA Stats API Gravity Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: GravityLeaders
#'
#'    **GravityLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       playerid \tab character \tab Playerid. \cr
#'       firstname \tab character \tab Firstname. \cr
#'       lastname \tab character \tab Lastname. \cr
#'       teamid \tab character \tab Teamid. \cr
#'       teamabbreviation \tab character \tab Teamabbreviation. \cr
#'       teamname \tab character \tab Teamname. \cr
#'       teamcity \tab character \tab Teamcity. \cr
#'       frames \tab character \tab Frames. \cr
#'       gravityscore \tab character \tab Gravityscore. \cr
#'       avggravityscore \tab character \tab Avggravityscore. \cr
#'       onballperimeterframes \tab character \tab Onballperimeterframes. \cr
#'       onballperimetergravityscore \tab character \tab Onballperimetergravityscore. \cr
#'       avgonballperimetergravityscore \tab character \tab Avgonballperimetergravityscore. \cr
#'       offballperimeterframes \tab character \tab Offballperimeterframes. \cr
#'       offballperimetergravityscore \tab character \tab Offballperimetergravityscore. \cr
#'       avgoffballperimetergravityscore \tab character \tab Avgoffballperimetergravityscore. \cr
#'       onballinteriorframes \tab character \tab Onballinteriorframes. \cr
#'       onballinteriorgravityscore \tab character \tab Onballinteriorgravityscore. \cr
#'       avgonballinteriorgravityscore \tab character \tab Avgonballinteriorgravityscore. \cr
#'       offballinteriorframes \tab character \tab Offballinteriorframes. \cr
#'       offballinteriorgravityscore \tab character \tab Offballinteriorgravityscore. \cr
#'       avgoffballinteriorgravityscore \tab character \tab Avgoffballinteriorgravityscore. \cr
#'       gamesplayed \tab character \tab Gamesplayed. \cr
#'       minutes \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       pts \tab character \tab Points scored. \cr
#'       reb \tab character \tab Total rebounds. \cr
#'       ast \tab character \tab Assists. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
