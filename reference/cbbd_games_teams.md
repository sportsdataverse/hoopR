# **CBD Team Box Scores**

**Get team box score statistics from the CollegeBasketballData API.**

## Usage

``` r
cbbd_games_teams(
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

A `hoopR_data` tibble with one row per team-game. Per-team statistic
objects (`team_stats`, `opponent_stats`) are flattened into
`team_stats_*` / `opponent_stats_*` columns. Key identifying columns:

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| game_id      | integer   | CollegeBasketballData game id.          |
| season       | integer   | Season (4-digit ending-year).           |
| start_date   | character | Game start date (ISO 8601).             |
| team_id      | integer   | Team id.                                |
| team         | character | Team name.                              |
| conference   | character | Team conference.                        |
| opponent_id  | integer   | Opponent team id.                       |
| opponent     | character | Opponent team name.                     |
| is_home      | logical   | Whether the team was home.              |
| neutral_site | logical   | Whether the game was at a neutral site. |
| game_minutes | numeric   | Total team minutes.                     |
| pace         | numeric   | Game pace (possessions).                |

## See also

Other CBD Games Functions:
[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md),
[`cbbd_games_media()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
[`cbbd_games_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_players.md),
[`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_scoreboard.md)

## Examples

``` r
# \donttest{
  try(cbbd_games_teams(season = 2024, team = "Duke"))
#> ✖ 2026-06-13 03:22:43.458303: Invalid arguments or no team box score data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
