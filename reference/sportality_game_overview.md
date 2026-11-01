# **Get Basketligaen Game Overview**

Score, state, clock and the Genius ids of one game (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/game-overview/{game_uuid}`

## Usage

``` r
sportality_game_overview(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Score, state, clock and the Genius ids of one
game (2023/24 on). An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_game_overview`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
| home_team_game_source_id | integer | Genius match id (Genius key space; integer here). |
| home_team_game_id | integer | Genius match id (Genius key space; the same number as gameSourceId). |
| home_team_team_id | integer | Genius team id of the home team (Genius key space; Int64). |
| home_team_team_name | character | Name of the home team. |
| home_team_team_code | character | Home team code as Genius spells it (mixed case, 'Hol'). |
| home_team_team_number | integer | Team number in the game; home is 1. |
| home_team_place | character | home. Values: `home` = home team. |
| home_team_instance_id | character | Site instance id of the home club (platform key space). |
| home_team_source | character | Feed that produced the row (genius-basketball-stream-reader). |
| home_team_game_uuid | character | Game uuid (platform key space). |
| away_team_game_source_id | integer | Genius match id (Genius key space; integer here). |
| away_team_game_id | integer | Genius match id (Genius key space; the same number as gameSourceId). |
| away_team_team_id | integer | Genius team id of the away team (Genius key space; Int64). |
| away_team_team_name | character | Name of the away team. |
| away_team_team_code | character | Away team code as Genius spells it. |
| away_team_team_number | integer | Team number in the game; away is 2. |
| away_team_place | character | away. Values: `away` = away team. |
| away_team_instance_id | character | Site instance id of the away club (platform key space). |
| away_team_source | character | Feed that produced the row (genius-basketball-stream-reader). |
| away_team_game_uuid | character | Game uuid (platform key space). |
| home_goals | integer | Points scored by the home team. |
| away_goals | integer | Points scored by the away team. |
| state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `GameEnded` = played (gameday overview). |
| time_game_id | integer | Genius match id (Genius key space). |
| time_period | integer | Period number the clock stands in (1-4 regulation, 5+ overtime). |
| time_period_time | character | Clock remaining in the period, 'hh:mm:ss' ('00:00:00' once the period or game is over). |
| time_instance_id | character | Site instance that owns the feed (platform key space; dbl1_dbl). |
| time_source | character | Feed that produced the row (genius-basketball-stream-reader). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
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

## Examples

``` r
# \donttest{
  try(sportality_game_overview(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Overview from basketligaen.dk ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:44:25 UTC
#> # A tibble: 1 × 29
#>   game_uuid  home_team_game_source_id home_team_game_id home_team_team_id
#>   <chr>                         <int>             <int>             <int>
#> 1 c4hh5nig6t                  2868126           2868126            153747
#> # ℹ 25 more variables: home_team_team_name <chr>, home_team_team_code <chr>,
#> #   home_team_team_number <int>, home_team_place <chr>,
#> #   home_team_instance_id <chr>, home_team_source <chr>,
#> #   home_team_game_uuid <chr>, away_team_game_source_id <int>,
#> #   away_team_game_id <int>, away_team_team_id <int>,
#> #   away_team_team_name <chr>, away_team_team_code <chr>,
#> #   away_team_team_number <int>, away_team_place <chr>, …
# }
```
