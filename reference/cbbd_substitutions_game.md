# **CBD Substitutions by Game**

**Get substitution data for a single game from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_substitutions_game(game_id)
```

## Arguments

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md).

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

## See also

Other CBD Substitutions Functions:
[`cbbd_substitutions_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_player.md),
[`cbbd_substitutions_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_team.md)

## Examples

``` r
# \donttest{
  try(cbbd_substitutions_game(game_id = 5881))
#> ✖ 2026-06-12 02:22:37.010074: Invalid arguments or no substitution data available for 5881!
#> ✖ Args: game_id = 5881
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
