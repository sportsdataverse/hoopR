# Sportpress fixtures (BNXT League, `bnxt.sportpress.info/api/v1`)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/sportpress/` (see its README: `captures/` are the refs
samples of sdv-internal-refs `sportpress/captures/` at refs `c6ebad8`, captured 2026-10-12, lists cut to 3 rows;
`full/` are untruncated bodies fetched live on 2026-10-12, contact fields dropped). Only the files the tests read are
copied, renamed by route to keep paths short, and compacted (whitespace removed, values untouched); `full/film.json.gz`
is byte for byte. No file holds the header key.

| here | sdv-py `tests/fixtures/sportpress/` |
|---|---|
| `cap/server_config.json` | `captures/server-config.json` |
| `cap/club_seasons.json` | `captures/competition-team__club__seasons.json` |
| `cap/staff_list.json` | `captures/staff__list.json` |
| `cap/phase_season.json` | `captures/phase__season__season.json` |
| `cap/competition_teams.json` | `captures/competition-team__all.json` |
| `cap/standings.json` | `captures/standings__competition__competitionId__phase__phaseId.json` |
| `cap/team_rankings.json` | `captures/competition-team__average-rankings__competitionId.json` |
| `cap/player_rankings.json` | `captures/player__average-rankings__competitionId.json` |
| `cap/nationality_codes.json` | `captures/roster__season-nationality-codes__season.json` |
| `cap/team_roster.json` | `captures/roster__team-players__competitionTeamId.json` |
| `cap/team_find.json` | `captures/competition-team__find__competitionTeamId.json` |
| `cap/team_games.json` | `captures/competition-team__statistics-by-game__total__competitionTeamId.json` |
| `cap/roster_find.json` | `captures/roster__find__rosterId.json` |
| `cap/player_career.json` | `captures/player__career-averages__rosterId.json` |
| `cap/player_games.json` | `captures/boxscore__player__season-games__rosterId.json` |
| `full/schedule.json` | `full/schedule__club__season.json` |
| `full/game_slider.json` | `full/schedule__game-slider__competitionId.json` |
| `full/season_roster.json` | `full/roster__season-players__season.json` |
| `full/team_player_averages.json` | `full/competition-team__player-averages__competitionTeamId.json` |
| `full/game_find.json` | `full/schedule__find__gameId.json` |
| `full/overview.json` | `full/schedule__overview__gameId.json` |
| `full/box.json` | `full/boxscore__game__competitionId__gameId.json` |
| `full/film.json.gz` | `full/film__game__competitionId__gameId.json.gz` |

`parity/` is sdv-py's own output on these files: each `sportpress_<short>.csv` is the frame of the sdv-py wrapper
`sportsdataverse.basketball.bnxt.sportpress_<short>` called with the arguments in `SP_CASES` of `test-sportpress.R`,
its transport (`bnxt_runtime._fetch`) faked to answer the fixture, so the runtime checks, the finished-game gate,
the personal-data scrub and the request stamp all run. `manifest.json` holds each frame's polars schema (`dtypes`)
and the API requests sdv-py sent, in order (`requests`: path under `/api/v1` and query). Written with
`/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py `e3d232ebc9` (`PYTHONPATH` set to it).
CSV conventions: nulls are `\N` (so an empty string `""` stays distinct), booleans `true` / `false`, dates ISO,
datetimes `%Y-%m-%d %H:%M:%S` (league local time; hoopR returns POSIXct in Europe/Brussels).
