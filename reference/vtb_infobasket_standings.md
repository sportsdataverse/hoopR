# **Get VTB Infobasket Standings**

Standings of one stage (a round-robin stage such as the regular season),
one row per team.

Endpoint:
`GET https://org.infobasket.su/Widget/CompTeamResults/{comp_id}`

## Usage

``` r
vtb_infobasket_standings(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_standings(comp_id = 50720))
#> ── VTB Infobasket Standings from org.infobasket.su ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:16:08 UTC
#> # A tibble: 11 × 28
#>    comp_id comp_team_id team_id place start_place games   won  lost
#>      <int>        <int>   <int> <int>       <int> <int> <int> <int>
#>  1   50720       450736      15     1          11    40    37     3
#>  2   50720       450734     697     2           9    40    33     7
#>  3   50720       450728    2994     3           4    40    28    12
#>  4   50720       450729    2650     4           5    40    27    13
#>  5   50720       450732    3059     5           2    40    22    18
#>  6   50720       450735    1390     6          10    40    19    21
#>  7   50720       450730    2747     7           6    40    18    22
#>  8   50720       450727     688     8           3    40    15    25
#>  9   50720       450731     468     9           7    40    12    28
#> 10   50720       450726     682    10           1    40     7    33
#> 11   50720       450733    2792    11           8    40     2    38
#> # ℹ 20 more variables: standing_game <int>, standing_win <int>,
#> #   standing_draw <chr>, standing_lose <int>, standing_forfeit <int>,
#> #   standing_points <int>, standing_goal_plus <int>, standing_goal_minus <int>,
#> #   standing_goal_difference <int>, standing_penalty <int>,
#> #   standing_is_play <lgl>, victory_percent <dbl>, avg_goal_plus <dbl>,
#> #   avg_goal_minus <dbl>, team_short_name_ru <chr>, team_short_name_en <chr>,
#> #   team_name_ru <chr>, team_name_en <chr>, team_region_name_ru <chr>, …
# }
```
