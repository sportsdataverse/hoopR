# **Get ESPN Women's College Basketball League Leaders**

**Get ESPN Women's College Basketball League Leaders**

**Get ESPN Women's College Basketball League Leaders**

**Get ESPN NBA League Leaders**

**Get ESPN NBA League Leaders**

## Usage

``` r
espn_mbb_leaders(season = most_recent_mbb_season(), season_type = 2, ...)

espn_nba_leaders(season = most_recent_nba_season(), season_type = 2, ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- season_type:

  Integer season type: 1 = preseason, 2 = regular (default), 3 =
  postseason.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per category-athlete pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| category | character | Category label. |
| abbreviation | character | Short abbreviation. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| team_id | character | Unique team identifier. |
| team_abbrev | character |  |
| value | numeric | Numeric or string value field. |
| rank | integer | Rank. |
| display_value | character | Human-readable display value. |

A `hoopR_data` tibble with one row per category-athlete pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| category | character | Category label. |
| abbreviation | character | Short abbreviation. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| team_id | character | Unique team identifier. |
| team_abbrev | character |  |
| value | numeric | Numeric or string value field. |
| rank | integer | Rank. |
| display_value | character | Human-readable display value. |

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
  espn_mbb_leaders(season = 2025, season_type = 2)
#> ── ESPN MENS-COLLEGE-BASKETBALL Leaders from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:57:50 UTC
#> # A tibble: 350 × 11
#>    season season_type category      abbreviation athlete_id athlete_name team_id
#>     <int>       <int> <chr>         <chr>        <chr>      <chr>        <chr>  
#>  1   2025           2 pointsPerGame PTS          5252523    NA           3106   
#>  2   2025           2 pointsPerGame PTS          5110002    NA           2590   
#>  3   2025           2 pointsPerGame PTS          5260123    NA           2392   
#>  4   2025           2 pointsPerGame PTS          4602999    NA           2380   
#>  5   2025           2 pointsPerGame PTS          5250293    NA           2905   
#>  6   2025           2 pointsPerGame PTS          4431718    NA           222    
#>  7   2025           2 pointsPerGame PTS          4896538    NA           2464   
#>  8   2025           2 pointsPerGame PTS          4904121    NA           49     
#>  9   2025           2 pointsPerGame PTS          5180670    NA           3078   
#> 10   2025           2 pointsPerGame PTS          5192144    NA           60     
#> # ℹ 340 more rows
#> # ℹ 4 more variables: team_abbrev <chr>, value <dbl>, rank <int>,
#> #   display_value <chr>
# }
# \donttest{
  espn_nba_leaders(season = 2024, season_type = 2)
#> ── ESPN NBA Leaders from ESPN.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:57:50 UTC
#> # A tibble: 400 × 11
#>    season season_type category      abbreviation athlete_id athlete_name team_id
#>     <int>       <int> <chr>         <chr>        <chr>      <chr>        <chr>  
#>  1   2024           2 pointsPerGame PTS          3059318    NA           20     
#>  2   2024           2 pointsPerGame PTS          3945274    NA           6      
#>  3   2024           2 pointsPerGame PTS          3032977    NA           15     
#>  4   2024           2 pointsPerGame PTS          4278073    NA           25     
#>  5   2024           2 pointsPerGame PTS          3934672    NA           18     
#>  6   2024           2 pointsPerGame PTS          3202       NA           21     
#>  7   2024           2 pointsPerGame PTS          3136193    NA           21     
#>  8   2024           2 pointsPerGame PTS          4065648    NA           2      
#>  9   2024           2 pointsPerGame PTS          3908809    NA           5      
#> 10   2024           2 pointsPerGame PTS          4066259    NA           23     
#> # ℹ 390 more rows
#> # ℹ 4 more variables: team_abbrev <chr>, value <dbl>, rank <int>,
#> #   display_value <chr>
# }
```
