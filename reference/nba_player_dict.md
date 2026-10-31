# **NBA Player Dictionary**

A tidy player dictionary (id, name, team, bio, headshot URL) sourced
from the stats.nba.com player index. Handy for joining player ids to
names/teams and for fetching headshots.

## Usage

``` r
nba_player_dict(season = year_to_season(most_recent_nba_season() - 2), ...)
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
if (FALSE) { # interactive()
# \donttest{
  try(nba_player_dict())
# }
}
```
