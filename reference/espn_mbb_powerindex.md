# **Get ESPN MBB Season Power Index (Long Format)**

Returns ESPN's Basketball Power Index (BPI) and related per-team metrics
for one MBB season, in long format: one row per (team x stat).
Auto-paginates through all teams.

Returns ESPN's Basketball Power Index (BPI) and related per-team metrics
for one NBA season, in long format: one row per (team x stat).
Auto-paginates through all teams. Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/powerindex`.

## Usage

``` r
espn_mbb_powerindex(
  season = most_recent_mbb_season(),
  season_type = c(2L, 3L),
  ...
)

espn_nba_powerindex(
  season = most_recent_nba_season(),
  season_type = c(2L, 3L),
  ...
)
```

## Arguments

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- season_type:

  Integer (1=preseason, 2=regular (default), 3=postseason).

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (team x stat).

|               |           |                                        |
|---------------|-----------|----------------------------------------|
| col_name      | types     | description                            |
| league        | character | League slug.                           |
| season        | integer   | Season year.                           |
| season_type   | integer   | 1=preseason, 2=regular, 3=postseason.  |
| team_id       | character | ESPN team id.                          |
| stat_name     | character | Internal stat key.                     |
| abbreviation  | character | Short stat abbreviation.               |
| display_name  | character | Human-readable stat name.              |
| description   | character | Stat description.                      |
| value         | numeric   | Stat value.                            |
| display_value | character | Display-formatted value.               |
| last_updated  | character | Last-updated timestamp.                |
| team_ref      | character | `$ref` to the team-in-season resource. |

A long tibble with one row per (team x stat).

|               |           |                                        |
|---------------|-----------|----------------------------------------|
| col_name      | types     | description                            |
| league        | character | League slug (`"nba"`).                 |
| season        | integer   | Season year.                           |
| season_type   | integer   | 1=preseason, 2=regular, 3=postseason.  |
| team_id       | character | ESPN team id (parsed from `team_ref`). |
| stat_name     | character | Internal stat key (e.g. "bpi").        |
| abbreviation  | character | Short stat abbreviation.               |
| display_name  | character | Human-readable stat name.              |
| description   | character | Stat description.                      |
| value         | numeric   | Stat value.                            |
| display_value | character | Display-formatted value.               |
| last_updated  | character | Last-updated timestamp.                |
| team_ref      | character | `$ref` to the team-in-season resource. |

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
  espn_mbb_powerindex(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Power Index ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:29 UTC
#> # A tibble: 1,475 × 12
#>    league         season season_type team_id stat_name abbreviation display_name
#>    <chr>           <int>       <int> <chr>   <chr>     <chr>        <chr>       
#>  1 mens-college-…   2025          NA 150     bpi       NA           BPI         
#>  2 mens-college-…   2025          NA 150     bpirank   NA           BPI RK      
#>  3 mens-college-…   2025          NA 150     rpirank   NA           RPI RK      
#>  4 mens-college-…   2025          NA 150     sor       NA           SOR         
#>  5 mens-college-…   2025          NA 150     sorrank   NA           SOR RK      
#>  6 mens-college-…   2025          NA 150     sospast   NA           SOS         
#>  7 mens-college-…   2025          NA 150     sospastr… NA           SOS RK      
#>  8 mens-college-…   2025          NA 150     wins      NA           W           
#>  9 mens-college-…   2025          NA 150     losses    NA           L           
#> 10 mens-college-…   2025          NA 150     winpct    NA           W-L         
#> # ℹ 1,465 more rows
#> # ℹ 5 more variables: description <chr>, value <dbl>, display_value <chr>,
#> #   last_updated <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_powerindex(season = 2025)
#> ── ESPN NBA Season Power Index ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:32 UTC
#> # A tibble: 4,260 × 12
#>    league season season_type team_id stat_name     abbreviation display_name
#>    <chr>   <int>       <int> <chr>   <chr>         <chr>        <chr>       
#>  1 nba      2025           2 25      bpi           BPI          BPI         
#>  2 nba      2025           2 25      bpirank       bpiRank      BPI RANK    
#>  3 nba      2025           2 25      bpioffense    Off          BPI OFFENSE 
#>  4 nba      2025           2 25      bpidefense    Def          BPI DEFENSE 
#>  5 nba      2025           2 25      numwins       W            NUM WINS    
#>  6 nba      2025           2 25      numlosses     L            NUM LOSSES  
#>  7 nba      2025           2 25      winpct        WPct         WIN PCT     
#>  8 nba      2025           2 25      projectedw    ProjW        PROJ WINS   
#>  9 nba      2025           2 25      projectedl    ProjL        PROJ LOSSES 
#> 10 nba      2025           2 25      projectedwpct ProjWPct     PROJ WIN PCT
#> # ℹ 4,250 more rows
#> # ℹ 5 more variables: description <chr>, value <dbl>, display_value <chr>,
#> #   last_updated <chr>, team_ref <chr>
# }
```
