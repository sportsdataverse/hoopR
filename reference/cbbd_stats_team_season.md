# **CBD Team Season Stats**

**Get team season statistics from the CollegeBasketballData API.**

## Usage

``` r
cbbd_stats_team_season(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL
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

## Value

A `hoopR_data` tibble with one row per team-season. The `team_stats` and
`opponent_stats` objects are flattened into `team_stats_*` /
`opponent_stats_*` columns. Key identifying columns:

|               |           |                               |
|---------------|-----------|-------------------------------|
| col_name      | types     | description                   |
| season        | integer   | Season (4-digit ending-year). |
| team_id       | integer   | Team id.                      |
| team          | character | Team name.                    |
| conference    | character | Conference name.              |
| games         | integer   | Games played.                 |
| wins          | numeric   | Wins.                         |
| losses        | numeric   | Losses.                       |
| total_minutes | numeric   | Total minutes played.         |
| pace          | numeric   | Average pace (possessions).   |

## See also

Other CBD Stats Functions:
[`cbbd_stats_player_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_season.md),
[`cbbd_stats_player_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_shooting_season.md),
[`cbbd_stats_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_leaderboard.md),
[`cbbd_stats_team_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_shooting_season.md)

## Examples

``` r
# \donttest{
  try(cbbd_stats_team_season(season = 2024, team = "Duke"))
#> ✖ 2026-06-09 21:38:41.810208: Invalid arguments or no team season stats available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
