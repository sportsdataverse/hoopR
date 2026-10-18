# ACB fixtures (`api2.acb.com`): provenance

Copied unchanged from sdv-py `tests/fixtures/acb/` at sdv-py `e3d232ebc9` (origin/main, 2026-10-18), which took them
from sdv-internal-refs `acb/` (captured live 2026-10-12). See that README for the capture details. The API key is
public (acb.com's bundle) and is not stored in any body.

* `full/` -- the ten FULL, untruncated bodies of sdv-py `tests/fixtures/acb/full/` (same names): match 105401
  (Barca 89-86 Valencia Basket, Liga 2026-27 round 3) header, box score, play-by-play (gzipped), shots, lead tracker,
  lineups and leaders; the Liga 2026-27 round 3 game list (`roundId=6017`), the standings and Barca's team stats.
* `cap/` -- refs capture samples, every array cut to 3 rows, renamed by route to keep paths under 100 characters:
  `cap/<route>[__<variant>].json` is sdv-py `captures/<scope>__<Controller>__<route>[__<variant>].json` (for example
  `cap/match-shots__2016.json` = `captures/matchdata__MatchShots__match-shots__2016.json`), except
  `cap/player-matches.json` = `captures/seasondata__PlayerProfile__matches.json`.
* `parity/<case>.csv` -- the frame of the sdv-py wrapper `acb_<case>` (a `__<variant>` suffix is the same wrapper on
  another fixture) called with the kwargs in `parity/requests.json` (which also names the fixture and records the
  URL and wire query sdv-py sent), its transport (`acb_runtime._fetch`) faked to answer the fixture, so the
  runtime's checks and the `_request` stamp run too. `parity/dtypes.json` is each frame's polars schema. Instants
  are written `%Y-%m-%dT%H:%M:%SZ` (UTC), dates ISO, nulls empty, booleans `true` / `false`. Generated with
  `/mnt/sdv_repos/sdv-py/.venv/bin/python` on a detached worktree of sdv-py `e3d232ebc9` (`PYTHONPATH` set to it).
  `test-acb.R` compares every cell; NA-vs-value counts as a mismatch.
