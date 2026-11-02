# **Get Basketligaen Game Summary**

Points per period, team comparison and best scorers (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/game-info/{game_uuid}`

## Usage

``` r
sportality_game_summary(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Points per period, team comparison and best
scorers (2023/24 on). An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_game_summary`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_head2_head | character | Team comparison rows (2P, 3P, FT, rebounds, ...), home and away side by side. |
| team_period_caption | character | Column caption of the table (G = goals/points). Values: `G` = goals/points column. |
| team_period_overtime | logical | Whether the game went to overtime. |
| team_period_shootout | logical | Whether the game was decided by a shootout (false). |
| team_period_stats | character | One row per period. |
| best_scorers | character | The game's top scorers, one per side (or the two best). |
| statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |

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
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
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
  try(sportality_game_summary(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Summary from basketligaen.dk ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:56:31 UTC
#> # A tibble: 1 × 7
#>   team_head2_head  team_period_caption team_period_overtime team_period_shootout
#>   <chr>            <chr>               <lgl>                <lgl>               
#> 1 "[{\"awayTeam\"… G                   FALSE                FALSE               
#> # ℹ 3 more variables: team_period_stats <chr>, best_scorers <chr>,
#> #   statistics_provider <chr>
# }
```
