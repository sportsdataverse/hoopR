# **Get ESPN MBB Team Roster (Per-Season, core-v2)**

Returns the per-season team roster as a tibble of athlete IDs from
`seasons/{y}/teams/{id}/athletes`. Distinct from
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md)
which targets a site-v2 endpoint optimized for the current season; this
core-v2 variant is era-correct and available back to ESPN's earliest
season for each league.

Returns the per-season team roster as a tibble of athlete IDs from
`seasons/{y}/teams/{id}/athletes`. Distinct from
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md)
which targets a site-v2 endpoint optimized for the current season; this
core-v2 variant is era-correct and available back to ESPN's earliest
season for each league.

## Usage

``` r
espn_mbb_team_season_roster(team_id, season = most_recent_mbb_season(), ...)

espn_nba_team_season_roster(team_id, season = most_recent_nba_season(), ...)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per athlete on the season roster.

|            |           |                                         |
|------------|-----------|-----------------------------------------|
| col_name   | types     | description                             |
| league     | character | League slug.                            |
| team_id    | character | ESPN team id.                           |
| season     | integer   | Season year.                            |
| athlete_id | character | ESPN athlete id.                        |
| ref        | character | `$ref` URL to athlete-in-season detail. |

A `hoopR_data` tibble with one row per athlete on the season roster.

|            |           |                                         |
|------------|-----------|-----------------------------------------|
| col_name   | types     | description                             |
| league     | character | League slug.                            |
| team_id    | character | ESPN team id.                           |
| season     | integer   | Season year.                            |
| athlete_id | character | ESPN athlete id.                        |
| ref        | character | `$ref` URL to athlete-in-season detail. |

## Details

**Get ESPN MBB Team Roster (Per-Season, core-v2)**

**Get ESPN NBA Team Roster (Per-Season, core-v2)**

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
  espn_mbb_team_season_roster(team_id = 150, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Season Roster ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:46 UTC
#> # A tibble: 23 × 5
#>    league                  team_id season athlete_id ref                        
#>    <chr>                   <chr>    <int> <chr>      <chr>                      
#>  1 mens-college-basketball 150       2025 4431890    http://sports.core.api.esp…
#>  2 mens-college-basketball 150       2025 4683735    http://sports.core.api.esp…
#>  3 mens-college-basketball 150       2025 4897107    http://sports.core.api.esp…
#>  4 mens-college-basketball 150       2025 5105337    http://sports.core.api.esp…
#>  5 mens-college-basketball 150       2025 5061585    http://sports.core.api.esp…
#>  6 mens-college-basketball 150       2025 5041939    http://sports.core.api.esp…
#>  7 mens-college-basketball 150       2025 4711256    http://sports.core.api.esp…
#>  8 mens-college-basketball 150       2025 4431753    http://sports.core.api.esp…
#>  9 mens-college-basketball 150       2025 4873107    http://sports.core.api.esp…
#> 10 mens-college-basketball 150       2025 4897108    http://sports.core.api.esp…
#> # ℹ 13 more rows
# }
# \donttest{
  espn_nba_team_season_roster(team_id = 13, season = 2025)
#> ── ESPN NBA Team Season Roster ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:46 UTC
#> # A tibble: 19 × 5
#>    league team_id season athlete_id ref                                         
#>    <chr>  <chr>    <int> <chr>      <chr>                                       
#>  1 nba    13        2025 5113969    http://sports.core.api.espn.com/v2/sports/b…
#>  2 nba    13        2025 5105817    http://sports.core.api.espn.com/v2/sports/b…
#>  3 nba    13        2025 3945274    http://sports.core.api.espn.com/v2/sports/b…
#>  4 nba    13        2025 4397014    http://sports.core.api.espn.com/v2/sports/b…
#>  5 nba    13        2025 4868423    http://sports.core.api.espn.com/v2/sports/b…
#>  6 nba    13        2025 4683774    http://sports.core.api.espn.com/v2/sports/b…
#>  7 nba    13        2025 4433599    http://sports.core.api.espn.com/v2/sports/b…
#>  8 nba    13        2025 4433136    http://sports.core.api.espn.com/v2/sports/b…
#>  9 nba    13        2025 4592691    http://sports.core.api.espn.com/v2/sports/b…
#> 10 nba    13        2025 3155535    http://sports.core.api.espn.com/v2/sports/b…
#> 11 nba    13        2025 4278580    http://sports.core.api.espn.com/v2/sports/b…
#> 12 nba    13        2025 4702972    http://sports.core.api.espn.com/v2/sports/b…
#> 13 nba    13        2025 5114350    http://sports.core.api.espn.com/v2/sports/b…
#> 14 nba    13        2025 4066457    http://sports.core.api.espn.com/v2/sports/b…
#> 15 nba    13        2025 4277811    http://sports.core.api.espn.com/v2/sports/b…
#> 16 nba    13        2025 5060631    http://sports.core.api.espn.com/v2/sports/b…
#> 17 nba    13        2025 3907498    http://sports.core.api.espn.com/v2/sports/b…
#> 18 nba    13        2025 4278077    http://sports.core.api.espn.com/v2/sports/b…
#> 19 nba    13        2025 4433137    http://sports.core.api.espn.com/v2/sports/b…
# }
```
