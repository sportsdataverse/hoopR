# **Get EASL Seasons**

Every configured EASL season (the four editions 2023-24 to 2026-27) with
its DataCore season id and END year.

Endpoint: `GET https://easl.joshricha.com/api/v1/metadata/seasons`

## Usage

``` r
easl_seasons()
```

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_seasons")`) and in the searchable
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
  try(easl_seasons())
#> ── EASL Seasons from easl.joshricha.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:53:06 UTC
#> # A tibble: 4 × 20
#>   season season_id        season_row_id  year name  name_latin status start_date
#>    <int> <chr>                    <int> <int> <chr> <chr>      <chr>  <date>    
#> 1   2027 1409787d-a683-1…             1  2026 EASL… NA         ACTIVE 2026-10-03
#> 2   2025 57cefc32-5ace-1…             2  2024 EASL… EASL 24-25 COMPL… 2024-10-02
#> 3   2026 77441bb3-9759-1…             3  2025 EASL… NA         COMPL… 2025-10-08
#> 4   2024 c24ce68a-6420-1…             4  2023 EASL… NA         COMPL… 2023-10-11
#> # ℹ 12 more variables: end_date <date>, competition_id <chr>, profile_id <chr>,
#> #   organization_id <chr>, age_group <chr>, event_type <chr>, gender <chr>,
#> #   representation <chr>, season_type <chr>, standard <chr>, created_at <chr>,
#> #   updated_at <chr>
# }
```
