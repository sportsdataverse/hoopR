# CEBL fixtures (`api.data.cebl.ca`, the CEBL Stats Hub backend)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/cebl/captures/` (refs captures from sdv-internal-refs
`cebl/` at refs `cb7a95a`, captured live 2026-10-12, arrays cut to 3 rows). Copied byte for byte under shorter names
(R CMD check warns on paths over 100 characters); only the files the tests read. No header key is stored here.

| hoopR file | sdv-py `tests/fixtures/cebl/captures/` file |
|:---|:---|
| `seasons.json` | `seasons.json` |
| `teams.json` | `teams.json` |
| `standings_2025.json` | `teams__season__2025.json` |
| `roster_14_2025.json` | `teams__team_id__roster__season__14_2025.json` |
| `team_stats_tot_2025_reg.json` | `teams__statistics__aggregated__TOTALS_2025_REGULAR.json` |
| `games_2025.json` | `games__season__2025.json` |
| `games_2025_team20.json` | `games__season__2025_team20.json` |
| `player_stats_pg_2025.json` | `players__statistics__aggregated__PER_GAME_2025.json` |
| `leaders_pg_2025.json` | `players__statistics__leaders__PER_GAME_2025.json` |
| `player_seasons_570965_pg.json` | `players__player_id__statistics__570965_PER_GAME.json` |
| `player_seasons_570965_career.json` | `players__player_id__statistics__570965_TOTALS_career.json` |
| `player_570965.json` | `players__player_id__570965.json` |
| `player_530.json` | `players__player_id__530.json` |
| `gamelog_570965_2025.json` | `players__player_id__gamelog__570965_2025.json` |
| `news_synthetic.json` | none: the row of sdv-py `test_news_row_shape_follows_the_upstream_schema` (the news route has answered `[]` on every probe, so no real article exists) |

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.cebl.<wrapper>`) called with the arguments in `CEBL_CASES` of `test-cebl.R`, its
transport (`cebl_runtime._call`) faked to answer the fixture, so the argument checks, the scope checks and the
request stamp run too. Timestamps are written as `%Y-%m-%dT%H:%M:%SZ` (UTC). `dtypes.json` is each frame's polars
schema and `requests.json` the URL and query sdv-py sent. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a
detached worktree of sdv-py `e3d232ebc9`. A `__team20` / `__career` suffix is the same wrapper with `team_id = 20` /
`career_only = TRUE`.
