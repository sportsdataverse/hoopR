# **CBD Team Stats Leaderboard**

**Get the team statistics leaderboard from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_stats_team_leaderboard(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per team. Nested statistic objects
(`record`, `summary`, `team_stats`, `opponent_stats`, `shot_profile`,
`adjusted_efficiency`) are flattened into prefixed columns. Key
identifying columns:

|          |           |                               |
|----------|-----------|-------------------------------|
| col_name | types     | description                   |
| season   | integer   | Season (4-digit ending-year). |
| team_id  | integer   | Team id.                      |
| team     | character | Team name.                    |

## See also

Other CBD Stats Functions:
[`cbbd_stats_player_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_season.md),
[`cbbd_stats_player_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_shooting_season.md),
[`cbbd_stats_team_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_season.md),
[`cbbd_stats_team_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_shooting_season.md)

## Examples

``` r
# \donttest{
  try(cbbd_stats_team_leaderboard(season = 2024))
#> ✖ 2026-06-24 02:48:34.712606: Invalid arguments or no team stats leaderboard available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
