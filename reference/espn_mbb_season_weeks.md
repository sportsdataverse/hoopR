# **Get ESPN MBB Season Weeks Index**

Returns the list of week IDs for one (MBB season x season-type). MBB
uses a week structure inherited from ESPN's schema, but week-level
rankings are populated only for college (MBB / WBB).

Returns the list of week IDs for one (NBA season x season-type). NBA
uses a week structure inherited from ESPN's schema, but week-level
rankings are populated only for college (MBB / WBB).

## Usage

``` r
espn_mbb_season_weeks(
  season = most_recent_mbb_season(),
  season_type = c(2L, 3L),
  ...
)

espn_nba_season_weeks(
  season = most_recent_nba_season(),
  season_type = c(2L, 3L),
  ...
)
```

## Arguments

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default), 3 = postseason).

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per week.

|             |           |                                 |
|-------------|-----------|---------------------------------|
| col_name    | types     | description                     |
| league      | character | League slug.                    |
| season      | integer   | Season year.                    |
| season_type | integer   | Season-type id.                 |
| week        | integer   | Week number (1-based).          |
| ref         | character | `$ref` URL for the week detail. |

A `hoopR_data` tibble with one row per week.

|             |           |                                 |
|-------------|-----------|---------------------------------|
| col_name    | types     | description                     |
| league      | character | League slug.                    |
| season      | integer   | Season year.                    |
| season_type | integer   | Season-type id.                 |
| week        | integer   | Week number (1-based).          |
| ref         | character | `$ref` URL for the week detail. |

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
  espn_mbb_season_weeks(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Weeks Index ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:05 UTC
#> # A tibble: 24 × 5
#>    league                  season season_type  week ref                         
#>    <chr>                    <int>       <int> <int> <chr>                       
#>  1 mens-college-basketball   2025           2     1 http://sports.core.api.espn…
#>  2 mens-college-basketball   2025           2     2 http://sports.core.api.espn…
#>  3 mens-college-basketball   2025           2     3 http://sports.core.api.espn…
#>  4 mens-college-basketball   2025           2     4 http://sports.core.api.espn…
#>  5 mens-college-basketball   2025           2     5 http://sports.core.api.espn…
#>  6 mens-college-basketball   2025           2     6 http://sports.core.api.espn…
#>  7 mens-college-basketball   2025           2     7 http://sports.core.api.espn…
#>  8 mens-college-basketball   2025           2     8 http://sports.core.api.espn…
#>  9 mens-college-basketball   2025           2     9 http://sports.core.api.espn…
#> 10 mens-college-basketball   2025           2    10 http://sports.core.api.espn…
#> # ℹ 14 more rows
# }
# \donttest{
  espn_nba_season_weeks(season = 2025)
#> ── ESPN NBA Season Weeks Index ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:06 UTC
#> # A tibble: 35 × 5
#>    league season season_type  week ref                                          
#>    <chr>   <int>       <int> <int> <chr>                                        
#>  1 nba      2025           2     1 http://sports.core.api.espn.com/v2/sports/ba…
#>  2 nba      2025           2     2 http://sports.core.api.espn.com/v2/sports/ba…
#>  3 nba      2025           2     3 http://sports.core.api.espn.com/v2/sports/ba…
#>  4 nba      2025           2     4 http://sports.core.api.espn.com/v2/sports/ba…
#>  5 nba      2025           2     5 http://sports.core.api.espn.com/v2/sports/ba…
#>  6 nba      2025           2     6 http://sports.core.api.espn.com/v2/sports/ba…
#>  7 nba      2025           2     7 http://sports.core.api.espn.com/v2/sports/ba…
#>  8 nba      2025           2     8 http://sports.core.api.espn.com/v2/sports/ba…
#>  9 nba      2025           2     9 http://sports.core.api.espn.com/v2/sports/ba…
#> 10 nba      2025           2    10 http://sports.core.api.espn.com/v2/sports/ba…
#> # ℹ 25 more rows
# }
```
