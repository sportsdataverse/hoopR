# LKL fixtures: provenance

Copied from sdv-py `tests/fixtures/lkl/` at sdv-py `e3d232ebc9` (origin/main, 2026-10-18), which captured them from
`https://lkl.lt` on 2026-10-12 (keyless, requests >= 1 s apart). See that README for the capture details. The site
serves no contact or birth data on these routes.

* `full/` -- the FULL, untruncated livestream bodies of ONE finished overtime game, 11446 (Nevezis-Paskolu klubas
  88-85 Jonavos Hipocredit, 2026-02-14, 2025-26), same names as sdv-py `full/`; `play-by-play.json.gz` and
  `shot-chart.json.gz` are those two files gzipped (unchanged bytes). `rungtynes.json` is sdv-py's game-page record
  of that game (`lkl_parsers._game_record`).
* `html/game_11446.html` -- NOT a capture: the game page of 11446 rebuilt from `full/rungtynes.json` the way sdv-py's
  `tests/basketball/lkl/test_lkl.py::_page_html` does (every record prop as a `<game-info-component>` attribute,
  `:`-props as HTML-escaped JSON), so the R game-page reader runs on the same input as sdv-py's runtime tests.
* `html/` (everything else) -- unchanged copies of sdv-py `html/`: the real page `game_11590.html` (only its
  `<game-info-component>`), the three `/loadResults` pages of 2026-27 (`results_49436_p{1,2,3}.html`, 10 + 10 + 2
  games), the two season selects (`rezultatai_selects.html`, `turnyrine_select.html`, every season 1993-94 to
  2026-27) and three standings fragments (`standings_{35,34,3}.html`: 2026-27, 2025-26 with its final table, 2007-08
  with a placeholder final table; each table cut to its header, 3 rows and its last row). sdv-py's `captures/` (refs
  samples cut to 3 rows) are not copied: the tests read only the files above.
* `parity/<case>.csv` (`pbp.csv.gz`) -- sdv-py's frame of `lkl_<wrapper>(<args>)` run END TO END through
  `lkl_runtime` over a scripted session serving these same files (game 11446, `season = 2027` for results and
  standings, plus `standings__2026` / `standings__2008` for `season = 2026` / `2008`), written with polars
  `write_csv(null_value = "<null>")`, so a null stays distinct from an empty string. `parity/dtypes.json` is each
  frame's polars schema; `parity/requests.json` the wrapper, its arguments, its row count and every request it sent
  (path and query). Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` over a worktree of sdv-py e3d232ebc9;
  the generator lives outside the repo. `test-lkl.R` compares every cell; NA-vs-value counts as a mismatch.
