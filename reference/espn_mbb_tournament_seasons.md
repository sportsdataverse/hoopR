# **Get ESPN MBB Tournament Seasons List**

Returns the seasons in which a given MBB tournament was held.

Returns the seasons in which a given NBA tournament was held.

## Usage

``` r
espn_mbb_tournament_seasons(tournament_id, ...)

espn_nba_tournament_seasons(tournament_id, ...)
```

## Arguments

- tournament_id:

  ESPN tournament identifier.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per season.

|               |           |                                  |
|---------------|-----------|----------------------------------|
| col_name      | types     | description                      |
| league        | character | League slug.                     |
| tournament_id | character | ESPN tournament identifier.      |
| season        | integer   | Season year.                     |
| ref           | character | Full `$ref` URL for that season. |

A `hoopR_data` tibble with one row per season.

|               |           |                                  |
|---------------|-----------|----------------------------------|
| col_name      | types     | description                      |
| league        | character | League slug (`"nba"`).           |
| tournament_id | character | ESPN tournament identifier.      |
| season        | integer   | Season year.                     |
| ref           | character | Full `$ref` URL for that season. |

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
  espn_mbb_tournament_seasons(tournament_id = 3)
#> ── ESPN MENS-COLLEGE-BASKETBALL Tournament Seasons ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:42 UTC
#> # A tibble: 14 × 4
#>    league                  tournament_id season ref                             
#>    <chr>                   <chr>          <int> <chr>                           
#>  1 mens-college-basketball 3               2009 http://sports.core.api.espn.com…
#>  2 mens-college-basketball 3               2010 http://sports.core.api.espn.com…
#>  3 mens-college-basketball 3               2011 http://sports.core.api.espn.com…
#>  4 mens-college-basketball 3               2012 http://sports.core.api.espn.com…
#>  5 mens-college-basketball 3               2013 http://sports.core.api.espn.com…
#>  6 mens-college-basketball 3               2014 http://sports.core.api.espn.com…
#>  7 mens-college-basketball 3               2015 http://sports.core.api.espn.com…
#>  8 mens-college-basketball 3               2016 http://sports.core.api.espn.com…
#>  9 mens-college-basketball 3               2017 http://sports.core.api.espn.com…
#> 10 mens-college-basketball 3               2018 http://sports.core.api.espn.com…
#> 11 mens-college-basketball 3               2019 http://sports.core.api.espn.com…
#> 12 mens-college-basketball 3               2020 http://sports.core.api.espn.com…
#> 13 mens-college-basketball 3               2022 http://sports.core.api.espn.com…
#> 14 mens-college-basketball 3               2023 http://sports.core.api.espn.com…
# }
# \donttest{
  espn_nba_tournament_seasons(tournament_id = 1)
#> ── ESPN NBA Tournament Seasons ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:42 UTC
#> # A tibble: 3 × 4
#>   league tournament_id season ref                                               
#>   <chr>  <chr>          <int> <chr>                                             
#> 1 nba    1               2024 http://sports.core.api.espn.com/v2/sports/basketb…
#> 2 nba    1               2025 http://sports.core.api.espn.com/v2/sports/basketb…
#> 3 nba    1               2026 http://sports.core.api.espn.com/v2/sports/basketb…
# }
```
