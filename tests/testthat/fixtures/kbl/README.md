# KBL fixtures (`api.kbl.or.kr`, the API behind www.kbl.or.kr)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/kbl/` (refs captures from sdv-internal-refs `kbl/` at
refs `cb7a95a`, captured live 2026-10-12 with arrays cut to 3 rows; `full/` bodies fetched live 2026-10-13 with the
headers `Channel: WEB`, `TeamCode: XX`). Copied byte for byte under shorter names (R CMD check warns on paths over
100 characters); only the files the tests read. The game routes use the untruncated `full/` bodies of game
`S47G01N49`, because the runtime's scope checks (every period, the game-end row, box points that add up to the
header's) refuse a truncated body.

| hoopR file | sdv-py `tests/fixtures/kbl/` file |
|:---|:---|
| `seasons.json` | `captures/season__list.json` |
| `teams.json` | `captures/common__teamList.json` |
| `schedule_20251101.json` | `captures/match__list__20251101.json` |
| `game_S47G01N49.json` | `full/match__gmkey__S47G01N49.json` |
| `text_cast_S47G01N49.json` | `full/match__gmkey__text-cast__S47G01N49.json` |
| `player_stat_S47G01N49.json` | `full/match__gmkey__player-stat__S47G01N49.json` |
| `team_record_S47G01N49.json` | `full/match__gmkey__team-record__S47G01N49.json` |
| `match_chart_S47G01N49.json` | `full/match__gmkey__match-chart__S47G01N49.json` |
| `player_totals_S45G01.json` | `captures/leagues__glkey__stats__players__S45G01.json` |
| `rank_S45G01.json` | `captures/league__rank__glkey__S45G01.json` |
| `team_tracks_S45G01.json` | `full/league__rank__glkey__team-tracks__S45G01.json` |
| `playoff_new_S45G01.json` | `full/league__playoff__new__glkey__S45G01.json` |
| `playoff_S43G01.json` | `captures/league__playoff__glkey__S43G01.json` |
| `round_mvp_45.json` | `captures/league__round-mvp__seasonCode__45.json` |
| `rank_team.json` | `captures/league__rank__team.json` |
| `season_leader.json` | `captures/league__season-leader.json` |
| `players.json` | `captures/players.json` |

`parity/` is sdv-py's own output on these files: each `<case>.csv` (gzipped when over 60 kB) is the frame of the
sdv-py wrapper (`sportsdataverse.basketball.kbl.<wrapper>`) called with the arguments in `KBL_CASES` of
`test-kbl.R`, its transport (`requests.Session.request`) faked to answer the fixture of each path, so the runtime's
argument checks, season mapping, final-game proof and scope checks run too. Polars `write_csv`: nulls `\N`, dates
ISO, booleans `true` / `false`. `dtypes.json` is each frame's polars schema and `requests.json` every path and query
sdv-py sent, in order. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py
`e3d232ebc9`. A `__2024` suffix is the same wrapper with `season = 2024` (the old-format bracket, seasonCode 43).
