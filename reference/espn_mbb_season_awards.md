# **Get ESPN MBB Season Awards Index**

Returns the list of award IDs given out in an MBB season from
`sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/awards`.
The index only contains IDs and `$ref` URLs - pass an ID to
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md)
for the award name, description, and winners.

Returns the list of award IDs given out in an NBA season from
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/awards`.
The index only contains IDs and `$ref` URLs - pass an ID to
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md)
for the award name, description, and winners.

## Usage

``` r
espn_mbb_season_awards(season = most_recent_mbb_season(), ...)

espn_nba_season_awards(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per award.

|          |           |                                            |
|----------|-----------|--------------------------------------------|
| col_name | types     | description                                |
| season   | integer   | Season year.                               |
| award_id | character | ESPN award identifier.                     |
| ref      | character | Full `$ref` URL for the award detail.      |
| league   | character | League slug (`"mens-college-basketball"`). |

A `hoopR_data` tibble with one row per award.

|          |           |                                       |
|----------|-----------|---------------------------------------|
| col_name | types     | description                           |
| season   | integer   | Season year.                          |
| award_id | character | ESPN award identifier.                |
| ref      | character | Full `$ref` URL for the award detail. |
| league   | character | League slug (`"nba"`).                |

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
  espn_mbb_season_awards(season = 2024)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Awards Index ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:57 UTC
#> # A tibble: 11 × 4
#>    season award_id ref                                                    league
#>     <int> <chr>    <chr>                                                  <chr> 
#>  1   2024 344      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  2   2024 342      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  3   2024 345      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  4   2024 346      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  5   2024 458      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  6   2024 337      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  7   2024 338      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  8   2024 339      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#>  9   2024 340      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#> 10   2024 347      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
#> 11   2024 343      http://sports.core.api.espn.com/v2/sports/basketball/… mens-…
# }
# \donttest{
  espn_nba_season_awards(season = 2024)
#> ── ESPN NBA Season Awards Index ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:57 UTC
#> # A tibble: 20 × 4
#>    season award_id ref                                                    league
#>     <int> <chr>    <chr>                                                  <chr> 
#>  1   2024 33       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  2   2024 39       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  3   2024 35       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  4   2024 40       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  5   2024 36       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  6   2024 43       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  7   2024 44       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  8   2024 45       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#>  9   2024 46       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 10   2024 47       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 11   2024 48       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 12   2024 49       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 13   2024 50       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 14   2024 53       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 15   2024 77       http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 16   2024 377      http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 17   2024 378      http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 18   2024 297      http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 19   2024 218      http://sports.core.api.espn.com/v2/sports/basketball/… nba   
#> 20   2024 217      http://sports.core.api.espn.com/v2/sports/basketball/… nba   
# }
```
