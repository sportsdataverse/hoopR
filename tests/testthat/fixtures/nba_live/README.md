# NBA CDN liveData fixtures

Real payloads for the offline tests in `tests/testthat/test-nba_live_cdn.R`, stored gzipped.
Each was captured on 2026-09-27 UTC with httr2 1.3.0 (libcurl 8.14.1, R 4.6.1) and the header
set in `.nba_cdn_headers()`. The bytes are the unmodified response body.

| File | URL | JSON bytes | md5 of the JSON |
|---|---|---:|---|
| `playbyplay_0022500001.json.gz` | `https://cdn.nba.com/static/json/liveData/playbyplay/playbyplay_0022500001.json` | 521223 | `1292ebea38d1420b12c97c65fda02534` |
| `boxscore_0022500001.json.gz` | `https://cdn.nba.com/static/json/liveData/boxscore/boxscore_0022500001.json` | 40846 | `99c0c08b528cbe7e3c0f49fdeff50d44` |
| `playbyplay_2052500034_gleague.json.gz` | `https://cdn-gleague.nba.com/static/json/liveData/playbyplay/playbyplay_2052500034.json` | 437088 | `c2d9a85bd9a33daf979b3f051d20f903` |
| `boxscore_2052500034_gleague.json.gz` | `https://cdn-gleague.nba.com/static/json/liveData/boxscore/boxscore_2052500034.json` | 32109 | `af0434e368b6661650e1933ab32df360` |
| `0022400001_full_pbp.json.gz` | `https://data.nba.com/data/v2015/json/mobile_teams/nba/2024/scores/pbp/0022400001_full_pbp.json` | 143397 | `50df11f05ddb00d66f0714b2c0099450` |
| `0022500001_full_pbp.json.gz` | `https://data.nba.com/data/v2015/json/mobile_teams/nba/2025/scores/pbp/0022500001_full_pbp.json` | 184 | `7db9790147b4539d5d543bcbf97115fc` |

Game `0022500001` is the 2025-26 NBA opener (OKC 125, HOU 124; 707 actions; 18 and 17 players).
Game `2052500034` is a 2025-26 G League game (RAP 111, MNE 75; 595 actions; 14 and 13 players).

The two `_full_pbp` files come from data.nba.com (`nba_data_pbp()`), captured 2026-09-29 UTC
the same way. `0022400001` is the 2024-25 opener (462 plays). `0022500001` is the 2025-26 opener,
which data.nba.com serves as an empty shell (`pd: []`): it covers 2016-17 through 2024-25.

The two `0022500001` payloads are byte-identical to the sportsdataverse-py fixtures
`tests/nba/fixtures/nba_live/{playbyplay,boxscore}_0022500001.json`, apart from the trailing
newline those files add. Those were captured with curl_cffi's Chrome impersonation and live on
the sportsdataverse-py branch `feat/nba-officiating` at commit 5a050774a (unmerged as of
2026-09-27 UTC), not on its main branch.
