#' @name nba_stats
#' @aliases nba_stats hoopR_nba_stats
#' @title **NBA Stats API Endpoint Overview**
#' @description
#' Wrappers around the NBA Stats backend at `stats.nba.com/stats/...`.
#' All requests go through `request_with_proxy()` (in
#' `utils_nba_stats.R`) which sets the required NBA-side headers
#' (`x-nba-stats-origin: stats`, `x-nba-stats-token: true`,
#' `Referer: https://www.nba.com/`) and threads a proxy via
#' `getOption("hoopR.proxy")` / env vars / explicit `proxy =` arg.
#'
#' @details
#'
#' ## **Boxscores (V2)**
#'
#' Tabular `resultSets[]` responses parsed via `nba_stats_map_result_sets()`.
#' See [nba_boxscoreadvancedv2()], [nba_boxscoretraditionalv2()],
#' [nba_boxscoredefensivev2()], [nba_boxscorefourfactorsv2()],
#' [nba_boxscorematchups()], [nba_boxscoremiscv2()],
#' [nba_boxscoreplayertrackv2()], [nba_boxscorescoringv2()],
#' [nba_boxscoresimilarityscore()], [nba_boxscoresummaryv2()],
#' [nba_boxscoreusagev2()], [nba_hustlestatsboxscore()].
#'
#' ## **Boxscores (V3)**
#'
#' Nested JSON responses parsed via `purrr::pluck()`. See
#' [nba_boxscoreadvancedv3()], [nba_boxscoredefensivev2()],
#' [nba_boxscorefourfactorsv3()], [nba_boxscorehustlev2()],
#' [nba_boxscorematchupsv3()], [nba_boxscoremiscv3()],
#' [nba_boxscoreplayertrackv3()], [nba_boxscorescoringv3()],
#' [nba_boxscoretraditionalv3()], [nba_boxscoreusagev3()].
#'
#' ## **Play-by-play**
#'
#' | Function | Purpose |
#' |---|---|
#' | [nba_pbp()]                | V2 + V3 play-by-play (with V3-to-V2 conversion pipeline) |
#' | [nba_pbps()]               | Multi-game PBP loader |
#' | [nba_playbyplayv3()]       | V3-only PBP |
#' | [nba_pbp_v2()]             | V2-only PBP (legacy) |
#' | [nba_data_pbp()]           | Data.nba.com PBP scraper |
#' | [nba_live_pbp()]           | Live PBP (CDN feed) |
#' | [nba_live_boxscore()]      | Live boxscore (CDN feed) |
#' | [nba_winprobabilitypbp()]  | Win-probability PBP overlay |
#'
#' ## **Leaders / standings / league**
#'
#' See [nba_leagueleaders()], [nba_leaguestandings()],
#' [nba_leaguestandingsv3()], [nba_iststandings()],
#' [nba_dunkscoreleaders()], [nba_gravityleaders()],
#' [nba_homepageleaders()], [nba_leaderstiles()].
#'
#' ## **Player + team season + game stats**
#'
#' Full per-mode / per-split families. Search the reference index for
#' `nba_playerdashboard*`, `nba_teamdashboard*`, `nba_playerprofile*`,
#' `nba_playergamelogs()`, `nba_teamgamelogs()`,
#' `nba_leaguedashplayerstats()`, `nba_leaguedashteamstats()`.
#'
#' ## **Schedule + scoreboard**
#'
#' [nba_schedule()], [nba_scheduleleaguev2int()],
#' [nba_scoreboard()], [nba_scoreboardv2()], [nba_scoreboardv3()],
#' [nba_todays_scoreboard()].
#'
#' ## **Draft + franchise + reference**
#'
#' [nba_draftboard()], [nba_drafthistory()],
#' [nba_draftcombinestats()], [nba_draftcombinedrillresults()],
#' [nba_draftcombineplayeranthro()],
#' [nba_draftcombinenonstationaryshooting()],
#' [nba_draftcombinespotshooting()],
#' [nba_franchisehistory()], [nba_franchiseleaders()],
#' [nba_franchiseleaderswrank()], [nba_franchiseplayers()].
#'
#' @keywords NBA Stats API
#' @family NBA Stats
NULL
