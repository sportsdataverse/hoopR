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
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_schedule_crosswalk())
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ─────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-10 23:10:17 UTC
#> # A tibble: 1,281 × 16
#>    season season_type game_date  home_espn_team_id away_espn_team_id
#>     <int> <chr>       <date>                 <int>             <int>
#>  1   2027 Pre-Season  2026-10-03                28                14
#>  2   2027 Pre-Season  2026-10-04                 7                26
#>  3   2027 Pre-Season  2026-10-04                12                 9
#>  4   2027 Pre-Season  2026-10-05                 1                29
#>  5   2027 Pre-Season  2026-10-05                 8                21
#>  6   2027 Pre-Season  2026-10-05                20                18
#>  7   2027 Pre-Season  2026-10-05                15                16
#>  8   2027 Pre-Season  2026-10-05                23                13
#>  9   2027 Pre-Season  2026-10-06                30                17
#> 10   2027 Pre-Season  2026-10-06                25                 3
#> # ℹ 1,271 more rows
#> # ℹ 11 more variables: espn_game_id <chr>, nba_game_id <chr>,
#> #   nba_game_code <chr>, nba_home_team_id <chr>, nba_away_team_id <chr>,
#> #   fox_game_id <chr>, fox_home_team_id <chr>, fox_away_team_id <chr>,
#> #   yahoo_game_id <chr>, match_method <chr>, match_confidence <dbl>
# }
```
