# **Get LBA Game**

Game header: teams, venue, quarter scores, coaches, referees and
broadcasters.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-by-id`
(`sc=1&id=<game_id>`)

## Usage

``` r
lba_game(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_game")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_game(game_id = 25602))
#> ── LBA Game from legabasket.it ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:17:02 UTC
#> # A tibble: 1 × 62
#>   season game_id game_status championship_id competition_name      
#>    <int>   <int> <chr>                 <int> <chr>                 
#> 1   2027   25602 2                       602 Regular Season 2026/27
#> # ℹ 57 more variables: championships_day_id <int>, year <int>, number <int>,
#> #   match_datetime <chr>, match_hh <int>, match_mm <int>, target_score <chr>,
#> #   home_final_score <int>, visitor_final_score <int>, q1_hs <int>,
#> #   q1_vs <int>, q2_hs <int>, q2_vs <int>, q3_hs <int>, q3_vs <int>,
#> #   q4_hs <int>, q4_vs <int>, ot_hs <int>, ot_vs <int>, home_coach_id <int>,
#> #   home_coach_code <chr>, home_coach_fullname <chr>, visitor_coach_id <int>,
#> #   visitor_coach_code <chr>, visitor_coach_fullname <chr>, …
# }
```
