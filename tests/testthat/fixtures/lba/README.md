# Lega Basket Serie A fixtures (`www.legabasket.it/api`)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/legabasket/` (the refs captures from sdv-internal-refs
`legabasket/` at refs `35e209b`, captured live 2026-10-12, arrays cut to 3 rows; `full/` one untruncated body per
route, fetched 2026-10-12). Copied byte for byte under shorter names; only the files the tests read. Season parameters
are START years on the wire (`s=2026` = 2026-27); the public argument is the END year (`season = 2027`).

| hoopR file | sdv-py `tests/fixtures/legabasket/` file |
|:---|:---|
| `championships_2027.json` | `full/championships__s2026.json` |
| `calendar_602_1.json` | `captures/2026/championships__get-championships-calendar-by-id.json` |
| `game_25602.json` | `captures/2026/championships__get-championships-matches-by-id.json` |
| `scores_25602.json` | `captures/2026/championships__get-championships-matches-scores-by-id.json` |
| `scores_14415.json` | `captures/1995/championships__get-championships-matches-scores-by-id.json` |
| `pbp_25602.json` | `captures/2026/championships__get-championships-matches-play-by-play.json` |
| `pbp_22288.json` | `captures/2017/championships__get-championships-matches-play-by-play.json` |
| `shots_25602.json` | `captures/2026/matches__get-championship-matches-shots-by-id.json` |
| `ranking_602_3.json` | `captures/2026/championships__get-championship-ranking.json` |
| `teams_2027.json` | `full/teams__2026.json` |
| `roster_1764.json` | `captures/2026/teams__get-team-roster.json` |
| `team_players_stats_1764.json` | `captures/2026/teams__get-team-players-stats.json` |
| `players_2027_p2.json` | `captures/2026/players__get-players.json` |
| `player_969.json` | `captures/2026/players__get-player-by-id.json` |
| `player_stats_969.json` | `captures/2026/players__get-player-stats.json` |
| `game_log_969.json` | `full/player_matches__969.json` |
| `players_leaderboard_points.json` | `captures/2026/statistics__get-players-statistics.json` |
| `teams_leaderboard_off.json` | `captures/2026/statistics__get-teams-statistics-by-type.json` |

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.lba.<wrapper>`) called with the arguments in `parity/manifest.json`, its transport
(`basketball_runtime._get`) faked to answer the fixture, so the season mapping, the scope checks and the `_request`
stamp of `lba_runtime._get` run too. Polars `write_csv` with `null_value = "<NA>"` (so a null is distinct from an
empty string), booleans `true` / `false`. `manifest.json` also holds each frame's row count, polars schema, and the
URL and wire query sdv-py sent. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of
sdv-py `e3d232ebc9`. A `__1995` / `__2017` suffix is the same wrapper on that season's capture.
