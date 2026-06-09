# **CBD Game Media**

**Get game broadcast media information from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_games_media(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL,
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

- tournament:

  (*character* optional): Tournament filter.

## Value

A `hoopR_data` tibble with one row per game. The `broadcasts` column is
a nested list of broadcast outlets:

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| game_id         | integer   | CollegeBasketballData game id.          |
| season          | integer   | Season (4-digit ending-year).           |
| season_type     | character | Season type.                            |
| start_date      | character | Game start date (ISO 8601).             |
| home_team_id    | integer   | Home team id.                           |
| home_team       | character | Home team name.                         |
| away_team_id    | integer   | Away team id.                           |
| away_team       | character | Away team name.                         |
| neutral_site    | logical   | Whether the game was at a neutral site. |
| conference_game | logical   | Whether the game was a conference game. |
| broadcasts      | list      | Nested list of broadcast outlets.       |

## See also

Other CBD Games Functions:
[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md),
[`cbbd_games_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_players.md),
[`cbbd_games_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_teams.md),
[`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_scoreboard.md)

## Examples

``` r
# \donttest{
  try(cbbd_games_media(season = 2024, team = "Duke"))
#> ✖ 2026-06-09 19:07:00.981451: Invalid arguments or no game media available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
