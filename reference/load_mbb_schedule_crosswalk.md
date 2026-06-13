# **Load hoopR MBB schedule crosswalk**

Loads a pre-built per-season MBB schedule crosswalk that links ESPN game
identifiers to Bart Torvik game identifiers. The files are versioned
`.rds` snapshots stored in the `mbb_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002; default:
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per MBB game per
season. Columns include at minimum `season` and `espn_game_id`.

## See also

Other MBB Crosswalk Functions:
[`load_mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_crosswalk.md),
[`load_mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:55:41 UTC
#> # A tibble: 6,386 × 14
#>    season game_date  home_espn_team_id away_espn_team_id espn_game_id bart_muid 
#>     <int> <date>                 <int>             <int> <chr>        <chr>     
#>  1   2026 2025-11-03               248              2329 401824809    LehighHou…
#>  2   2026 2025-11-03                12                57 401826885    ArizonaFl…
#>  3   2026 2025-11-03                41              2441 401812785    New Haven…
#>  4   2026 2025-11-03              2599              2514 401820577    Quinnipia…
#>  5   2026 2025-11-03               130              2473 401826083    OaklandMi…
#>  6   2026 2025-11-03               252               222 401819834    BYUVillan…
#>  7   2026 2025-11-03                97              2569 401817239    South Car…
#>  8   2026 2025-11-03                26               331 401813756    Eastern W…
#>  9   2026 2025-11-03                 8              2582 401826784    SouthernA…
#> 10   2026 2025-11-03               333               155 401812260    North Dak…
#> # ℹ 6,376 more rows
#> # ℹ 8 more variables: bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>,
#> #   kp_game_id <chr>, fox_game_id <chr>, yahoo_game_id <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
```
