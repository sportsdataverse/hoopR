# KZS fixtures (`api.kzs.si/api/v1/public`)

Every file is a body as the API sends it: the `{"status": "OK", "data": ...}` envelope. Provenance: sdv-py origin/main
`e3d232ebc9`, `tests/fixtures/kzs/` (itself the sdv-internal-refs `kzs/captures/` samples, arrays cut to 3 rows, and
the `full/` bodies fetched and redacted on 2026-10-12). Copied byte for byte under shorter names (R CMD check warns on
paths over 100 characters); only the files the tests read.

| hoopR file | Source |
|:---|:---|
| `seasons.json` | sdv-py `captures/seasons.json` |
| `competitions.json` | sdv-py `captures/competitions.json` |
| `competitions_s26.json` | sdv-py `full/competitions__season26.json` |
| `competition_579.json` | live `GET /competitions/579`, 2026-10-18 (see below) |
| `rounds_579.json` | live `GET /competitions/579/rounds`, 2026-10-18 (see below) |
| `player_board_579.json` | sdv-py `captures/competitions__competitionId__playerStats__579.json` |
| `team_board_579.json` | sdv-py `captures/competitions__competitionId__teamStats__579.json` |
| `matches_579_2025-10.json` | sdv-py `captures/matches__579_2025-10.json` |
| `match_101839.json` | sdv-py `captures/matches__matchId__101839.json` |
| `pbp_101839.json.gz` | sdv-py `full/playByPlay__101839.json.gz` (816 actions; the 3-action capture lists one side only) |
| `stats_101839.json` | sdv-py `captures/matches__matchId__stats__101839.json` |
| `standings_579.json` | sdv-py `full/standings__579.json` (every entrant, so the leaderboard and team checks pass) |
| `days_579.json` | sdv-py `captures/matches__competitionId__playingDays__579.json` |
| `teams_579.json` | sdv-py `captures/teams__579.json` |
| `team_17551.json` | sdv-py `captures/teams__teamId__17551.json` |
| `team_general_17551_579.json` | sdv-py `captures/teams__teamId__general__17551_579.json` |
| `roster_17551_579.json` | sdv-py `captures/teamPlayers__17551_579.json` |
| `player_106285.json` | sdv-py `captures/players__playerId__106285.json` |
| `player_stats_106285_26.json` | sdv-py `captures/players__playerId__stats__106285_26.json` |

The refs captures cut competition 579 and its rounds to three different phases each, so the rounds scope check (the
rounds' phases must be the competition's) refuses them as a pair. `competition_579.json` and `rounds_579.json` are
therefore the full, untruncated bodies, fetched with plain `curl` 1.5 s apart (no key, no proxy). Neither carries
personal data (competition header, phases and round counts only).

`parity/` is sdv-py's own output on these files: each `<case>.csv` (`pbp.csv.gz` for the play-by-play) is the frame of
the sdv-py wrapper `sportsdataverse.basketball.kzs.<fn>` called with the `args` in `parity/requests.json`, its
transport (`basketball_runtime._get`) faked to answer each route's fixture (`routes`), so the argument checks, the
season mapping, the dependency requests and every scope check run too. Nulls are written as `<null>` (distinct from an
empty string). `dtypes.json` is each frame's polars schema and `requests` in `requests.json` the URLs and queries
sdv-py sent, in order. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py
`e3d232ebc9`. A `__2026` suffix is the same wrapper with `season = 2026`.
