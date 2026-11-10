# **Get ESPN MBB Team Record (Per Season Type)**

Returns the long-format record breakdown for an MBB team in one season
and season-type. Each row is one record category.

Returns the long-format record breakdown for an NBA team in one season
and season-type. Each row is one record type (Overall, Home, Road, vs
Conference, vs Division, etc.). Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/types/{season_type}/teams/{team_id}/record`.

## Usage

``` r
espn_mbb_team_record(
  team_id,
  season = most_recent_mbb_season(),
  season_type = c(2L, 3L),
  ...
)

espn_nba_team_record(
  team_id,
  season = most_recent_nba_season(),
  season_type = c(2L, 3L),
  ...
)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Integer (2 = regular season default).

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per record category. See `espn_nba_team_record()`
for the full column schema.

A `hoopR_data` tibble with one row per record category.

|                    |           |                                          |
|--------------------|-----------|------------------------------------------|
| col_name           | types     | description                              |
| league             | character | League slug (`"nba"`).                   |
| team_id            | character | ESPN team identifier.                    |
| season             | integer   | Season year.                             |
| season_type        | integer   | Season type (1/2/3).                     |
| record_id          | character | Record sub-id.                           |
| name               | character | Internal record name (e.g. "overall").   |
| abbreviation       | character | Abbreviation (e.g. "Total").             |
| display_name       | character | Display name (e.g. "Overall").           |
| short_display_name | character | Short display (e.g. "OVER").             |
| description        | character | Description (e.g. "Overall Record").     |
| type               | character | Record type code (`total`, `home`, ...). |
| summary            | character | W-L summary (e.g. "50-32").              |
| display_value      | character | Same as summary in most cases.           |
| value              | numeric   | Win percentage (0-1).                    |

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
  espn_mbb_team_record(team_id = 150, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Record ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:52 UTC
#> # A tibble: 12 × 14
#>    league   team_id season season_type record_id name  abbreviation display_name
#>    <chr>    <chr>    <int>       <int> <chr>     <chr> <chr>        <chr>       
#>  1 mens-co… 150       2025           2 0         over… Season       Team Season…
#>  2 mens-co… 150       2025           2 2         Home  Home         Home        
#>  3 mens-co… 150       2025           2 3         Road  AWAY         Away        
#>  4 mens-co… 150       2025           2 4         vs A… VS AP        NA          
#>  5 mens-co… 150       2025           2 6         vs U… VS USA       NA          
#>  6 mens-co… 150       2025           2 9         vs. … VS CONF      CONF        
#>  7 mens-co… 150       2025           3 0         over… Season       Team Season…
#>  8 mens-co… 150       2025           3 2         Home  Home         Home        
#>  9 mens-co… 150       2025           3 3         Road  AWAY         Away        
#> 10 mens-co… 150       2025           3 4         vs A… VS AP        NA          
#> 11 mens-co… 150       2025           3 6         vs U… VS USA       NA          
#> 12 mens-co… 150       2025           3 9         vs. … VS CONF      CONF        
#> # ℹ 6 more variables: short_display_name <chr>, description <chr>, type <chr>,
#> #   summary <chr>, display_value <chr>, value <dbl>
# }
# \donttest{
  espn_nba_team_record(team_id = 13, season = 2025)
#> ── ESPN NBA Team Record ───────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:53 UTC
#> # A tibble: 12 × 14
#>    league team_id season season_type record_id name    abbreviation display_name
#>    <chr>  <chr>    <int>       <int> <chr>     <chr>   <chr>        <chr>       
#>  1 nba    13        2025           2 0         overall Total        Overall     
#>  2 nba    13        2025           2 33        Home    NA           Home        
#>  3 nba    13        2025           2 34        Road    NA           Road        
#>  4 nba    13        2025           2 60        vs. Di… NA           DIV         
#>  5 nba    13        2025           2 61        vs. Co… NA           CONF        
#>  6 nba    13        2025           2 901       Last T… L10          Last Ten Ga…
#>  7 nba    13        2025           3 0         overall Total        Overall     
#>  8 nba    13        2025           3 33        Home    NA           Home        
#>  9 nba    13        2025           3 34        Road    NA           Road        
#> 10 nba    13        2025           3 60        vs. Di… NA           DIV         
#> 11 nba    13        2025           3 61        vs. Co… NA           CONF        
#> 12 nba    13        2025           3 901       Last T… L10          Last Ten Ga…
#> # ℹ 6 more variables: short_display_name <chr>, description <chr>, type <chr>,
#> #   summary <chr>, display_value <chr>, value <dbl>
# }
```
