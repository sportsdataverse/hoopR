# Layer deep-dive — College Basketball Data API

College Basketball Data API wrappers (cbbd_*) for games, lines, rankings, stats, and team/player data.

**14 files** · 0 functions/classes

## Dependencies

**Depends on:** — (leaf)

**Depended on by:** — (none)

## Files

### `R/cbbd_api_key.R`  _(api-client, authentication, config, collegebasketballdata)_

Manages the CollegeBasketballData API key (cbbd_key/has_cbbd_key/check_cbbd_key) and provides the shared authenticated .cbbd_get request helper used by every cbbd_* endpoint wrapper.

### `R/cbbd_conferences.R`  _(api-client, collegebasketballdata, conferences, mbb)_

Wraps the CollegeBasketballData conferences endpoints (cbbd_conferences and cbbd_conferences_history) returning conference metadata as tidy frames.

### `R/cbbd_draft.R`  _(api-client, collegebasketballdata, draft, mbb)_

Wraps the CollegeBasketballData NBA-draft endpoints (cbbd_draft_teams, cbbd_draft_positions, cbbd_draft_picks) for draft-pick and prospect data.

### `R/cbbd_games.R`  _(api-client, collegebasketballdata, games, box-score)_

Wraps the CollegeBasketballData games surface (cbbd_games, cbbd_games_media, cbbd_games_teams, cbbd_games_players, cbbd_scoreboard) returning schedule, box-score, and scoreboard frames.

### `R/cbbd_lines.R`  _(api-client, collegebasketballdata, betting-lines, odds)_

Wraps the CollegeBasketballData betting-lines endpoints (cbbd_lines and cbbd_lines_providers) returning game odds and provider metadata.

### `R/cbbd_lineups.R`  _(api-client, collegebasketballdata, lineups, advanced-stats)_

Wraps the CollegeBasketballData lineup-statistics endpoints (cbbd_lineups_team and cbbd_lineups_game) returning five-man lineup metrics.

### `R/cbbd_plays.R`  _(api-client, collegebasketballdata, play-by-play, pbp)_

Wraps the CollegeBasketballData play-by-play surface (by game, player, team, date, and tournament, plus cbbd_play_types) returning detailed PBP event frames.

### `R/cbbd_rankings.R`  _(api-client, collegebasketballdata, rankings, polls)_

Wraps the CollegeBasketballData poll-rankings endpoint (cbbd_rankings) returning AP and Coaches poll standings.

### `R/cbbd_ratings.R`  _(api-client, collegebasketballdata, ratings, advanced-stats)_

Wraps the CollegeBasketballData team-ratings endpoints (cbbd_ratings_srs, cbbd_ratings_adjusted, cbbd_ratings_elo) returning SRS, adjusted-efficiency, and Elo ratings.

### `R/cbbd_recruiting.R`  _(api-client, collegebasketballdata, recruiting, transfer-portal)_

Wraps the CollegeBasketballData recruiting endpoints (cbbd_recruiting_players, cbbd_recruiting_teams, cbbd_recruiting_portal) returning prospect rankings and transfer-portal data.

### `R/cbbd_stats.R`  _(api-client, collegebasketballdata, statistics, shooting)_

Wraps the CollegeBasketballData statistics surface (team-season, team-leaderboard, team/player shooting, player-season) returning aggregate and shooting-split stat frames.

### `R/cbbd_substitutions.R`  _(api-client, collegebasketballdata, substitutions, lineups)_

Wraps the CollegeBasketballData substitution endpoints (by game, player, and team) returning on/off substitution event data.

### `R/cbbd_teams.R`  _(api-client, collegebasketballdata, teams, roster)_

Wraps the CollegeBasketballData teams endpoints (cbbd_teams and cbbd_teams_roster) returning team metadata and season rosters.

### `R/cbbd_venues.R`  _(api-client, collegebasketballdata, venues, mbb)_

Wraps the CollegeBasketballData venues endpoint (cbbd_venues) returning arena/venue metadata as a tidy frame.

