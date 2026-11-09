#' **Get NBA Stats API League Hustle Stats Player**
#' @name nba_leaguehustlestatsplayer
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Player**
#' @rdname nba_leaguehustlestatsplayer
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
#' @param last_n_games Deprecated and ignored. The hustle endpoints take no `LastNGames`
#'   filter, so this argument was never sent; passing it now warns.
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leaguehustlestatsplayer", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Hustle Functions
#' @details
#' [Player Hustle Stats](https://www.nba.com/stats/players/hustle)
#' ```r
#'  nba_leaguehustlestatsplayer(league_id = '00')
#'  nba_leaguehustlestatsplayer(league_id = '00', team_id = '1610612761')
#'
#' ```
nba_leaguehustlestatsplayer <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  #intentional
  # season_type <- gsub(' ','+',season_type)
  if (!missing(last_n_games)) {
    lifecycle::deprecate_warn(
      "3.2.0", "nba_leaguehustlestatsplayer(last_n_games)",
      details = "stats.nba.com's leaguehustlestatsplayer endpoint has no LastNGames filter; the argument is ignored."
    )
  }
  version <- "leaguehustlestatsplayer"
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
    Height = height,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no league hustle player stats data available for {season}!",
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
#' **Get NBA Stats API League Hustle Stats Player Leaders**
#' @rdname nba_leaguehustlestatsplayer
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
#' @param last_n_games Deprecated and ignored. The hustle endpoints take no `LastNGames`
#'   filter, so this argument was never sent; passing it now warns.
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leaguehustlestatsplayerleaders", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Hustle Functions
#' @details
#' [Player Hustle Stats Leaders](https://www.nba.com/stats/players/hustle-leaders)
#' ```r
#'  nba_leaguehustlestatsplayerleaders(league_id = '00')
#' ```
nba_leaguehustlestatsplayerleaders <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  if (!missing(last_n_games)) {
    lifecycle::deprecate_warn(
      "3.2.0", "nba_leaguehustlestatsplayerleaders(last_n_games)",
      details = "stats.nba.com's leaguehustlestatsplayerleaders endpoint has no LastNGames filter; the argument is ignored."
    )
  }
  version <- "leaguehustlestatsplayerleaders"
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
    Height = height,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no league hustle stats player leaders data available for {season}!",
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
#' **Get NBA Stats API League Hustle Stats Team**
#' @rdname nba_leaguehustlestatsplayer
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
#' @param last_n_games Deprecated and ignored. The hustle endpoints take no `LastNGames`
#'   filter, so this argument was never sent; passing it now warns.
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leaguehustlestatsteam", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Hustle Functions
#' @details
#' [Team Hustle Stats](https://www.nba.com/stats/teams/hustle)
#' ```r
#'  nba_leaguehustlestatsteam(league_id = '00')
#' ```
nba_leaguehustlestatsteam <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ','+',season_type)
  if (!missing(last_n_games)) {
    lifecycle::deprecate_warn(
      "3.2.0", "nba_leaguehustlestatsteam(last_n_games)",
      details = "stats.nba.com's leaguehustlestatsteam endpoint has no LastNGames filter; the argument is ignored."
    )
  }
  version <- "leaguehustlestatsteam"
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
    Height = height,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no league hustle team stats data available for {season}!",
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
#' **Get NBA Stats API League Hustle Stats Team Leaders**
#' @rdname nba_leaguehustlestatsplayer
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
#' @param last_n_games Deprecated and ignored. The hustle endpoints take no `LastNGames`
#'   filter, so this argument was never sent; passing it now warns.
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leaguehustlestatsteamleaders", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Hustle Functions
#' @details
#' [Team Hustle Stats Leaders](https://www.nba.com/stats/teams/hustle-leaders)
#' ```r
#'  nba_leaguehustlestatsteamleaders(league_id = '00')
#' ```
nba_leaguehustlestatsteamleaders <- function(
    college = '',
    conference = '',
    country = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_pick = '',
    draft_year = '',
    height = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    per_mode = 'Totals',
    player_experience = '',
    player_position = '',
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ','+',season_type)
  if (!missing(last_n_games)) {
    lifecycle::deprecate_warn(
      "3.2.0", "nba_leaguehustlestatsteamleaders(last_n_games)",
      details = "stats.nba.com's leaguehustlestatsteamleaders endpoint has no LastNGames filter; the argument is ignored."
    )
  }
  version <- "leaguehustlestatsteamleaders"
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
    Height = height,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    PlayerExperience = player_experience,
    PlayerPosition = player_position,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no league hustle team stats leaders data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
