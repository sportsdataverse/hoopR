# **Load hoopR NBA schedule crosswalk**

Loads a pre-built per-season NBA schedule crosswalk that links ESPN game
identifiers to NBA.com game identifiers. The files are versioned `.rds`
snapshots stored in the `nba_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons. (Min:
  2002; default:
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per NBA game per
season. Columns include at minimum `season`, `espn_game_id`, and
`nba_game_id`.

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:51:46 UTC
#> # A tibble: 1,416 × 16
#>    season season_type game_date  home_espn_team_id away_espn_team_id
#>     <int> <chr>       <date>                 <int>             <int>
#>  1   2026 Pre-Season  2025-10-02                18                20
#>  2   2026 NA          2025-10-03                 3            111124
#>  3   2026 Pre-Season  2025-10-03                13                21
#>  4   2026 Pre-Season  2025-10-04                20                18
#>  5   2026 NA          2025-10-04                17            131570
#>  6   2026 Pre-Season  2025-10-04                14                19
#>  7   2026 Pre-Season  2025-10-04                 7                16
#>  8   2026 NA          2025-10-04                 3            126120
#>  9   2026 Pre-Season  2025-10-05                30                25
#> 10   2026 Pre-Season  2025-10-05                 9                13
#> # ℹ 1,406 more rows
#> # ℹ 11 more variables: espn_game_id <chr>, nba_game_id <chr>,
#> #   nba_game_code <chr>, nba_home_team_id <chr>, nba_away_team_id <chr>,
#> #   fox_game_id <chr>, fox_home_team_id <chr>, fox_away_team_id <chr>,
#> #   yahoo_game_id <chr>, match_method <chr>, match_confidence <dbl>
# }
```
