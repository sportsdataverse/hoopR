# Layer deep-dive — NBA Stats API

NBA Stats API endpoint wrappers (nba_*) plus their shared request/parse utilities covering box scores, tracking, leaders, and synergy data.

**28 files** · 0 functions/classes

## Dependencies

**Depends on:** Utilities & Crosswalks (2)

**Depended on by:** Basketball-Reference, RealGM & Aux Sources (2), Data Loaders (1), Vignettes & Docs (1)

## Files

### `R/nba_crosswalk.R`  _(crosswalk, nba, data-reconciliation, fuzzy-match)_

Builds NBA cross-source crosswalks (team / schedule / player) reconciling ESPN, NBA Stats, and Fox identities via the shared .bb_* normalization and fuzzy-matching engine.

### `R/nba_data_pbp.R`  _(nba, play-by-play, data-loader, api-handler)_

Provides nba_data_pbp(), a loader for tidy NBA play-by-play data scraped from the data.nba.com feed for a given game id.

### `R/nba_datasets.R`  _(nba, data-transformation, serialization, utility)_

Tidy reshaping helpers that flatten raw NBA Stats payloads into analysis-ready frames — franchise history, player box scores with team context, and nested player profiles.

### `R/nba_dictionaries.R`  _(nba, reference-data, utility, data-model)_

Reference-data helpers exposing NBA player/team dictionaries and URL builders for player headshots and team logos.

### `R/nba_metrics.R`  _(nba, analytics, metrics, utility)_

Vectorized basketball analytics primitives — true shooting, eFG%, free-throw rate, game score, assist/turnover ratios, possessions, pace, offensive/defensive/net ratings, usage, and the four factors.

### `R/nba_reduce.R`  _(nba, data-transformation, utility, reduce)_

Set-combination utilities for multi-table NBA Stats results — bind, join, and nest lists of named data frames into a single structure.

### `R/nba_scaling.R`  _(nba, analytics, scaling, utility)_

Box-score scaling helpers that rescale counting stats to per-N-minutes or per-N-possessions and append advanced metrics, with a private column-finder helper.

### `R/nba_stats_boxscore_v3.R`  _(nba, nba-stats-api, boxscore, api-handler)_

Wrappers for the NBA Stats v3 boxscore endpoints — traditional, advanced, misc, scoring, usage, four-factors, player-track, matchups, hustle, defensive, game rotation, and summary. The largest boxscore module in the package.

### `R/nba_stats_boxscore.R`  _(nba, nba-stats-api, boxscore, api-handler)_

Wrappers for the NBA Stats v2/legacy boxscore endpoints — traditional, advanced, defensive, four-factors, misc, scoring, usage, summary, matchups, player-track, hustle, and similarity scores.

### `R/nba_stats_cume.R`  _(nba, nba-stats-api, cumulative-stats, api-handler)_

Wrappers for the NBA Stats cumulative-stats endpoints covering player and team cumulative totals and per-game cumulative breakdowns.

### `R/nba_stats_draft.R`  _(nba, nba-stats-api, draft, api-handler)_

Wrappers for the NBA Stats draft endpoints — draft board, draft history, and the full draft-combine suite (measurements, drills, shooting, anthro).

### `R/nba_stats_franchise.R`  _(nba, nba-stats-api, franchise, api-handler)_

Wrappers for the NBA Stats franchise endpoints — franchise leaders (with and without rank), franchise players, and franchise history.

### `R/nba_stats_hustle.R`  _(nba, nba-stats-api, hustle-stats, api-handler)_

Wrappers for the NBA Stats league hustle-stats endpoints covering player and team hustle stats plus their leaderboards.

### `R/nba_stats_leaders.R`  _(nba, nba-stats-api, leaderboard, api-handler)_

Wrappers for the NBA Stats leaders/leaderboard endpoints — all-time grids, assist leaders/tracker, homepage leaders, leader tiles, defense hub, league leaders, and dunk/gravity score leaders.

### `R/nba_stats_league_dash.R`  _(nba, nba-stats-api, league-dashboard, api-handler)_

Wrappers for the NBA Stats leaguedash endpoints — player/team stats, clutch, bio, shot dashboards (opponent, point, shot locations), and tracking defend/stats. One of the largest endpoint modules.

### `R/nba_stats_league.R`  _(nba, nba-stats-api, standings, schedule)_

Wrappers for league-wide NBA Stats endpoints — game log, standings (legacy + v3), playoff picture, game finder, and in-season tournament standings.

### `R/nba_stats_lineups.R`  _(nba-stats-api, api-handler, lineups, matchups)_

Wraps the NBA Stats API lineup and matchup endpoints (leaguedashlineups, leaguelineupviz, leagueplayerondetails, leagueseasonmatchups, matchupsrollup, fantasywidget), returning tidy data frames of five-man lineup and head-to-head matchup statistics.

### `R/nba_stats_pbp.R`  _(nba-stats-api, play-by-play, api-handler, live-data)_

Core NBA play-by-play retrieval module exposing nba_playbyplayv3, nba_pbp/nba_pbps (multi-game), and the live cdn.nba.com feeds nba_live_pbp and nba_live_boxscore; assembles enriched per-event play-by-play frames.

### `R/nba_stats_player_dash.R`  _(nba-stats-api, api-handler, player-stats, dashboard)_

Wraps the NBA Stats player-dashboard family (by clutch, game splits, general splits, last-N games, opponent, shooting splits, team performance, year-over-year) plus the player-tracking dashboards (pt pass/reb/shots/shotdefend), returning split player statistics.

### `R/nba_stats_player.R`  _(nba-stats-api, api-handler, player-stats, data-model)_

Largest player-data module: wraps NBA Stats player endpoints including playerindex, career stats, game logs, awards, fantasy profiles, estimated metrics, and the cdn.nba.com player headshot helper; several legacy endpoints are lifecycle-deprecated.

### `R/nba_stats_roster.R`  _(nba-stats-api, api-handler, roster, metadata)_

Wraps the NBA Stats common-info endpoints (commonallplayers, commonplayerinfo, commonplayoffseries, commonteamroster, commonteamyears), providing league player directories, individual bios, playoff series, and team roster tables.

### `R/nba_stats_scoreboard.R`  _(nba-stats-api, api-handler, schedule, scoreboard)_

Provides NBA schedule and scoreboard access (nba_schedule, scoreboard/scoreboardv2/scoreboardv3, todays_scoreboard, winprobabilitypbp, scheduleleaguev2int) drawing on both the cdn.nba.com schedule feed and the stats.nba.com scoreboard endpoints.

### `R/nba_stats_shotchart.R`  _(nba-stats-api, api-handler, shot-chart, spatial-data)_

Wraps the NBA Stats shot-chart endpoints (shotchartdetail, shotchartleaguewide, shotchartlineupdetail), returning per-shot location and make/miss data for players, the league, and lineups.

### `R/nba_stats_team_dash.R`  _(nba-stats-api, api-handler, team-stats, dashboard)_

Team-side counterpart to the player dashboards: wraps the NBA Stats team-dashboard family (clutch, game/general/last-N/opponent/shooting splits, team performance, year-over-year) plus team lineups and player-tracking dashboards.

### `R/nba_stats_team.R`  _(nba-stats-api, api-handler, team-stats, data-model)_

Largest team-data module: wraps NBA Stats team endpoints including teams, teamdetails, estimated metrics, game logs, historical leaders, info-common, player on/off details, year-by-year stats, and team-vs-player splits.

### `R/nba_stats_video.R`  _(nba-stats-api, api-handler, video, media-metadata)_

Wraps the NBA Stats video endpoints (videodetails/videodetailsasset, videoevents/videoeventsasset, videostatus), returning play video metadata and asset URLs tied to game events.

### `R/nba_stats.R`  _(nba-stats-api, documentation, overview, entry-point)_

Overview/index module for the NBA Stats API surface, documenting the stats.nba.com endpoint families and serving as the conceptual entry point for the nba_stats_* wrapper modules.

### `R/utils_nba_stats.R`  _(utility, nba, http, api-client)_

Internal HTTP and result-parsing layer for the NBA Stats / G-League APIs: builds endpoint requests (with proxy support), maps stats.nba.com resultSets into tibbles, and provides id/time padding plus schedule-rejoin helpers.

