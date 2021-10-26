#' **Get NBA Stats API League Hustle Stats Player**
#' @name hustle_p
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Player**
#' @rdname hustle_p
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguehustlestatsplayer <- function(
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguehustlestatsplayer"
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
                     "&Height=", height,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr = {
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no league hustle player stats data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Hustle Stats Player Leaders**
#' @name hustle_pl
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Player Leaders**
#' @rdname hustle_pl
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguehustlestatsplayerleaders <- function(
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguehustlestatsplayerleaders"
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
                     "&Height=", height,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr = {
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no league hustle stats player leaders data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API League Hustle Stats Team**
#' @name hustle_t
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Team**
#' @rdname hustle_t
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguehustlestatsteam <- function(
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguehustlestatsteam"
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
                     "&Height=", height,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr = {
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no league hustle team stats data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
#' **Get NBA Stats API League Hustle Stats Team Leaders**
#' @name hustle_tl
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Team Leaders**
#' @rdname hustle_tl
#' @author Saiem Gilani
#' @param college college
#' @param conference conference
#' @param country country
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_pick draft_pick
#' @param draft_year draft_year
#' @param height height
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param player_experience player_experience
#' @param player_position player_position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param weight weight
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguehustlestatsteamleaders <- function(
  college='',
  conference = '',
  country = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_pick = '',
  draft_year = '',
  height = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  per_mode='Totals',
  player_experience='',
  player_position='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division='',
  weight=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguehustlestatsteamleaders"
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
                     "&Height=", height,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&PlayerExperience=",player_experience,
                     "&PlayerPosition=", player_position,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&Weight=", weight)

  tryCatch(
    expr = {
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no league hustle team stats leaders data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

