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

    res <-
      httr::RETRY("GET", url,
                  query=params,
                httr::add_headers(.headers = headers))

    json <- res$content %>%
      rawToChar() %>%
      jsonlite::fromJSON(simplifyVector = T)

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
    `Pragma` = "no-cache",
    `Cache-Control` = "no-cache"
  )
  return(headers)
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

#' @title **year to season (XXXX -> XXXX-YY)**
#' @param year Four digit year (XXXX)
#' @importFrom dplyr mutate filter select left_join
#' @importFrom stringr str_detect
#' @importFrom tidyr everything
#' @export
year_to_season <- function(year){
  first_year <- substr(year,3,4)
  next_year <- as.numeric(first_year)+1
  next_year <- dplyr::case_when(
    next_year <10 & first_year > 0 ~ glue::glue("0{next_year}"),
    first_year == 99 ~ "00",
    TRUE ~ as.character(next_year))
  return(glue::glue("{year}-{next_year}"))
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
    dplyr::select(-.data$WL,.data$MATCHUP)
  away_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "AWAY") %>%
    dplyr::select(-.data$HOME_AWAY) %>%
    dplyr::select(.data$SEASON_ID, .data$GAME_ID, .data$GAME_DATE, .data$MATCHUP, tidyr::everything())
  colnames(away_df)[5:ncol(away_df)]<-paste0("AWAY_", colnames(away_df)[5:ncol(away_df)])
  home_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "HOME") %>%
    dplyr::select(-.data$HOME_AWAY, -.data$MATCHUP) %>%
    dplyr::select(.data$SEASON_ID, .data$GAME_ID, .data$GAME_DATE,  tidyr::everything())
  colnames(home_df)[4:ncol(home_df)]<-paste0("HOME_", colnames(home_df)[4:ncol(home_df)])
  sched_df <- away_df %>%
    dplyr::left_join(home_df, by=c("GAME_ID", "SEASON_ID", "GAME_DATE"))
  return(sched_df)
}
