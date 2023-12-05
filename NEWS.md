# **hoopR development**

* hoopR now uses cli for its progress bars and error messages (@olivroy, #134), which means it no longer depends on usethis and progressr.

# **hoopR 2.1.0**
* `load_nba_*()` functions now use `sportsdataverse-data` releases url instead of `hoopR-data` repository URL
* `load_mbb_*()` functions now use `sportsdataverse-data` releases url instead of `hoopR-data` repository URL
- `nba_pbp()` and `nba_pbps()` functions add parameter `on_court` (default `TRUE`) to return on-court players for each play event, courtesy of [\@shufinskiy](https://github.com/shufinskiy)

# **hoopR 2.0.0**

### **NBA Stats API Live Endpoints**

- `nba_live_pbp()` function added.
- `nba_live_boxscore()` function added.
- `nba_todays_scoreboard()` function added.

### **NBA Boxscore V3 (and V3-styled) Endpoints Added**

- `nba_scoreboardv3()` function added.
- `nba_boxscoretraditionalv3()` function added.
- `nba_boxscoreadvancedv3()` function added.
- `nba_boxscoremiscv3()` function added.
- `nba_boxscorescoringv3()` function added.
- `nba_boxscoreusagev3()` function added.
- `nba_boxscorefourfactorsv3()` function added.
- `nba_boxscoreplayertrackv3()` function added.
- `nba_boxscorematchupsv3()` function added.
- `nba_boxscorehustlev2()` function added.
- `nba_boxscoredefensivev2()` function added.

### **Other NBA Stats API functions added**

- `nba_shotchartlineupdetail()` function added.
- `nba_synergyplaytypes()` function added.
- `nba_franchiseleaderswrank()` function added.
- `nba_videodetailsasset()` function added.
- `nba_infographicfanduelplayer()` function added.
- `nba_teams()` function added.

### **Other Functions Added**

- `ncaa_mbb_teams()` function added.

### **Proxy Capability Added and Other Notes**

- Add rlang dots option for passing `httr::use_proxy()` option to `nba_*()` functions
- Returns documentation added for all working NBA Stats API endpoints and ESPN functions
- Tests added for all working NBA Stats API endpoints and ESPN functions, over 1000 tests when
  run locally

# **hoopR 1.9.1**
- Updates under-the-hood urls to the ESPN site API v2 summary endpoints

# **hoopR 1.9.0**
- Takes care of tidyselect deprecation of data masking for certain tidyr and dplyr functions.
- Regular minor maintenance on `kp_*` functions
- `espn_mbb_game_rosters()` function added.
- `espn_nba_game_rosters()` function added.

# **hoopR 1.8.1**
- `espn_mbb_player_stats()` function exported properly.
- `espn_nba_player_stats()` function exported properly.
- Fixing headers for `kp_` functions.

# **hoopR 1.8.0**
- `espn_mbb_player_stats()` function added.
- `espn_mbb_team_stats()` function added.
- `espn_nba_player_stats()` function added.
- `espn_nba_team_stats()` function added.

# **hoopR 1.7.0**
- `nba_pbps()` function added, courtesy of [\@papagorgio23](https://github.com/papagorgio23). 
- `nbagl_players()` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- `nbagl_schedule()` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- `nbagl_pbp()` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- `nbagl_standings()` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- `nba_gamerotation()` function added.

# **hoopR 1.6.0**
- `nba_playerindex()` function added.
- `nba_playerheadshot()` function added.
- `nba_drafthistory()` function added.

# **hoopR 1.5.0**
- Major documentation update to include names of returned lists of data frames for all exported NBA Stats API, ESPN API, KenPom, NCAA and Data repository functions. 

# **hoopR 1.4.5**
- Add `kp_referee()` function

# **hoopR 1.4.4**
- Remove referee ranks from `kp_box()` function

# **hoopR 1.4.3**
- Option configs changed to revert to user options

# **hoopR 1.4.2**
- Implement additional boxscore function parameters for `nba_boxscore(.*)` functions

# **hoopR 1.4.1**
- Update `teams_links` internal dataset for 2022 (need a better solve here)
- Added `nba_teams` dataset for working with the NBA Stats API

# **hoopR 1.4.0**
- [`hoopR::espn_mbb_betting()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_betting.html)
    function added
- [`hoopR::espn_nba_betting()`](https://hoopr.sportsdataverse.org/reference/espn_nba_betting.html)
    function added

# **hoopR 1.3.1**
- Fix [`kp_winprob`](https://hoopr.sportsdataverse.org/reference/kp_winprob.html) function, adding runs as third output

# **hoopR 1.3.0**

### **Add Full Coverage for NBA Stats API**

Adding roughly 127 functions

| Function  | File Location   |
|---	|---	|
| `nba_alltimeleadersgrids()` 	| R/nba_stats_leaders.R 	|
| `nba_assistleaders()` 	| R/nba_stats_leaders.R 	|
| `nba_assisttracker()` 	| R/nba_stats_leaders.R 	|
| `nba_boxscoreadvancedv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoredefensive()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscorefourfactorsv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscorematchups()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoremiscv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoreplayertrackv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscorescoringv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoresimilarityscore()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoresummaryv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoretraditionalv2()` 	| R/nba_stats_boxscore.R 	|
| `nba_boxscoreusagev2()` 	| R/nba_stats_boxscore.R 	|
| `nba_commonallplayers()` 	| R/nba_stats_roster.R 	|
| `nba_commonplayerinfo()` 	| R/nba_stats_roster.R 	|
| `nba_commonplayoffseries()` 	| R/nba_stats_roster.R 	|
| `nba_commonteamroster()` 	| R/nba_stats_roster.R 	|
| `nba_cumestatsplayer()` 	| R/nba_stats_cume.R 	|
| `nba_cumestatsplayergames()` 	| R/nba_stats_cume.R 	|
| `nba_cumestatsteam()` 	| R/nba_stats_cume.R 	|
| `nba_cumestatsteamgames()` 	| R/nba_stats_cume.R 	|
| `nba_defensehub()` 	| R/nba_stats_leaders.R 	|
| `nba_draftboard()` 	| R/nba_stats_draft.R 	|
| `nba_draftcombinedrillresults()` 	| R/nba_stats_draft.R 	|
| `nba_draftcombinenonstationaryshooting()` 	| R/nba_stats_draft.R 	|
| `nba_draftcombineplayeranthro()` 	| R/nba_stats_draft.R 	|
| `nba_draftcombinespotshooting()` 	| R/nba_stats_draft.R 	|
| `nba_draftcombinestats()` 	| R/nba_stats_draft.R 	|
| `nba_fantasywidget()` 	| R/nba_stats_lineups.R 	|
| `nba_franchisehistory()` 	| R/nba_stats_franchise.R 	|
| `nba_franchiseleaders()` 	| R/nba_stats_franchise.R 	|
| `nba_franchiseplayers()` 	| R/nba_stats_franchise.R 	|
| `nba_glalumboxscoresimilarityscore()` 	| R/nba_stats_boxscore.R 	|
| `nba_homepageleaders()` 	| R/nba_stats_leaders.R 	|
| `nba_homepagev2()` 	| R/nba_stats_leaders.R 	|
| `nba_hustlestatsboxscore()` 	| R/nba_stats_boxscore.R 	|
| `nba_leaderstiles()` 	| R/nba_stats_leaders.R 	|
| `nba_leaguedashlineups()` 	| R/nba_stats_lineups.R 	|
| `nba_leaguedashoppptshot()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashplayerbiostats()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashplayerclutch()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashplayerptshot()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashplayershotlocations()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashplayerstats()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashptdefend()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashptstats()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashptteamdefend()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashteamclutch()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashteamptshot()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashteamshotlocations()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguedashteamstats()` 	| R/nba_stats_league_dash.R 	|
| `nba_leaguegamefinder()` 	| R/nba_stats_league.R 	|
| `nba_leaguegamelog()` 	| R/nba_stats_league.R 	|
| `nba_leaguehustlestatsplayer()` 	| R/nba_stats_hustle.R 	|
| `nba_leaguehustlestatsplayerleaders()` 	| R/nba_stats_hustle.R 	|
| `nba_leaguehustlestatsteam()` 	| R/nba_stats_hustle.R 	|
| `nba_leaguehustlestatsteamleaders()` 	| R/nba_stats_hustle.R 	|
| `nba_leagueleaders()` 	| R/nba_stats_leaders.R 	|
| `nba_leaguelineupviz()` 	| R/nba_stats_lineups.R 	|
| `nba_leagueplayerondetails()` 	| R/nba_stats_lineups.R 	|
| `nba_leagueseasonmatchups()` 	| R/nba_stats_lineups.R 	|
| `nba_leaguestandings()` 	| R/nba_stats_league.R 	|
| `nba_leaguestandingsv3()` 	| R/nba_stats_league.R 	|
| `nba_matchupsrollup()` 	| R/nba_stats_lineups.R 	|
| `nba_pbp()` 	| R/nba_stats_pbp.R 	|
| `nba_playerawards()` 	| R/nba_stats_player.R 	|
| `nba_playercareerbycollege()` 	| R/nba_stats_player.R 	|
| `nba_playercareerbycollegerollup()` 	| R/nba_stats_player.R 	|
| `nba_playercareerstats()` 	| R/nba_stats_player.R 	|
| `nba_playercompare()` 	| R/nba_stats_player.R 	|
| `nba_playerdashboardbyclutch()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbygamesplits()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbygeneralsplits()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbylastngames()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbyopponent()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbyshootingsplits()` 	| R/nba_stats_player_dash.R 	|
| `nba_playerdashboardbyteamperformance()` 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbyyearoveryear 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptpass 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptreb 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptshotdefend 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptshots 	| R/nba_stats_player_dash.R 	|
| nba_playerestimatedmetrics 	| R/nba_stats_player.R 	|
| nba_playerfantasyprofile 	| R/nba_stats_player.R 	|
| nba_playerfantasyprofilebargraph 	| R/nba_stats_player.R 	|
| nba_playergamelog 	| R/nba_stats_player.R 	|
| nba_playergamelogs 	| R/nba_stats_player.R 	|
| nba_playergamestreakfinder 	| R/nba_stats_player.R 	|
| nba_playernextngames 	| R/nba_stats_player.R 	|
| nba_playerprofilev2 	| R/nba_stats_player.R 	|
| nba_playervsplayer 	| R/nba_stats_player.R 	|
| nba_playoffpicture 	| R/nba_stats_league.R 	|
| nba_schedule 	| R/nba_stats_pbp.R 	|
| nba_scoreboard 	| R/nba_stats_scoreboard.R 	|
| nba_scoreboardv2 	| R/nba_stats_scoreboard.R 	|
| nba_shotchartdetail 	| R/nba_stats_shotchart.R 	|
| nba_shotchartleaguewide 	| R/nba_stats_shotchart.R 	|
| nba_teamdashboardbyclutch 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbygamesplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbygeneralsplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbylastngames 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyopponent 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyshootingsplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyteamperformance 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyyearoveryear 	| R/nba_stats_team_dash.R 	|
| nba_teamdashlineups 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptpass 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptreb 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptshots 	| R/nba_stats_team_dash.R 	|
| nba_teamdetails 	| R/nba_stats_team.R 	|
| nba_teamestimatedmetrics 	| R/nba_stats_team.R 	|
| nba_teamgamelog 	| R/nba_stats_team.R 	|
| nba_teamgamelogs 	| R/nba_stats_team.R 	|
| nba_teamgamestreakfinder 	| R/nba_stats_team.R 	|
| nba_teamhistoricalleaders 	| R/nba_stats_team.R 	|
| nba_teaminfocommon 	| R/nba_stats_team.R 	|
| nba_teamplayerdashboard 	| R/nba_stats_team.R 	|
| nba_teamplayeronoffdetails 	| R/nba_stats_team.R 	|
| nba_teamplayeronoffsummary 	| R/nba_stats_team.R 	|
| nba_teamvsplayer 	| R/nba_stats_team.R 	|
| nba_teamyearbyyearstats 	| R/nba_stats_team.R 	|
| nba_videodetails 	| R/nba_stats_video.R 	|
| nba_videoevents 	| R/nba_stats_video.R 	|
| nba_videostatus 	| R/nba_stats_video.R 	|
| nba_winprobabilitypbp 	| R/nba_stats_scoreboard.R 	|

# **hoopR 1.2.0**

### **Add schedule loaders**

  - [`hoopR::load_mbb_schedule()`](https://hoopr.sportsdataverse.org/reference/load_mbb_schedule.html)
    function added
  - [`hoopR::load_nba_schedule()`](https://hoopr.sportsdataverse.org/reference/load_nba_schedule.html)
    function added

# **hoopR 1.1.0** 
### **Add team box score loaders**
- [`hoopR::load_mbb_team_box()`](https://hoopr.sportsdataverse.org/reference/load_mbb_team_box.html) function added
- [`hoopR::load_nba_team_box()`](https://hoopr.sportsdataverse.org/reference/load_nba_team_box.html) function added

### **Add player box score loaders**
- [`hoopR::load_mbb_player_box()`](https://hoopr.sportsdataverse.org/reference/load_mbb_player_box.html) function added
- [`hoopR::load_nba_player_box()`](https://hoopr.sportsdataverse.org/reference/load_nba_player_box.html) function added

# **hoopR 1.0.5**
### **Standings functions**
- [`hoopR::espn_nba_standings()`](https://hoopr.sportsdataverse.org/reference/espn_nba_standings.html)
- [`hoopR::espn_mbb_standings()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_standings.html)

# **hoopR 1.0.4**
### **Add retry**
- Adding [`httr::retry()`](https://httr.r-lib.org/reference/RETRY.html) to all function calls to more naturally navigate rejected/failed requests from the API.

# **hoopR 1.0.2-3** 
### **Quick fix for update db functions**

# **hoopR 1.0.1-4**
### **Dependency pruning**
This update is a non-user facing change to package dependencies to shrink the list of dependencies.

# **hoopR 1.0.0**
### **Package renamed to hoopR**
To reflect that the package is no longer just a men's college basketball and KenPom package, but also an NBA package. 

### **Clean names and team returns**
- All functions have now been given the [`janitor::clean_names()`](https://rdrr.io/cran/janitor/man/clean_names.html) treatment
- [`hoopR::espn_mbb_teams()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_teams.html) has updated the returns to be more identity information related only
- [`hoopR::espn_nba_teams()`](https://hoopr.sportsdataverse.org/reference/espn_nba_teams.html) to be more identity information related only
- All tests were updated

### **Loading capabilities added to the package**
- [`hoopR::load_mbb_pbp()`](https://hoopr.sportsdataverse.org/reference/load_mbb_pbp.html) and [`hoopR::update_mbb_db()`](https://hoopr.sportsdataverse.org/reference/update_mbb_db.html) functions added
- [`hoopR::load_nba_pbp()`](https://hoopr.sportsdataverse.org/reference/load_nba_pbp.html) and [`hoopR::update_nba_db()`](https://hoopr.sportsdataverse.org/reference/update_nba_db.html) functions added

# **hoopR 0.4**
- Added support for ESPN's NBA play-by-play endpoints with the addition of the following functions:
- `hoopR::espn_nba_game_all()` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- `hoopR::espn_nba_team_box()`
- `hoopR::espn_nba_player_box()`
- `hoopR::espn_nba_pbp()`
- `hoopR::espn_nba_teams()` 
- `hoopR::espn_nba_scoreboard()` 

# **hoopR 0.3.0**
### **Dependencies**
- `R` version 3.5.0 or greater dependency added
- `purrr` version 0.3.0 or greater dependency added
- `rvest` version 1.0.0 or greater dependency added
- `progressr` version 0.6.0 or greater dependency added
- `usethis` version 1.6.0 or greater dependency added
- `xgboost` version 1.1.0 or greater dependency added
- `tidyr` version 1.0.0 or greater dependency added
- `stringr` version 1.3.0 or greater dependency added
- `tibble` version 3.0.0 or greater dependency added
- `furrr` dependency added
- `future` dependency added

### **Test coverage**
* Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**
* All functions sourced from [kenpom.com](https://kenpom.com/) will start with `kp_` as opposed to `get_` 
* Similarly, data and metrics sourced from ESPN will begin with `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_` have been changed to `mbb_` as appropriate.
* Data sourced directly from the NCAA website will start the function with `ncaa_`


# **hoopR 0.2.0-3**
- Added support for ESPN's men's college basketball play-by-play endpoints with the addition of the following functions:
- `hoopR::espn_mbb_game_all()` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- `hoopR::espn_mbb_team_box()`
- `hoopR::espn_mbb_player_box()`
- `hoopR::espn_mbb_pbp()`
- `hoopR::espn_mbb_teams()` (bumps to v0.2.1)
- `hoopR::espn_mbb_conferences()` (bumps to v0.2.1)
- `hoopR::espn_mbb_scoreboard()` (bumps to v0.2.2)
- `hoopR::ncaa_mbb_NET_rankings()` (bumps to v0.2.3)
- `hoopR::espn_mbb_rankings()` (bumps to v0.2.3)

# **hoopR 0.1.0** 
-    Minor fixes

# **hoopR 0.0.0.9**
Initial Commits, remaining tasks:

-   Game Prep Tables
-   ~~Player Career Tables~~
-   ~~Game Box Scores~~
-   ~~Argument assertions~~
