# **Get ESPN Women's College Basketball Injuries**

**Get ESPN Women's College Basketball Injuries**

**Get ESPN Women's College Basketball Injuries**

**Get ESPN NBA Injuries**

**Get ESPN NBA Injuries**

## Usage

``` r
espn_mbb_injuries(season = most_recent_mbb_season(), ...)

espn_nba_injuries(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Numeric or character season year (e.g. `2025`). The ESPN injury
  endpoint does not filter by season server-side; the value is attached
  as a constant column on the returned tibble for downstream joins.
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- ...:

  Currently unused; reserved for future argument threading.

## Value

A named list of `hoopR_data` tibbles: `Injuries`.

**Injuries**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| position | character | Listed roster position (G, F, C, etc.). |
| status | character | Status label. |
| date | character | Date in YYYY-MM-DD format. |
| type | character | Record type / category. |
| side | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| returns_at | character |  |
| short_comment | character |  |
| long_comment | character | Long-form play / event comment. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |

ESPN's MBB injury data is typically sparse. An empty tibble (zero rows)
when no injuries are reported.

A named list of `hoopR_data` tibbles: `Injuries`.

**Injuries**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| position | character | Listed roster position (G, F, C, etc.). |
| status | character | Status label. |
| date | character | Date in YYYY-MM-DD format. |
| type | character | Record type / category. |
| side | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| returns_at | character |  |
| short_comment | character |  |
| long_comment | character | Long-form play / event comment. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |

An empty tibble (zero rows) when no injuries are reported.

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
  espn_mbb_injuries()
# }
# \donttest{
  espn_nba_injuries()
#> ── ESPN NBA Injury Information from ESPN.com ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:31 UTC
#> # A tibble: 28 × 12
#>    team_id athlete_id athlete_name position status date  type  side  returns_at
#>    <chr>   <chr>      <chr>        <chr>    <chr>  <chr> <chr> <chr> <chr>     
#>  1 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  2 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  3 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  4 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  5 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  6 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  7 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  8 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#>  9 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#> 10 NA      NA         NA           NA       NA     NA    NA    NA    NA        
#> # ℹ 18 more rows
#> # ℹ 3 more variables: short_comment <chr>, long_comment <chr>, season <int>
# }
```
