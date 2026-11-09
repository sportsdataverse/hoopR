# **Get ESPN Women's College Basketball Season Info**

**Get ESPN Women's College Basketball Season Info**

**Get ESPN Women's College Basketball Season Info**

**Get ESPN NBA Season Info**

**Get ESPN NBA Season Info**

## Usage

``` r
espn_mbb_season_info(season = most_recent_mbb_season(), ...)

espn_nba_season_info(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of `hoopR_data` tibbles: `Info`, `Types`, `Athletes`,
`Coaches`, `Teams`, `Awards`.

**Info**

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| year         | integer   | 4-digit year.              |
| start_date   | character | Start date (YYYY-MM-DD).   |
| end_date     | character | End date (YYYY-MM-DD).     |
| display_name | character | Display name.              |
| type_id      | character | Type identifier (numeric). |
| type_name    | character |                            |

**Types / Athletes / Coaches / Teams / Awards**

|          |           |                 |
|----------|-----------|-----------------|
| col_name | types     | description     |
| count    | integer   | Count of count. |
| ref      | character |                 |

`Types`, `Athletes`, `Coaches`, `Teams` and `Awards` share the second
table. `$ref` URL components are returned as character columns and are
NOT auto-resolved – use targeted endpoint functions for details.

A named list of `hoopR_data` tibbles: `Info`, `Types`, `Athletes`,
`Coaches`, `Teams`, `Awards`.

**Info**

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| year         | integer   | 4-digit year.              |
| start_date   | character | Start date (YYYY-MM-DD).   |
| end_date     | character | End date (YYYY-MM-DD).     |
| display_name | character | Display name.              |
| type_id      | character | Type identifier (numeric). |
| type_name    | character |                            |

**Types / Athletes / Coaches / Teams / Awards**

|          |           |                 |
|----------|-----------|-----------------|
| col_name | types     | description     |
| count    | integer   | Count of count. |
| ref      | character |                 |

`Types`, `Athletes`, `Coaches`, `Teams` and `Awards` share the second
table. `$ref` URL components are returned as character columns and are
NOT auto-resolved – use targeted endpoint functions for details.

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
  espn_mbb_season_info(season = 2025)
#> $Info
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Info from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 6
#>    year start_date        end_date          display_name type_id type_name 
#>   <int> <chr>             <chr>             <chr>        <chr>   <chr>     
#> 1  2025 2024-07-13T07:00Z 2025-04-09T06:59Z 2024-25      3       Postseason
#> 
#> $Types
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Types from ESPN.com ────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1     4 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-colle…
#> 
#> $Athletes
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Athletes from ESPN.com ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1    NA http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-colle…
#> 
#> $Coaches
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Coaches from ESPN.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Teams
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Teams from ESPN.com ────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Awards
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Awards from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1    NA http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-colle…
#> 
# }
# \donttest{
  espn_nba_season_info(season = 2025)
#> $Info
#> ── ESPN NBA Season Info from ESPN.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 6
#>    year start_date        end_date          display_name type_id type_name     
#>   <int> <chr>             <chr>             <chr>        <chr>   <chr>         
#> 1  2025 2024-09-24T07:00Z 2025-06-27T06:59Z 2024-25      2       Regular Season
#> 
#> $Types
#> ── ESPN NBA Season Types from ESPN.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1     5 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/season…
#> 
#> $Athletes
#> ── ESPN NBA Season Athletes from ESPN.com ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Coaches
#> ── ESPN NBA Season Coaches from ESPN.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Teams
#> ── ESPN NBA Season Teams from ESPN.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Awards
#> ── ESPN NBA Season Awards from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:34 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1    NA http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/season…
#> 
# }
```
