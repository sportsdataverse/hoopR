# **hoopR 1.4.0**
- [`hoopR::espn_mbb_betting()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_betting.html)
    function added
- [`hoopR::espn_nba_betting()`](https://saiemgilani.github.io/hoopR/reference/espn_nba_betting.html)
    function added

# **hoopR 1.3.1**
- Fix [```kp_winprob```](https://saiemgilani.github.io/hoopR/reference/kp_winprob.html) function, adding runs as third output

# **hoopR 1.3.0**

### **Add Full Coverage for NBA Stats API**

Adding roughly 127 functions

| Function  | File Location   |
|---	|---	|
| [nba_alltimeleadersgrids](https://saiemgilani.github.io/hoopR/reference/nba_alltimeleadersgrids.html) 	| R/nba_stats_leaders.R 	|
| [nba_assistleaders](https://saiemgilani.github.io/hoopR/reference/nba_assistleaders.html) 	| R/nba_stats_leaders.R 	|
| [nba_assisttracker](https://saiemgilani.github.io/hoopR/reference/nba_assisttracker.html) 	| R/nba_stats_leaders.R 	|
| [nba_boxscoreadvancedv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscoreadvancedv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoredefensive](https://saiemgilani.github.io/hoopR/reference/nba_boxscoredefensive.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscorefourfactorsv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscorefourfactorsv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscorematchups](https://saiemgilani.github.io/hoopR/reference/nba_boxscorematchups.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoremiscv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscoremiscv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoreplayertrackv2](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscorescoringv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscorescoringv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoresimilarityscore](https://saiemgilani.github.io/hoopR/reference/nba_boxscoresimilarityscore.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoresummaryv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscoresummaryv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoretraditionalv2](https://saiemgilani.github.io/hoopR/reference/nba_boxscoretraditionalv2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_boxscoreusagev2](https://saiemgilani.github.io/hoopR/reference/nba_boxscoreusagev2.html) 	| R/nba_stats_boxscore.R 	|
| [nba_commonallplayers](https://saiemgilani.github.io/hoopR/reference/nba_commonallplayers.html) 	| R/nba_stats_roster.R 	|
| [nba_commonplayerinfo](https://saiemgilani.github.io/hoopR/reference/nba_commonplayerinfo.html) 	| R/nba_stats_roster.R 	|
| [nba_commonplayoffseries](https://saiemgilani.github.io/hoopR/reference/nba_commonplayoffseries.html) 	| R/nba_stats_roster.R 	|
| [nba_commonteamroster](https://saiemgilani.github.io/hoopR/reference/nba_commonteamroster.html) 	| R/nba_stats_roster.R 	|
| [nba_commonteamyears](https://saiemgilani.github.io/hoopR/reference/nba_commonteamyears.html) 	| R/nba_stats_roster.R 	|
| [nba_cumestatsplayer](https://saiemgilani.github.io/hoopR/reference/nba_cumestatsplayer.html) 	| R/nba_stats_cume.R 	|
| [nba_cumestatsplayergames](https://saiemgilani.github.io/hoopR/reference/nba_cumestatsplayergames.html) 	| R/nba_stats_cume.R 	|
| [nba_cumestatsteam](https://saiemgilani.github.io/hoopR/reference/nba_cumestatsteam.html) 	| R/nba_stats_cume.R 	|
| [nba_cumestatsteamgames](https://saiemgilani.github.io/hoopR/reference/nba_cumestatsteamgames.html) 	| R/nba_stats_cume.R 	|
| [nba_defensehub](https://saiemgilani.github.io/hoopR/reference/nba_defensehub.html) 	| R/nba_stats_leaders.R 	|
| [nba_draftboard](https://saiemgilani.github.io/hoopR/reference/nba_draftboard.html) 	| R/nba_stats_draft.R 	|
| [nba_draftcombinedrillresults](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_draft.R 	|
| [nba_draftcombinenonstationaryshooting](https://saiemgilani.github.io/hoopR/reference/nba_draftcombinenonstationaryshooting.html) 	| R/nba_stats_draft.R 	|
| [nba_draftcombineplayeranthro](https://saiemgilani.github.io/hoopR/reference/nba_draftcombineplayeranthro.html) 	| R/nba_stats_draft.R 	|
| [nba_draftcombinespotshooting](https://saiemgilani.github.io/hoopR/reference/nba_draftcombinespotshooting.html) 	| R/nba_stats_draft.R 	|
| [nba_draftcombinestats](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_draft.R 	|
| [nba_fantasywidget](https://saiemgilani.github.io/hoopR/reference/nba_fantasywidget.html) 	| R/nba_stats_lineups.R 	|
| [nba_franchisehistory](https://saiemgilani.github.io/hoopR/reference/nba_franchisehistory.html) 	| R/nba_stats_franchise.R 	|
| [nba_franchiseleaders](https://saiemgilani.github.io/hoopR/reference/nba_franchiseleaders.html) 	| R/nba_stats_franchise.R 	|
| [nba_franchiseplayers](https://saiemgilani.github.io/hoopR/reference/nba_franchiseplayers.html) 	| R/nba_stats_franchise.R 	|
| [nba_glalumboxscoresimilarityscore](https://saiemgilani.github.io/hoopR/reference/nba_glalumboxscoresimilarityscore.html) 	| R/nba_stats_boxscore.R 	|
| [nba_homepageleaders](https://saiemgilani.github.io/hoopR/reference/nba_homepageleaders.html) 	| R/nba_stats_leaders.R 	|
| [nba_homepagev2](https://saiemgilani.github.io/hoopR/reference/nba_homepagev2.html) 	| R/nba_stats_leaders.R 	|
| [nba_hustlestatsboxscore](https://saiemgilani.github.io/hoopR/reference/nba_hustlestatsboxscore.html) 	| R/nba_stats_boxscore.R 	|
| [nba_leaderstiles](https://saiemgilani.github.io/hoopR/reference/nba_hustlestatsboxscore.html) 	| R/nba_stats_leaders.R 	|
| [nba_leaguedashlineups](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashlineups.html) 	| R/nba_stats_lineups.R 	|
| [nba_leaguedashoppptshot](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashoppptshot.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashplayerbiostats](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashplayerbiostats.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashplayerclutch](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashplayerclutch.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashplayerptshot](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashplayerptshot.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashplayershotlocations](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashplayershotlocations.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashplayerstats](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashplayerstats.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashptdefend](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashptdefend.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashptstats](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashptstats.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashptteamdefend](https://saiemgilani.github.io/hoopR/reference/nba_leaguedashptteamdefend.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashteamclutch](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashteamptshot](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashteamshotlocations](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguedashteamstats](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league_dash.R 	|
| [nba_leaguegamefinder](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league.R 	|
| [nba_leaguegamelog](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league.R 	|
| [nba_leaguehustlestatsplayer](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_hustle.R 	|
| [nba_leaguehustlestatsplayerleaders](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_hustle.R 	|
| [nba_leaguehustlestatsteam](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_hustle.R 	|
| [nba_leaguehustlestatsteamleaders](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_hustle.R 	|
| [nba_leagueleaders](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_leaders.R 	|
| [nba_leaguelineupviz](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_lineups.R 	|
| [nba_leagueplayerondetails](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_lineups.R 	|
| [nba_leagueseasonmatchups](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_lineups.R 	|
| [nba_leaguestandings](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league.R 	|
| [nba_leaguestandingsv3](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_league.R 	|
| [nba_matchupsrollup](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_lineups.R 	|
| [nba_pbp](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_pbp.R 	|
| [nba_playerawards](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playercareerbycollege](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playercareerbycollegerollup](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playercareerstats](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playercompare](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playerdashboardbyclutch](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbygamesplits](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbygeneralsplits](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbylastngames](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbyopponent](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbyshootingsplits](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbyteamperformance](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashboardbyyearoveryear](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashptpass](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashptreb](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashptshotdefend](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerdashptshots](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player_dash.R 	|
| [nba_playerestimatedmetrics](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playerfantasyprofile](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playerfantasyprofilebargraph](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playergamelog](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playergamelogs](https://saiemgilani.github.io/hoopR/reference/.html) 	| R/nba_stats_player.R 	|
| [nba_playergamestreakfinder](https://saiemgilani.github.io/hoopR/reference/nba_playergamestreakfinder.html) 	| R/nba_stats_player.R 	|
| [nba_playernextngames](https://saiemgilani.github.io/hoopR/reference/nba_playernextngames.html) 	| R/nba_stats_player.R 	|
| [nba_playerprofilev2](https://saiemgilani.github.io/hoopR/reference/nba_playerprofilev2.html) 	| R/nba_stats_player.R 	|
| [nba_playervsplayer](https://saiemgilani.github.io/hoopR/reference/nba_playervsplayer.html) 	| R/nba_stats_player.R 	|
| [nba_playoffpicture](https://saiemgilani.github.io/hoopR/reference/nba_playoffpicture.html) 	| R/nba_stats_league.R 	|
| [nba_schedule](https://saiemgilani.github.io/hoopR/reference/nba_schedule.html) 	| R/nba_stats_pbp.R 	|
| [nba_scoreboard](https://saiemgilani.github.io/hoopR/reference/nba_scoreboard.html) 	| R/nba_stats_scoreboard.R 	|
| [nba_scoreboardv2](https://saiemgilani.github.io/hoopR/reference/nba_scoreboardv2.html) 	| R/nba_stats_scoreboard.R 	|
| [nba_shotchartdetail](https://saiemgilani.github.io/hoopR/reference/[nba_shotchartdetail.html) 	| R/nba_stats_shotchart.R 	|
| [nba_shotchartleaguewide](https://saiemgilani.github.io/hoopR/reference/nba_shotchartleaguewide.html) 	| R/nba_stats_shotchart.R 	|
| [nba_teamdashboardbyclutch](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbyclutch.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbygamesplits](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbygamesplits.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbygeneralsplits](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbygeneralsplits.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbylastngames](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbylastngames.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbyopponent](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbyopponent.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbyshootingsplits](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbyshootingsplits.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbyteamperformance](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbyteamperformance.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashboardbyyearoveryear](https://saiemgilani.github.io/hoopR/reference/nba_teamdashboardbyyearoveryear.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashlineups](https://saiemgilani.github.io/hoopR/reference/nba_teamdashlineups.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashptpass](https://saiemgilani.github.io/hoopR/reference/nba_teamdashptpass.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashptreb](https://saiemgilani.github.io/hoopR/reference/nba_teamdashptreb.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdashptshots](https://saiemgilani.github.io/hoopR/reference/nba_teamdashptshots.html) 	| R/nba_stats_team_dash.R 	|
| [nba_teamdetails](https://saiemgilani.github.io/hoopR/reference/nba_teamdetails.html) 	| R/nba_stats_team.R 	|
| [nba_teamestimatedmetrics](https://saiemgilani.github.io/hoopR/reference/nba_teamestimatedmetrics.html) 	| R/nba_stats_team.R 	|
| [nba_teamgamelog](https://saiemgilani.github.io/hoopR/reference/nba_teamgamelog.html) 	| R/nba_stats_team.R 	|
| [nba_teamgamelogs](https://saiemgilani.github.io/hoopR/reference/nba_teamgamelogs.html) 	| R/nba_stats_team.R 	|
| [nba_teamgamestreakfinder](https://saiemgilani.github.io/hoopR/reference/nba_teamgamestreakfinder.html) 	| R/nba_stats_team.R 	|
| [nba_teamhistoricalleaders](https://saiemgilani.github.io/hoopR/reference/nba_teamhistoricalleaders.html) 	| R/nba_stats_team.R 	|
| [nba_teaminfocommon](https://saiemgilani.github.io/hoopR/reference/nba_teaminfocommon.html) 	| R/nba_stats_team.R 	|
| [nba_teamplayerdashboard](https://saiemgilani.github.io/hoopR/reference/nba_teamplayerdashboard.html) 	| R/nba_stats_team.R 	|
| [nba_teamplayeronoffdetails](https://saiemgilani.github.io/hoopR/reference/nba_teamplayeronoffdetails.html) 	| R/nba_stats_team.R 	|
| [nba_teamplayeronoffsummary](https://saiemgilani.github.io/hoopR/reference/nba_teamplayeronoffsummary.html) 	| R/nba_stats_team.R 	|
| [nba_teamvsplayer](https://saiemgilani.github.io/hoopR/reference/nba_teamplayeronoffsummary.html) 	| R/nba_stats_team.R 	|
| [nba_teamyearbyyearstats](https://saiemgilani.github.io/hoopR/reference/nba_teamyearbyyearstats.html) 	| R/nba_stats_team.R 	|
| [nba_videodetails](https://saiemgilani.github.io/hoopR/reference/nba_videodetails.html) 	| R/nba_stats_video.R 	|
| [nba_videoevents](https://saiemgilani.github.io/hoopR/reference/nba_videoevents.html) 	| R/nba_stats_video.R 	|
| [nba_videostatus](https://saiemgilani.github.io/hoopR/reference/nba_videostatus.html) 	| R/nba_stats_video.R 	|
| [nba_winprobabilitypbp](https://saiemgilani.github.io/hoopR/reference/nba_winprobabilitypbp.html) 	| R/nba_stats_scoreboard.R 	|

# **hoopR 1.2.0**

### **Add schedule loaders**

  - [`hoopR::load_mbb_schedule()`](https://saiemgilani.github.io/hoopR/reference/load_mbb_schedule.html)
    function added
  - [`hoopR::load_nba_schedule()`](https://saiemgilani.github.io/hoopR/reference/load_nba_schedule.html)
    function added

# **hoopR 1.1.0** 
### **Add team box score loaders**
- [```hoopR::load_mbb_team_box()```](https://saiemgilani.github.io/hoopR/reference/load_mbb_team_box.html) function added
- [```hoopR::load_nba_team_box()```](https://saiemgilani.github.io/hoopR/reference/load_nba_team_box.html) function added

### **Add player box score loaders**
- [```hoopR::load_mbb_player_box()```](https://saiemgilani.github.io/hoopR/reference/load_mbb_player_box.html) function added
- [```hoopR::load_nba_player_box()```](https://saiemgilani.github.io/hoopR/reference/load_nba_player_box.html) function added

# **hoopR 1.0.5**
### **Standings functions**
- [```hoopR::espn_nba_standings()```](https://saiemgilani.github.io/hoopR/reference/espn_nba_standings.html)
- [```hoopR::espn_mbb_standings()```](https://saiemgilani.github.io/hoopR/reference/espn_mbb_standings.html)

# **hoopR 1.0.4**
### **Add retry**
- Adding [```httr::retry()```](https://httr.r-lib.org/reference/RETRY.html) to all function calls to more naturally navigate rejected/failed requests from the API.

# **hoopR 1.0.2-3** 
### **Quick fix for update db functions**

# **hoopR 1.0.1-4**
### **Dependency pruning**
This update is a non-user facing change to package dependencies to shrink the list of dependencies.

# **hoopR 1.0.0**
### **Package renamed to hoopR**
To reflect that the package is no longer just a men's college basketball and KenPom package, but also an NBA package. 

### **Clean names and team returns**
- All functions have now been given the [```janitor::clean_names()```](https://rdrr.io/cran/janitor/man/clean_names.html) treatment
- [```hoopR::espn_mbb_teams()```](https://saiemgilani.github.io/hoopR/reference/espn_mbb_teams.html) has updated the returns to be more identity information related only
- [```hoopR::espn_nba_teams()```](https://saiemgilani.github.io/hoopR/reference/espn_nba_teams.html) to be more identity information related only
- All tests were updated

### **Loading capabilities added to the package**
- [```hoopR::load_mbb_pbp()```](https://saiemgilani.github.io/hoopR/reference/load_mbb_pbp.html) and [```hoopR::update_mbb_db()```](https://saiemgilani.github.io/hoopR/reference/update_mbb_db.html) functions added
- [```hoopR::load_nba_pbp()```](https://saiemgilani.github.io/hoopR/reference/load_nba_pbp.html) and [```hoopR::update_nba_db()```](https://saiemgilani.github.io/hoopR/reference/update_nba_db.html) functions added

# **hoopR 0.4**
- Added support for ESPN's NBA play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_nba_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_nba_team_box()```
- ```hoopR::espn_nba_player_box()```
- ```hoopR::espn_nba_pbp()```
- ```hoopR::espn_nba_teams()``` 
- ```hoopR::espn_nba_scoreboard()``` 

# **hoopR 0.3.0**
### **Dependencies**
- ```R``` version 3.5.0 or greater dependency added
- ```purrr``` version 0.3.0 or greater dependency added
- ```rvest``` version 1.0.0 or greater dependency added
- ```progressr``` version 0.6.0 or greater dependency added
- ```usethis``` version 1.6.0 or greater dependency added
- ```xgboost``` version 1.1.0 or greater dependency added
- ```tidyr``` version 1.0.0 or greater dependency added
- ```stringr``` version 1.3.0 or greater dependency added
- ```tibble``` version 3.0.0 or greater dependency added
- ```furrr``` dependency added
- ```future``` dependency added

### **Test coverage**
* Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**
* All functions sourced from [kenpom.com](https://www.kenpom.com/) will start with `kp_` as opposed to `get_` 
* Similarly, data and metrics sourced from ESPN will begin with `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_` have been changed to `mbb_` as appropriate.
* Data sourced directly from the NCAA website will start the function with `ncaa_`


# **hoopR 0.2.0-3**
- Added support for ESPN's men's college basketball play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_mbb_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_mbb_team_box()```
- ```hoopR::espn_mbb_player_box()```
- ```hoopR::espn_mbb_pbp()```
- ```hoopR::espn_mbb_teams()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_conferences()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_scoreboard()``` (bumps to v0.2.2)
- ```hoopR::ncaa_mbb_NET_rankings()``` (bumps to v0.2.3)
- ```hoopR::espn_mbb_rankings()``` (bumps to v0.2.3)

# **hoopR 0.1.0** 
-    Minor fixes

# **hoopR 0.0.0.9**
Initial Commits, remaining tasks:

-   Game Prep Tables
-   ~~Player Career Tables~~
-   ~~Game Box Scores~~
-   ~~Argument assertions~~
