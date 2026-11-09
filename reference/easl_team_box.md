# **Get EASL Team Box Score**

Team totals of a finished game, one row per team, with the opponent's
totals as `*_against` columns.

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/teamstats`

## Usage

``` r
easl_team_box(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_team_box")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_team_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Team Box Score from easl.joshricha.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:24 UTC
#> # A tibble: 2 × 105
#>   fixture_id          team_id team_name team_name_native assists assists_against
#>   <chr>               <chr>   <chr>     <chr>              <int>           <int>
#> 1 10af8fd4-106e-11f1… 865489… Utsunomi… 宇都宮ブレックス      19              24
#> 2 10af8fd4-106e-11f1… f17004… Taoyuan … Taoyuan Pauian …      24              19
#> # ℹ 99 more variables: assists_defensive <int>, assists_turnover_ratio <dbl>,
#> #   biggest_lead <int>, biggest_scoring_run <int>, blocks <int>,
#> #   blocks_received <int>, dunks <int>, efficiency <int>,
#> #   efficiency_custom <int>, field_goals_attempted <int>,
#> #   field_goals_attempted_against <int>,
#> #   field_goals_effective_percentage <dbl>, field_goals_made <int>,
#> #   field_goals_made_against <int>, field_goals_percentage <dbl>, …
# }
```
