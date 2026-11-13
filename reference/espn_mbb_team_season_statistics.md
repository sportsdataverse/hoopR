# **Get ESPN MBB Team Season Statistics (Long Format with Rank)**

Returns the full team-season-type statistics sheet for one MBB team in
long format: one row per (category x stat). Each row carries the team's
league rank for that stat where ESPN provides it (`rank` +
`rank_display_value`). Complements
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md)
(W-L only) with the full stat package.

Returns the full team-season-type statistics sheet for one NBA team in
long format: one row per (category x stat). Each row carries the team's
league rank for that stat where ESPN provides it (`rank` +
`rank_display_value`). Complements
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md)
(W-L only) with the full stat package.

## Usage

``` r
espn_mbb_team_season_statistics(
  team_id,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_nba_team_season_statistics(
  team_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- season_type:

  Integer season type: 1 = preseason, 2 = regular (default), 3 =
  postseason.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (category x stat).

A long tibble with one row per (category x stat).

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
  espn_mbb_team_season_statistics(team_id = 150, season = 2024)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Season Statistics ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:08 UTC
#> # A tibble: 77 × 13
#>    league    season season_type team_id category_name category_display stat_name
#>    <chr>      <int>       <int> <chr>   <chr>         <chr>            <chr>    
#>  1 mens-col…   2024           2 150     defensive     Defensive        blocks   
#>  2 mens-col…   2024           2 150     defensive     Defensive        defensiv…
#>  3 mens-col…   2024           2 150     defensive     Defensive        steals   
#>  4 mens-col…   2024           2 150     defensive     Defensive        turnover…
#>  5 mens-col…   2024           2 150     defensive     Defensive        avgDefen…
#>  6 mens-col…   2024           2 150     defensive     Defensive        avgBlocks
#>  7 mens-col…   2024           2 150     defensive     Defensive        avgSteals
#>  8 mens-col…   2024           2 150     general       General          disquali…
#>  9 mens-col…   2024           2 150     general       General          flagrant…
#> 10 mens-col…   2024           2 150     general       General          fouls    
#> # ℹ 67 more rows
#> # ℹ 6 more variables: stat_abbrev <chr>, stat_display <chr>, value <dbl>,
#> #   display_value <chr>, rank <int>, rank_display_value <chr>
# }
# \donttest{
  espn_nba_team_season_statistics(team_id = 13, season = 2024)
#> ── ESPN NBA Team Season Statistics ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:08 UTC
#> # A tibble: 109 × 13
#>    league season season_type team_id category_name category_display stat_name   
#>    <chr>   <int>       <int> <chr>   <chr>         <chr>            <chr>       
#>  1 nba      2024           2 13      defensive     Defensive        blocks      
#>  2 nba      2024           2 13      defensive     Defensive        defensiveRe…
#>  3 nba      2024           2 13      defensive     Defensive        steals      
#>  4 nba      2024           2 13      defensive     Defensive        turnoverPoi…
#>  5 nba      2024           2 13      defensive     Defensive        defReboundR…
#>  6 nba      2024           2 13      defensive     Defensive        avgDefensiv…
#>  7 nba      2024           2 13      defensive     Defensive        avgBlocks   
#>  8 nba      2024           2 13      defensive     Defensive        avgSteals   
#>  9 nba      2024           2 13      defensive     Defensive        avg48Defens…
#> 10 nba      2024           2 13      defensive     Defensive        avg48Blocks 
#> # ℹ 99 more rows
#> # ℹ 6 more variables: stat_abbrev <chr>, stat_display <chr>, value <dbl>,
#> #   display_value <chr>, rank <int>, rank_display_value <chr>
# }
```
