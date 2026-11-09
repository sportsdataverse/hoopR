# **Get EASL Schedule**

Every fixture of one season: status, tip-off, stage, pool, venue and
both teams with their scores.

Endpoint: `GET https://easl.joshricha.com/api/v1/matches`

## Usage

``` r
easl_schedule(season = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_schedule")`) and in the searchable
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
  try(easl_schedule(season = 2026))
#> ── EASL Schedule from easl.joshricha.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:16 UTC
#> # A tibble: 42 × 44
#>    season season_id   fixture_id fixture_number fixture_type status fixture_name
#>     <int> <chr>       <chr>               <int> <chr>        <chr>  <chr>       
#>  1   2026 77441bb3-9… 10af8fd4-…        2526042 FINAL        CONFI… EASL Champi…
#>  2   2026 77441bb3-9… fed1d9e9-…        2526041 FINAL        CONFI… Third-Place…
#>  3   2026 77441bb3-9… c050a9ab-…        2526040 PLAYOFF      CONFI… Semifinals 2
#>  4   2026 77441bb3-9… 9b6a67ec-…        2526039 PLAYOFF      CONFI… Semifinals 1
#>  5   2026 77441bb3-9… b7b2d03c-…        2526038 PLAYOFF      CONFI… Quarterfina…
#>  6   2026 77441bb3-9… 919bd7cc-…        2526037 PLAYOFF      CONFI… Quarterfina…
#>  7   2026 77441bb3-9… 4841a0de-…        2526035 REGULAR      CONFI… NA          
#>  8   2026 77441bb3-9… 63129de2-…        2526036 REGULAR      CONFI… NA          
#>  9   2026 77441bb3-9… 25c39958-…        2526034 REGULAR      CONFI… NA          
#> 10   2026 77441bb3-9… be4c5140-…        2526031 REGULAR      CONFI… NA          
#> # ℹ 32 more rows
#> # ℹ 37 more variables: start_time_utc <chr>, start_time_local <chr>,
#> #   attendance <int>, live_data_available <lgl>, live_video_available <lgl>,
#> #   pool_code <chr>, pool_id <chr>, pool_name <chr>, pool_abb <chr>,
#> #   stage_id <chr>, stage_code <chr>, stage_name <chr>, stage_order <int>,
#> #   venue_name <chr>, venue_name_latin <chr>, venue_abbreviation_latin <chr>,
#> #   venue_abbreviation_local <chr>, venue_alternate_name_latin <chr>, …
# }
```
