# **CBD Substitutions by Game**

**Get substitution data for a single game from the CollegeBasketballData
API.**

**Get substitution data for a single player from the
CollegeBasketballData API.**

**Get substitution data for a team-season from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_substitutions_game(game_id)

cbbd_substitutions_player(player_id, season = most_recent_mbb_season())

cbbd_substitutions_team(season = most_recent_mbb_season(), team)
```

## Arguments

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md).

- player_id:

  (*integer* required): Athlete id.

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* required): Team name (e.g. `Duke`).

## Value

A `hoopR_data` tibble with one row per substitution. `sub_in` and
`sub_out` objects are flattened to `sub_in_*` / `sub_out_*` columns:

|                     |           |                             |
|---------------------|-----------|-----------------------------|
| col_name            | types     | description                 |
| game_id             | integer   | Game id.                    |
| start_date          | character | Game start date (ISO 8601). |
| team_id             | integer   | Team id.                    |
| team                | character | Team name.                  |
| conference          | character | Team conference.            |
| athlete_id          | integer   | Athlete id.                 |
| athlete             | character | Athlete name.               |
| position            | character | Athlete position.           |
| opponent_id         | integer   | Opponent team id.           |
| opponent            | character | Opponent team name.         |
| opponent_conference | character | Opponent conference.        |

A `hoopR_data` tibble with one row per substitution (same columns as
`cbbd_substitutions_game()`).

A `hoopR_data` tibble with one row per substitution (same columns as
`cbbd_substitutions_game()`).

## Examples

``` r
# \donttest{
  try(cbbd_substitutions_game(game_id = 5881))
#> ✖ 2026-08-25 02:46:51.258541: Invalid arguments or no substitution data available for 5881!
#> ✖ Args: game_id = 5881
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_substitutions_player(player_id = 160, season = 2024))
#> ✖ 2026-08-25 02:46:51.2685: Invalid arguments or no substitution data available for player 160!
#> ✖ Args: player_id = 160, season = 2024
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_substitutions_team(season = 2024, team = "Duke"))
#> ✖ 2026-08-25 02:46:51.278412: Invalid arguments or no substitution data available for Duke!
#> ✖ Args: season = 2024, team = "Duke"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
