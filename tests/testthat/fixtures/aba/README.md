# ABA League fixtures: provenance

Copied unchanged from sdv-py `tests/fixtures/aba/` at sdv-py `e3d232ebc9` (origin/main, 2026-10-18), which copied
them from sdv-internal-refs `aba-liga/` (commit `14f731b`, captured live 2026-10-12; `full/` fetched 2026-10-13).
See that README for the capture details. Nothing is masked: officials appear by name only and the player bio is the
public profile.

* `full/match_6_25_1.json` -- the FULL parsed record (sdv-py `aba_parsers.record_for("match", ...)`) of ABA League
  2025-26 game 6, Buducnost VOLI 93:97 Spartak Office Shoes after overtime: 24 box rows (2 did-not-play), 659
  play-by-play events, 5 periods. The 478 KB HTML page itself is not committed (as in sdv-py).
* `match_6_25_1.html`, `match_1_8_1.html` (2008-09, box only), `calendar_25_1.html`, `standings_25_1.html`,
  `player_4807_25_1.html` -- the refs cut-down pages: the input of the R HTML walk.
* `create_shooting_chart_6_25_1.json`, `create_json_6_25_1.json` -- whole live-match helper bodies of game 6;
  `create_scoredifference_unknown.json` -- the 40-row zero placeholder an unknown id gets (refused).
* `cap/` -- the refs parsed records, every array cut to 3 rows. Renamed to keep file names portable (no `@`):

| here | sdv-py `tests/fixtures/aba/captures/` |
|---|---|
| `cap/calendar_25_1.json` | `calendar.json` |
| `cap/calendar_25_2.json` | `calendar@25_2.json` |
| `cap/calendar_8_1.json` | `calendar@8_1.json` |
| `cap/flow_6_25_1.json` | `create_json.json` |
| `cap/flow_17_1_1.json` | `create_json@17_1_1.json` |
| `cap/flow_25_2_1.json` | `create_json@25_2_1.json` |
| `cap/scorediff_6_25_1.json` | `create_scoredifference.json` |
| `cap/scorediff_17_1_1.json` | `create_scoredifference@17_1_1.json` |
| `cap/scorediff_25_2_1.json` | `create_scoredifference@25_2_1.json` |
| `cap/shots_6_25_1.json` | `create_shooting_chart.json` |
| `cap/shots_17_1_1.json` | `create_shooting_chart@17_1_1.json` |
| `cap/shots_25_2_1.json` | `create_shooting_chart@25_2_1.json` |
| `cap/match_6_25_1.json` | `match__gameNo.json` |
| `cap/match_17_1_1.json` | `match__gameNo@17_1_1.json` |
| `cap/match_25_2_1.json` | `match__gameNo@25_2_1.json` |
| `cap/match_8_1_1.json` | `match__gameNo@8_1_1.json` |
| `cap/player_4807_25_1.json` | `player__playerId.json` |
| `cap/standings_25_1.json` | `standings.json` |
| `cap/standings_25_2.json` | `standings@25_2.json` |
| `cap/standings_8_1.json` | `standings@8_1.json` |

* `parity/<case>.csv` -- the sdv-py frame of each case in `parity/manifest.json` (38 cases over the 12 wrappers),
  written by sdv-py's own parsers (`aba_parsers.parse_aba_<short>`, with the wrapper's `_PARSER_COLUMNS`) run with
  sdv-py e3d232ebc9 over the SAME fixture: `source = html` is `record_for(kind, <page>, want)` (the HTML walk is
  compared too), `record` a committed parsed record, `helper` a helper body stamped with the manifest's `_request`.
  Polars `write_csv`: dates ISO, nulls empty, booleans `true`/`false`. `test-aba.R` compares every cell;
  NA-vs-value counts as a mismatch.
