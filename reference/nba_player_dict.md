# **NBA Player Dictionary**

A tidy player dictionary (id, name, team, bio, headshot URL) sourced
from the stats.nba.com player index. Handy for joining player ids to
names/teams and for fetching headshots.

## Usage

``` r
nba_player_dict(season = year_to_season(most_recent_nba_season() - 1), ...)
```

## Arguments

- season:

  Season in `"YYYY-YY"` form. Defaults to the most recent completed
  season.

- ...:

  Additional arguments passed to
  [`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)
  (e.g. `proxy`).

## Value

A `hoopR_data` tibble with one row per player:

|                   |           |                                        |
|-------------------|-----------|----------------------------------------|
| col_name          | types     | description                            |
| player_id         | character | Player id (`PERSON_ID`).               |
| player_name       | character | Full name.                             |
| player_slug       | character | URL-safe player slug.                  |
| team_id           | character | Team id.                               |
| team_abbreviation | character | Team abbreviation.                     |
| team_name         | character | Full team name.                        |
| position          | character | Listed position.                       |
| jersey_number     | character | Jersey number.                         |
| height            | character | Listed height.                         |
| weight            | character | Listed weight.                         |
| country           | character | Country.                               |
| draft_year        | character | Draft year.                            |
| from_year         | character | First season.                          |
| to_year           | character | Most recent season.                    |
| headshot_url      | character | NBA CDN headshot URL.                  |
| season            | character | Season (echoes the `season` argument). |

## See also

Other NBA Dictionary Functions:
[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md),
[`nba_team_dict()`](https://hoopR.sportsdataverse.org/reference/nba_team_dict.md),
[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)

## Examples

``` r
# \donttest{
  try(nba_player_dict())
#> ✖ 2026-08-25 02:57:31.074244: Invalid arguments or no player index data for 2025-26 available!
#> ✖ Args: college = "", country = "", draft_pick = "", draft_round = "", draft_year = "", height = "", historical = 1, league_id = "00", season = "2025-26", season_type = "Regular Season", team_id = "0", weight = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-08-25 02:57:31.08673: No NBA player dictionary for 2025-26 available!
#> ✖ Args: season = "2025-26"
#> ✖ Error: No player index returned
#> data frame with 0 columns and 0 rows
# }
```
