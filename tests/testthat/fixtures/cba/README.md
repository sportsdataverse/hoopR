# tests/testthat/fixtures/cba

Provenance: sdv-py `origin/main` **e3d232e** (`sportsdataverse-py`), `tests/fixtures/cba/`: real responses of
`data-server.cbaleague.com` captured 2026-10-12 through a residential proxy (see that directory's README). The wire
bodies are AES-128-ECB encrypted; these files hold the DECRYPTED JSON (re-minified, otherwise unchanged), one per route,
named after the wrapper that reads it. The tests encrypt them with the public key before serving them.

- `wire_getMatchType.txt`: the raw wire body of `GET /api/com-code-tables/getMatchType`
  (`full/wire_getMatchType.txt`), which proves the decrypt path against the real service.
- `routes.json`: API route -> fixture file. The sources: `seasons` = `full/season_list.json`, `team_options` =
  `full/getTeam_2025.json`, `game_info` / `player_box` / `period_scores` / `best_player` / `best_stats` /
  `report_status` = `full/{baseinfo,data_count,quarter_info,best_player,best_quota,report_status}_100105799.json`,
  `pbp.json.gz` = `full/events_100105799.json` (all four periods of game 100105799, keyed by period, gzipped), and every
  other file the `captures/<route>.json` sample of the same game / team 29128 / season 2025 (arrays cut to 3 rows).
- `parity/<wrapper>.csv` (`pbp.csv.gz`): sdv-py's frame of `cba_<wrapper>(<example args>)` run end to end over these
  same bodies (encrypted on a fake session), written with polars `write_csv` (null = `<null>`, so an empty string stays distinct).
  `parity/dtypes.json` is that frame's polars schema; `parity/requests.json` every request the wrapper sent (method,
  URL, query, JSON body) and its arguments. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` over a worktree of
  sdv-py e3d232e; the generator lives outside the repo (no one-off scripts here).
