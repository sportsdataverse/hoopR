# **Get ESPN MBB Tournament Season Detail**

Returns single-row detail for one (tournament, season) pair: id, display
name, number of rounds, and `$ref`s to the season + bracketology
resources. Use
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md)
to enumerate valid (tournament_id, season) pairs.

Returns single-row detail for one (tournament, season) pair: id, display
name, number of rounds, and `$ref`s to the season + bracketology
resources. Use
[`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md)
to enumerate valid (tournament_id, season) pairs.

## Usage

``` r
espn_mbb_tournament_season(tournament_id, season, ...)

espn_nba_tournament_season(tournament_id, season, ...)
```

## Arguments

- tournament_id:

  ESPN tournament identifier.

- season:

  Season year (numeric).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

A single-row tibble.

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
  espn_mbb_tournament_season(tournament_id = 3, season = 2024)
#> ── ESPN MENS-COLLEGE-BASKETBALL Tournament Season Detail ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:20 UTC
#> # A tibble: 1 × 8
#>   league   tournament_id season display_name short_display_name number_of_rounds
#>   <chr>    <chr>          <int> <chr>        <chr>                         <int>
#> 1 mens-co… 3               2024 ACC Tournam… ACC                               0
#> # ℹ 2 more variables: season_ref <chr>, bracketology_ref <chr>
# }
# \donttest{
  espn_nba_tournament_season(tournament_id = 1, season = 2024)
#> ── ESPN NBA Tournament Season Detail ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:20 UTC
#> # A tibble: 1 × 8
#>   league tournament_id season display_name   short_display_name number_of_rounds
#>   <chr>  <chr>          <int> <chr>          <chr>                         <int>
#> 1 nba    1               2024 In-Season Tou… In-Season Tournam…                3
#> # ℹ 2 more variables: season_ref <chr>, bracketology_ref <chr>
# }
```
