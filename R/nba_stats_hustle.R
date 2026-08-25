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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HustleStatsPlayer
#'
#'    **HustleStatsPlayer**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       G \tab character \tab Games played. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'       CONTESTED_SHOTS_2PT \tab character \tab Contested two-point shots. \cr
#'       CONTESTED_SHOTS_3PT \tab character \tab Contested three-point shots. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'       SCREEN_AST_PTS \tab character \tab  \cr
#'       OFF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       DEF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'       PCT_LOOSE_BALLS_RECOVERED_OFF \tab character \tab  \cr
#'       PCT_LOOSE_BALLS_RECOVERED_DEF \tab character \tab  \cr
#'       OFF_BOXOUTS \tab character \tab  \cr
#'       DEF_BOXOUTS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_TEAM_REBS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_REBS \tab character \tab  \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'       PCT_BOX_OUTS_OFF \tab character \tab  \cr
#'       PCT_BOX_OUTS_DEF \tab character \tab  \cr
#'       PCT_BOX_OUTS_TEAM_REB \tab character \tab  \cr
#'       PCT_BOX_OUTS_REB \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    season = year_to_season(most_recent_nba_season() - 1),
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerChargesDrawnLeaders,
#'  PlayerContestedShotsLeaders, PlayerDeflectionsLeaders, PlayerLooseBallLeaders,
#'  PlayerScreenAssistLeaders, Table5
#'
#'    **PlayerContestedShotsLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerChargesDrawnLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerDeflectionsLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerLooseBallLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerScreenAssistLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Table5**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       RANK \tab character \tab Rank. \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    weight = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HustleStatsTeam
#'
#'    **HustleStatsTeam**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'       CONTESTED_SHOTS_2PT \tab character \tab Contested two-point shots. \cr
#'       CONTESTED_SHOTS_3PT \tab character \tab Contested three-point shots. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'       SCREEN_AST_PTS \tab character \tab  \cr
#'       OFF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       DEF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'       PCT_LOOSE_BALLS_RECOVERED_OFF \tab character \tab  \cr
#'       PCT_LOOSE_BALLS_RECOVERED_DEF \tab character \tab  \cr
#'       OFF_BOXOUTS \tab character \tab  \cr
#'       DEF_BOXOUTS \tab character \tab  \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'       PCT_BOX_OUTS_OFF \tab character \tab  \cr
#'       PCT_BOX_OUTS_DEF \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    season = year_to_season(most_recent_nba_season() - 1),
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Table5, Table6, TeamChargesDrawnLeaders, TeamContestedShotsLeaders, TeamDeflectionsLeaders,  TeamLooseBallLeaders, TeamScreenAssistLeaders
#'
#'    **TeamContestedShotsLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamChargesDrawnLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamDeflectionsLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamLooseBallLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamScreenAssistLeaders**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Table5**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       RANK \tab character \tab Rank. \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Table6**
#'
#'
#'    Same columns as the **Table5** table above.
#'
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
    season = year_to_season(most_recent_nba_season() - 1),
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
