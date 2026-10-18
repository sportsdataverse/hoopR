# tests/testthat/fixtures/pleague

Provenance: sdv-py `origin/main` **e3d232e** (`sportsdataverse-py`), `tests/fixtures/pleague/` and
`tests/fixtures/pleague_preciser/`: real pages and bodies of `pleagueofficial.com` and the third-party vendor
`api.preciser.io`, captured live 2026-10-12 / 2026-10-13 by sdv-internal-refs `pleague/tools/capture.py` (see those
directories' READMEs). Files over 8 KB are gzipped (`gzip -n -9`), otherwise byte-identical to the sdv-py copies.

- `site/`: `game_{197,13,206}.html` (2022-23 opener, 2020-21 opener with an empty uuid, double overtime),
  `box_{197,13,206}.json` (whole box bodies, era B / era A / double overtime), `pbp_{197,206}.json` (the refs
  cut-down play-by-play bodies: every period header, the closing row, some events), the cut-down pages
  `schedule_regular_2022-23.html`, `schedule_finals_2022-23.html`, `schedule_regular_2020-21.html`,
  `standings_2022-23.html`, `stat_player_2022-23_2.html`, `player_1JbPozLB.html` (an EASL block) and
  `player_1P42uoZg.html` (one season).
- `vendor/`: `chart_data_197.json` (sdv-py `pleague_preciser/full/`, all 168 shots of gid 197), and the whole
  `summary_197.json`, `rotation_197.json` and `injury_197.json` bodies. Clip urls carry `key=<redacted>`.
- Trimmed: sdv-py's `captures/` (parsed refs records), `full/pbp_197.json` (a parsed record, not the HTML the R
  port reads), `game_716.html` / `box_716.json` and `schedule_future_2026-27.html` are not copied.
- `parity/<case>.csv` (`.csv.gz` over 16 KB): sdv-py's frame of `pleague_<fn>(<args>)` run END TO END over these
  same files (a fake curl_cffi transport and a fake `download()` serving them), written with polars `write_csv`
  (null = `<null>`, so an empty string stays distinct). `parity/cases.json`: per case the wrapper, its
  arguments, the row count, the polars dtypes and every request it sent (URL and query); the `_verified` cases
  (`gid` passed to a vendor wrapper) share the unverified case's CSV. Generated with
  `/mnt/sdv_repos/sdv-py/.venv/bin/python` over a worktree of sdv-py e3d232e; the generator lives outside the repo.

`parity/pbp_206.csv` was regenerated the same way on sdv-py **38a22f936d** (#892), which reads `action_en` from
each row's own phrase (e3d232e mapped the action code, so every free throw read "free throw 1 of 3 awarded"); its
two free-throw `action_en` cells are the only change. hoopR matches it cell for cell.
