# **Get KZS Standings**

Standings of a competition, one row per team in each phase (and group).

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/standings`

## Usage

``` r
kzs_standings(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble with one row per team in each phase. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_standings(competition_id = 579))
#> ── KZS Standings from api.kzs.si ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:14:25 UTC
#> # A tibble: 24 × 25
#>    competition_id phase_id phase_name phase_type group_id group_name position
#>             <int>    <int> <chr>      <chr>         <int> <chr>         <int>
#>  1            579     5811 Redni del  GROUP            NA NA                1
#>  2            579     5811 Redni del  GROUP            NA NA                2
#>  3            579     5811 Redni del  GROUP            NA NA                3
#>  4            579     5811 Redni del  GROUP            NA NA                4
#>  5            579     5811 Redni del  GROUP            NA NA                5
#>  6            579     5811 Redni del  GROUP            NA NA                6
#>  7            579     5811 Redni del  GROUP            NA NA                7
#>  8            579     5811 Redni del  GROUP            NA NA                8
#>  9            579     5811 Redni del  GROUP            NA NA                9
#> 10            579     5811 Redni del  GROUP            NA NA               10
#> # ℹ 14 more rows
#> # ℹ 18 more variables: team_id <int>, team_name <chr>, club_code <chr>,
#> #   logo_uuid <chr>, games_played <int>, won <int>, lost <int>, pts_plus <int>,
#> #   pts_minus <int>, home_won <int>, home_lost <int>, away_won <int>,
#> #   away_lost <int>, points <int>, draws <int>, lost_points <int>,
#> #   tie_break_position <int>, pts_difference <int>
# }
```
