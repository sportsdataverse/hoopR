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
if (FALSE) { # interactive()
# \donttest{
  try(nba_schedule_crosswalk())
# }
}
```
