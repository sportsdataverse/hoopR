# FEB fixtures (`intrafeb.feb.es` LiveStats API + `baloncestoenvivo.feb.es`)

Copied from sdv-py `tests/fixtures/feb/` at sdv-py `origin/main`
`e3d232ebc9bf9e9f98225666a67707b8e554f9b7` (provenance of the bodies themselves:
that directory's README).

Captured: the game bodies (game 2535725 and the overview of its day) were fetched 2026-10-12 with the public site
token; `KeyFacts_2171130.json` (and, in wehoop, `lf/`) are sdv-internal-refs captures of 2026-10-12 (refs commit
`38e5cf0`); the cut-down schedule pages carry no fetch stamp and were committed to sdv-py on 2026-10-13
(`4636718a57`).

`parity/dtypes.json` is sdv-py's polars dtype per column of each parity frame, from the same fixtures:
sdv-py e3d232ebc9 (`PYTHONPATH` set to a detached worktree of it) run with `/mnt/sdv_repos/sdv-py/.venv/bin/python`
by a generator kept outside the repo (the parsers on the stamped bodies, as below). The test asserts each R column's class against it.

| File here | sdv-py source | What |
|---|---|---|
| `BoxScore.json`, `KeyFacts.json.gz`, `Ranking.json`, `ShotChart.json`, `TeamStats.json`, `overview.json` | `full/` | Full bodies of game 2535725 (Primera FEB 2026-27) and that day's `/overview` |
| `KeyFacts_2171130.json` | `captures/KeyFacts__gameId@2171130.json` | 2020-21 text-only play-by-play (3 rows), renamed for portable file names |
| `calendario_g1_t2026.html`, `resultados_g1_t2026.html`, `resultados_g1_t2025.html` | same names | Cut-down real schedule pages; the token input is `TOKEN_REDACTED` |
| `parity/*.csv` (`pbp.csv.gz`) | generated | sdv-py's frame for each route on the fixture above, every cell a string, empty = null |

No file holds a bearer token. `t` in the page names is the site's season START year
(`t=2026` is 2026-27, the wrappers' `season = 2027`).

## Regenerating `parity/`

From a `git worktree` of sdv-py `origin/main` (never install into the venv), with this
directory as `SRC`:

```sh
PYTHONPATH=<sdv-py worktree> <sdv-py>/.venv/bin/python parity.py "$SRC" "$SRC/parity" && gzip -9 -n "$SRC/parity/pbp.csv"
```

where `parity.py` parses each fixture with `sportsdataverse.basketball.feb.feb_parsers`
(`parse_feb_<route>(raw, columns=feb._PARSER_COLUMNS[route])`, the game bodies stamped with
`_request = {"game_id": ...}`, the pages through `feb_parsers._page_record(kind, html, g, t)`)
and writes every column as strings: integers as `str`, floats as `repr`, booleans as
`TRUE` / `FALSE`, dates ISO, datetimes `%Y-%m-%d %H:%M:%S`, nulls empty. Files:
`game_info`, `period_scores`, `team_stats` (TeamStats), `player_box` (BoxScore), `pbp`
(KeyFacts), `pbp_2171130`, `shots` (ShotChart), `leaders` (Ranking), `overview`,
`schedule` (calendario g1 t2026), `results` and `standings` (resultados g1 t2026),
`standings_final` (resultados g1 t2025).
