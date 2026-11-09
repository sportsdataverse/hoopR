# **Get ESPN MBB Per-Week Rankings Index**

Returns the index of ranking sources available for one (MBB season x
season-type x week). Typical sources: AP Top 25 (id 1), Coaches Poll (id
2). Pass an id to
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md)
for the ranked teams.

Returns the index of ranking sources available for one (NBA season x
season-type x week). NBA does not publish weekly rankings, so this
typically returns an empty tibble; the wrapper is provided for symmetry
with college (MBB / WBB).

## Usage

``` r
espn_mbb_week_rankings(
  week,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_nba_week_rankings(
  week,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- week:

  Week number.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per ranking source.

Columns as documented in the shared
[espn_mbb_week_rankings_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings_schema.md)
table.

A tibble with one row per ranking source.

Columns as documented in the shared
[espn_mbb_week_rankings_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings_schema.md)
table.

## Details

**Get ESPN MBB Per-Week Rankings Index**

**Get ESPN NBA Per-Week Rankings Index**

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
  espn_mbb_week_rankings(week = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Week Rankings Index ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:04 UTC
#> # A tibble: 2 × 6
#>   league                  season season_type  week ranking_id ref               
#>   <chr>                    <int>       <int> <int> <chr>      <chr>             
#> 1 mens-college-basketball   2025           2     5 1          http://sports.cor…
#> 2 mens-college-basketball   2025           2     5 2          http://sports.cor…
# }
# \donttest{
  espn_nba_week_rankings(week = 5, season = 2025)
#> ── ESPN NBA Week Rankings Index ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:04 UTC
#> # A tibble: 0 × 6
#> # ℹ 6 variables: league <chr>, season <int>, season_type <int>, week <int>,
#> #   ranking_id <chr>, ref <chr>
# }
```
