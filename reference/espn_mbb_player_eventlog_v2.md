# **Get ESPN MBB Athlete Per-Season Event Log (core-v2)**

Returns one row per (event x team) for an MBB athlete's appearances in a
given season. Distinct from
[`espn_mbb_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md)
which wraps the web-common-v3 endpoint; this core-v2 variant is
era-correct.

Returns one row per (event x team) for an NBA athlete's appearances in a
given season. Distinct from
[`espn_nba_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md)
which wraps the web-common-v3 gamelog endpoint returning stats per game;
this core-v2 variant returns refs + `played` flag and is era-correct.

## Usage

``` r
espn_mbb_player_eventlog_v2(athlete_id, season = most_recent_mbb_season(), ...)

espn_nba_player_eventlog_v2(athlete_id, season = most_recent_nba_season(), ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier.

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per event appearance.

A tibble with one row per event appearance. See package source for
column schema.

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
  espn_mbb_player_eventlog_v2(athlete_id = 4683735, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Event Log ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:54 UTC
#> # A tibble: 25 × 8
#>    league    athlete_id season event_id team_id played event_ref competition_ref
#>    <chr>     <chr>       <int> <chr>    <chr>   <lgl>  <chr>     <chr>          
#>  1 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  2 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  3 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  4 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  5 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  6 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  7 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  8 mens-col… 4683735      2025 4017156… 24      TRUE   http://s… http://sports.…
#>  9 mens-col… 4683735      2025 4017157… 24      TRUE   http://s… http://sports.…
#> 10 mens-col… 4683735      2025 4017247… 24      TRUE   http://s… http://sports.…
#> # ℹ 15 more rows
# }
# \donttest{
  espn_nba_player_eventlog_v2(athlete_id = 1966, season = 2025)
#> ── ESPN NBA Athlete Event Log ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:54 UTC
#> # A tibble: 25 × 8
#>    league athlete_id season event_id  team_id played event_ref   competition_ref
#>    <chr>  <chr>       <int> <chr>     <chr>   <lgl>  <chr>       <chr>          
#>  1 nba    1966         2025 401716949 13      FALSE  http://spo… http://sports.…
#>  2 nba    1966         2025 401716955 13      TRUE   http://spo… http://sports.…
#>  3 nba    1966         2025 401716980 13      TRUE   http://spo… http://sports.…
#>  4 nba    1966         2025 401717008 13      TRUE   http://spo… http://sports.…
#>  5 nba    1966         2025 401717017 13      FALSE  http://spo… http://sports.…
#>  6 nba    1966         2025 401717026 13      FALSE  http://spo… http://sports.…
#>  7 nba    1966         2025 401704628 13      TRUE   http://spo… http://sports.…
#>  8 nba    1966         2025 401704651 13      TRUE   http://spo… http://sports.…
#>  9 nba    1966         2025 401704662 13      TRUE   http://spo… http://sports.…
#> 10 nba    1966         2025 401704677 13      TRUE   http://spo… http://sports.…
#> # ℹ 15 more rows
# }
```
