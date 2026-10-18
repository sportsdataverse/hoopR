# **Get the P. LEAGUE+ Team Crosswalk**

P. LEAGUE+ site `team_id` (1-8) to Preciser team uuid, for every club
ever listed. The site's `team_id` is stable across seasons and renames;
the vendor keys teams by uuid (`team_uuid` / `home_team_uuid` /
`away_team_uuid` of the `pleague_preciser_*()` frames). Persons need no
table: the Preciser `person_id` is the site box row's `person_id`. A
constant table: no request is made.

## Usage

``` r
pleague_team_crosswalk()
```

## Value

A `hoopR_data` tibble of eight rows (sdv-py `pleague_team_crosswalk`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | P. LEAGUE+ site team id (1-8), stable across seasons and renames. |
| team_uuid | character | Preciser team uuid of the same club (team_uuid of the pleague_preciser frames). |

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
[`pleague_player()`](https://hoopR.sportsdataverse.org/reference/pleague_player.md),
[`pleague_player_seasons()`](https://hoopR.sportsdataverse.org/reference/pleague_player_seasons.md),
[`pleague_preciser_injury()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_injury.md),
[`pleague_preciser_lead_flow()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_lead_flow.md),
[`pleague_preciser_rotation()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_rotation.md),
[`pleague_preciser_score_log()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_score_log.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md)

## Examples

``` r
# \donttest{
  pleague_team_crosswalk()
#> ── P. LEAGUE+ Team Crosswalk ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:45:20 UTC
#> # A tibble: 8 × 2
#>   team_id team_uuid                           
#>     <int> <chr>                               
#> 1       1 e86394aa-3d88-11ed-8ba8-7f44ba46b0b1
#> 2       2 e865bb20-3d88-11ed-a956-7f44ba46b0b1
#> 3       3 e8674343-3d88-11ed-98b4-7f44ba46b0b1
#> 4       4 e869743f-3d88-11ed-925e-7f44ba46b0b1
#> 5       5 e86cac11-3d88-11ed-8637-7f44ba46b0b1
#> 6       6 e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1
#> 7       7 3c3a601a-358a-11ed-ab92-711c34ed1298
#> 8       8 bf957f5a-9389-11f0-812c-a38482ec4d30
# }
```
