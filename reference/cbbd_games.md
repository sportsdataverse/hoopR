# **CBD Games**

**Get college basketball games from the CollegeBasketballData API.**

## Usage

``` r
cbbd_games(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL,
  status = NULL,
  tournament = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- season_type:

  (*character* optional): One of `regular`, `postseason`, `preseason`.

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

- start_date_range:

  (*character* optional): ISO 8601 start of date range.

- end_date_range:

  (*character* optional): ISO 8601 end of date range.

- status:

  (*character* optional): One of `scheduled`, `in_progress`, `final`,
  `postponed`, `cancelled`.

- tournament:

  (*character* optional): Tournament filter.

## Value

A `hoopR_data` tibble with one row per game (key columns; period-point
arrays are returned as list-columns):

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| id              | integer   | CollegeBasketballData game id.          |
| source_id       | character | Source (ESPN) game id.                  |
| season          | integer   | Season (4-digit ending-year).           |
| season_type     | character | Season type.                            |
| start_date      | character | Game start date (ISO 8601).             |
| neutral_site    | logical   | Whether the game was at a neutral site. |
| conference_game | logical   | Whether the game was a conference game. |
| status          | character | Game status.                            |
| home_team_id    | integer   | Home team id.                           |
| home_team       | character | Home team name.                         |
| home_points     | integer   | Home team points.                       |
| home_winner     | logical   | Whether the home team won.              |
| away_team_id    | integer   | Away team id.                           |
| away_team       | character | Away team name.                         |
| away_points     | integer   | Away team points.                       |
| away_winner     | logical   | Whether the away team won.              |
| venue_id        | integer   | Venue id.                               |
| venue           | character | Venue name.                             |

## See also

Other CBD Games Functions:
[`cbbd_games_media()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
[`cbbd_games_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_players.md),
[`cbbd_games_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_teams.md),
[`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_scoreboard.md)

## Examples

``` r
# \donttest{
  try(cbbd_games(season = 2024, team = "Duke"))
#> ✖ 2026-06-09 09:57:40.166758: Invalid arguments or no games data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, status = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
