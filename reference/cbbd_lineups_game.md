# **CBD Team Lineups**

**Get lineup statistics for a team-season from the CollegeBasketballData
API.**

**Get lineup statistics for a single game from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_lineups_team(
  season = most_recent_mbb_season(),
  team,
  start_date_range = NULL,
  end_date_range = NULL
)

cbbd_lineups_game(game_id)
```

## Arguments

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* required): Team name (e.g. `Duke`).

- start_date_range:

  (*character* optional): ISO 8601 start of date range.

- end_date_range:

  (*character* optional): ISO 8601 end of date range.

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md).

## Value

A `hoopR_data` tibble with one row per lineup. The `athletes` column is
a list of lineup members; `team_stats`/`opponent_stats` are flattened
into prefixed columns. Key identifying columns:

|                |           |                                     |
|----------------|-----------|-------------------------------------|
| col_name       | types     | description                         |
| team_id        | integer   | Team id.                            |
| team           | character | Team name.                          |
| conference     | character | Conference name.                    |
| id_hash        | character | Unique hash identifying the lineup. |
| athletes       | list      | List of athletes in the lineup.     |
| total_seconds  | numeric   | Total seconds the lineup played.    |
| pace           | numeric   | Lineup pace (possessions).          |
| offense_rating | numeric   | Lineup offensive rating.            |
| defense_rating | numeric   | Lineup defensive rating.            |
| net_rating     | numeric   | Lineup net rating.                  |

A `hoopR_data` tibble with one row per lineup (same columns as
`cbbd_lineups_team()`).

## Examples

``` r
# \donttest{
  try(cbbd_lineups_team(season = 2024, team = "Duke"))
#> ✖ 2026-08-26 19:54:17.157689: Invalid arguments or no lineup data available for Duke!
#> ✖ Args: season = 2024, team = "Duke", start_date_range = NULL, end_date_range = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_lineups_game(game_id = 5881))
#> ✖ 2026-08-26 19:54:17.168019: Invalid arguments or no lineup data available for 5881!
#> ✖ Args: game_id = 5881
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
