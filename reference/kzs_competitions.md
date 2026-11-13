# **Get KZS Competitions**

Competitions of a season (leagues, cups, youth, 3x3, national teams), or
of every season.

Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/`

## Usage

``` r
kzs_competitions(season = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque
  season id. Omitted = every season (627 competitions).

## Value

A `hoopR_data` tibble with one row per competition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_competitions")`) and in the
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
  try(kzs_competitions(season = 2026))
#> ── KZS Competitions from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:52:11 UTC
#> # A tibble: 44 × 11
#>    competition_id name               gender category rank  season_id season_name
#>             <int> <chr>              <chr>  <chr>    <chr>     <int> <chr>      
#>  1            579 Liga OTP banka     MALE   ABSOLUTE FIRST        26 2025/2026  
#>  2            553 Pripravljalne tek… MALE   ABSOLUTE FIRST        26 2025/2026  
#>  3            585 1. Ž SKL           FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  4            546 Pripravljalne tek… FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  5            581 2. SKL             MALE   ABSOLUTE SECO…        26 2025/2026  
#>  6            582 3. SKL             MALE   ABSOLUTE THIRD        26 2025/2026  
#>  7            583 4. SKL             MALE   ABSOLUTE FOUR…        26 2025/2026  
#>  8            584 Pokal Spar         MALE   ABSOLUTE TOUR…        26 2025/2026  
#>  9            580 Superpokal         MALE   ABSOLUTE TOUR…        26 2025/2026  
#> 10            586 Pokal članice      FEMALE ABSOLUTE TOUR…        26 2025/2026  
#> # ℹ 34 more rows
#> # ℹ 4 more variables: season_is_active <lgl>, season_active <lgl>, type <chr>,
#> #   season <int>
# }
```
