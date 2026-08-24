# Layer deep-dive — ESPN NBA

ESPN NBA scrapers (espn_nba_*) for play-by-play, schedules, rosters, box scores, and team/standings data.

**25 files** · 0 functions/classes

## Dependencies

**Depends on:** — (leaf)

**Depended on by:** ESPN MBB (2)

## Files

### `R/espn_nba_athlete_career.R`  _(api-handler, espn, nba, athlete)_

ESPN NBA athlete career wrappers (espn_nba_player_seasons, espn_nba_player_career_stats, and more) returning a player's season list and career statistical history.

### `R/espn_nba_athlete_contracts.R`  _(api-handler, espn, nba, contracts)_

ESPN NBA athlete contract wrappers (espn_nba_player_contracts, espn_nba_player_contract) returning a player's contract list and single-contract detail.

### `R/espn_nba_athletes.R`  _(api-handler, espn, nba, athlete)_

ESPN NBA athlete endpoint wrappers (espn_nba_player_info, _overview, _stats_v3, _gamelog, etc.) returning per-player bio, overview, V3 stats and game-log frames; NBA mirror of espn_mbb_athletes.R.

### `R/espn_nba_awards.R`  _(api-handler, espn, nba, awards)_

ESPN NBA awards wrappers (espn_nba_season_awards, espn_nba_award) that fetch season award lists and single-award detail; NBA mirror of espn_mbb_awards.R.

### `R/espn_nba_calendar.R`  _(espn, nba, api-handler, calendar)_

Wraps the ESPN NBA calendar endpoint, returning the league's season calendar (date ranges and season types) as a tidy tibble.

### `R/espn_nba_coach.R`  _(espn, nba, api-handler, coach)_

Fetches single-coach detail and per-coach win/loss records from ESPN's NBA Core v2 coach endpoints.

### `R/espn_nba_data.R`  _(espn, nba, play-by-play, box-score)_

Core ESPN NBA game-data module providing play-by-play, team/player box scores, rosters, schedules, scoreboard, standings, betting, and team/player stats from ESPN Site v2 game summaries.

### `R/espn_nba_event_detail.R`  _(espn, nba, api-handler, event-detail)_

Per-event (game) detail scrapers covering ESPN NBA odds, win probabilities, officials, broadcasts, predictors, prop bets, linescores, leaders, rosters, and team statistics.

### `R/espn_nba_franchise.R`  _(espn, nba, api-handler, franchise)_

Retrieves the ESPN NBA franchises index and single-franchise detail records (franchise identity, venue, colors) from Core v2 endpoints.

### `R/espn_nba_futures.R`  _(espn, nba, api-handler, futures)_

Returns ESPN NBA season futures betting markets in long format from the Core v2 futures endpoint.

### `R/espn_nba_groups_v2.R`  _(espn, nba, api-handler, groups)_

Season-scoped group hierarchy scrapers for ESPN NBA: groups index, single group, child groups, and group team membership.

### `R/espn_nba_groups.R`  _(espn, nba, api-handler, conferences)_

Fetches the ESPN NBA conferences listing (Eastern/Western and their groupings) as a tidy tibble.

### `R/espn_nba_injuries.R`  _(espn, nba, api-handler, injuries)_

Provides league-wide and per-team ESPN NBA injury reports resolved from Core v2 injury reference endpoints.

### `R/espn_nba_league.R`  _(espn, nba, api-handler, league)_

League-level ESPN NBA reference scrapers: league leaders, venues, coaches index, athletes index, seasons list, and per-season info.

### `R/espn_nba_news.R`  _(espn, nba, api-handler, news)_

Retrieves league-wide and team-specific ESPN NBA news articles from the Site v2 news endpoint.

### `R/espn_nba_positions.R`  _(espn, nba, api-handler, positions)_

Returns the ESPN NBA positions index and single-position detail from Core v2 position reference endpoints.

### `R/espn_nba_powerindex.R`  _(espn, nba, api-handler, power-index)_

Fetches ESPN NBA season Basketball Power Index (BPI) ratings in long format from the Core v2 powerindex endpoint.

### `R/espn_nba_season_meta.R`  _(espn, nba, api-handler, season-meta)_

Season metadata scrapers for ESPN NBA: season types index/detail, season leaders, and season rankings index/detail.

### `R/espn_nba_team_deep.R`  _(espn, nba, api-handler, team)_

Deep per-team ESPN NBA scrapers covering odds records, depth charts, season rosters, coach-by-season, and detailed records.

### `R/espn_nba_team_detail.R`  _(espn, nba, api-handler, team)_

Per-team ESPN NBA detail scrapers: team identity, roster, schedule, leaders, season profile, and season statistics.

### `R/espn_nba_team_record.R`  _(espn, nba, api-handler, team)_

Returns an ESPN NBA team's win/loss record broken out per season type from the Core v2 record endpoint.

### `R/espn_nba_tournaments.R`  _(espn, nba, api-handler, tournaments)_

Scrapes ESPN NBA tournament metadata: tournaments index, single tournament, and per-tournament season listings (e.g., In-Season Tournament).

### `R/espn_nba_transactions.R`  _(espn, nba, api-handler, transactions)_

Provides ESPN NBA draft picks, free-agent listings, and roster transaction feeds parsed from Core v2 transaction endpoints.

### `R/espn_nba_weeks.R`  _(espn, nba, api-handler, weeks)_

Season-week scrapers for ESPN NBA: weeks index, single week, and per-week rankings index/detail.

### `R/espn_nba_wp.R`  _(espn, nba, win-probability, play-by-play)_

Builds NBA win-probability chart data per play from ESPN's game-summary win-probability feed.

