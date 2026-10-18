# TPBL fixtures (`api.tpbl.basketball/api`, the Laravel JSON API behind tpbl.basketball)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/tpbl/` (the refs captures from sdv-internal-refs `tpbl/`
at refs `239f4bc`, captured live 2026-10-12 with arrays cut to 3 rows and players' `birthday` replaced by
`<redacted>`; and the `full/` bodies, fetched live 2026-10-13 through sdv-py's runtime). Only the files the tests read,
under shorter names (R CMD check warns on paths over 100 characters). The API is keyless; no credential is stored.

| hoopR file | sdv-py `tests/fixtures/tpbl/` file |
|:---|:---|
| `seasons.json` | `full/seasons.json` |
| `divisions_3.json` | `captures/events__event_id__divisions@3.json` (season id 3 = 2026-27 = sdv 2027) |
| `teams_2.json` | `captures/events__event_id__teams@2.json` (2025-26 = sdv 2026) |
| `games_3.json` | `captures/seasons__season_id__games@3.json` |
| `games_3_team3.json` | TRIMMED `full/season_games_2027.json`: the first 3 games that involve team 3, minified |
| `standings_2.json` | `captures/divisions__division_id__games__standings.json` (division 2) |
| `game_6.json` | `full/game_6.json` |
| `box_6.json` | TRIMMED `full/game_stats_6.json`, minified (see below) |
| `roster_2_4.json` | `captures/divisions__division_id__teams__team_id__players.json` |
| `team_shots_2_4.json` | `captures/divisions__division_id__teams__team_id__shooting-spots.json` |
| `team_shots_2_4_r1.json` | `captures/divisions__division_id__teams__team_id__shooting-spots@2_4_r1.json` |
| `player_shots_2_75.json` | `captures/divisions__division_id__players__player_id__shooting-spots.json` |
| `player_games_75_2.json` | `captures/players__player_id__games__stats.json` (player 75, division 2) |

`box_6.json` keeps every whole-game player line (`players.total`, 17 + 18; the runtime sums their points against the
final score, so none can be dropped) and every team line (`teams.total`, `teams.rounds`); the per-quarter player
lines (`players.rounds`) are cut to quarters 1 and 4 and to the first 4 sheet lines of each side (the full body is
456 KB). The refs box-score captures cannot be used: their 3-key cut breaks the score and quarter checks.

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.tpbl.<wrapper>`) called with the arguments in `TPBL_CASES` of `test-tpbl.R`, its
transport (a `requests` adapter on `tpbl_runtime.SESSION`) faked to answer these files, so the season mapping, the
game checks and the scope checks run too. Nulls are written as `\N`; `tipoff` is sdv-py's naive Taiwan-local
timestamp as `%Y-%m-%d %H:%M:%S`. `dtypes.json` is each frame's polars schema and `requests.json` the routes and query
sdv-py sent, in order. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py
`e3d232ebc9`. A `__team3` / `__r1` suffix is the same wrapper with `team_id = 3` / `rounds = 1`.
