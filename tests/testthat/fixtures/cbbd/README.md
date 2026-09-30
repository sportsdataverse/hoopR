# CollegeBasketballData (CBD) fixtures

Real payloads for the offline wrapper tests in `tests/testthat/test-cbbd_teams.R`, stored
gzipped. Each was captured on 2026-09-30 UTC (CBD API v1.29.0) with curl 7.68.0 and a
`Authorization: Bearer <CBBD_API_KEY>` header. The bytes are the unmodified response body.

| File | URL | JSON bytes | md5 of the JSON |
|---|---|---:|---|
| `teams_directory_2025.json.gz` | `https://api.collegebasketballdata.com/teams/directory?season=2025` | 66772 | `b4241e4eb97cb76b8fa70b9a5bda59b7` |
| `teams_season_overview_72_2025.json.gz` | `https://api.collegebasketballdata.com/teams/72/season/2025/overview` | 33273 | `caa4b7b659cecae7fdc1b45a8a3b7d3e` |

The directory is the 2024-25 season: 364 teams, 31 conferences. Team `72` is Duke; its
2024-25 overview has 15 players, 39 games and 3 shot buckets.
