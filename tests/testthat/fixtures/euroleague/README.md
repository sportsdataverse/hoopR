# EuroLeague fixtures

Real payloads for the offline tests in `tests/testthat/test-euroleague.R`. The 22 route
`*.json` files are **byte copies** of the recon captures in
`sdv-internal-refs/euroleague/captures/` (the same bytes sdv-py vendors under
`tests/fixtures/euroleague/`), captured live and keyless; every array is cut to its first 3
elements at every depth and the body is pretty-printed (2-space indent, LF). Do not edit them:
re-capture upstream and copy. They are named by route (the `columns.json` key) because
R CMD check limits tarball paths to 100 bytes; the upstream capture name is listed per file.

api-live.euroleague.net v2 (header `Accept: application/json`; captured 2026-10-05, season `E2025`):

| Fixture | Upstream capture (`captures/E2025/`) | Request |
|---|---|---|
| `competitions.json` | `competitions.json` | `/competitions` |
| `seasons.json` | `competitions__E__seasons.json` | `/competitions/E/seasons` |
| `rounds.json` | `competitions__E__seasons__E2025__rounds.json` | `/competitions/E/seasons/E2025/rounds` |
| `clubs.json` | `competitions__E__seasons__E2025__clubs.json` | `/competitions/E/seasons/E2025/clubs` |
| `people.json` | `competitions__E__seasons__E2025__people.json` | `/competitions/E/seasons/E2025/people` |
| `games.json` | `competitions__E__seasons__E2025__games.json` | `/competitions/E/seasons/E2025/games` |
| `game_stats.json` | `competitions__E__seasons__E2025__games__1__stats.json` | `/competitions/E/seasons/E2025/games/1/stats` |

api-live.euroleague.net v3 (same header; captured 2026-10-06):

| Fixture | Upstream capture (`captures/E2025/`) | Request |
|---|---|---|
| `game_report.json` | `v3__competitions__E__seasons__E2025__games__1__report.json` | `/competitions/E/seasons/E2025/games/1/report` |
| `standings__basicstandings.json` | `v3__competitions__E__seasons__E2025__rounds__1__basicstandings.json` | `/competitions/E/seasons/E2025/rounds/1/basicstandings` |
| `standings__calendarstandings.json` | `v3__..._rounds__1__calendarstandings.json` | `.../rounds/1/calendarstandings` |
| `standings__streaks.json` | `v3__..._rounds__1__streaks.json` | `.../rounds/1/streaks` |
| `standings__aheadbehind.json` | `v3__..._rounds__1__aheadbehind.json` | `.../rounds/1/aheadbehind` |
| `player_stats__traditional.json` | `v3__competitions__E__statistics__players__traditional.json` | `/competitions/E/statistics/players/traditional?SeasonMode=Single&SeasonCode=E2025&statisticMode=PerGame&limit=3` |
| `player_stats__advanced.json` | `v3__competitions__E__statistics__players__advanced.json` | `.../players/advanced` (same query) |
| `team_stats__traditional.json` | `v3__competitions__E__statistics__teams__traditional.json` | `.../teams/traditional` (same query) |
| `team_stats__advanced.json` | `v3__competitions__E__statistics__teams__advanced.json` | `.../teams/advanced` (same query) |

live.euroleague.net/api (JSON by default, no Accept header; captured 2026-10-06; game 1 of
`E2025` is Anadolu Efes vs Maccabi, 2025-09-30):

| Fixture | Upstream capture | Request |
|---|---|---|
| `game_points.json` | `captures/E2025/api__Points.json` | `/Points?gamecode=1&seasoncode=E2025` |
| `game_pbp.json` | `captures/E2025/api__PlayByPlay.json` | `/PlayByPlay?gamecode=1&seasoncode=E2025` |
| `game_boxscore.json` | `captures/E2025/api__Boxscore.json` | `/Boxscore?gamecode=1&seasoncode=E2025` |
| `game_header.json` | `captures/E2025/api__Header.json` | `/Header?gamecode=1&seasoncode=E2025` |
| `game_points__U2025.json` | `captures/U2025/api__Points.json` | `/Points?gamecode=1&seasoncode=U2025` (EuroCup) |
| `game_pbp__U2025.json` | `captures/U2025/api__PlayByPlay.json` | `/PlayByPlay?gamecode=1&seasoncode=U2025` |

## Parity goldens (generated from sdv-py, not hand-written)

`columns.json` and `gold__<route>[__<section>].csv` are the sdv-py side of the R-vs-Python
parity test, written by the committed generator `data-raw/euroleague_goldens.py`: it runs
sdv-py's parsers (`sportsdataverse.euroleague.euroleague_parsers`) on the fixtures above and
writes, per route and `kind` / `mode` section, the frame's column names (asserted equal, in
order, to `tools/codegen/schemas/native/euroleague/<route>.yaml`), polars dtypes mapped to R
classes, the row count, and the frame as CSV (`null_value = "NA"`, so a Python null and an
empty string stay distinct). **Last generated from sdv-py commit `90372b5a46`** (branch
`fix/frames-null-promotion`: the shared frame builder keeps nullable boolean / integer columns
and never writes `"nan"`; merged to sdv-py main as `67ee42280f`, PR #712), with that checkout's
venv python:

```sh
<sdv-py>/.venv/Scripts/python.exe data-raw/euroleague_goldens.py --sdv-py <sdv-py>
```

The offline tests assert `identical(names(df), columns)`, `nrow` and every column's class
against `types`, then compare every cell strictly with that class (NA is NA, "" is "");
JSON-encoded list cells are compared by parsing both sides (Python's `", "` / `": "` separators
and `\uXXXX` escapes are the only byte-level difference). Regenerate (same command, new commit
cited here) when sdv-py's euroleague parsers or schemas change.
