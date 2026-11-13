# **Get ESPN NBA Team Depth Chart (Long Format)**

Returns the team's depth chart in long format, one row per (position x
rank x athlete). NBA-only at ESPN's core-v2.

## Usage

``` r
espn_nba_team_depthchart(team_id, season = most_recent_nba_season(), ...)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year. Defaults to most recent NBA season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per athlete depth entry.

|                 |           |                                          |
|-----------------|-----------|------------------------------------------|
| col_name        | types     | description                              |
| league          | character | League slug.                             |
| team_id         | character | ESPN team id.                            |
| season          | integer   | Season year.                             |
| depthchart_id   | character | Depth chart id (typically "1").          |
| depthchart_name | character | Depth chart name.                        |
| position        | character | Position code (`pg`/`sg`/`sf`/`pf`/`c`). |
| rank            | integer   | Depth rank (1 = starter).                |
| athlete_id      | character | ESPN athlete id.                         |
| athlete_ref     | character | `$ref` URL to athlete-in-season.         |
| position_ref    | character | `$ref` URL to position resource.         |

## Details

**Get ESPN NBA Team Depth Chart (Long Format)**

## See also

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_team_depthchart(team_id = 13, season = 2025)
#> ── ESPN NBA Team Depth Chart ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:29 UTC
#> # A tibble: 30 × 10
#>    league team_id season depthchart_id depthchart_name position  rank athlete_id
#>    <chr>  <chr>    <int> <chr>         <chr>           <chr>    <int> <chr>     
#>  1 nba    13        2025 1             Depth Chart     pg           1 3945274   
#>  2 nba    13        2025 1             Depth Chart     pg           2 3137259   
#>  3 nba    13        2025 1             Depth Chart     pg           3 2990992   
#>  4 nba    13        2025 1             Depth Chart     pg           4 4683774   
#>  5 nba    13        2025 1             Depth Chart     pg           5 4066457   
#>  6 nba    13        2025 1             Depth Chart     pg           6 4683686   
#>  7 nba    13        2025 1             Depth Chart     sg           1 4066457   
#>  8 nba    13        2025 1             Depth Chart     sg           2 2990992   
#>  9 nba    13        2025 1             Depth Chart     sg           3 4897943   
#> 10 nba    13        2025 1             Depth Chart     sg           4 4683774   
#> # ℹ 20 more rows
#> # ℹ 2 more variables: athlete_ref <chr>, position_ref <chr>
# }
```
