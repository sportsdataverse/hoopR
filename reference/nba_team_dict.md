# **NBA Team Dictionary**

A tidy team dictionary (id, abbreviation, name, conference, division,
logo URL) derived from the stats.nba.com player index plus a static
conference/division map.

## Usage

``` r
nba_team_dict(season = year_to_season(most_recent_nba_season() - 2), ...)
```

## Arguments

- season:

  Season in `"YYYY-YY"` form. Defaults to the previous season,
  `year_to_season(most_recent_nba_season() - 2)` (the current season
  rolls over in October).

- ...:

  Additional arguments passed to
  [`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)
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
if (FALSE) { # interactive()
# \donttest{
  try(nba_team_dict())
# }
}
```
