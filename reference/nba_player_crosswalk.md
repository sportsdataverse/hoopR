# **Get the NBA cross-source player crosswalk**

Build a wide, one-row-per-player-per-team crosswalk linking ESPN, NBA
Stats, and Fox player identities. Matching is deterministic: normalized
exact name within a team block, then Jaro-Winkler fuzzy with jersey/DOB
tiebreakers. Yahoo columns are NA placeholders.

## Usage

``` r
nba_player_crosswalk(season = most_recent_nba_season(), min_confidence = 0.92)
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)).

- min_confidence:

  Jaro-Winkler similarity floor for fuzzy matches (default 0.92).

## Value

A `hoopR_data` tibble, one row per player per team (ESPN-anchored).

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_player_crosswalk())
#> ✖ 2026-06-12 14:48:34.565304: Invalid arguments or no league standings v3 data available for 2025-26!
#> ✖ Args: league_id = "00", season = "2025-26", season_type = "Regular Season", season_year = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-06-12 14:49:34.606461: Invalid arguments or no league game log data for 2025-26 available!
#> ✖ Args: counter = 0, date_from = "", date_to = "", direction = "ASC", league_id = "00", player_or_team = "T", season = "2025-26", season_type = "Regular Season", sorter = "DATE"
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-06-12 14:49:34.619003: Invalid arguments or no team details data available!
#> ✖ Error: argument is of length zero
#> Error in !nrow(nt) : invalid argument type
# }
```
