# Basketligaen fixtures (`www.basketligaen.dk/api`, Sportality platform)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/sportality/` (see its README: 3-row route samples copied
from sdv-internal-refs `sportality/captures/` at refs `cb7a95a`; `full/` bodies fetched on 2026-10-13). Personal keys
are removed or read `<redacted>`. Only the files the tests read are here.

| File | Source |
|---|---|
| `athlete_career`, `athlete_details`, `athlete_profile`, `game_header`, `game_overview`, `game_summary`, `last_game_day`, `next_game_day`, `player_h2h`, `post_game_team_stats`, `standings`, `team`, `played_games`, `upcoming_games` | the sdv-py route sample of the same route, unchanged (game `c4hh5nig6t`, team `rfo82vr830`, ssgt `xs07bd3fmp`) |
| `teams_summary_2003.json` | `statistics-v2__stats-info__module__teams_summary@rejluryl18.json` (2002/03), unchanged |
| `boxscore.json`, `team_stats.json` | `full/gameday__boxscore__c4hh5nig6t.json`, `full/gameday__team-stats__c4hh5nig6t.json`, unchanged |
| `layout.json` | **Derived** from `full/statistics-v2__layout-info__directory.json`: all 49 ssgts, team lists kept only for `xs07bd3fmp`, `qzw34da6jg`, `al4a0u2go5`, `rejluryl18` (the ssgts the tests use) |
| `pbp.json` | **Derived** from `full/gameday__play-by-play__c4hh5nig6t.json`: the first event of each `type` / `subType` pair plus the three newest events (the game-end line included), in feed order (41 events) |
| `roster.json` | **Derived** from `sports-v2__athletes__by-team-uuid__team_uuid.json`: `portraitList` emptied, `renderedLatestPortrait` cut to its `url` (the only fields the parser drops or reads) |
| `schedule.json` | **Derived** from `full/sports-v2__game-schedule__qzw34da6jg.json` (2025/26): the first 4 games, `teamList` cut to the team uuids |
| `players_summary.json`, `games_games.json` | **Derived** from the `full/` `players_summary` / `games_games` tables of `qzw34da6jg`: the first 6 / 4 rows, `totalCount` set to match, the `players` / `teams` / `games` maps cut to what those rows name |
| `player_stats.json`, `season_filter.json`, `sites.json` | **Live**, 2026-10-18 09:34 UTC, plain GETs 1.5 s apart: `/gameday/player-stats/c4hh5nig6t`, `/sports-v2/season-series-game-types-filter`, `/sports-v2/all-sites/xs07bd3fmp`, personal keys removed with sdv-py `sportality_parsers._scrub` (the 3-row samples fail the runtime's own checks: rows not in the name maps, 3 of 25 seasons, 3 of 12 clubs) |

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.dbl.sportality_<case>`, the part before `__`) called with the arguments in `DBL_CASES` of
`test-sportality.R`, its transport (`sportality_runtime.download`) faked to answer the fixture (and `layout.json` for
layout-info), so the season mapping and the runtime checks run too; `dtypes.json` is each frame's polars schema and
`requests.json` the URL and query sdv-py sent (the last request other than layout-info). Generated with
`/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py `e3d232ebc9` (`PYTHONPATH` set to it).
