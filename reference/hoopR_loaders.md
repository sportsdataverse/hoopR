# **hoopR Data Loaders Overview**

Loaders for full seasons of pre-scraped data from the
`sportsdataverse/hoopR-{nba,mbb}-data` releases on
`sportsdataverse-data`. Each helper validates the requested seasons,
builds the per-asset URLs, downloads in parallel (with optional
[progressr::progressr](https://progressr.futureverse.org/reference/progressr.html)
progress + optional `DBI` insertion), and tags the result with the
`hoopR_data` S3 class.

## Details

### **NBA loaders**

|  |  |
|----|----|
| Function | Asset family |
| [`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md) | NBA play-by-play |
| [`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md) | NBA player boxscores |
| [`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md) | NBA team boxscores |
| [`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md) | NBA schedule |
| [`update_nba_db()`](https://hoopR.sportsdataverse.org/reference/update_nba_db.md) | Delta loader -\> DB |

### **MBB loaders**

|  |  |
|----|----|
| Function | Asset family |
| [`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md) | Men's college basketball PBP |
| [`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md) | MBB player boxscores |
| [`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md) | MBB team boxscores |
| [`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md) | MBB schedule |
| [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md) | Delta loader -\> DB |
