# Atrium fixtures (Sportradar embed API, `embed-api.eui.connect.sportradar.com/v1/embed`)

**Provenance.** Every `*.json` here is a byte-for-byte copy of the file at the same relative path under
sdv-py `tests/fixtures/atrium/` at sdv-py commit `e3d232ebc9bf9e9f98225666a67707b8e554f9b7` (see that
directory's README for how each body was captured):

- `<websiteId>__<type>[__<sub>].json`: per-route captures (copied there from sdv-internal-refs
  `atrium-embed/captures/`, refs commit `40142b0`, 2026-10-12), truncated to 3 entries per array.
- `full/12__fixture_detail__statistics.json`, `full/14__fixture_detail__statistics.json`: whole LNB and LNBP box
  score bodies (fetched live 2026-10-12).
- `refusals/14__fixture_detail__pbp__other_site.json`: the LNB game `5423072b-...` asked under site 14 (LNBP):
  HTTP 200 with an empty `fixture`, the body an unknown id gets too (fetched live 2026-10-18).

**Parity oracle (`parity/`).** `parity/<case>.csv` is sdv-py's frame for one `parse_atrium_*` parser on one of
the fixtures above, and `parity/dtypes.csv` its polars dtype per column. They were written by running the sdv-py
parsers (same commit, polars 2.0) from a `git worktree` of sdv-py `origin/main`, with datetimes formatted
`%Y-%m-%d %H:%M:%S` and nulls as empty cells. The case -> fixture map is `atrium_cases` in
`tests/testthat/test-atrium.R`. To regenerate after an sdv-py parser change, run each `parse_atrium_*` on the
listed fixture and `write_csv` the frame the same way.
