# **Get VTB Infobasket Playoff**

Playoff bracket of a playoff stage, one row per series.

Endpoint: `GET https://org.infobasket.su/Widget/PlayOff/{comp_id}`

## Usage

``` r
vtb_infobasket_playoff(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble with one row per series. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_playoff")`) and in the
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
  try(vtb_infobasket_playoff(comp_id = 54281))
#> ── VTB Infobasket Playoff from org.infobasket.su ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:20:36 UTC
#> # A tibble: 8 × 25
#>   comp_id  tree round is_current_round  sort round_name_ru  round_name_en score1
#>     <int> <int> <int> <lgl>            <int> <chr>          <chr>          <int>
#> 1   54281     1     4 FALSE                1 1/4 финала     1/4 finals         3
#> 2   54281     1     4 FALSE                2 1/4 финала     1/4 finals         3
#> 3   54281     1     4 FALSE                3 1/4 финала     1/4 finals         3
#> 4   54281     1     4 FALSE                4 1/4 финала     1/4 finals         3
#> 5   54281     1     2 FALSE                1 1/2 финала     1/2 finals         4
#> 6   54281     1     2 FALSE                2 1/2 финала     1/2 finals         4
#> 7   54281     1     1 TRUE                 1 Финал          Final              4
#> 8   54281     2     1 TRUE                 2 Финал за 3 ме… Final for 3        2
#> # ℹ 17 more variables: score2 <int>, is_final <lgl>, winner <int>,
#> #   team1_id <int>, team1_short_name_ru <chr>, team1_short_name_en <chr>,
#> #   team1_name_ru <chr>, team1_name_en <chr>, team1_region_name_ru <chr>,
#> #   team1_region_name_en <chr>, team2_id <int>, team2_short_name_ru <chr>,
#> #   team2_short_name_en <chr>, team2_name_ru <chr>, team2_name_en <chr>,
#> #   team2_region_name_ru <chr>, team2_region_name_en <chr>
# }
```
