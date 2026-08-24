# Layer deep-dive — ESPN MBB

ESPN men’s college basketball scrapers (espn_mbb_*) for play-by-play, schedules, rosters, box scores, and team/standings data.

**22 files** · 0 functions/classes

## Dependencies

**Depends on:** ESPN NBA (2), ESPN Shared Helpers (1)

**Depended on by:** — (none)

## Files

### `R/espn_mbb_athlete_career.R`  _(api-handler, espn, mbb, athlete)_

Public MBB athlete-career loaders: espn_mbb_player_seasons, espn_mbb_player_career_stats, and espn_mbb_player_eventlog_v2 — exported thin wrappers that surface ESPN men's college basketball athlete career data as tibbles.

### `R/espn_mbb_athletes.R`  _(api-handler, espn, mbb, athlete)_

ESPN men's college basketball athlete endpoint wrappers (espn_mbb_player_info, _overview, _stats_v3, _gamelog, etc.), returning per-player bio, overview, V3 stats and game-log frames from ESPN's web/core athlete APIs.

### `R/espn_mbb_awards.R`  _(api-handler, espn, mbb, awards)_

ESPN MBB awards wrappers (espn_mbb_season_awards, espn_mbb_award) that fetch season award lists and single-award detail from ESPN's core awards endpoints.

### `R/espn_mbb_calendar.R`  _(api-handler, espn, mbb, calendar)_

Single-function wrapper (espn_mbb_calendar) returning the ESPN MBB season calendar of date ranges and season types for a given season.

### `R/espn_mbb_coach.R`  _(api-handler, espn, mbb, coach)_

ESPN MBB coach wrappers (espn_mbb_coach, espn_mbb_coach_record) that fetch a coach's profile and win/loss record from ESPN's core coach endpoints.

### `R/espn_mbb_data.R`  _(api-handler, espn, mbb, play-by-play)_

Core ESPN men's college basketball data module: play-by-play, team/player box scores, game rosters, scoreboard, schedule, teams, conferences, rankings, standings, betting and team/player stats, plus the helper parsers that flatten ESPN summary payloads.

### `R/espn_mbb_event_detail.R`  _(api-handler, espn, mbb, event)_

ESPN MBB per-event (game) detail wrappers (odds, win probabilities, officials, broadcasts, and other event sub-resources) drawn from ESPN's core event endpoints.

### `R/espn_mbb_franchise.R`  _(api-handler, espn, mbb, franchise)_

ESPN MBB franchise wrappers (espn_mbb_franchises, espn_mbb_franchise) listing all program franchises and fetching a single franchise's detail.

### `R/espn_mbb_futures.R`  _(api-handler, espn, mbb, futures)_

Single-function wrapper (espn_mbb_futures) returning ESPN MBB season futures betting markets for a given season.

### `R/espn_mbb_groups_v2.R`  _(api-handler, espn, mbb, groups)_

ESPN MBB v2 group/conference wrappers (espn_mbb_season_groups, espn_mbb_season_group, and children) resolving conference and grouping hierarchies for a season.

### `R/espn_mbb_injuries.R`  _(api-handler, espn, mbb, injuries)_

ESPN MBB injury wrappers (espn_mbb_injuries, espn_mbb_team_injuries) returning league-wide and per-team injury reports.

### `R/espn_mbb_league.R`  _(api-handler, espn, mbb, league)_

ESPN MBB league-level index wrappers (espn_mbb_leaders, espn_mbb_venues, espn_mbb_coaches, espn_mbb_athletes_index, and more) exposing season-wide leaders, venues and entity directories.

### `R/espn_mbb_news.R`  _(api-handler, espn, mbb, news)_

ESPN MBB news wrappers (espn_mbb_news, espn_mbb_team_news) returning league and team headline feeds.

### `R/espn_mbb_positions.R`  _(api-handler, espn, mbb, positions)_

ESPN MBB position wrappers (espn_mbb_positions, espn_mbb_position) listing roster positions and fetching a single position's detail.

### `R/espn_mbb_powerindex.R`  _(api-handler, espn, mbb, powerindex)_

Single-function wrapper (espn_mbb_powerindex) returning ESPN's MBB power index team ratings for a season.

### `R/espn_mbb_season_meta.R`  _(api-handler, espn, mbb, season)_

ESPN MBB season metadata wrappers (espn_mbb_season_types, espn_mbb_season_type, and children) describing a season's structure, types and associated sub-resources.

### `R/espn_mbb_team_deep.R`  _(api-handler, espn, mbb, team)_

ESPN MBB deep team-resource wrappers (espn_mbb_team_odds_records, espn_mbb_team_season_roster, and more) exposing season-scoped team odds records and rosters from core team endpoints.

### `R/espn_mbb_team_detail.R`  _(api-handler, espn, mbb, team)_

ESPN MBB team detail wrappers (espn_mbb_team, espn_mbb_team_roster, espn_mbb_team_schedule, espn_mbb_team_leaders, etc.) returning a single team's profile, roster, schedule and statistical leaders.

### `R/espn_mbb_team_record.R`  _(api-handler, espn, mbb, team)_

Single-function wrapper (espn_mbb_team_record) returning a team's season win/loss record splits from ESPN's core team record endpoint.

### `R/espn_mbb_tournaments.R`  _(api-handler, espn, mbb, tournament)_

ESPN MBB tournament wrappers (espn_mbb_tournaments, espn_mbb_tournament, and children) listing postseason tournaments and resolving a single tournament's bracket/detail.

### `R/espn_mbb_weeks.R`  _(api-handler, espn, mbb, weeks)_

ESPN MBB scheduling-week wrappers (espn_mbb_season_weeks, espn_mbb_season_week, and children) enumerating a season's weeks and per-week sub-resources.

### `R/espn_mbb_wp.R`  _(api-handler, espn, mbb, win-probability)_

Single-function wrapper (espn_mbb_wp) that extracts ESPN's per-game win-probability time series for a men's college basketball game.

