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

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_game_summary(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Summary from basketligaen.dk ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:08:44 UTC
#> # A tibble: 1 × 7
#>   team_head2_head  team_period_caption team_period_overtime team_period_shootout
#>   <chr>            <chr>               <lgl>                <lgl>               
#> 1 "[{\"awayTeam\"… G                   FALSE                FALSE               
#> # ℹ 3 more variables: team_period_stats <chr>, best_scorers <chr>,
#> #   statistics_provider <chr>
# }
```
