# B.LEAGUE fixtures (`b-league.s3.amazonaws.com` + `www.bleague.jp`)

Copied from sdv-py `tests/fixtures/bleague/` at sdv-py `origin/main`
`e3d232ebc9bf9e9f98225666a67707b8e554f9b7` (2026-10-18), which copied them from sdv-internal-refs
`bleague/` (captured live and keyless 2026-10-12/13; provenance of the bodies: that directory's README).
`@` in the refs capture names is not a portable file name, so those files are renamed here.

| File here | sdv-py source | What |
|---|---|---|
| `full/v2_504734.json.gz` | `full/v2_504734.json.gz` | FULL v2 context: B1 2025-26 sec 1, Alvark Tokyo 56-81 Utsunomiya Brex |
| `full/v1_10693.json.gz` | `full/v1_10693.json.gz` | FULL v1 context: B3 2025-26 sec 29, Veertien Mie 81-93 Tachikawa Dice |
| `cap/v2_505508.json`, `cap/v2_500017.json`, `cap/v2_5856.json` | `captures/v2_genius_contexts__ScheduleKey__latestId@<key>.json` | refs captures (arrays cut to 3 rows): B2 2025-26, B1 2022-23, B1 2020-21 |
| `cap/v1_2988.json` | `captures/v1_contexts__ScheduleKey__latestId@2988.json` | refs capture, v1 B1 2018-20 era |
| `cap/schedule_<tab>_<year>_<mmdd>.json` | `captures/schedule@<tab>_<year>_<mmdd>.json` | refs schedule page records (B1 2016-17, B2 / B3 2025-26) |
| `cap/standings_<tab>_<year>.json` | `captures/standings@<tab>_<year>.json` | refs standings page records (B1 2016-17, B3 2025-26) |
| `html/game_detail_1.html` | same | a bare page around the refs `game_detail.json` record as `_contexts_s3id.data` (ScheduleKey 1, 2016-17) |
| `html/schedule_2025_1004.html.gz`, `html/standings_2025_b1.html.gz` | same | the REAL pages `schedule/?tab=1&year=2025&event=2&mon=10&day=04` and `standings/?year=2025&tab=1` |
| `parity/<set>/<route>.csv` (`.csv.gz` when large) | generated | sdv-py's frame of each route on that fixture |
| `parity/manifest.json` | generated | each set's fixture, kind and row counts, plus sdv-py's column types per route (`SPECS`) |

`year` in the page names is the site's season START year (`year=2025` is 2025-26, the wrappers'
`season = 2026`). No body carries contact data (the sdv-py runtime redacts contact keys; none occur).

## Regenerating `parity/`

From a `git worktree` of sdv-py `origin/main` (never install into the venv), with this directory as `SRC`:

```sh
PYTHONPATH=<sdv-py worktree> <sdv-py>/.venv/bin/python -I bleague_parity.py "$SRC"
```

where `bleague_parity.py` runs sdv-py's own parsers (`bleague_parsers.parse_bleague_<route>(raw,
columns=bleague._PARSER_COLUMNS[route])`) over:

* the two `full/` contexts stamped `_request = {"schedule_key", "feed"}` as `bleague_runtime` stamps a live body
  (sets `v2_504734`, `v1_10693`; every game route);
* the four `cap/` contexts unstamped, as sdv-py's tests read them (`v2_505508`, `v2_500017`, `v2_5856`,
  `v1_2988`);
* `bleague_runtime._embed_body(game_detail_1.html, 1)`, stamped (`embed_1`);
* `bleague_parsers._schedule_record(schedule html, 1, 2025, 2, 10, 4)` (`schedule_page`) and
  `_standings_record(standings html, 2025, 1)` (`standings_page`);
* the five refs page records (`schedule_*`, `standings_*`),

and writes every cell as a string: integers `str`, floats `repr`, booleans `TRUE` / `FALSE`, dates ISO,
datetimes (UTC) `%Y-%m-%d %H:%M:%S`, nulls empty; a CSV over 60 kB is gzipped. `test-bleague.R` compares
every cell (NA-vs-value counts as a mismatch). The wrapper sets (`v2_504734`, `v1_10693`, `embed_1`,
`schedule_page`, `standings_page`) run through the exported wrappers with the transport mocked.
