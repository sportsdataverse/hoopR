# **Get ESPN MBB Athlete Career Stats (Long Format)**

Returns career stats for an MBB athlete in long format. Default
`stat_type = 0L` fetches the standard "All Splits" / regular-season
view. Pass a vector like `c(0L, 1L, 2L)` to attempt multiple types and
bind them via a `stat_type_id` column; variants that 404 for that
athlete are silently skipped. Stat types: 0 = regular season (default
endpoint), 1 = postseason, 2 = career aggregate. Coverage of types 1 and
2 is sparse - many athletes only have type 0 populated.

Returns career stats for an NBA athlete in long format. Default
`stat_type = 0L` fetches the standard "All Splits" / regular-season
view. Pass a vector like `c(0L, 1L, 2L)` to attempt multiple types and
bind them via a `stat_type_id` column; variants that 404 for that
athlete are silently skipped. Stat types: 0 = regular season (default
endpoint), 1 = postseason, 2 = career aggregate. Coverage of types 1 and
2 is sparse - many athletes only have type 0 populated.

## Usage

``` r
espn_mbb_player_career_stats(athlete_id, stat_type = 0L, ...)

espn_nba_player_career_stats(athlete_id, stat_type = 0L, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier.

- stat_type:

  Integer or integer vector of stat-type codes. Default `0L` fetches the
  standard "All Splits" / regular-season view. Pass a vector like
  `c(0L, 1L, 2L)` to bind multiple types via a `stat_type_id` column;
  non-existent variants are silently skipped.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble (one row per stat_type x split x category x stat).

Columns as documented in the shared
[espn_mbb_player_career_stats_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats_schema.md)
table.

A long tibble (one row per stat_type x split x category x stat).

Columns as documented in the shared
[espn_mbb_player_career_stats_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats_schema.md)
table.

## Details

**Get ESPN MBB Athlete Career Stats (Long Format)**

**Get ESPN NBA Athlete Career Stats (Long Format)**

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
  # LeBron James - regular + postseason combined
  espn_mbb_player_career_stats(athlete_id = 4593919)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Career Stats ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:22 UTC
#> # A tibble: 87 × 17
#>    league   athlete_id stat_type_id split_id split_name split_type category_name
#>    <chr>    <chr>      <chr>        <chr>    <chr>      <chr>      <chr>        
#>  1 mens-co… 4593919    0            0        Season     season     defensive    
#>  2 mens-co… 4593919    0            0        Season     season     defensive    
#>  3 mens-co… 4593919    0            0        Season     season     defensive    
#>  4 mens-co… 4593919    0            0        Season     season     defensive    
#>  5 mens-co… 4593919    0            0        Season     season     defensive    
#>  6 mens-co… 4593919    0            0        Season     season     defensive    
#>  7 mens-co… 4593919    0            0        Season     season     defensive    
#>  8 mens-co… 4593919    0            0        Season     season     defensive    
#>  9 mens-co… 4593919    0            0        Season     season     general      
#> 10 mens-co… 4593919    0            0        Season     season     general      
#> # ℹ 77 more rows
#> # ℹ 10 more variables: category_display <chr>, category_short <chr>,
#> #   category_abbrev <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, stat_short <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>
  # Just career aggregate
  espn_mbb_player_career_stats(athlete_id = 4593919, stat_type = 2L)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Career Stats ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:23 UTC
#> # A tibble: 0 × 17
#> # ℹ 17 variables: league <chr>, athlete_id <chr>, stat_type_id <chr>,
#> #   split_id <chr>, split_name <chr>, split_type <chr>, category_name <chr>,
#> #   category_display <chr>, category_short <chr>, category_abbrev <chr>,
#> #   stat_name <chr>, stat_abbrev <chr>, stat_display <chr>, stat_short <chr>,
#> #   description <chr>, value <dbl>, display_value <chr>
# }
# \donttest{
  # LeBron James - regular + postseason combined
  espn_nba_player_career_stats(athlete_id = 1966)
#> ── ESPN NBA Athlete Career Stats ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:23 UTC
#> # A tibble: 114 × 17
#>    league athlete_id stat_type_id split_id split_name split_type category_name
#>    <chr>  <chr>      <chr>        <chr>    <chr>      <chr>      <chr>        
#>  1 nba    1966       0            0        All Splits total      defensive    
#>  2 nba    1966       0            0        All Splits total      defensive    
#>  3 nba    1966       0            0        All Splits total      defensive    
#>  4 nba    1966       0            0        All Splits total      defensive    
#>  5 nba    1966       0            0        All Splits total      defensive    
#>  6 nba    1966       0            0        All Splits total      defensive    
#>  7 nba    1966       0            0        All Splits total      defensive    
#>  8 nba    1966       0            0        All Splits total      defensive    
#>  9 nba    1966       0            0        All Splits total      defensive    
#> 10 nba    1966       0            0        All Splits total      defensive    
#> # ℹ 104 more rows
#> # ℹ 10 more variables: category_display <chr>, category_short <chr>,
#> #   category_abbrev <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, stat_short <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>
  # Just career aggregate
  espn_nba_player_career_stats(athlete_id = 1966, stat_type = 2L)
#> ── ESPN NBA Athlete Career Stats ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:23 UTC
#> # A tibble: 0 × 17
#> # ℹ 17 variables: league <chr>, athlete_id <chr>, stat_type_id <chr>,
#> #   split_id <chr>, split_name <chr>, split_type <chr>, category_name <chr>,
#> #   category_display <chr>, category_short <chr>, category_abbrev <chr>,
#> #   stat_name <chr>, stat_abbrev <chr>, stat_display <chr>, stat_short <chr>,
#> #   description <chr>, value <dbl>, display_value <chr>
# }
```
