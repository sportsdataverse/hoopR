# **CBD Player Box Scores**

**Get player box score statistics from the CollegeBasketballData API.**

## Usage

``` r
cbbd_games_players(
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

A `hoopR_data` tibble with one row per team-game. The `players` column
is a nested list of per-player box scores. Key identifying columns:

|              |           |                                       |
|--------------|-----------|---------------------------------------|
| col_name     | types     | description                           |
| game_id      | integer   | CollegeBasketballData game id.        |
| season       | integer   | Season (4-digit ending-year).         |
| start_date   | character | Game start date (ISO 8601).           |
| team_id      | integer   | Team id.                              |
| team         | character | Team name.                            |
| conference   | character | Team conference.                      |
| opponent_id  | integer   | Opponent team id.                     |
| opponent     | character | Opponent team name.                   |
| is_home      | logical   | Whether the team was home.            |
| game_minutes | numeric   | Total team minutes.                   |
| game_pace    | numeric   | Game pace (possessions).              |
| players      | list      | Nested list of per-player box scores. |

## See also

Other CBD Games Functions:
[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md),
[`cbbd_games_media()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
[`cbbd_games_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_teams.md),
[`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_scoreboard.md)

## Examples

``` r
# \donttest{
  try(cbbd_games_players(season = 2024, team = "Duke"))
#> ✖ 2026-08-06 03:58:49.39932: Invalid arguments or no player box score data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
