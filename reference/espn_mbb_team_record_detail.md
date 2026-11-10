# **Get ESPN MBB Team Record Detail (Long Format)**

Returns one team's record detail in long format: one row per stat in the
record's `stats[]` array. Use
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md)
to enumerate available `record_id` values per team-season (overall /
home / away / conference + per-opponent breakdowns).

Returns one team's record detail in long format: one row per stat in the
record's `stats[]` array. Use
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md)
to enumerate available `record_id` values per team-season (overall /
home / away / conference + per-opponent breakdowns).

## Usage

``` r
espn_mbb_team_record_detail(team_id, season, record_id, season_type = 2L, ...)

espn_nba_team_record_detail(team_id, season, record_id, season_type = 2L, ...)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year (numeric).

- record_id:

  Record identifier (from
  [`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md)
  index).

- season_type:

  Integer season type: 1 = preseason, 2 = regular (default), 3 =
  postseason.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble.

A long tibble.

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
  espn_mbb_team_record_detail(team_id = 150, season = 2024, record_id = 0)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Record Detail ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:53 UTC
#> # A tibble: 20 × 15
#>    league         team_id season season_type record_id record_name record_abbrev
#>    <chr>          <chr>    <int>       <int> <chr>     <chr>       <chr>        
#>  1 mens-college-… 150       2024           2 0         overall     Season       
#>  2 mens-college-… 150       2024           2 0         overall     Season       
#>  3 mens-college-… 150       2024           2 0         overall     Season       
#>  4 mens-college-… 150       2024           2 0         overall     Season       
#>  5 mens-college-… 150       2024           2 0         overall     Season       
#>  6 mens-college-… 150       2024           2 0         overall     Season       
#>  7 mens-college-… 150       2024           2 0         overall     Season       
#>  8 mens-college-… 150       2024           2 0         overall     Season       
#>  9 mens-college-… 150       2024           2 0         overall     Season       
#> 10 mens-college-… 150       2024           2 0         overall     Season       
#> 11 mens-college-… 150       2024           2 0         overall     Season       
#> 12 mens-college-… 150       2024           2 0         overall     Season       
#> 13 mens-college-… 150       2024           2 0         overall     Season       
#> 14 mens-college-… 150       2024           2 0         overall     Season       
#> 15 mens-college-… 150       2024           2 0         overall     Season       
#> 16 mens-college-… 150       2024           2 0         overall     Season       
#> 17 mens-college-… 150       2024           2 0         overall     Season       
#> 18 mens-college-… 150       2024           2 0         overall     Season       
#> 19 mens-college-… 150       2024           2 0         overall     Season       
#> 20 mens-college-… 150       2024           2 0         overall     Season       
#> # ℹ 8 more variables: record_display <chr>, record_type <chr>,
#> #   record_summary <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, value <dbl>, stat_display_value <chr>
# }
# \donttest{
  espn_nba_team_record_detail(team_id = 13, season = 2024, record_id = 0)
#> ── ESPN NBA Team Record Detail ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:53 UTC
#> # A tibble: 21 × 15
#>    league team_id season season_type record_id record_name record_abbrev
#>    <chr>  <chr>    <int>       <int> <chr>     <chr>       <chr>        
#>  1 nba    13        2024           2 0         overall     Total        
#>  2 nba    13        2024           2 0         overall     Total        
#>  3 nba    13        2024           2 0         overall     Total        
#>  4 nba    13        2024           2 0         overall     Total        
#>  5 nba    13        2024           2 0         overall     Total        
#>  6 nba    13        2024           2 0         overall     Total        
#>  7 nba    13        2024           2 0         overall     Total        
#>  8 nba    13        2024           2 0         overall     Total        
#>  9 nba    13        2024           2 0         overall     Total        
#> 10 nba    13        2024           2 0         overall     Total        
#> # ℹ 11 more rows
#> # ℹ 8 more variables: record_display <chr>, record_type <chr>,
#> #   record_summary <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, value <dbl>, stat_display_value <chr>
# }
```
