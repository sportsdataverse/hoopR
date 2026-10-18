# SCB fixtures (BBL `api.basketball-bundesliga.de`, DBBL `api-1.dbbl.scb.world`)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/scb/` (see its README: per-route captures from
sdv-internal-refs `scb/captures/` at refs `cb7a95a`, truncated to 3 array elements; `full/` bodies fetched
untruncated on 2026-10-12). Copied verbatim: only the files the tests read. No auth value is stored here.

`parity/` is sdv-py's own output on these files: each `<case>.csv` is the frame of the sdv-py wrapper
(`sportsdataverse.basketball.scb.<wrapper>`) called with the arguments in `SCB_CASES` of `test-scb.R`, its
transport (`scb_runtime._send`) faked to answer the fixture, so the runtime checks and the request stamp run too;
`dtypes.json` is each frame's polars schema and `requests.json` the URL and query sdv-py sent. Generated with
`/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py `e3d232ebc9` (`PYTHONPATH` set to it).
A `__2005` suffix is the same wrapper on the 2005-06 box score.

`parity/scb_games_recent.csv` and `parity/scb_game.csv` were regenerated the same way on sdv-py `38a22f936d`
(#892), which joins the `name`s of `tvChannel` objects (e3d232ebc9 wrote Python dict reprs there); their
`tv_channel` cells are the only change, and hoopR matches them as they are.
