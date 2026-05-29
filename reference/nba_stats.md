# **NBA Stats API Endpoint Overview**

Wrappers around the NBA Stats backend at `stats.nba.com/stats/...`. All
requests go through
[`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
(in `utils_nba_stats.R`) which sets the required NBA-side headers
(`x-nba-stats-origin: stats`, `x-nba-stats-token: true`,
`Referer: https://www.nba.com/`) and threads a proxy via
`getOption("hoopR.proxy")` / env vars / explicit `proxy =` arg.

## Details

### **Boxscores (V2)**

Tabular `resultSets[]` responses parsed via
`nba_stats_map_result_sets()`. See
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md),
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md),
[`nba_boxscoresimilarityscore()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresimilarityscore.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md).

### **Boxscores (V3)**

Nested JSON responses parsed via
[`purrr::pluck()`](https://purrr.tidyverse.org/reference/pluck.html).
See
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md).

### **Play-by-play**

|  |  |
|----|----|
| Function | Purpose |
| [`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md) | V2 + V3 play-by-play (with V3-to-V2 conversion pipeline) |
| [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md) | Multi-game PBP loader |
| [`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md) | V3-only PBP |
| `nba_pbp_v2()` | V2-only PBP (legacy) |
| [`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md) | Data.nba.com PBP scraper |
| [`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md) | Live PBP (CDN feed) |
| [`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md) | Live boxscore (CDN feed) |
| [`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md) | Win-probability PBP overlay |

### **Leaders / standings / league**

See
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md),
[`nba_leaguestandings()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandings.md),
[`nba_leaguestandingsv3()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandingsv3.md),
[`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md).

### **Player + team season + game stats**

Full per-mode / per-split families. Search the reference index for
`nba_playerdashboard*`, `nba_teamdashboard*`, `nba_playerprofile*`,
[`nba_playergamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelogs.md),
[`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md).

### **Schedule + scoreboard**

[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md).

### **Draft + franchise + reference**

[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md),
[`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaders.md),
[`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md),
[`nba_franchiseplayers()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseplayers.md).
