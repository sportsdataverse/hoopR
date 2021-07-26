#' **Get NBA Stats API All-time Leaders Grid**
#' @name alltime
NULL
#' @title
#' **Get NBA Stats API All-time Leaders Grid**
#' @rdname alltime
#' @author Saiem Gilani
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @param top_x Top X
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_alltimeleadersgrids <- function(league_id='00',
                                    per_mode = 'PerGame',
                                    season_type = 'Regular Season',
                                    top_x = 10){
  season_type <- gsub(' ','+',season_type)
  version <- "alltimeleadersgrids"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&SeasonType=",season_type,
                     "&TopX=",top_x)

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
  return(df_list)
}


#' **Get NBA Stats API Assist Leaders**
#' @name assists
NULL
#' @title
#' **Get NBA Stats API Assist Leaders**
#' @rdname assists
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param player_or_team Player or Team
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_assistleaders <- function(league_id='00',
                              per_mode = 'PerGame',
                              player_or_team ='Team',
                              season = '2020-21',
                              season_type = 'Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "assistleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&PlayerOrTeam=",player_or_team,
                     "&Season=",season,
                     "&SeasonType=",season_type)

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
  return(df_list)
}
#' **Get NBA Stats API Assist Tracker**
#' @name assist_tracker
NULL
#' @title
#' **Get NBA Stats API Assist Tracker**
#' @rdname assist_tracker
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_assisttracker <- function(league_id='00',
                              per_mode = 'PerGame',
                              season = '2020-21',
                              season_type = 'Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "assisttracker"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=",per_mode,
                     "&Season=",season,
                     "&SeasonType=",season_type)

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
  return(df_list)
}

#' **Get NBA Stats API Homepage Leaders**
#' @name homepageleaders
NULL
#' @title
#' **Get NBA Stats API Homepage Leaders**
#' @rdname homepageleaders
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @param stat_category Stat Category: Points, Rebounds, Assists, Defense, Clutch, Playmaking, Efficiency, Fast Break, Scoring Breakdown
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_homepageleaders <- function(league_id='00',
                              game_scope = 'Season',
                              player_or_team = 'Team',
                              player_scope = 'All Players',
                              season = '2020-21',
                              season_type = 'Regular Season',
                              stat_category = 'Points'){
  player_scope <- gsub(' ','+',player_scope)
  season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "homepageleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameScope=", game_scope,
                     "&LeagueID=",league_id,
                     "&PlayerOrTeam=", player_or_team,
                     "&PlayerScope=", player_scope,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&StatCategory=",stat_category)

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
  return(df_list)
}


#' **Get NBA Stats API HomepageV2 Leaders**
#' @name homepagev2
NULL
#' @title
#' **Get NBA Stats API HomepageV2 Leaders**
#' @rdname homepagev2
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @param stat_type Stat Type - Traditional, Advanced, Tracking
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_homepagev2 <- function(league_id='00',
                                game_scope = 'Season',
                                player_or_team = 'Team',
                                player_scope = 'All Players',
                                season = '2020-21',
                                season_type = 'Regular Season',
                                stat_type = 'Traditional'){
  player_scope <- gsub(' ','+',player_scope)
  season_type <- gsub(' ','+',season_type)
  stat_type <- gsub(' ','+',stat_type)
  version <- "homepagev2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameScope=", game_scope,
                     "&LeagueID=",league_id,
                     "&PlayerOrTeam=", player_or_team,
                     "&PlayerScope=", player_scope,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&StatType=",stat_type)

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
  return(df_list)
}


#' **Get NBA Stats API Leaders Tiles**
#' @name leaderstiles
NULL
#' @title
#' **Get NBA Stats API Leaders Tiles**
#' @rdname leaderstiles
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @param stat Stat - PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_leaderstiles <- function(league_id='00',
                           game_scope = 'Season',
                           player_or_team = 'Team',
                           player_scope = 'All Players',
                           season = '2020-21',
                           season_type = 'Regular Season',
                           stat = 'PTS'){
  player_scope <- gsub(' ','+',player_scope)
  season_type <- gsub(' ','+',season_type)
  stat <- gsub(' ','+',stat)
  version <- "leaderstiles"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameScope=", game_scope,
                     "&LeagueID=",league_id,
                     "&PlayerOrTeam=", player_or_team,
                     "&PlayerScope=", player_scope,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&Stat=",stat)

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
  return(df_list)
}


#' **Get NBA Stats API Defense Hub**
#' @name defensehub
NULL
#' @title
#' **Get NBA Stats API Defense Hub**
#' @rdname defensehub
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_defensehub <- function(league_id='00',
                             game_scope = 'Season',
                             player_or_team = 'Team',
                             player_scope = 'All Players',
                             season = '2020-21',
                             season_type = 'Regular Season'){

  player_scope <- gsub(' ','+',player_scope)
  season_type <- gsub(' ','+',season_type)
  version <- "defensehub"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameScope=", game_scope,
                     "&LeagueID=",league_id,
                     "&PlayerOrTeam=", player_or_team,
                     "&PlayerScope=", player_scope,
                     "&Season=",season,
                     "&SeasonType=",season_type)

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
  return(df_list)
}




#' **Get NBA Stats API League Leaders**
#' @name leagueleaders
NULL
#' @title
#' **Get NBA Stats API League Leaders**
#' @rdname leagueleaders
#' @author Saiem Gilani
#' @param active_flag Active Flag
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs
#' @param per_mode Per Mode - Totals, PerGame, Per48
#' @param scope Scope - RS, S, Rookies
#' @param league_id League - default: '00'. Other options include '01','02','03'
#' @param stat_category Stat Category: PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export

nba_leagueleaders <- function(active_flag='',
                              league_id='00',
                              per_mode = 'Totals',
                              scope = 'S',
                              season = '2020-21',
                              season_type = 'Regular Season',
                              stat_category = 'PTS'){
  scope <- gsub(' ','+',scope)
  season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "leagueleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?ActiveFlag=", active_flag,
                     "&LeagueID=",league_id,
                     "&PerMode=", per_mode,
                     "&Scope=", scope,
                     "&Season=",season,
                     "&SeasonType=",season_type,
                     "&StatCategory=",stat_category)

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
  return(df_list)
}
