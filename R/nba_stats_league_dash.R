

#' **Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**
#' @name nba_leaguedashoppptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param close_def_dist_range close_def_dist_range
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param dribble_range dribble_range
#' @param game_segment game_segment
#' @param general_range general_range
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
#' @param shot_dist_range shot_dist_range
#' @param team_id team_id
#' @param touch_time_range touch_time_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPTShots
#'
#'    **LeagueDashPTShots**
#'
#'
#'    Columns as documented in the shared [nba_leaguedashoppptshot_leaguedashptshots_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Opponent Shots - General](https://www.nba.com/stats/teams/opponent-shots-general)
#' ```r
#'  nba_leaguedashoppptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashoppptshot <- function(
    close_def_dist_range = '',
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    dribble_range = '',
    game_segment = '',
    general_range = '',
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
    plus_minus = 'N',
    rank = 'Y',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    shot_dist_range = '',
    team_id = '',
    touch_time_range = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashoppptshot"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    CloseDefDistRange = close_def_dist_range,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DribbleRange = dribble_range,
    GameSegment = game_segment,
    GeneralRange = general_range,
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    ShotDistRange = shot_dist_range,
    TeamID = team_id,
    TouchTimeRange = touch_time_range,
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
      hint = "Invalid arguments or no league dashboard player-tracking oppponent shooting data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Biographical Stats**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashplayerbiostats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Biographical Stats**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param game_segment game_segment
#' @param game_scope game_scope
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param touch_time_range touch_time_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPlayerBioStats
#'
#'    **LeagueDashPlayerBioStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       PLAYER_HEIGHT \tab character \tab  \cr
#'       PLAYER_HEIGHT_INCHES \tab character \tab  \cr
#'       PLAYER_WEIGHT \tab character \tab  \cr
#'       COLLEGE \tab character \tab College or school attended. \cr
#'       COUNTRY \tab character \tab Country (full name or code). \cr
#'       DRAFT_YEAR \tab character \tab Draft year (4-digit). \cr
#'       DRAFT_ROUND \tab character \tab Round of the draft selection. \cr
#'       DRAFT_NUMBER \tab character \tab  \cr
#'       GP \tab character \tab Games played. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       NET_RATING \tab character \tab Net rating (off rating - def rating). \cr
#'       OREB_PCT \tab character \tab Offensive rebound percentage (0-1). \cr
#'       DREB_PCT \tab character \tab Defensive rebound percentage (0-1). \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'       TS_PCT \tab character \tab True shooting percentage (0-1). \cr
#'       AST_PCT \tab character \tab Assist percentage (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Functions
#' @details
#' [Player Bio Stats](https://www.nba.com/stats/players/bio)
#' ```r
#'  nba_leaguedashplayerbiostats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashplayerbiostats <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    game_segment = '',
    game_scope = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    period = '',
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    touch_time_range = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashplayerbiostats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    GameScope = game_scope,
    GameSegment = game_segment,
    Height = height,
    LastNGames = last_n_games,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    TouchTimeRange = touch_time_range,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player bio stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Dashboard by Player Clutch Splits**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashplayerclutch
NULL
#' @title
#' **Get NBA Stats API League Dashboard by Player Clutch Splits**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param ahead_behind ahead_behind
#' @param clutch_time clutch_time
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param plus_minus plus_minus
#' @param point_diff point_diff
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_position player_position
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param touch_time_range touch_time_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPlayerClutch
#'
#'    **LeagueDashPlayerClutch**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GROUP_SET \tab character \tab  \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
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
#' @family NBA League Functions
#' @family NBA Player Functions
#' @details
#' [Players Clutch Stats](https://www.nba.com/stats/players/clutch-traditional)
#' ```r
#'  nba_leaguedashplayerclutch(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashplayerclutch <- function(
    ahead_behind = 'Ahead or Behind',
    clutch_time = 'Last 5 Minutes',
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    game_scope = '',
    game_segment = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    plus_minus = 'N',
    point_diff = 5,
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    player_experience = '',
    player_position = '',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    touch_time_range = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # ahead_behind <- gsub(' ', '+', ahead_behind)
  # clutch_time <- gsub(' ', '+', clutch_time)
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashplayerclutch"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    AheadBehind = ahead_behind,
    ClutchTime = clutch_time,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    GameScope = game_scope,
    GameSegment = game_segment,
    Height = height,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    PlusMinus = plus_minus,
    PointDiff = point_diff,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    TouchTimeRange = touch_time_range,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player clutch stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Player Shots**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashplayerptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Player Shots**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param close_def_dist_range close_def_dist_range
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param distance_range distance_range
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param dribble_range dribble_range
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param general_range general_range
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param shot_dist_range shot_dist_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param touch_time_range touch_time_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPTShots
#'
#'    **LeagueDashPTShots**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       PLAYER_LAST_TEAM_ID \tab character \tab  \cr
#'       PLAYER_LAST_TEAM_ABBREVIATION \tab character \tab  \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       GP \tab character \tab Games played. \cr
#'       G \tab character \tab Games played. \cr
#'       FGA_FREQUENCY \tab character \tab  \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       FG2A_FREQUENCY \tab character \tab  \cr
#'       FG2M \tab character \tab  \cr
#'       FG2A \tab character \tab  \cr
#'       FG2_PCT \tab character \tab  \cr
#'       FG3A_FREQUENCY \tab character \tab  \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Players Shot Dashboard](https://www.nba.com/stats/players/shots-general)
#' ```r
#'  nba_leaguedashplayerptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashplayerptshot <- function(
    close_def_dist_range = '',
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    distance_range = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    dribble_range = '',
    game_scope = '',
    game_segment = '',
    general_range = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    shot_dist_range = '',
    starter_bench = '',
    team_id = '',
    touch_time_range = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashplayerptshot"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    CloseDefDistRange = close_def_dist_range,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    DistanceRange = distance_range,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    DribbleRange = dribble_range,
    GameScope = game_scope,
    GameSegment = game_segment,
    GeneralRange = general_range,
    Height = height,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    TouchTimeRange = touch_time_range,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player-tracking player shooting data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Stats**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashplayerstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Stats**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_position player_position
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param two_way two_way
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPlayerStats
#'
#'    **LeagueDashPlayerStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
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
#' @family NBA League Functions
#' @family NBA Player Functions
#' @details
#' [Players Stats](https://www.nba.com/stats/players/traditional)
#' ```r
#'  nba_leaguedashplayerstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashplayerstats <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    game_scope = '',
    game_segment = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    player_experience = '',
    player_position = '',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    two_way = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashplayerstats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    GameScope = game_scope,
    GameSegment = game_segment,
    Height = height,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    TwoWay = two_way,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Dashboard Player Shot Locations**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashplayershotlocations
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Shot Locations**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param distance_range distance_range
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param dribble_range dribble_range
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param height height
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
#' @param player_experience player_experience
#' @param player_position player_position
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: ShotLocations
#'
#'    **ShotLocations**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       Restricted_Area_FGM \tab character \tab  \cr
#'       Restricted_Area_FGA \tab character \tab  \cr
#'       Restricted_Area_FG_PCT \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FGM \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FGA \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FG_PCT \tab character \tab  \cr
#'       Mid_Range_FGM \tab character \tab  \cr
#'       Mid_Range_FGA \tab character \tab  \cr
#'       Mid_Range_FG_PCT \tab character \tab  \cr
#'       Left_Corner_3_FGM \tab character \tab  \cr
#'       Left_Corner_3_FGA \tab character \tab  \cr
#'       Left_Corner_3_FG_PCT \tab character \tab  \cr
#'       Right_Corner_3_FGM \tab character \tab  \cr
#'       Right_Corner_3_FGA \tab character \tab  \cr
#'       Right_Corner_3_FG_PCT \tab character \tab  \cr
#'       Above_the_Break_3_FGM \tab character \tab  \cr
#'       Above_the_Break_3_FGA \tab character \tab  \cr
#'       Above_the_Break_3_FG_PCT \tab character \tab  \cr
#'       Backcourt_FGM \tab character \tab  \cr
#'       Backcourt_FGA \tab character \tab  \cr
#'       Backcourt_FG_PCT \tab character \tab  \cr
#'       Corner_3_FGM \tab character \tab  \cr
#'       Corner_3_FGA \tab character \tab  \cr
#'       Corner_3_FG_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Functions
#' @family NBA Shooting Functions
#' @details
#' [Players Shooting by Shot Location](https://www.nba.com/stats/players/shooting)
#' ```r
#'  nba_leaguedashplayershotlocations(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashplayershotlocations <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    distance_range = 'By Zone',
    division = '',
    draft_pick = '',
    draft_year = '',
    dribble_range = '',
    game_scope = '',
    game_segment = '',
    height = '',
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
    player_experience = '',
    player_position = '',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # distance_range <- gsub(' ', '+', distance_range)
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashplayershotlocations"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DistanceRange = distance_range,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    DribbleRange = dribble_range,
    GameScope = game_scope,
    GameSegment = game_segment,
    Height = height,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          dplyr::as_tibble()
        columnsToSkip <- resp$resultSets$headers$columnsToSkip[[1]]
        columnSpan <- resp$resultSets$headers$columnSpan[[1]]
        json_names1 <- resp$resultSets$headers$columnNames[[1]]
        json_names_rep <- rep(json_names1, times = 1, each = columnSpan)
        json_names2 <- resp$resultSets$headers$columnNames[[2]]
        json_names <- c(json_names2[1:columnsToSkip], paste(json_names_rep, json_names2[(columnsToSkip + 1):30]))
        colnames(data) <- gsub('\\(|\\)|','', gsub(' |-','_',json_names))
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player shot locations data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Defense**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashptdefend
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Defense**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param defense_category defense_category
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param game_segment game_segment
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_id player_id
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPTDefend
#'
#'    **LeagueDashPTDefend**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       CLOSE_DEF_PERSON_ID \tab character \tab  \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       PLAYER_LAST_TEAM_ID \tab character \tab  \cr
#'       PLAYER_LAST_TEAM_ABBREVIATION \tab character \tab  \cr
#'       PLAYER_POSITION \tab character \tab  \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       GP \tab character \tab Games played. \cr
#'       G \tab character \tab Games played. \cr
#'       FREQ \tab character \tab  \cr
#'       D_FGM \tab character \tab  \cr
#'       D_FGA \tab character \tab  \cr
#'       D_FG_PCT \tab character \tab  \cr
#'       NORMAL_FG_PCT \tab character \tab  \cr
#'       PCT_PLUSMINUS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Defensive Dashboard](https://www.nba.com/stats/players/defense-dash-overall)
#' ```r
#'  nba_leaguedashptdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashptdefend <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    defense_category = 'Overall',
    division = '',
    draft_pick = '',
    draft_year = '',
    game_segment = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    period = '',
    player_experience = '',
    player_id = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashptdefend"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    DefenseCategory = defense_category,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    GameSegment = game_segment,
    Height = height,
    LastNGames = last_n_games,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerExperience = player_experience,
    PlayerID = player_id,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player-tracking player defense data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Stats**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashptstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Stats**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param game_scope game_scope
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_or_team player_or_team
#' @param player_position player_position
#' @param pt_measure_type pt_measure_type
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPtStats
#'
#'    **LeagueDashPtStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       GP \tab character \tab Games played. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       DRIVES \tab character \tab  \cr
#'       DRIVE_FGM \tab character \tab  \cr
#'       DRIVE_FGA \tab character \tab  \cr
#'       DRIVE_FG_PCT \tab character \tab  \cr
#'       DRIVE_FTM \tab character \tab  \cr
#'       DRIVE_FTA \tab character \tab  \cr
#'       DRIVE_FT_PCT \tab character \tab  \cr
#'       DRIVE_PTS \tab character \tab  \cr
#'       DRIVE_PTS_PCT \tab character \tab  \cr
#'       DRIVE_PASSES \tab character \tab  \cr
#'       DRIVE_PASSES_PCT \tab character \tab  \cr
#'       DRIVE_AST \tab character \tab  \cr
#'       DRIVE_AST_PCT \tab character \tab  \cr
#'       DRIVE_TOV \tab character \tab  \cr
#'       DRIVE_TOV_PCT \tab character \tab  \cr
#'       DRIVE_PF \tab character \tab  \cr
#'       DRIVE_PF_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Players Tracking (Second Spectrum) Stats](https://www.nba.com/stats/players/drives)
#' ```r
#'  nba_leaguedashptstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashptstats <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    game_scope = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'PerGame',
    period = '',
    player_experience = '',
    player_or_team = 'Player',
    player_position = '',
    pt_measure_type = 'Drives',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashptstats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    GameScope = game_scope,
    Height = height,
    LastNGames = last_n_games,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerExperience = player_experience,
    PlayerOrTeam = player_or_team,
    PlayerPosition = player_position,
    PtMeasureType = pt_measure_type,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard player-tracking stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Team Defense**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashptteamdefend
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Team Defense**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param defense_category defense_category
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPtTeamDefend
#'
#'    **LeagueDashPtTeamDefend**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       GP \tab character \tab Games played. \cr
#'       G \tab character \tab Games played. \cr
#'       FREQ \tab character \tab  \cr
#'       D_FGM \tab character \tab  \cr
#'       D_FGA \tab character \tab  \cr
#'       D_FG_PCT \tab character \tab  \cr
#'       NORMAL_FG_PCT \tab character \tab  \cr
#'       PCT_PLUSMINUS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Team Defensive Dashboard](https://www.nba.com/stats/teams/defense-dash-overall)
#' ```r
#'  nba_leaguedashptteamdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashptteamdefend <- function(
    conference = '',
    date_from = '',
    date_to = '',
    defense_category = 'Overall',
    division = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'PerGame',
    period = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashptteamdefend"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    DefenseCategory = defense_category,
    Division = division,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
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
      hint = "Invalid arguments or no league dashboard player-tracking team defensive stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard by Team Clutch Splits**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashteamclutch
NULL
#' @title
#' **Get NBA Stats API League Dashboard by Team Clutch Splits**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param ahead_behind ahead_behind
#' @param clutch_time clutch_time
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param plus_minus plus_minus
#' @param point_diff point_diff
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_experience player_experience
#' @param player_position player_position
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashTeamClutch
#'
#'    **LeagueDashTeamClutch**
#'
#'
#'    Columns as documented in the shared [nba_leaguedashteamclutch_leaguedashteamclutch_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Clutch Functions
#' @details
#' [Team Clutch Stats](https://www.nba.com/stats/teams/clutch-traditional)
#' ```r
#'  nba_leaguedashteamclutch(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashteamclutch <- function(
    ahead_behind = 'Ahead or Behind',
    clutch_time = 'Last 5 Minutes',
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    game_scope = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust='N',
    plus_minus = 'N',
    point_diff = 5,
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    player_experience = '',
    player_position = '',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # ahead_behind <- gsub(' ', '+', ahead_behind)
  # clutch_time <- gsub(' ', '+', clutch_time)
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashteamclutch"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    AheadBehind = ahead_behind,
    ClutchTime = clutch_time,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    GameScope = game_scope,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    PlusMinus = plus_minus,
    PointDiff = point_diff,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
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
      hint = "Invalid arguments or no league dashboard team clutch data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Team Shots**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashteamptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Team Shots**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param close_def_dist_range close_def_dist_range
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param dribble_range dribble_range
#' @param game_segment game_segment
#' @param general_range general_range
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param shot_dist_range shot_dist_range
#' @param team_id team_id
#' @param touch_time_range touch_time_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashPTShots
#'
#'    **LeagueDashPTShots**
#'
#'
#'    Columns as documented in the shared [nba_leaguedashoppptshot_leaguedashptshots_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Player Tracking Functions
#' @family NBA Shooting Functions
#' @details
#' [Team Shot Dashboard](https://www.nba.com/stats/teams/shots-general)
#' ```r
#'  nba_leaguedashteamptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashteamptshot <- function(
    close_def_dist_range = '',
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    dribble_range = '',
    game_segment = '',
    general_range = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    shot_dist_range = '',
    team_id = '',
    touch_time_range = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashteamptshot"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    CloseDefDistRange = close_def_dist_range,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DribbleRange = dribble_range,
    GameSegment = game_segment,
    GeneralRange = general_range,
    LastNGames = last_n_games,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    TeamID = team_id,
    TouchTimeRange = touch_time_range,
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
      hint = "Invalid arguments or no league dashboard team player-tracking shooting stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Team Stats**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashteamstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Team Stats**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param game_scope game_scope
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param two_way two_way
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: LeagueDashTeamStats
#'
#'    **LeagueDashTeamStats**
#'
#'
#'    Columns as documented in the shared [nba_leaguedashteamclutch_leaguedashteamclutch_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Team Functions
#' @details
#' [Team Stats](https://www.nba.com/stats/teams/traditional)
#' ```r
#'  nba_leaguedashteamstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashteamstats <- function(
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    game_scope = '',
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
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    two_way = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashteamstats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    GameScope = game_scope,
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    TwoWay = two_way,
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
      hint = "Invalid arguments or no league dashboard team stats data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Team Shot Locations**
#' @rdname nba_leaguedashoppptshot
#' @name nba_leaguedashteamshotlocations
NULL
#' @title
#' **Get NBA Stats API League Dashboard Team Shot Locations**
#' @rdname nba_leaguedashoppptshot
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param distance_range distance_range
#' @param division division
#' @param game_scope game_scope
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
#' @param player_experience player_experience
#' @param player_position player_position
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: ShotLocations
#'
#'    **ShotLocations**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       Restricted_Area_FGM \tab character \tab  \cr
#'       Restricted_Area_FGA \tab character \tab  \cr
#'       Restricted_Area_FG_PCT \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FGM \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FGA \tab character \tab  \cr
#'       In_The_Paint_Non_RA_FG_PCT \tab character \tab  \cr
#'       Mid_Range_FGM \tab character \tab  \cr
#'       Mid_Range_FGA \tab character \tab  \cr
#'       Mid_Range_FG_PCT \tab character \tab  \cr
#'       Left_Corner_3_FGM \tab character \tab  \cr
#'       Left_Corner_3_FGA \tab character \tab  \cr
#'       Left_Corner_3_FG_PCT \tab character \tab  \cr
#'       Right_Corner_3_FGM \tab character \tab  \cr
#'       Right_Corner_3_FGA \tab character \tab  \cr
#'       Right_Corner_3_FG_PCT \tab character \tab  \cr
#'       Above_the_Break_3_FGM \tab character \tab  \cr
#'       Above_the_Break_3_FGA \tab character \tab  \cr
#'       Above_the_Break_3_FG_PCT \tab character \tab  \cr
#'       Backcourt_FGM \tab character \tab  \cr
#'       Backcourt_FGA \tab character \tab  \cr
#'       Backcourt_FG_PCT \tab character \tab  \cr
#'       Corner_3_FGM \tab character \tab  \cr
#'       Corner_3_FGA \tab character \tab  \cr
#'       Corner_3_FG_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Shooting Functions
#' @details
#' [Team Shooting by Shot Location](https://www.nba.com/stats/teams/shooting)
#' ```r
#'  nba_leaguedashteamshotlocations(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguedashteamshotlocations <- function(
    conference = '',
    date_from = '',
    date_to = '',
    distance_range = 'By Zone',
    division = '',
    game_scope = '',
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
    player_experience = '',
    player_position = '',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # distance_range <- gsub(' ', '+', distance_range)
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguedashteamshotlocations"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DistanceRange = distance_range,
    GameScope = game_scope,
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
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          dplyr::as_tibble()
        columnsToSkip <- resp$resultSets$headers$columnsToSkip[[1]]
        columnSpan <- resp$resultSets$headers$columnSpan[[1]]
        json_names1 <- resp$resultSets$headers$columnNames[[1]]
        json_names_rep <- rep(json_names1,times = 1, each = columnSpan)
        json_names2 <- resp$resultSets$headers$columnNames[[2]]
        json_names <- c(json_names2[1:columnsToSkip], paste(json_names_rep, json_names2[(columnsToSkip + 1):30]))
        colnames(data) <- gsub('\\(|\\)|','', gsub(' |-','_',json_names))
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league dashboard team shot location data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
