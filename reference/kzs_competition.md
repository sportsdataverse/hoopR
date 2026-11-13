# **Get KZS Competition**

One competition: season, gender, category, rank and type (its phases are
kzs_phases).

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`

## Usage

``` r
kzs_competition(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble with one row per competition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_competition")`) and in the
searchable [return
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
  try(kzs_competition(competition_id = 579))
#> ── KZS Competition from api.kzs.si ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:52:10 UTC
#> # A tibble: 1 × 12
#>   competition_id name       season_id season_name season_is_active season_active
#>            <int> <chr>          <int> <chr>       <lgl>            <lgl>        
#> 1            579 Liga OTP …        26 2025/2026   FALSE            FALSE        
#> # ℹ 6 more variables: gender <chr>, category <chr>, rank <chr>, type <chr>,
#> #   season <int>, social_medias <chr>
# }
```
