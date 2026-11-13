# **CBD Games**

**Get college basketball games from the CollegeBasketballData API.**

**Get game broadcast media information from the CollegeBasketballData
API.**

**Get team box score statistics from the CollegeBasketballData API.**

**Get player box score statistics from the CollegeBasketballData API.**

**Get the current scoreboard from the CollegeBasketballData API.**

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

cbbd_games_media(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL,
  tournament = NULL
)

cbbd_games_teams(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL,
  tournament = NULL
)

cbbd_games_players(
  season = most_recent_mbb_season(),
  season_type = NULL,
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL,
  tournament = NULL
)

cbbd_scoreboard(conference = NULL)
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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_games")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_games_media")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-game. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_games_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-game. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_games_players")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_scoreboard")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_games(season = 2024, team = "Duke"))
#> ✖ 2026-11-13 18:52:37.762634: Invalid arguments or no games data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, status = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_games_media(season = 2024, team = "Duke"))
#> ✖ 2026-11-13 18:52:37.773842: Invalid arguments or no game media available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_games_teams(season = 2024, team = "Duke"))
#> ✖ 2026-11-13 18:52:37.783759: Invalid arguments or no team box score data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_games_players(season = 2024, team = "Duke"))
#> ✖ 2026-11-13 18:52:37.794428: Invalid arguments or no player box score data available!
#> ✖ Args: season = 2024, season_type = NULL, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL, tournament = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_scoreboard(conference = "ACC"))
#> ✖ 2026-11-13 18:52:37.804914: Invalid arguments or no scoreboard data available!
#> ✖ Args: conference = "ACC"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
