# **CBD Plays by Game**

**Get play-by-play data for a single game from the CollegeBasketballData
API.**

**Get play-by-play data for a single player from the
CollegeBasketballData API.**

**Get play-by-play data for a team-season from the CollegeBasketballData
API.**

**Get play-by-play data for all games on a date from the
CollegeBasketballData API.**

**Get play-by-play data for a tournament from the CollegeBasketballData
API.**

**Get the list of play types from the CollegeBasketballData API.**

## Usage

``` r
cbbd_plays_game(game_id, shooting_plays_only = FALSE)

cbbd_plays_player(
  player_id,
  season = most_recent_mbb_season(),
  shooting_plays_only = FALSE
)

cbbd_plays_team(
  season = most_recent_mbb_season(),
  team,
  shooting_plays_only = FALSE
)

cbbd_plays_date(date, shooting_plays_only = FALSE, utc_offset = NULL)

cbbd_plays_tournament(
  tournament,
  season = most_recent_mbb_season(),
  shooting_plays_only = FALSE
)

cbbd_play_types()
```

## Arguments

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md).

- shooting_plays_only:

  (*logical* optional): If `TRUE`, return only shooting plays. Defaults
  to `FALSE`.

- player_id:

  (*integer* required): Athlete id.

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* required): Team name (e.g. `Duke`).

- date:

  (*character* required): Date-time in ISO 8601 format (e.g.
  `2024-02-01T00:00:00.000Z`).

- utc_offset:

  (*numeric* optional): UTC offset (hours) for the date.

- tournament:

  (*character* required): Tournament name (e.g. `NCAA`).

## Value

A `hoopR_data` tibble with one row per play (key columns; `shot_info` is
flattened to `shot_info_*`, `participants`/`on_floor` are list-columns):

|                   |           |                                  |
|-------------------|-----------|----------------------------------|
| col_name          | types     | description                      |
| id                | integer   | Play id.                         |
| game_id           | integer   | Game id.                         |
| season            | numeric   | Season (4-digit ending-year).    |
| play_type         | character | Play type description.           |
| team_id           | integer   | Team id of the team on the play. |
| team              | character | Team on the play.                |
| period            | integer   | Period number.                   |
| clock             | character | Game clock.                      |
| seconds_remaining | integer   | Seconds remaining in the period. |
| home_score        | integer   | Home score after the play.       |
| away_score        | integer   | Away score after the play.       |
| scoring_play      | logical   | Whether the play scored.         |
| shooting_play     | logical   | Whether the play was a shot.     |
| score_value       | numeric   | Point value of the play.         |
| play_text         | character | Play description text.           |

A `hoopR_data` tibble with one row per play (same columns as
`cbbd_plays_game()`).

A `hoopR_data` tibble with one row per play (same columns as
`cbbd_plays_game()`).

A `hoopR_data` tibble with one row per play (same columns as
`cbbd_plays_game()`).

A `hoopR_data` tibble with one row per play (same columns as
`cbbd_plays_game()`).

A `hoopR_data` tibble with one row per play type:

|          |           |                 |
|----------|-----------|-----------------|
| col_name | types     | description     |
| id       | integer   | Play type id.   |
| name     | character | Play type name. |

## Examples

``` r
# \donttest{
  try(cbbd_plays_game(game_id = 5881))
#> ✖ 2026-08-27 17:46:33.854211: Invalid arguments or no play data available for 5881!
#> ✖ Args: game_id = 5881, shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_plays_player(player_id = 160, season = 2024))
#> ✖ 2026-08-27 17:46:33.864457: Invalid arguments or no play data available for player 160!
#> ✖ Args: player_id = 160, season = 2024, shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_plays_team(season = 2024, team = "Duke"))
#> ✖ 2026-08-27 17:46:33.874027: Invalid arguments or no play data available for Duke!
#> ✖ Args: season = 2024, team = "Duke", shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_plays_date(date = "2024-02-01T00:00:00.000Z"))
#> ✖ 2026-08-27 17:46:33.883753: Invalid arguments or no play data available for 2024-02-01T00:00:00.000Z!
#> ✖ Args: date = "2024-02-01T00:00:00.000Z", shooting_plays_only = FALSE, utc_offset = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_plays_tournament(tournament = "NCAA", season = 2024))
#> ✖ 2026-08-27 17:46:33.894614: Invalid arguments or no play data available for NCAA!
#> ✖ Args: tournament = "NCAA", season = 2024, shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_play_types())
#> ✖ 2026-08-27 17:46:33.904867: Invalid arguments or no play types available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
