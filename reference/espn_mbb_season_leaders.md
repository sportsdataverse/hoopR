# **Get ESPN MBB Season Leaders (Long Format)**

Returns the per-category leaderboard for one (MBB season x season-type),
in long format. Each row is one (category x rank) entry, e.g. "Points
Per Game x rank 1 x LeBron James".

Returns the per-category leaderboard for one (NBA season x season-type),
in long format. Each row is one (category x rank) entry, e.g. "Points
Per Game x rank 1 x LeBron James".

## Usage

``` r
espn_mbb_season_leaders(
  season = most_recent_mbb_season(),
  season_type = c(2L, 3L),
  ...
)

espn_nba_season_leaders(
  season = most_recent_nba_season(),
  season_type = c(2L, 3L),
  ...
)
```

## Arguments

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default), 3 = postseason).

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (category x leader).

Columns as documented in the shared
[espn_mbb_season_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders_schema.md)
table.

A long tibble with one row per (category x leader).

Columns as documented in the shared
[espn_mbb_season_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders_schema.md)
table.

## Details

**Get ESPN MBB Season Leaders (Long Format)**

**Get ESPN NBA Season Leaders (Long Format)**

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
  espn_mbb_season_leaders(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season-Type Leaders ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:38 UTC
#> # A tibble: 350 × 15
#>    league       season season_type category_name category_display category_short
#>    <chr>         <int>       <int> <chr>         <chr>            <chr>         
#>  1 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  2 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  3 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  4 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  5 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  6 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  7 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  8 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#>  9 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#> 10 mens-colleg…   2025           2 pointsPerGame Points Per Game  PPG           
#> # ℹ 340 more rows
#> # ℹ 9 more variables: category_abbrev <chr>, rank <int>, athlete_id <chr>,
#> #   team_id <chr>, display_value <chr>, value <dbl>, rel <chr>,
#> #   athlete_ref <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_season_leaders(season = 2025)
#> ── ESPN NBA Season-Type Leaders ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:40 UTC
#> # A tibble: 800 × 15
#>    league season season_type category_name category_display category_short
#>    <chr>   <int>       <int> <chr>         <chr>            <chr>         
#>  1 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  2 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  3 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  4 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  5 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  6 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  7 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  8 nba      2025           2 pointsPerGame Points Per Game  PPG           
#>  9 nba      2025           2 pointsPerGame Points Per Game  PPG           
#> 10 nba      2025           2 pointsPerGame Points Per Game  PPG           
#> # ℹ 790 more rows
#> # ℹ 9 more variables: category_abbrev <chr>, rank <int>, athlete_id <chr>,
#> #   team_id <chr>, display_value <chr>, value <dbl>, rel <chr>,
#> #   athlete_ref <chr>, team_ref <chr>
# }
```
