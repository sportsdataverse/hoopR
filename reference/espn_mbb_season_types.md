# **Get ESPN MBB Season Types Index**

Returns the index of season-type IDs that exist for one MBB season
(typically 1 = preseason, 2 = regular, 3 = postseason, 4 = off-season).
Pass an ID to
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md)
for the start/end dates and whether that type carries groups, standings,
or legs.

Returns the index of season-type IDs that exist for one NBA season
(typically 1 = preseason, 2 = regular, 3 = postseason, 4 = off-season).
Pass an ID to
[`espn_nba_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md)
for the start/end dates and whether that type carries groups, standings,
or legs.

## Usage

``` r
espn_mbb_season_types(season = most_recent_mbb_season(), ...)

espn_nba_season_types(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per season type.

|             |           |                                            |
|-------------|-----------|--------------------------------------------|
| col_name    | types     | description                                |
| league      | character | League slug (`"mens-college-basketball"`). |
| season      | integer   | Season year.                               |
| season_type | integer   | Season-type id (1/2/3/4).                  |
| ref         | character | `$ref` URL for the type detail.            |

A tibble with one row per season type.

|             |           |                                 |
|-------------|-----------|---------------------------------|
| col_name    | types     | description                     |
| league      | character | League slug (`"nba"`).          |
| season      | integer   | Season year.                    |
| season_type | integer   | Season-type id (1/2/3/4).       |
| ref         | character | `$ref` URL for the type detail. |

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
  espn_mbb_season_types(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Types Index ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:20 UTC
#> # A tibble: 4 × 4
#>   league                  season season_type ref                                
#>   <chr>                    <int>       <int> <chr>                              
#> 1 mens-college-basketball   2025           1 http://sports.core.api.espn.com/v2…
#> 2 mens-college-basketball   2025           2 http://sports.core.api.espn.com/v2…
#> 3 mens-college-basketball   2025           3 http://sports.core.api.espn.com/v2…
#> 4 mens-college-basketball   2025           4 http://sports.core.api.espn.com/v2…
# }
# \donttest{
  espn_nba_season_types(season = 2025)
#> ── ESPN NBA Season Types Index ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:20 UTC
#> # A tibble: 5 × 4
#>   league season season_type ref                                                 
#>   <chr>   <int>       <int> <chr>                                               
#> 1 nba      2025           1 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 2 nba      2025           2 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 3 nba      2025           3 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 4 nba      2025           4 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 5 nba      2025           5 http://sports.core.api.espn.com/v2/sports/basketbal…
# }
```
