# **Get ESPN MBB Season Ranking Detail**

Returns the per-week snapshot index for one ranking source (e.g. AP Top
25). Each row is one weekly snapshot; the `ref` URL resolves to the
actual ranked teams for that (season-type x week) and will be wrapped by
a forthcoming `espn_LOWERMBB_week_ranking()`.

Returns the per-week snapshot index for one ranking source (e.g. AP Top
25). Each row is one weekly snapshot; the `ref` URL resolves to the
actual ranked teams for that (season-type x week) and will be wrapped by
a forthcoming
[`espn_nba_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md).

## Usage

``` r
espn_mbb_season_ranking(ranking_id, season = most_recent_mbb_season(), ...)

espn_nba_season_ranking(ranking_id, season = most_recent_nba_season(), ...)
```

## Arguments

- ranking_id:

  ESPN ranking identifier (character or numeric).

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per weekly snapshot.

Columns as documented in the shared
[espn_mbb_season_ranking_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking_schema.md)
table.

A tibble with one row per weekly snapshot.

Columns as documented in the shared
[espn_mbb_season_ranking_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking_schema.md)
table.

## Details

**Get ESPN MBB Season Ranking Detail**

**Get ESPN NBA Season Ranking Detail**

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
  espn_mbb_season_ranking(ranking_id = 1, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Ranking Snapshots Index ── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:19 UTC
#> # A tibble: 21 × 9
#>    league       season ranking_id name  short_name type  season_type  week ref  
#>    <chr>         <int> <chr>      <chr> <chr>      <chr>       <int> <int> <chr>
#>  1 mens-colleg…   2025 1          AP T… AP Poll    ap              2     1 http…
#>  2 mens-colleg…   2025 1          AP T… AP Poll    ap              2     2 http…
#>  3 mens-colleg…   2025 1          AP T… AP Poll    ap              2     3 http…
#>  4 mens-colleg…   2025 1          AP T… AP Poll    ap              2     4 http…
#>  5 mens-colleg…   2025 1          AP T… AP Poll    ap              2     5 http…
#>  6 mens-colleg…   2025 1          AP T… AP Poll    ap              2     6 http…
#>  7 mens-colleg…   2025 1          AP T… AP Poll    ap              2     7 http…
#>  8 mens-colleg…   2025 1          AP T… AP Poll    ap              2     8 http…
#>  9 mens-colleg…   2025 1          AP T… AP Poll    ap              2     9 http…
#> 10 mens-colleg…   2025 1          AP T… AP Poll    ap              2    10 http…
#> # ℹ 11 more rows
# }
# \donttest{
  espn_nba_season_ranking(ranking_id = 1, season = 2025)
#> ✖ 2026-11-09 12:04:19.657627: Failed to retrieve ESPN nba ranking 1 for season=2025
#> ✖ Args: league = "nba", season = 2025, ranking_id = 1
#> ✖ Error: The API returned an error
#> ── ESPN NBA Season Ranking Snapshots Index ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:19 UTC
#> # A tibble: 0 × 0
# }
```
