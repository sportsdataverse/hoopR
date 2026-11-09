# **Get TPBL Game**

Header of one finished game: teams with scores, venue, status, quarters,
tip-off, attendance and links.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}`

## Usage

``` r
tpbl_game(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_game")`) and in the searchable
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
  try(tpbl_game(game_id = 6))
#> ── TPBL Game from api.tpbl.basketball ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:17:25 UTC
#> # A tibble: 1 × 34
#>   season season_id game_id gohoops_game_id division_id gohoops_division_id
#>    <int>     <int>   <int>           <int>       <int>               <int>
#> 1     NA        NA       6            1242           1                  64
#> # ℹ 28 more variables: gohoops_season_id <int>, gohoops_event_id <int>,
#> #   code <chr>, status <chr>, is_live <lgl>, periods <int>, game_date <date>,
#> #   game_day_of_week <chr>, game_time <chr>, tipoff <dttm>, venue <chr>,
#> #   attendance <int>, home_team_id <int>, home_gohoops_team_id <int>,
#> #   home_gohoops_squad_id <int>, home_team <chr>, home_alt_name <chr>,
#> #   home_score <int>, away_team_id <int>, away_gohoops_team_id <int>,
#> #   away_gohoops_squad_id <int>, away_team <chr>, away_alt_name <chr>, …
# }
```
