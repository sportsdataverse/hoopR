# **Get TPBL Player Box Score**

Whole-game box score lines of every player on either team sheet, keyed
by GoHoops roster id.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_players(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_box_players")`) and in the
searchable [return
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
  try(tpbl_box_players(game_id = 6))
#> ── TPBL Player Box Score from api.tpbl.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:18:07 UTC
#> # A tibble: 35 × 137
#>    game_id side  team_id team       gohoops_squad_id player_id gohoops_person_id
#>      <int> <chr>   <int> <chr>                 <int>     <int>             <int>
#>  1       6 home        4 新竹御嵿攻城獅……             8211        72             70829
#>  2       6 home        4 新竹御嵿攻城獅……             8211        74             70831
#>  3       6 home        4 新竹御嵿攻城獅……             8211        76             70833
#>  4       6 home        4 新竹御嵿攻城獅……             8211        78             70835
#>  5       6 home        4 新竹御嵿攻城獅……             8211        80             70837
#>  6       6 home        4 新竹御嵿攻城獅……             8211        85             70843
#>  7       6 home        4 新竹御嵿攻城獅……             8211        96             70854
#>  8       6 home        4 新竹御嵿攻城獅……             8211        84             70842
#>  9       6 home        4 新竹御嵿攻城獅……             8211        87             70845
#> 10       6 home        4 新竹御嵿攻城獅……             8211        88             70846
#> # ℹ 25 more rows
#> # ℹ 130 more variables: gohoops_roster_id <int>, player <chr>, number <chr>,
#> #   position <chr>, status <chr>, roster_status <chr>, is_starting <lgl>,
#> #   entered <lgl>, time_on_court <int>, score <int>, plus_minus <int>,
#> #   field_goals_made <int>, field_goals_missed <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   two_pointers_made <int>, two_pointers_missed <int>, …
# }
```
