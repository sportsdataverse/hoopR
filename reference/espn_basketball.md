# **ESPN Basketball Endpoint Overview (NBA + MBB)**

Wrappers around ESPN's basketball endpoints. Two parallel families share
a common set of internal helpers in `R/espn_basketball_*.R`:

- `espn_nba_*()` — ESPN NBA wrappers

- `espn_mbb_*()` — ESPN men's college basketball wrappers

Each public wrapper is a thin shim over an internal helper that takes a
`league` argument (`"nba"` or `"mens-college-basketball"`); the helper
does the actual HTTP call + parsing.

## Details

### **Play-by-play, scoreboard, schedule**

|  |  |
|----|----|
| NBA function | MBB function |
| [`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md) | [`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md) |
| [`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md) | [`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md) |
| [`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md) | [`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md) |
| [`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md) | [`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md) |
| [`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md) | [`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md) |
| [`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md) | [`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md) |
| [`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md) | [`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md) |

### **Reference data**

|  |  |
|----|----|
| NBA function | MBB function |
| [`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md) | [`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md) |
| [`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md) | [`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md) |
| [`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md) | [`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md) |
| [`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md) | [`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md) |
| [`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md) | [`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md) |
|  | [`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md) |
|  | [`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md) |

### **HTTP layer**

ESPN wrappers call
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
directly without `...`, so per-call proxy overrides aren't supported.
Use `options(hoopR.proxy = ...)` or the `http_proxy` / `https_proxy` env
vars for proxy routing.
