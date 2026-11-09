# **Get ESPN MBB Calendar**

**Get ESPN MBB Calendar**

**Get ESPN Women's College Basketball Calendar**

**Get ESPN NBA Calendar**

**Get ESPN NBA Calendar**

## Usage

``` r
espn_mbb_calendar(season = most_recent_mbb_season())

espn_nba_calendar(season = most_recent_nba_season())
```

## Arguments

- season:

  integer or character. Four-digit season year (e.g. `2025`). Defaults
  to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

Returns a tibble of calendar entries.

Columns as documented in the shared
[espn_mbb_calendar_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar_schema.md)
table.

Returns a tibble of calendar entries.

Columns as documented in the shared
[espn_mbb_calendar_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar_schema.md)
table.

## Details

Retrieve the ESPN women's college basketball schedule calendar for a
given season. The underlying scoreboard response contains a
`leagues[[1]]$calendar` block with season-type entries (pre-season,
regular, post). Uses `getOption("hoopR.proxy")` or
`http_proxy`/`https_proxy` environment variables for proxy configuration
(per-call proxy override is not supported for ESPN wrappers).

Retrieve the ESPN NBA schedule calendar for a given season. The
underlying scoreboard response contains a `leagues[[1]]$calendar` block
with season-type entries (pre-season, regular, post). Uses
`getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
variables for proxy configuration (per-call proxy override is not
supported for ESPN wrappers).

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_calendar(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Calendar from ESPN.com ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:03:38 UTC
#> # A tibble: 131 × 12
#>    season season_type season_type_label season_start_date season_end_date  
#>    <chr>  <chr>       <chr>             <chr>             <chr>            
#>  1 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  2 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  3 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  4 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  5 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  6 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  7 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  8 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#>  9 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#> 10 2025   NA          NA                2024-07-13T07:00Z 2025-04-09T06:59Z
#> # ℹ 121 more rows
#> # ℹ 7 more variables: calendar_type <chr>, label <chr>, alternate_label <chr>,
#> #   detail <chr>, value <chr>, start_date <chr>, end_date <chr>
# }
# \donttest{
  espn_nba_calendar(season = 2025)
#> ── ESPN NBA Calendar from ESPN.com ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:03:39 UTC
#> # A tibble: 230 × 12
#>    season season_type season_type_label season_start_date season_end_date  
#>    <chr>  <chr>       <chr>             <chr>             <chr>            
#>  1 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  2 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  3 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  4 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  5 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  6 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  7 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  8 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#>  9 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#> 10 2025   NA          NA                2024-09-24T07:00Z 2025-06-27T06:59Z
#> # ℹ 220 more rows
#> # ℹ 7 more variables: calendar_type <chr>, label <chr>, alternate_label <chr>,
#> #   detail <chr>, value <chr>, start_date <chr>, end_date <chr>
# }
```
