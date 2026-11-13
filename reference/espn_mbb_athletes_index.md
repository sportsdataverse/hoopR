# **Get ESPN Women's College Basketball Athletes Index**

**Get ESPN Women's College Basketball Athletes Index**

**Get ESPN Women's College Basketball Athletes Index**

**Get ESPN NBA Athletes Index**

**Get ESPN NBA Athletes Index**

## Usage

``` r
espn_mbb_athletes_index(
  season = most_recent_mbb_season(),
  active = TRUE,
  limit = 25000L,
  ...
)

espn_nba_athletes_index(
  season = most_recent_nba_season(),
  active = TRUE,
  limit = 5000L,
  ...
)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- active:

  logical. When `TRUE` (default) only active athletes are returned. Set
  to `FALSE` for the full historical roster.

- limit:

  integer. Maximum number of rows to return. Default 25000. MBB can
  return 6,000-12,000 athletes per season; increase if needed. Pass a
  small value (e.g. `limit = 50`) in tests to keep execution fast.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per athlete.

|            |           |                                         |
|------------|-----------|-----------------------------------------|
| col_name   | types     | description                             |
| athlete_id | character | Unique athlete identifier (ESPN).       |
| full_name  | character | Player's full name.                     |
| jersey     | character | Jersey number worn by the player.       |
| position   | character | Listed roster position (G, F, C, etc.). |
| team_id    | character | Unique team identifier.                 |
| headshot   | character | Headshot image URL.                     |
| status     | character | Status label.                           |
| link       | character |                                         |

A `hoopR_data` tibble with one row per athlete.

|            |           |                                         |
|------------|-----------|-----------------------------------------|
| col_name   | types     | description                             |
| athlete_id | character | Unique athlete identifier (ESPN).       |
| full_name  | character | Player's full name.                     |
| jersey     | character | Jersey number worn by the player.       |
| position   | character | Listed roster position (G, F, C, etc.). |
| team_id    | character | Unique team identifier.                 |
| headshot   | character | Headshot image URL.                     |
| status     | character | Status label.                           |
| link       | character |                                         |

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
  espn_mbb_athletes_index(season = 2025, limit = 50)
#> Fetching page 1 of 1 for mens-college-basketball athletes (season=2025)...
#> ── ESPN MENS-COLLEGE-BASKETBALL Athletes Index from ESPN.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:57:30 UTC
#> # A tibble: 50 × 9
#>    athlete_id full_name jersey position team_id headshot status link     ref_url
#>    <chr>      <chr>     <chr>  <chr>    <chr>   <chr>    <chr>  <chr>    <chr>  
#>  1 2571       NA        NA     NA       NA      NA       NA     http://… http:/…
#>  2 23574      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  3 50600      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  4 71520      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  5 71896      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  6 71897      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  7 71898      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  8 71899      NA        NA     NA       NA      NA       NA     http://… http:/…
#>  9 71900      NA        NA     NA       NA      NA       NA     http://… http:/…
#> 10 71901      NA        NA     NA       NA      NA       NA     http://… http:/…
#> # ℹ 40 more rows
# }
# \donttest{
  espn_nba_athletes_index(season = 2025, limit = 50)
#> Fetching page 1 of 1 for nba athletes (season=2025)...
#> ── ESPN NBA Athletes Index from ESPN.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:57:30 UTC
#> # A tibble: 50 × 9
#>    athlete_id full_name jersey position team_id headshot status link     ref_url
#>    <chr>      <chr>     <chr>  <chr>    <chr>   <chr>    <chr>  <chr>    <chr>  
#>  1 4431679    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  2 5142620    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  3 6576       NA        NA     NA       NA      NA       NA     http://… http:/…
#>  4 2991235    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  5 4066261    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  6 4397018    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  7 4593815    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  8 4684682    NA        NA     NA       NA      NA       NA     http://… http:/…
#>  9 5176517    NA        NA     NA       NA      NA       NA     http://… http:/…
#> 10 4683730    NA        NA     NA       NA      NA       NA     http://… http:/…
#> # ℹ 40 more rows
# }
```
