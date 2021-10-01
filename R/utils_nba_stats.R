.nba_headers <-
  function(url = "https://stats.nba.com/stats/leaguegamelog?Counter=1000&Season=2019-20&Direction=DESC&LeagueID=00&PlayerOrTeam=P&SeasonType=Regular%20Season&Sorter=DATE") {

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
                httr::add_headers(.headers = headers))

    json <- res$content %>%
      rawToChar() %>%
      jsonlite::fromJSON(simplifyVector = T)

    return(json)

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
