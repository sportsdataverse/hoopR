# **Get the NBA cross-source schedule crosswalk**

Build a wide, one-row-per-game crosswalk linking ESPN and NBA Stats game
ids (NA Fox/Yahoo placeholders). Dates from both sources are reduced to
the local Eastern-Time game date before joining. Note: the NBA Stats CDN
serves the current season only, so the live builder is effectively
current-season; historical coverage comes from cached release artifacts.

## Usage

``` r
nba_schedule_crosswalk(season = most_recent_nba_season())
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)).

## Value

A `hoopR_data` tibble, one row per game.

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_schedule_crosswalk())
#> ✖ 2026-06-13 04:29:22.851601: Invalid arguments or no scoreboard data available!
#> ✖ Args: season = 20260213L
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:29:34 UTC
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
