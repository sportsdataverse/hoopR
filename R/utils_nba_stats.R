.nba_headers <-
  function(url = "https://stats.nba.com/stats/leaguegamelog?Counter=1000&Season=2019-20&Direction=DESC&LeagueID=00&PlayerOrTeam=P&SeasonType=Regular%20Season&Sorter=DATE",
           params = list()) {

    headers <- c(
      `Host` = 'stats.nba.com',
      `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36',
      `Accept` = 'application/json, text/plain, */*',
      `Accept-Language` = 'en-US,en;q=0.5',
      `Accept-Encoding` = 'gzip, deflate, br',
      `x-nba-stats-origin` = 'stats',
      `x-nba-stats-token` = 'true',
      `Connection` = 'keep-alive',
      `Origin` = "http://stats.nba.com",
      `Referer` = 'https://www.nba.com/',
      `Pragma` = 'no-cache',
      `Cache-Control` = 'no-cache'
    )

    if (length(params) == 0) {
      res <- httr::RETRY("GET", url, httr::add_headers(.headers = headers))
    } else {
      res <- httr::RETRY("GET", url, query = params, httr::add_headers(.headers = headers))
    }

    json <- res$content %>%
      rawToChar() %>%
      jsonlite::fromJSON(simplifyVector = T)

    return(json)

  }


#' @title
#' **Retry http request with proxy**
#' @description
#' This is a thin wrapper on httr::RETRY
#' @param url Request url
#' @param params list of params
#' @param origin Origin url
#' @param referer Referer url
#' @param ... passed to httr::RETRY
#' @keywords internal
#' @import rvest
#' @noRd
request_with_proxy <- function(url,
                               params = list(),
                               origin = "https://stats.nba.com",
                               referer="https://www.nba.com/",
                               ...){

  dots <- rlang::dots_list(..., .named = TRUE)
  proxy <- dots$proxy
  headers <- dots$headers
  headers <- c(
    `Host` = 'stats.nba.com',
    `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0',
    `Accept` = 'application/json, text/plain, */*',
    `Accept-Language` = 'en-US,en;q=0.5',
    `Accept-Encoding` = 'gzip, deflate, br',
    `x-nba-stats-origin` = 'stats',
    `x-nba-stats-token` = 'true',
    `Connection` = 'keep-alive',
    `Referer` = 'https://www.nba.com/',
    `Pragma` = 'no-cache',
    `Cache-Control` = 'no-cache'
  )
  if (length(params) >= 1) {
    url <- httr::modify_url({{url}}, query = params)
    res <- rvest::session(url = url, ...,  httr::add_headers(.headers = headers), httr::timeout(60))

    json <- res$response %>%
      httr::content(as = "text", encoding = "UTF-8") %>%
      jsonlite::fromJSON()

  } else {
    res <- rvest::session(url = {{url}}, ..., httr::add_headers(.headers = headers), httr::timeout(60))

    json <- res$response %>%
      httr::content(as = "text", encoding = "UTF-8") %>%
      jsonlite::fromJSON()
  }

  return(json)
}

.kp_headers <- function(url = "https://kenpom.com/index.php"){
  headers <- c(
    `Host` = "kenpom.com",
    `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv =104.0) Gecko/20100101 Firefox/104.0",
    `Accept` = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
    `Accept-Language` = "en-US,en;q=0.5",
    `Accept-Encoding` = "gzip, deflate",
    `Connection` = "keep-alive",
    # `Referer` = 'https://kenpom.com/',
    `Pragma` = "no-cache",
    `Cache-Control` = "no-cache",
    `Upgrade-Insecure-Requests` = 1
  )
  return(headers)
}

nba_live_endpoint <- function(endpoint){
  base_url = glue::glue('https://cdn.nba.com/static/json/liveData/{endpoint}')
  return(base_url)
}

nba_endpoint <- function(endpoint){
  all_endpoints = c(
    'alltimeleadersgrids',
    'assistleaders',
    'assisttracker',
    'boxscoreadvancedv2',
    'boxscoredefensive',
    'boxscorefourfactorsv2',
    'boxscorematchups',
    'boxscoremiscv2',
    'boxscoreplayertrackv2',
    'boxscorescoringv2',
    'boxscoresimilarityscore',
    'boxscoresummaryv2',
    'boxscoretraditionalv2',
    'boxscoreusagev2',
    'commonallplayers',
    'commonplayerinfo',
    'commonplayoffseries',
    'commonteamroster',
    'commonteamyears',
    'cumestatsplayer',
    'cumestatsplayergames',
    'cumestatsteam',
    'cumestatsteamgames',
    'defensehub',
    'draftboard',
    'draftcombinedrillresults',
    'draftcombinenonstationaryshooting',
    'draftcombineplayeranthro',
    'draftcombinespotshooting',
    'draftcombinestats',
    'drafthistory',
    'fantasywidget',
    'franchisehistory',
    'franchiseleaders',
    'franchiseplayers',
    'gamerotation',
    'glalumboxscoresimilarityscore',
    'homepageleaders',
    'homepagev2',
    'hustlestatsboxscore',
    'infographicfanduelplayer',
    'leaderstiles',
    'leaguedashlineups',
    'leaguedashplayerbiostats',
    'leaguedashplayerclutch',
    'leaguedashplayerptshot',
    'leaguedashplayershotlocations',
    'leaguedashplayerstats',
    'leaguedashptdefend',
    'leaguedashptstats',
    'leaguedashptteamdefend',
    'leaguedashteamclutch',
    'leaguedashoppptshot',
    'leaguedashteamptshot',
    'leaguedashteamshotlocations',
    'leaguedashteamstats',
    'leaguegamefinder',
    'leaguegamelog',
    'leaguehustlestatsplayer',
    'leaguehustlestatsplayerleaders',
    'leaguehustlestatsteam',
    'leaguehustlestatsteamleaders',
    'leagueleaders',
    'leaguelineupviz',
    'leagueplayerondetails',
    'leagueseasonmatchups',
    'leaguestandings',
    'leaguestandingsv3',
    'matchupsrollup',
    'playbyplay',#d
    'playbyplayv2',#d
    'playerawards',
    'playercareerbycollege',
    'playercareerbycollegerollup',
    'playercareerstats',
    'playercompare',
    'playerdashptpass',
    'playerdashptreb',
    'playerdashptshotdefend',
    'playerdashptshots',
    'playerdashboardbyclutch',
    'playerdashboardbygamesplits',
    'playerdashboardbygeneralsplits',
    'playerdashboardbylastngames',
    'playerdashboardbyopponent',
    'playerdashboardbyshootingsplits',
    'playerdashboardbyteamperformance',
    'playerdashboardbyyearoveryear',
    'playerestimatedmetrics',
    'playerfantasyprofile',
    'playerfantasyprofilebargraph',
    'playergamelog',
    'playergamelogs',
    'playergamestreakfinder',
    'playernextngames',
    'playerprofilev2',
    'playervsplayer',
    'playoffpicture',
    'scoreboard',
    'scoreboardv2',
    'shotchartdetail',
    'shotchartleaguewide',
    'shotchartlineupdetail',
    'synergyplaytypes',
    'teamandplayersvsplayers',
    'teamdashlineups',
    'teamdashptpass',
    'teamdashptreb',
    'teamdashptshots',
    'teamdashboardbyclutch',
    'teamdashboardbygamesplits',
    'teamdashboardbygeneralsplits',
    'teamdashboardbylastngames',
    'teamdashboardbyopponent',
    'teamdashboardbyshootingsplits',
    'teamdashboardbyteamperformance',
    'teamdashboardbyyearoveryear',
    'teamdetails',
    'teamestimatedmetrics',
    'teamgamelog',
    'teamgamelogs',
    'teamgamestreakfinder',
    'teamhistoricalleaders',
    'teaminfocommon',
    'teamplayerdashboard',
    'teamplayeronoffdetails',
    'teamplayeronoffsummary',
    'teamvsplayer',
    'teamyearbyyearstats',
    'videodetails',
    'videoevents',
    'videostatus',
    'winprobabilitypbp'
  )
  base_url = glue::glue('https://stats.nba.com/stats/{endpoint}')
  return(base_url)
}


nba_stats_map_result_sets <- function(resp) {
  if ("resultSets" %in% names(resp)) {
    df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
      data <- resp$resultSets$rowSet[[x]] %>%
        data.frame(stringsAsFactors = F) %>%
        dplyr::as_tibble()

      json_names <- resp$resultSets$headers[[x]]
      colnames(data) <- json_names
      return(data)
    })
    names(df_list) <- resp$resultSets$name
    return(df_list)
  } else {
    df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
      data <- resp$resultSet$rowSet[[x]] %>%
        data.frame(stringsAsFactors = FALSE) %>%
        dplyr::as_tibble()

      json_names <- resp$resultSet$headers[[x]]
      colnames(data) <- json_names
      return(data)
    })
    names(df_list) <- resp$resultSet$name
    return(df_list)
  }
}

pad_id <- function(id = 21601112) {
  zeros <-
    10 - nchar(id)

  if (zeros == 0) {
    return(id)
  }

  start <-
    rep("0", times = zeros) %>% stringr::str_c(collapse = "")
  glue("{start}{id}") %>% as.character()
}

pad_time <- function(time = 1) {
  zeros <-
    4 - nchar(time)

  if (zeros == 0) {
    return(time)
  }

  start <-
    rep("0", times = zeros) %>% stringr::str_c(collapse = "")
  glue("{start}{time}") %>% as.character()
}


#' @title **rejoin schedules (when used from league game finder)**
#' @param df data frame pulled from nba_leaguegamefinder()
#' @importFrom dplyr mutate filter select left_join
#' @importFrom stringr str_detect
#' @importFrom tidyr everything
rejoin_schedules <- function(df){
  df <- df %>%
    dplyr::mutate(
      HOME_AWAY = ifelse(stringr::str_detect(.data$MATCHUP,"@"),"AWAY","HOME")) %>%
    dplyr::select(-"WL","MATCHUP", tidyr::everything())
  away_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "AWAY") %>%
    dplyr::select(-"HOME_AWAY") %>%
    dplyr::select("SEASON_ID", "GAME_ID", "GAME_DATE", "MATCHUP", tidyr::everything())
  colnames(away_df)[5:ncol(away_df)]<-paste0("AWAY_", colnames(away_df)[5:ncol(away_df)])
  home_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "HOME") %>%
    dplyr::select(-"HOME_AWAY", -"MATCHUP") %>%
    dplyr::select("SEASON_ID", "GAME_ID", "GAME_DATE", tidyr::everything())
  colnames(home_df)[4:ncol(home_df)]<-paste0("HOME_", colnames(home_df)[4:ncol(home_df)])
  sched_df <- away_df %>%
    dplyr::left_join(home_df, by=c("GAME_ID", "SEASON_ID", "GAME_DATE"))
  return(sched_df)
}

.ncaa_headers <- function(url){
  headers <- c(
    `Host` = 'stats.ncaa.org',
    `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
    `Accept` = 'application/json, text/html, text/plain, */*',
    `Accept-Language` = 'en-US,en;q=0.5',
    `Accept-Encoding` = 'gzip, deflate, br',
    `Pragma` = 'no-cache',
    `Cache-Control` = 'no-cache'
  )
  return(headers)
}
