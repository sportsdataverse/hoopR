# Running-score repair fixtures

Real ESPN summary payloads for `tests/testthat/test-espn_score_repair.R`, and sportsdataverse-py's
output on the same bytes (`expected/<name>.csv`: `row` = 1-based array position, `sequence_number`,
`home_score`, `away_score`, `score_source`). Never hand-edit either: regenerate with
`ClaudeCowork/scripts/score-repair-r/write_expected.py` (plan `2026-10-11-bball-score-repair-r.md`, Task 1)
from a sportsdataverse-py checkout. Expected files written from sportsdataverse-py @ 78a0fb8130b5acd8180e8784b67e26481c4c44a8.

| File | Source | What it pins |
|---|---|---|
| `nba_401766458.json.gz` | hoopR-nba-raw `nba/json/raw/401766458.json` @ 1fa774d21de (2026-06-02), via sportsdataverse-py's fixture | 2025-04-15 ATL @ ORL play-in: Trae Young's second technical FT keyed late (seq 738, row 439); ESPN's rows from seq 658 on are never re-based, last row 119-95 vs official 120-95 |
| `nba_400829116.json.gz` | hoopR-nba-raw `nba/json/raw/400829116.json` @ 2db1b380436 (2023-04-07) | 2015-16: every scoring free throw ships `scoreValue: 0`; ESPN ends 112-105 vs official 114-105 |
| `nba_401704638.json.gz` | hoopR-nba-raw `nba/json/raw/401704638.json` @ 1fa774d21de (2026-06-02) | 2024-25: the scoring plays sum to 104-139 against an official 104-140, so the rebuild is rejected (`score_source` "espn") |
| `summary_nba.json.gz` | gzip of sportsdataverse-py `tests/fixtures/espn/summary_nba.json` (Site v2 `summary?event=401585607`) | 2024-03-17 TOR @ ORL: one dip, 17 rows re-based, ends 111-96 |
| `mbb_401829457.json.gz` | hoopR-mbb-raw `mbb/json/raw/401829457.json` @ 11e4542f967 (2026-07-18) | 2025-11-23 CCU vs UND, neutral site: every ESPN row carries the header away team's score in `homeScore` (ends 75-58; official UND home 58, CCU 75) |
| `summary_mbb.json.gz` | gzip of sportsdataverse-py `tests/fixtures/espn/summary_mbb.json` (`summary?event=401638645`) | 2024 national final PUR vs CONN, neutral site, halves, clean feed: rebuild equals ESPN |
| `mbb_401830342.json.gz` | sportsdataverse-py `tests/fixtures/espn/basketball_pbp/mbb_401830342.json.gz` (hoopR-mbb-raw) | 2025-11-15 UTU @ MVSU, double overtime, clean feed |
