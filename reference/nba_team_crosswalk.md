# **Get the NBA cross-source team crosswalk**

Build a wide, one-row-per-team crosswalk linking ESPN, NBA Stats, and
Fox team identities, keyed on `espn_team_id`.
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md)
already supplies the ESPN\<-\>Stats linkage; this reshapes it and
attaches Fox. Yahoo columns are NA placeholders. NOTE: ESPN/Stats team
endpoints are current-season snapshots, so `season` is a stamp;
historical relocations are not back-modeled live.

## Usage

``` r
nba_team_crosswalk(season = most_recent_nba_season())
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md);
  e.g. 2025 for 2024-25).

## Value

A `hoopR_data` tibble, one row per team (ESPN / `nba_*` / Fox / Yahoo
column groups + `match_method` / `match_confidence`).

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_team_crosswalk())
#> ✖ 2026-06-24 03:03:37.787996: Invalid arguments or no league standings v3 data available for 2025-26!
#> ✖ Args: league_id = "00", season = "2025-26", season_type = "Regular Season", season_year = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-06-24 03:04:37.826305: Invalid arguments or no league game log data for 2025-26 available!
#> ✖ Args: counter = 0, date_from = "", date_to = "", direction = "ASC", league_id = "00", player_or_team = "T", season = "2025-26", season_type = "Regular Season", sorter = "DATE"
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60002 milliseconds with 0 bytes received
#> ✖ 2026-06-24 03:04:37.838221: Invalid arguments or no team details data available!
#> ✖ Error: argument is of length zero
#> Error in !nrow(nt) : invalid argument type
# }
```
