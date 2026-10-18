# EASL fixtures (`easl.joshricha.com/api/v1`, an UNOFFICIAL third-party sync server)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/easl/` (the refs captures from sdv-internal-refs `easl/`
at refs `0fb6793`, captured 2026-10-12 with arrays cut to 3 rows; and the UNTRUNCATED `full/` bodies, fetched live on
2026-10-13). Copied byte for byte under shorter names (R CMD check warns on paths over 100 characters); only the files
the tests read. The server is an individual's Express mirror of Sportradar DataCore (organisation `b1e0z`), keyless;
no personal contact data occurs in these bodies.

| hoopR file | sdv-py `tests/fixtures/easl/` file |
|:---|:---|
| `health.json` | `captures/health.json` |
| `seasons.json` | `full/metadata__seasons.json` |
| `matches_2026.json` | `captures/matches@2025.json` (2025-26 = sdv 2026) |
| `matches_active.json` | `captures/matches.json` (the active season, 2026-27) |
| `game.json` | `captures/matches__fixtureId@2025.json` (the 2025-26 final, `10af8fd4-106e-11f1-960b-5798087c7aa3`) |
| `game_2024.json` | `captures/matches__fixtureId@2023.json` (the 2023-24 championship game) |
| `boxscore.json` | `full/matches__fixtureId__boxscore@2025.json` |
| `playbyplay.json` | `full/matches__fixtureId__playbyplay@2025.json` |
| `teamstats.json` | `full/matches__fixtureId__teamstats@2025.json` |
| `teamstats_period.json` | `full/matches__fixtureId__teamstats__by__period@2025.json` |
| `standings_2026.json` | `captures/standings@2025.json` |
| `leaders_2026.json` | `captures/leaders@2025.json` |
| `teams.json` | `captures/teams.json` |
| `team.json` | `captures/teams__teamId.json` (Utsunomiya Brex) |
| `team_matches_2026.json` | `captures/teams__teamId__matches@2025.json` |
| `team_stats_2026.json` | `captures/teams__teamId__stats@2025.json` |
| `team_leaders_2026.json` | `captures/teams__teamId__leaders@2025.json` |
| `players.json` | `captures/players.json` |
| `roster_2026.json` | `captures/players@roster.json` |
| `player.json` | `captures/players__playerId.json` |
| `player_stats.json` | `captures/players__playerId__stats.json` |

The game routes use the untruncated bodies because the runtime checks them against the final score (box points,
the play-by-play's last event, the period table); the 3-row captures would be refused.

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.easl.<wrapper>`) called with the arguments in `EASL_CASES` of `test-easl.R`, its
transport (`requests.Session.request`) faked to answer the fixture and its clock fixed at 2026-10-12T23:00Z, so the
season mapping, the freshness check and the game checks run too. Nulls are written as `\N`. `dtypes.json` is each
frame's polars schema and `requests.json` the routes and query sdv-py sent, in order. Generated with
`/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py `e3d232ebc9`. A `__active` / `__2024` /
`__roster` suffix is the same wrapper on the active season, the 2023-24 game and `season = 2026, team_id = <Brex>`.
