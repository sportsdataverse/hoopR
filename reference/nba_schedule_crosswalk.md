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
#> ✖ 2026-08-25 00:32:23.698596: Invalid arguments or no league schedule data for 2025-26 available!
#> ✖ Args: league_id = "00", season = "2025-26"
#> ✖ Error: lexical error: invalid char in json text.                                        <HTML><HEAD> <TITLE>Access Deni                      (right here) ------^ 
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:32:23 UTC
#> # A tibble: 0 × 16
#> # ℹ 16 variables: season <int>, season_type <chr>, game_date <date>,
#> #   home_espn_team_id <int>, away_espn_team_id <int>, espn_game_id <chr>,
#> #   nba_game_id <chr>, nba_game_code <chr>, nba_home_team_id <chr>,
#> #   nba_away_team_id <chr>, fox_game_id <chr>, fox_home_team_id <chr>,
#> #   fox_away_team_id <chr>, yahoo_game_id <chr>, match_method <chr>,
#> #   match_confidence <dbl>
# }
```
