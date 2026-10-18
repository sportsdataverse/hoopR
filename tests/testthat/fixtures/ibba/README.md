# IBBA fixtures (`basket.co.il` ASMX + Segev Stats)

Copied from sdv-py `tests/fixtures/ibba/` at sdv-py `origin/main`
`e3d232ebc9bf9e9f98225666a67707b8e554f9b7` (2026-10-18). sdv-py took them from sdv-internal-refs `ibba/`
(refs `main` `f8064c2`, captured live and keyless 2026-10-12; the full bodies fetched the same day). `@` in the
refs capture names is not a portable file name, so it is `_` here; the full bodies are gzipped.

| File here | sdv-py source | What |
|---|---|---|
| `full/Boxscore.json.gz` | `full/Boxscore.json` | ASMX box score, game 26392 (2025-26 round 1, Beer Sheva 92-104 Maccabi Tel Aviv) |
| `full/Games.json.gz` | `full/Games.json` | ASMX games, board 5 round 1, 2025-26 (carries the Segev ids) |
| `full/getGameInfo.json.gz`, `full/getBoxScore.json.gz`, `full/getActions.json.gz` | `full/` same names | Segev game 50 (= IBBA 26392): header + rosters, box score, 768 actions |
| `full/getBoxScore_419.json.gz` | `full/getBoxScore_419.json` | Segev game 419 (2026-27): the renamed team game-stat keys |
| `cap/<Op>_<params>.json` | `captures/asmx/<Op>@<params>.json` | refs samples (arrays cut to 3 rows) of every ASMX op; 2005 = 2004-05 |
| `cap/getGameInfo_300.json` | `captures/segev/getGameInfo@300.json` | refs sample, Segev game 300 (women's league) |
| `parity/<case>.csv` (`.csv.gz` when large) | generated | sdv-py's frame of one wrapper call on one fixture; nulls are `\N` |
| `parity/manifest.json` | generated | each case's wrapper, arguments, fixture and row count, plus sdv-py's column types per wrapper |

Contact fields are `REDACTED` in the refs captures; the parsers drop them anyway.

## Regenerating `parity/`

From a `git worktree` of sdv-py `origin/main` (never install into the venv): mock the two runtimes' `_fetch`
to answer each case's fixture, call the wrapper with the case's arguments, and write
`df.write_csv(null_value="\\N", datetime_format="%Y-%m-%d %H:%M:%S", date_format="%Y-%m-%d")` plus the
manifest, with `PYTHONPATH=<worktree> <sdv-py>/.venv/bin/python -I`.
