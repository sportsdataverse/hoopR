<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Release summary](#release-summary)
  - [NBA Play-by-Play V3](#nba-play-by-play-v3)
  - [NBA Boxscore Summary V3](#nba-boxscore-summary-v3)
  - [New NBA Stats API Endpoint Wrappers](#new-nba-stats-api-endpoint-wrappers)
  - [ESPN Functions](#espn-functions)
  - [Bug Fixes](#bug-fixes)
  - [Deprecations](#deprecations)
- [R CMD check results](#r-cmd-check-results)
- [revdepcheck results](#revdepcheck-results)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Release summary

This is a major release (v3.0.0) with the following changes:

### NBA Play-by-Play V3
- `nba_playbyplayv3()` function added -- dedicated wrapper for the NBA Stats PlayByPlayV3 endpoint.
- `nba_pbp()` and `nba_pbps()` now default to `version = "v3"` (previously `"v2"`).
- `.v3_to_v2_format()` internal helper added -- converts V3 PBP to V2-compatible format with event type mapping and player resolution.
- `.build_player_roster()` internal helper added -- retrieves player roster from boxscore for name-to-ID resolution.
- `.players_on_court_v3()` internal helper rewritten -- uses `nba_gamerotation()` stint data for robust on-court player determination.

### NBA Boxscore Summary V3
- `nba_boxscoresummaryv3()` function added -- returns 9 data frames including GameSummary, Officials, LineScore, etc.

### New NBA Stats API Endpoint Wrappers
- `nba_commonteamyears()` function added.
- `nba_dunkscoreleaders()` function added.
- `nba_gravityleaders()` function added.
- `nba_iststandings()` function added.
- `nba_scheduleleaguev2int()` function added.
- `nba_teamandplayersvsplayers()` function added.
- `nba_videoeventsasset()` function added.

### ESPN Functions
- `espn_nba_team_current_roster()` function added.
- `espn_mbb_team_current_roster()` function added.
- `nbagl_live_pbp()` function added.
- `nbagl_live_boxscore()` function added.

### Bug Fixes
- Fixed `df_list` not initialized before `tryCatch` in 147 NBA Stats API wrapper functions, preventing crashes on API errors.
- Fixed `nba_data_pbp()` `plays_df` not initialized before `tryCatch`.
- Fixed `nba_iststandings()` nested games column flattening.
- Moves `furrr` and `future` dependencies to Suggests with version requirements for users who want to use parallel features, but not required for core functionality.
- Add `lifecycle` dependency and deprecation warnings for unstable functions/endpoints to guide users to maintained alternatives.

### Deprecations
- Deprecated unstable NBA boxscore V2 wrappers and redirect users to maintained alternatives:
  `nba_boxscorefourfactorsv2()` -> `nba_boxscorefourfactorsv3()`,
  `nba_boxscoremiscv2()` -> `nba_boxscoremiscv3()`,
  `nba_boxscorescoringv2()` -> `nba_boxscorescoringv3()`,
  `nba_boxscoreusagev2()` -> `nba_boxscoreusagev3()`,
  `nba_boxscoreplayertrackv2()` -> `nba_boxscoreplayertrackv3()`,
  `nba_boxscorehustlev2()` -> `nba_hustlestatsboxscore()`.
- Deprecated unstable NBA endpoints and redirect users to maintained alternatives:
  `nba_homepageleaders()` -> `nba_leagueleaders()`,
  `nba_homepagev2()` -> `nba_leagueleaders()`,
  `nba_leaderstiles()` -> `nba_leagueleaders()`,
  `nba_teamgamestreakfinder()` -> `nba_teamgamelogs()`,
  `nba_teamhistoricalleaders()` -> `nba_franchiseleaders()`,
  `nba_videodetails()` -> `nba_videodetailsasset()`,
  `nba_winprobabilitypbp()` -> No replacement available.
- Deprecated additional unstable NBA endpoints and redirect users to maintained alternatives:
  `nba_playercareerbycollege()` -> `nba_playercareerbycollegerollup()`/`nba_leaguedashplayerbiostats()`,
  `nba_playernextngames()` -> `nba_playerprofilev2()`,
  `nba_scoreboard()` -> `nba_scoreboardv3()`,
  `nba_scoreboardv2()` -> `nba_scoreboardv3()`.


## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  - New submission (major version bump from 2.1.0 to 3.0.0)

## revdepcheck results

We checked 0 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
