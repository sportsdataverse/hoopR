# **Get ESPN MBB Season Groups Index**

Returns the list of group IDs (conferences / divisions) for one (MBB
season x season-type) via core-v2
`/seasons/{season}/types/{season_type}/groups`.

Returns the list of group IDs (conferences / divisions) for one (NBA
season x season-type) via core-v2
`/seasons/{season}/types/{season_type}/groups`.

## Usage

``` r
espn_mbb_season_groups(
  season = most_recent_mbb_season(),
  season_type = c(2L, 3L),
  ...
)

espn_nba_season_groups(
  season = most_recent_nba_season(),
  season_type = c(2L, 3L),
  ...
)
```

## Arguments

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per group.

|             |           |                                  |
|-------------|-----------|----------------------------------|
| col_name    | types     | description                      |
| league      | character | League slug.                     |
| season      | integer   | Season year.                     |
| season_type | integer   | Season-type id.                  |
| group_id    | character | ESPN group id.                   |
| ref         | character | `$ref` URL for the group detail. |

A `hoopR_data` tibble with one row per group.

|             |           |                                  |
|-------------|-----------|----------------------------------|
| col_name    | types     | description                      |
| league      | character | League slug.                     |
| season      | integer   | Season year.                     |
| season_type | integer   | Season-type id.                  |
| group_id    | character | ESPN group id.                   |
| ref         | character | `$ref` URL for the group detail. |

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
  espn_mbb_season_groups(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Groups Index ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:34 UTC
#> # A tibble: 4 × 5
#>   league                  season season_type group_id ref                       
#>   <chr>                    <int>       <int> <chr>    <chr>                     
#> 1 mens-college-basketball   2025           2 50       http://sports.core.api.es…
#> 2 mens-college-basketball   2025           2 51       http://sports.core.api.es…
#> 3 mens-college-basketball   2025           3 50       http://sports.core.api.es…
#> 4 mens-college-basketball   2025           3 51       http://sports.core.api.es…
# }
# \donttest{
  espn_nba_season_groups(season = 2025)
#> ── ESPN NBA Season Groups Index ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:35 UTC
#> # A tibble: 4 × 5
#>   league season season_type group_id ref                                        
#>   <chr>   <int>       <int> <chr>    <chr>                                      
#> 1 nba      2025           2 5        http://sports.core.api.espn.com/v2/sports/…
#> 2 nba      2025           2 6        http://sports.core.api.espn.com/v2/sports/…
#> 3 nba      2025           3 5        http://sports.core.api.espn.com/v2/sports/…
#> 4 nba      2025           3 6        http://sports.core.api.espn.com/v2/sports/…
# }
```
