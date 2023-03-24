#' **Get NBA Stats API League Game Log**
#' @name nba_leaguegamelog
NULL
#' @title
#' **Get NBA Stats API League Game Log**
#' @rdname nba_leaguegamelog
#' @author Saiem Gilani
#' @param counter counter
#' @param date_from date_from
#' @param date_to date_to
#' @param direction direction
#' @param league_id league_id
#' @param player_or_team player_or_team
#' @param season season
#' @param season_type season_type
#' @param sorter sorter
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: LeagueGameLog
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [Player/Team Boxscores](https://www.nba.com/stats/players/boxscores)
#' ```r
#'  nba_leaguegamelog(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguegamelog <- function(
    counter = 0,
    date_from = '',
    date_to = '',
    direction = 'ASC',
    league_id = '00',
    player_or_team = 'T',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    sorter = 'DATE',
    ...){

  season_type <- gsub(' ','+',season_type)
  version <- "leaguegamelog"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Counter = counter,
    DateFrom = date_from,
    DateTo = date_to,
    Direction = direction,
    LeagueID = league_id,
    PlayerOrTeam = player_or_team,
    Season = season,
    SeasonType = season_type,
    Sorter = sorter
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league game log data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Standings**
#' @name nba_leaguestandings
NULL
#' @title
#' **Get NBA Stats API League Standings**
#' @rdname nba_leaguestandings
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Standings
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [League Standings](https://www.nba.com/standings)
#' ```r
#'  nba_leaguestandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguestandings <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    season_year = '',
    ...){

  season_type <- gsub(' ','+',season_type)
  version <- "leaguestandings"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league standings data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Standings V3**
#' @name nba_leaguestandingsv3
NULL
#' @title
#' **Get NBA Stats API League Standings V3**
#' @rdname nba_leaguestandingsv3
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Standings
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [League Standings](https://www.nba.com/standings)
#' ```r
#'  nba_leaguestandingsv3(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguestandingsv3 <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    season_year = '',
    ...){

  season_type <- gsub(' ','+',season_type)
  version <- "leaguestandingsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league standings v3 data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Playoff Picture**
#' @name nba_playoffpicture
NULL
#' @title
#' **Get NBA Stats API Playoff Picture**
#' @rdname nba_playoffpicture
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_id season_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: EastConfPlayoffPicture,
#' EastConfRemainingGames, EastConfStandings, WestConfPlayoffPicture,
#' WestConfRemainingGames, WestConfStandings
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playoffpicture <- function(
    league_id = '00',
    season_id = '22022',
    ...){

  version <- "playoffpicture"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonID = season_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no playoff picture data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Game Streak Finder**
#' @name nba_leaguegamefinder
NULL
#' @title
#' **Get NBA Stats API League Game Streak Finder**
#' @rdname nba_leaguegamefinder
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_year draft_year
#' @param draft_team_id draft_team_id
#' @param draft_round draft_round
#' @param draft_number draft_number
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
#' @param et_oreb et_oreb
#' @param et_pf et_pf
#' @param et_pts et_pts
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
#' @param gt_oreb gt_oreb
#' @param gt_pf gt_pf
#' @param gt_pts gt_pts
#' @param gt_reb gt_reb
#' @param gt_stl gt_stl
#' @param gt_td gt_td
#' @param gt_tov gt_tov
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
#' @param lt_oreb lt_oreb
#' @param lt_pf lt_pf
#' @param lt_pts lt_pts
#' @param lt_reb lt_reb
#' @param lt_stl lt_stl
#' @param lt_td lt_td
#' @param lt_tov lt_tov
#' @param outcome outcome
#' @param po_round po_round
#' @param player_or_team player_or_team
#' @param player_id player_id
#' @param rookie_year rookie_year
#' @param season season - Min: '1983-84'
#' @param season_segment season_segment
#' @param season_type season_type
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param years_experience years_experience
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: LeagueGameFinderResults
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_leaguegamefinder(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguegamefinder <- function(
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_year = '',
    draft_team_id = '',
    draft_round = '',
    draft_number = '',
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
    et_oreb = '',
    et_pf = '',
    et_pts = '',
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
    gt_oreb = '',
    gt_pf = '',
    gt_pts = '',
    gt_reb = '',
    gt_stl = '',
    gt_td = '',
    gt_tov = '',
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
    lt_oreb = '',
    lt_pf = '',
    lt_pts = '',
    lt_reb = '',
    lt_stl = '',
    lt_td = '',
    lt_tov = '',
    outcome = '',
    po_round = '',
    player_id = '',
    player_or_team = 'T',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    vs_team_id = '',
    years_experience = '',
    ...){

  season_type <- gsub(' ','+',season_type)
  version <- "leaguegamefinder"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftNumber = draft_number,
    DraftRound = draft_round,
    DraftTeamID = draft_team_id,
    DraftYear = draft_year,
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
    EqOREB = et_oreb,
    EqPF = et_pf,
    EqPTS = et_pts,
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
    GtOREB = gt_oreb,
    GtPF = gt_pf,
    GtPTS = gt_pts,
    GtREB = gt_reb,
    GtSTL = gt_stl,
    GtTD = gt_td,
    GtTOV = gt_tov,
    LeagueID = league_id,
    Location = location,
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
    LtOREB = lt_oreb,
    LtPF = lt_pf,
    LtPTS = lt_pts,
    LtREB = lt_reb,
    LtSTL = lt_stl,
    LtTD = lt_td,
    LtTOV = lt_tov,
    Outcome = outcome,
    PORound = po_round,
    PlayerID = player_id,
    PlayerOrTeam = player_or_team,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id,
    YearsExperience = years_experience
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league game finder data available for the given parameters!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
