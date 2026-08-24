# Layer deep-dive — ESPN Shared Helpers

Cross-league ESPN Core v2 helper functions (espn_basketball_*_helpers) shared by both the MBB and NBA ESPN scrapers for athletes, events, betting, franchises, and league metadata.

**25 files** · 0 functions/classes

## Dependencies

**Depends on:** — (leaf)

**Depended on by:** ESPN MBB (1)

## Files

### `R/espn_basketball_athlete_career_helpers.R`  _(api-client, espn, athlete-career, internal)_

Internal ESPN basketball helpers for career-level athlete endpoints (athlete seasons index, career statistics, and v2 event log) shared across the league-specific athlete wrappers.

### `R/espn_basketball_athlete_helpers.R`  _(api-handler, espn, athlete, utility)_

Internal, cross-league ESPN basketball athlete backend: ~14 helpers (info, overview, stats, gamelog, splits, eventlog) that fetch core-v2 / site-v2 athlete resources and tidy them into tibbles, shared by both espn_nba_* and espn_mbb_* wrappers.

### `R/espn_basketball_awards_helpers.R`  _(api-handler, espn, awards, utility)_

Internal ESPN basketball season-awards helper that fetches the paginated per-season award index from the core-v2 API and returns a tidy long-format tibble of award winners.

### `R/espn_basketball_calendar_helpers.R`  _(api-handler, espn, calendar, schedule)_

Internal ESPN basketball calendar helper that fetches the schedule calendar for a league and returns a tidy tibble of calendar entries/date ranges.

### `R/espn_basketball_coach_helpers.R`  _(api-handler, espn, coach, utility)_

Internal ESPN basketball coach helper that fetches a single coach detail resource (core-v2 coaches/{coach_id}) and returns a one-row tibble of coach attributes.

### `R/espn_basketball_draft_helpers.R`  _(api-handler, espn, draft, utility)_

Internal ESPN basketball draft backend: ~7 helpers covering draft pick detail, rounds index, draftable athletes, draft status, and the season-draft roll-up, each tidying core-v2 draft resources into tibbles.

### `R/espn_basketball_event_betting_helpers.R`  _(api-handler, espn, betting, odds)_

Internal ESPN basketball event-odds/betting helper that fetches per-event odds-market data from the core-v2 API and returns a tidy long-format betting tibble.

### `R/espn_basketball_event_competitor_helpers.R`  _(api-handler, espn, event, box-score)_

Internal ESPN basketball per-competitor event backend: ~8 helpers (linescores, leaders, roster, statistics, records, player box, score) that tidy a single competitor's nested event resources into tibbles.

### `R/espn_basketball_event_helpers.R`  _(api-handler, espn, event, win-probability)_

Internal ESPN basketball event-level backend: ~9 helpers (win probabilities, officials, broadcasts, situation, predictor, powerindex) that fetch and tidy nested competition resources for a single game.

### `R/espn_basketball_event_play_helpers.R`  _(api-handler, espn, play-by-play, event)_

Internal ESPN basketball single-play helper wrapping events/{eid}/competitions/{cid}/plays/{pid}, returning a one-row tibble of play-by-play detail.

### `R/espn_basketball_franchise_helpers.R`  _(api-handler, espn, franchise, team)_

Internal ESPN basketball franchise helper that fetches the core-v2 franchise resource and returns a tidy tibble of franchise metadata.

### `R/espn_basketball_futures_helpers.R`  _(api-handler, espn, futures, betting)_

Internal ESPN basketball season-futures helper that fetches the per-season futures-market index from the core-v2 API and returns a tidy long-format tibble.

### `R/espn_basketball_group_helpers.R`  _(api-handler, espn, groups, conference)_

Internal ESPN basketball season-groups (conference/division) helper that fetches the per-season groups index across season types and returns a tidy tibble of group hierarchy.

### `R/espn_basketball_injuries_helpers.R`  _(api-handler, espn, injuries, utility)_

Internal ESPN basketball injuries helper that fetches the league-wide injuries array and returns a tidy tibble of player injury statuses.

### `R/espn_basketball_league_helpers.R`  _(api-handler, espn, league, leaders)_

Internal ESPN basketball league-wide backend: ~9 helpers (statistical leaders by athlete, venues, coaches, athletes index, seasons, season info) plus league-validation and $ref-parsing utilities, each tidying league-scoped API resources.

### `R/espn_basketball_news_helpers.R`  _(api-handler, espn, news, utility)_

Internal ESPN basketball news helper that fetches the league-level news feed and returns a tidy tibble of articles/headlines.

### `R/espn_basketball_position_helpers.R`  _(api-handler, espn, positions, reference)_

Internal ESPN basketball positions helper that fetches the position dictionary resource and returns a tidy reference tibble of position codes.

### `R/espn_basketball_powerindex_helpers.R`  _(api-handler, espn, power-index, metrics)_

Internal ESPN basketball power-index helper that fetches the per-season BPI/powerindex resource and returns a tidy long-format tibble of team metrics.

### `R/espn_basketball_record_helpers.R`  _(api-handler, espn, records, team)_

Internal ESPN basketball team-record helper that fetches the per-season-type team record resource and returns a tidy long-format tibble of W/L and category records.

### `R/espn_basketball_season_meta_helpers.R`  _(api-handler, espn, season, rankings)_

Internal ESPN basketball season-metadata backend: ~6 helpers (season-types index/detail, season leaders, season rankings/ranking) that tidy per-season core-v2 metadata resources into tibbles.

### `R/espn_basketball_team_deep_helpers.R`  _(api-handler, espn, team, roster)_

Internal ESPN basketball deep-team backend: ~6 helpers (odds-records, depth chart, season roster, coach-by-season, season statistics) that tidy team-scoped per-season resources into long-format tibbles.

### `R/espn_basketball_team_helpers.R`  _(api-handler, espn, team, schedule)_

Internal ESPN basketball team backend: ~6 helpers (team detail, roster, schedule, leaders, season profile) plus league validation, tidying site-v2 team resources into tibbles shared by NBA and MBB wrappers.

### `R/espn_basketball_tournaments_helpers.R`  _(api-handler, espn, tournaments, utility)_

Internal ESPN basketball tournaments helper that fetches the league tournament index and returns a tidy tibble of tournament/bracket metadata.

### `R/espn_basketball_week_helpers.R`  _(api-handler, espn, weeks, schedule)_

Internal ESPN basketball season-weeks helper that fetches the per-season weeks index across season types and returns a tidy tibble of week boundaries.

### `R/espn_basketball.R`  _(documentation, espn, barrel, overview)_

Roxygen documentation landing page (@name espn_basketball) giving the cross-league ESPN Basketball endpoint overview that ties together the espn_nba_* and espn_mbb_* wrapper surfaces; contains no executable code.

