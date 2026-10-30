# release_ids fixtures

A few real rows (column subset) of `sportsdataverse/sportsdataverse-data`
release assets, downloaded 2026-10-30. Used by `test-load_release_ids.R`,
which mocks the release readers onto these files so the tests stay offline.

| file | release tag / asset | rows kept |
|---|---|---|
| `game_rosters_2026.rds` | `espn_mens_college_basketball_game_rosters/game_rosters_2026.rds` | first 3; `game_id` is character in the asset |
| `mbb_schedule_2026.rds` | `espn_mens_college_basketball_schedules/mbb_schedule_2026.rds` | the games in `game_rosters_2026.rds` |
| `rosters_2026.rds` | `espn_mens_college_basketball_rosters/rosters_2026.rds` | first 3; `athlete_id` is character in the asset |
| `mbb_schedule_crosswalk_2026.rds` | `mbb_crosswalk/mbb_schedule_crosswalk_2026.rds` | first 3; `espn_game_id` is character |
| `mbb_player_crosswalk_2026.rds` | `mbb_crosswalk/mbb_player_crosswalk_2026.rds` | first 3; `espn_athlete_id` is character |
| `ncaa_mbb_team_box_2026.rds` | `ncaa_mbb_team_box/ncaa_mbb_team_box_2026.rds` | first 3; `espn_*` ids are character |
| `play_by_play_2025.rds` / `.parquet` | `espn_mens_college_basketball_pbp/play_by_play_2025.{rds,parquet}` | 4 plays of game 401700174 whose 18-digit ids (…828001-…828004, exact in the parquet's int64) all round to 401700174101828032 in the rds double |

The `.rds` files are gzip-compressed (`saveRDS(compress = TRUE)`), as the
release assets are.
