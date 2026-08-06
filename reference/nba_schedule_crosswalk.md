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
#> ✖ 2026-08-06 04:08:17.019018: Invalid arguments or no league standings v3 data available for 2025-26!
#> ✖ Args: league_id = "00", season = "2025-26", season_type = "Regular Season", season_year = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-08-06 04:09:17.050282: Invalid arguments or no league game log data for 2025-26 available!
#> ✖ Args: counter = 0, date_from = "", date_to = "", direction = "ASC", league_id = "00", player_or_team = "T", season = "2025-26", season_type = "Regular Season", sorter = "DATE"
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60002 milliseconds with 0 bytes received
#> ✖ 2026-08-06 04:09:17.060956: Invalid arguments or no team details data available!
#> ✖ Error: argument is of length zero
#> Error in !nrow(nt) : invalid argument type
# }
```
