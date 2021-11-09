

#' **Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**
#' @name ld_oppptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**
#' @rdname ld_oppptshot
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
#' @return Returns a named list of data frames: LeagueDashPTShots
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashoppptshot <- function(
  close_def_dist_range = '',
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  dribble_range = '',
  game_segment = '',
  general_range='',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  shot_dist_range = '',
  team_id='',
  touch_time_range = '',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashoppptshot"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?CloseDefDistRange=",close_def_dist_range,
                     "&Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DribbleRange=", dribble_range,
                     "&GameSegment=", game_segment,
                     "&GeneralRange=", general_range,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&ShotDistRange=",shot_dist_range,
                     "&TeamID=", team_id,
                     "&TouchTimeRange=",touch_time_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player-tracking oppponent shooting data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Biographical Stats**
#' @name ld_pbiostats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Biographical Stats**
#' @rdname ld_pbiostats
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
#' @return Returns a named list of data frames: LeagueDashPlayerBioStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
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
  game_scope='',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  period='',
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  touch_time_range = '',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashplayerbiostats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&TouchTimeRange=",touch_time_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player bio stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Dashboard by Player Clutch Splits**
#' @name ld_pclutch
NULL
#' @title
#' **Get NBA Stats API League Dashboard by Player Clutch Splits**
#' @rdname ld_pclutch
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
#' @return Returns a named list of data frames: LeagueDashPlayerClutch
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashplayerclutch <- function(
  ahead_behind='Ahead or Behind',
  clutch_time = 'Last 5 Minutes',
  college = '',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  game_scope='',
  game_segment = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  pace_adjust='N',
  plus_minus = 'N',
  point_diff = 5,
  po_round='',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  touch_time_range = '',
  vs_conference='',
  vs_division='',
  weight=''){
  ahead_behind <- gsub(' ','+',ahead_behind)
  clutch_time <- gsub(' ','+',clutch_time)
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashplayerclutch"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?AheadBehind=",ahead_behind,
                     "&ClutchTime=",clutch_time,
                     "&College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&PlusMinus=", plus_minus,
                     "&PointDiff=", point_diff,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&TouchTimeRange=",touch_time_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player clutch stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Player Shots**
#' @name ld_pptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Player Shots**
#' @rdname ld_pptshot
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
#' @return Returns a named list of data frames: LeagueDashPTShots
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashplayerptshot <- function(
  close_def_dist_range = '',
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  distance_range='',
  division = '',
  draft_pick = '',
  draft_year = '',
  dribble_range = '',
  game_scope='',
  game_segment = '',
  general_range='',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type = 'Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  pace_adjust = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  shot_dist_range = '',
  starter_bench = '',
  team_id='',
  touch_time_range = '',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashplayerptshot"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?CloseDefDistRange=",close_def_dist_range,
                     "&College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&DistanceRange=", distance_range,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&DribbleRange=", dribble_range,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&GeneralRange=", general_range,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&TouchTimeRange=",touch_time_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player-tracking player shooting data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Stats**
#' @name ld_pstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Stats**
#' @rdname ld_pstats
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
#' @return Returns a named list of data frames: LeagueDashPlayerStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashplayerstats <- function(
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  game_scope='',
  game_segment = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type = 'Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  pace_adjust = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  two_way='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashplayerstats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&TwoWay=",two_way,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Dashboard Player Shot Locations**
#' @name ld_pshotloc
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Shot Locations**
#' @rdname ld_pshotloc
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
#' @return Returns a named list of data frames: ShotLocations
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashplayershotlocations <- function(
  college='',
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
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust = 'N',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  plus_minus='N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){

  distance_range <- gsub(' ','+',distance_range)
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashplayershotlocations"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DistanceRange=", distance_range,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&DribbleRange=", dribble_range,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=",measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()
        columnsToSkip <- resp$resultSets$headers$columnsToSkip[[1]]
        columnSpan <- resp$resultSets$headers$columnSpan[[1]]
        json_names1 <- resp$resultSets$headers$columnNames[[1]]
        json_names_rep <- rep(json_names1,times=1,each=columnSpan)
        json_names2 <- resp$resultSets$headers$columnNames[[2]]
        json_names <- c(json_names2[1:columnsToSkip], paste(json_names_rep, json_names2[(columnsToSkip+1):30]))
        colnames(data) <- gsub('\\(|\\)|','', gsub(' |-','_',json_names))
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player shot locations data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Defense**
#' @name ld_ptdefend
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Defense**
#' @rdname ld_ptdefend
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
#' @return Returns a named list of data frames: LeagueDashPTDefend
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
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
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  period='',
  player_experience='',
  player_id='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  starter_bench = '',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashptdefend"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&DefenseCategory=", defense_category,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&GameSegment=", game_segment,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerID=", player_id,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player-tracking player defense data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Stats**
#' @name ld_ptstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Stats**
#' @rdname ld_ptstats
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
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
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  period='',
  player_experience='',
  player_or_team='Team',
  player_position='',
  pt_measure_type = 'SpeedDistance',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  starter_bench = '',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashptstats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Conference=", conference,
                     "&Country=", country,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DraftPick=", draft_pick,
                     "&DraftYear=", draft_year,
                     "&GameScope=", game_scope,
                     "&Height=", height,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerOrTeam=", player_or_team,
                     "&PlayerPosition=", player_position,
                     "&PtMeasureType=", pt_measure_type,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player-tracking stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Team Defense**
#' @name ld_ptteamdefend
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Team Defense**
#' @rdname ld_ptteamdefend
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashptteamdefend <- function(
  conference = '',
  date_from = '',
  date_to = '',
  defense_category = 'Overall',
  division = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  period='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashptteamdefend"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&DefenseCategory=", defense_category,
                     "&Division=", division,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard player-tracking team defensive stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard by Team Clutch Splits**
#' @name ld_tclutch
NULL
#' @title
#' **Get NBA Stats API League Dashboard by Team Clutch Splits**
#' @rdname ld_tclutch
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
#' @return Returns a named list of data frames: LeagueDashTeamClutch
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashteamclutch <- function(
  ahead_behind='Ahead or Behind',
  clutch_time = 'Last 5 Minutes',
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  game_scope='',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  pace_adjust='N',
  plus_minus = 'N',
  point_diff = 5,
  po_round='',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  vs_conference='',
  vs_division=''){
  ahead_behind <- gsub(' ','+',ahead_behind)
  clutch_time <- gsub(' ','+',clutch_time)
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashteamclutch"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?AheadBehind=",ahead_behind,
                     "&ClutchTime=",clutch_time,
                     "&Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&PlusMinus=", plus_minus,
                     "&PointDiff=", point_diff,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard team clutch data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Player Tracking - Team Shots**
#' @name ld_tptshot
NULL
#' @title
#' **Get NBA Stats API League Dashboard Player Tracking - Team Shots**
#' @rdname ld_tptshot
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
#' @return Returns a named list of data frames: LeagueDashPTShots
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashteamptshot <- function(
  close_def_dist_range = '',
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  dribble_range = '',
  game_segment = '',
  general_range='',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  period=0,
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  shot_dist_range = '',
  team_id='',
  touch_time_range = '',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashteamptshot"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?CloseDefDistRange=",close_def_dist_range,
                     "&Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DribbleRange=", dribble_range,
                     "&GameSegment=", game_segment,
                     "&GeneralRange=", general_range,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&TeamID=", team_id,
                     "&TouchTimeRange=",touch_time_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard team player-tracking shooting stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Team Stats**
#' @name ld_tstats
NULL
#' @title
#' **Get NBA Stats API League Dashboard Team Stats**
#' @rdname ld_tstats
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
#' @return Returns a named list of data frames: LeagueDashTeamStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashteamstats <- function(
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  game_scope='',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench='',
  team_id='',
  two_way='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashteamstats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=",starter_bench,
                     "&TeamID=", team_id,
                     "&TwoWay=", two_way,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

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
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard team stats data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Dashboard Team Shot Locations**
#' @name ld_tshotloc
NULL
#' @title
#' **Get NBA Stats API League Dashboard Team Shot Locations**
#' @rdname ld_tshotloc
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
#' @return Returns a named list of data frames: ShotLocations
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_leaguedashteamshotlocations <- function(
  conference = '',
  date_from = '',
  date_to = '',
  distance_range = 'By Zone',
  division = '',
  game_scope = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust = 'N',
  per_mode='Totals',
  period=0,
  player_experience='',
  player_position='',
  plus_minus='N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  starter_bench = '',
  team_id='',
  vs_conference='',
  vs_division=''){

  distance_range <- gsub(' ','+',distance_range)
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashteamshotlocations"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DistanceRange=", distance_range,
                     "&GameScope=", game_scope,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=",measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&StarterBench=", starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr={
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()
        columnsToSkip <- resp$resultSets$headers$columnsToSkip[[1]]
        columnSpan <- resp$resultSets$headers$columnSpan[[1]]
        json_names1 <- resp$resultSets$headers$columnNames[[1]]
        json_names_rep <- rep(json_names1,times=1,each=columnSpan)
        json_names2 <- resp$resultSets$headers$columnNames[[2]]
        json_names <- c(json_names2[1:columnsToSkip], paste(json_names_rep, json_names2[(columnsToSkip+1):30]))
        colnames(data) <- gsub('\\(|\\)|','', gsub(' |-','_',json_names))
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league dashboard team shot location data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
