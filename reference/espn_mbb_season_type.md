# **Get ESPN MBB Season-Type Detail**

Returns metadata for one season-type within an MBB season: name,
abbreviation, start / end dates, and whether it carries groups,
standings, or playoff legs.

Returns metadata for one season-type within an NBA season: name,
abbreviation, start / end dates, and whether it carries groups,
standings, or playoff legs.

## Usage

``` r
espn_mbb_season_type(season_type = 2L, season = most_recent_mbb_season(), ...)

espn_nba_season_type(season_type = 2L, season = most_recent_nba_season(), ...)
```

## Arguments

- season_type:

  Season-type id (1 = preseason, 2 = regular (default), 3 = postseason,
  4 = off-season).

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

Columns as documented in the shared
[espn_mbb_season_type_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type_schema.md)
table.

A single-row tibble.

Columns as documented in the shared
[espn_mbb_season_type_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type_schema.md)
table.

## Details

**Get ESPN MBB Season-Type Detail**

**Get ESPN NBA Season-Type Detail**

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
  espn_mbb_season_type(season_type = 2, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Type Detail ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:41 UTC
#> # A tibble: 1 × 16
#>   league   season season_type  type name  abbreviation  year start_date end_date
#>   <chr>     <int>       <int> <int> <chr> <chr>        <int> <chr>      <chr>   
#> 1 mens-co…   2025           2     2 Regu… reg           2025 2024-11-0… 2025-03…
#> # ℹ 7 more variables: has_groups <lgl>, has_standings <lgl>, has_legs <lgl>,
#> #   slug <chr>, groups_ref <chr>, weeks_ref <chr>, leaders_ref <chr>
# }
# \donttest{
  espn_nba_season_type(season_type = 2, season = 2025)
#> ── ESPN NBA Season Type Detail ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:41 UTC
#> # A tibble: 1 × 16
#>   league season season_type  type name    abbreviation  year start_date end_date
#>   <chr>   <int>       <int> <int> <chr>   <chr>        <int> <chr>      <chr>   
#> 1 nba      2025           2     2 Regula… reg           2025 2024-10-2… 2025-04…
#> # ℹ 7 more variables: has_groups <lgl>, has_standings <lgl>, has_legs <lgl>,
#> #   slug <chr>, groups_ref <chr>, weeks_ref <chr>, leaders_ref <chr>
# }
```
