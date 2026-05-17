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
#'    |col_name                      |types     |description                             |
#'    |:-----------------------------|:---------|:---------------------------------------|
#'    |PLAYER_ID                     |character |Unique player identifier.               |
#'    |PLAYER_NAME                   |character |Player name.                            |
#'    |TEAM_ID                       |character |Unique team identifier.                 |
#'    |TEAM_ABBREVIATION             |character |Short team abbreviation (e.g. 'LAS').   |
#'    |AGE                           |character |Player age (in years).                  |
#'    |G                             |character |Games played.                           |
#'    |MIN                           |character |Minutes played.                         |
#'    |CONTESTED_SHOTS               |character |Defensively contested shots.            |
#'    |CONTESTED_SHOTS_2PT           |character |Contested two-point shots.              |
#'    |CONTESTED_SHOTS_3PT           |character |Contested three-point shots.            |
#'    |DEFLECTIONS                   |character |Defensive deflections.                  |
#'    |CHARGES_DRAWN                 |character |Charges drawn.                          |
#'    |SCREEN_ASSISTS                |character |Screen assists (resulting in a basket). |
#'    |SCREEN_AST_PTS                |character |                                        |
#'    |OFF_LOOSE_BALLS_RECOVERED     |character |                                        |
#'    |DEF_LOOSE_BALLS_RECOVERED     |character |                                        |
#'    |LOOSE_BALLS_RECOVERED         |character |Loose balls recovered.                  |
#'    |PCT_LOOSE_BALLS_RECOVERED_OFF |character |                                        |
#'    |PCT_LOOSE_BALLS_RECOVERED_DEF |character |                                        |
#'    |OFF_BOXOUTS                   |character |                                        |
#'    |DEF_BOXOUTS                   |character |                                        |
#'    |BOX_OUT_PLAYER_TEAM_REBS      |character |                                        |
#'    |BOX_OUT_PLAYER_REBS           |character |                                        |
#'    |BOX_OUTS                      |character |Box-outs executed.                      |
#'    |PCT_BOX_OUTS_OFF              |character |                                        |
#'    |PCT_BOX_OUTS_DEF              |character |                                        |
#'    |PCT_BOX_OUTS_TEAM_REB         |character |                                        |
#'    |PCT_BOX_OUTS_REB              |character |                                        |
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
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    Height = height,
    LeagueID = league_id,
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

#' **Get NBA Stats API League Hustle Stats Player Leaders**
#' @name nba_leaguehustlestatsplayerleaders
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Player Leaders**
#' @rdname nba_leaguehustlestatsplayerleaders
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
#'    |col_name          |types     |description                           |
#'    |:-----------------|:---------|:-------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.             |
#'    |PLAYER_NAME       |character |Player name.                          |
#'    |TEAM_ID           |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS'). |
#'    |AGE               |character |Player age (in years).                |
#'    |RANK              |character |Rank.                                 |
#'    |CONTESTED_SHOTS   |character |Defensively contested shots.          |
#'
#'    **PlayerChargesDrawnLeaders**
#'
#'
#'    |col_name          |types     |description                           |
#'    |:-----------------|:---------|:-------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.             |
#'    |PLAYER_NAME       |character |Player name.                          |
#'    |TEAM_ID           |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS'). |
#'    |AGE               |character |Player age (in years).                |
#'    |RANK              |character |Rank.                                 |
#'    |CHARGES_DRAWN     |character |Charges drawn.                        |
#'
#'    **PlayerDeflectionsLeaders**
#'
#'
#'    |col_name          |types     |description                           |
#'    |:-----------------|:---------|:-------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.             |
#'    |PLAYER_NAME       |character |Player name.                          |
#'    |TEAM_ID           |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS'). |
#'    |AGE               |character |Player age (in years).                |
#'    |RANK              |character |Rank.                                 |
#'    |DEFLECTIONS       |character |Defensive deflections.                |
#'
#'    **PlayerLooseBallLeaders**
#'
#'
#'    |col_name              |types     |description                           |
#'    |:---------------------|:---------|:-------------------------------------|
#'    |PLAYER_ID             |character |Unique player identifier.             |
#'    |PLAYER_NAME           |character |Player name.                          |
#'    |TEAM_ID               |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION     |character |Short team abbreviation (e.g. 'LAS'). |
#'    |AGE                   |character |Player age (in years).                |
#'    |RANK                  |character |Rank.                                 |
#'    |LOOSE_BALLS_RECOVERED |character |Loose balls recovered.                |
#'
#'    **PlayerScreenAssistLeaders**
#'
#'
#'    |col_name          |types     |description                             |
#'    |:-----------------|:---------|:---------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.               |
#'    |PLAYER_NAME       |character |Player name.                            |
#'    |TEAM_ID           |character |Unique team identifier.                 |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').   |
#'    |AGE               |character |Player age (in years).                  |
#'    |RANK              |character |Rank.                                   |
#'    |SCREEN_ASSISTS    |character |Screen assists (resulting in a basket). |
#'
#'    **Table5**
#'
#'
#'    |col_name          |types     |description                           |
#'    |:-----------------|:---------|:-------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.             |
#'    |PLAYER_NAME       |character |Player name.                          |
#'    |TEAM_ID           |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS'). |
#'    |AGE               |character |Player age (in years).                |
#'    |RANK              |character |Rank.                                 |
#'    |BOX_OUTS          |character |Box-outs executed.                    |
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
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    Height = height,
    LeagueID = league_id,
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

#' **Get NBA Stats API League Hustle Stats Team**
#' @name nba_leaguehustlestatsteam
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Team**
#' @rdname nba_leaguehustlestatsteam
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
#'    |col_name                      |types     |description                                     |
#'    |:-----------------------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID                       |character |Unique team identifier.                         |
#'    |TEAM_NAME                     |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |MIN                           |character |Minutes played.                                 |
#'    |CONTESTED_SHOTS               |character |Defensively contested shots.                    |
#'    |CONTESTED_SHOTS_2PT           |character |Contested two-point shots.                      |
#'    |CONTESTED_SHOTS_3PT           |character |Contested three-point shots.                    |
#'    |DEFLECTIONS                   |character |Defensive deflections.                          |
#'    |CHARGES_DRAWN                 |character |Charges drawn.                                  |
#'    |SCREEN_ASSISTS                |character |Screen assists (resulting in a basket).         |
#'    |SCREEN_AST_PTS                |character |                                                |
#'    |OFF_LOOSE_BALLS_RECOVERED     |character |                                                |
#'    |DEF_LOOSE_BALLS_RECOVERED     |character |                                                |
#'    |LOOSE_BALLS_RECOVERED         |character |Loose balls recovered.                          |
#'    |PCT_LOOSE_BALLS_RECOVERED_OFF |character |                                                |
#'    |PCT_LOOSE_BALLS_RECOVERED_DEF |character |                                                |
#'    |OFF_BOXOUTS                   |character |                                                |
#'    |DEF_BOXOUTS                   |character |                                                |
#'    |BOX_OUTS                      |character |Box-outs executed.                              |
#'    |PCT_BOX_OUTS_OFF              |character |                                                |
#'    |PCT_BOX_OUTS_DEF              |character |                                                |
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
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    Height = height,
    LeagueID = league_id,
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
#' **Get NBA Stats API League Hustle Stats Team Leaders**
#' @name nba_leaguehustlestatsteamleaders
NULL
#' @title
#' **Get NBA Stats API League Hustle Stats Team Leaders**
#' @rdname nba_leaguehustlestatsteamleaders
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
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |CONTESTED_SHOTS   |character |Defensively contested shots.                    |
#'
#'    **TeamChargesDrawnLeaders**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |CHARGES_DRAWN     |character |Charges drawn.                                  |
#'
#'    **TeamDeflectionsLeaders**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |DEFLECTIONS       |character |Defensive deflections.                          |
#'
#'    **TeamLooseBallLeaders**
#'
#'
#'    |col_name              |types     |description                                     |
#'    |:---------------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID               |character |Unique team identifier.                         |
#'    |TEAM_NAME             |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION     |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK                  |character |Rank.                                           |
#'    |LOOSE_BALLS_RECOVERED |character |Loose balls recovered.                          |
#'
#'    **TeamScreenAssistLeaders**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |SCREEN_ASSISTS    |character |Screen assists (resulting in a basket).         |
#'
#'    **Table5**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |BOX_OUTS          |character |Box-outs executed.                              |
#'
#'    **Table6**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |RANK              |character |Rank.                                           |
#'    |BOX_OUTS          |character |Box-outs executed.                              |
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
    College = college,
    Conference = conference,
    Country = country,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftPick = draft_pick,
    DraftYear = draft_year,
    Height = height,
    LeagueID = league_id,
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
