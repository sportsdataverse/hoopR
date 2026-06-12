# **NBA Team Dictionary**

A tidy team dictionary (id, abbreviation, name, conference, division,
logo URL) derived from the stats.nba.com player index plus a static
conference/division map.

## Usage

``` r
nba_team_dict(season = year_to_season(most_recent_nba_season() - 1), ...)
```

## Arguments

- season:

  Season in `"YYYY-YY"` form. Defaults to the most recent completed
  season.

- ...:

  Additional arguments passed to
  [`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md)
  (e.g. `proxy`).

## Value

A `hoopR_data` tibble with one row per team:

|                   |           |                                     |
|-------------------|-----------|-------------------------------------|
| col_name          | types     | description                         |
| team_id           | character | Team id.                            |
| team_abbreviation | character | Team abbreviation.                  |
| team_city         | character | Team city / region.                 |
| team_name         | character | Team nickname.                      |
| team_full         | character | Full team name.                     |
| conference        | character | Conference (`Eastern` / `Western`). |
| division          | character | Division.                           |
| logo_url          | character | NBA CDN primary logo URL.           |

## See also

Other NBA Dictionary Functions:
[`nba_player_dict()`](https://hoopR.sportsdataverse.org/reference/nba_player_dict.md),
[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md),
[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)

## Examples

``` r
# \donttest{
  try(nba_team_dict())
#> ✖ 2026-06-12 23:43:59.1081: Invalid arguments or no player index data for 2025-26 available!
#> ✖ Args: college = "", country = "", draft_pick = "", draft_round = "", draft_year = "", height = "", historical = 0, league_id = "00", season = "2025-26", season_type = "Regular Season", team_id = "0", weight = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60002 milliseconds with 0 bytes received
#> ✖ 2026-06-12 23:43:59.119553: No NBA team dictionary available!
#> ✖ Args: season = "2025-26"
#> ✖ Error: No player index returned
#> data frame with 0 columns and 0 rows
# }
```
