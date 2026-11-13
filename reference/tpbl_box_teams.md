# **Get TPBL Team Box Score**

Whole-game team totals of both teams: shooting, rebounds, fouls,
assists, turnovers and paint points.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_teams(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_box_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tpbl_box_teams(game_id = 6))
#> ── TPBL Team Box Score from api.tpbl.basketball ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:40:08 UTC
#> # A tibble: 2 × 40
#>   game_id side  team_id team  gohoops_squad_id opponent_team_id field_goals_made
#>     <int> <chr>   <int> <chr>            <int>            <int>            <int>
#> 1       6 home        4 新竹御嵿…             8211                8               47
#> 2       6 away        8 臺北台新…             8215                4               42
#> # ℹ 33 more variables: field_goals_missed <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, two_pointers_made <int>,
#> #   two_pointers_missed <int>, two_pointers_attempted <int>,
#> #   two_pointers_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_missed <int>, three_pointers_attempted <int>,
#> #   three_pointers_percentage <dbl>, free_throws_made <int>,
#> #   free_throws_missed <int>, free_throws_attempted <int>, …
# }
```
