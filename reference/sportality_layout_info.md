# **Get Basketligaen Layout Info (ssgt Directory)**

Directory of every ssgt (season + series + game type) with its teams,
and the stats modules.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/layout-info`

## Usage

``` r
sportality_layout_info()
```

## Value

A `hoopR_data` tibble: Directory of every ssgt (season + series + game
type) with its teams, and the stats modules. An empty valid answer
raises `hoopR_no_data`; the documented columns come first, in this order
(sportsdataverse-py `sportality_layout_info`), then any column the API
added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025/26). |
| season_code | character | Provider season code: the START year (2025 = 2025/26). |
| season_name | character | Season name as 'YYYY/YYYY' (start/end year). |
| game_type | character | Game type of the game (” on every line seen). |
| game_type_name | character | Game type name in Danish (Grundspil = regular season, Slutspil = playoffs). |
| series_code | character | Series code (DBL = Basketligaen). |
| ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
| state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `active` = current ssgt; `closed` = past ssgt. |
| season_uuid | character | Season uuid (platform key space). |
| series_uuid | character | Series uuid (platform key space). |
| game_type_uuid | character | Game type uuid (platform key space). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_layout_info()

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)
