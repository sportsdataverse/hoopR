# **CBD Plays by Game**

**Get play-by-play data for a single game from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_plays_game(game_id, shooting_plays_only = FALSE)
```

## Arguments

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md).

- shooting_plays_only:

  (*logical* optional): If `TRUE`, return only shooting plays. Defaults
  to `FALSE`.

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

## See also

Other CBD Plays Functions:
[`cbbd_play_types()`](https://hoopR.sportsdataverse.org/reference/cbbd_play_types.md),
[`cbbd_plays_date()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_date.md),
[`cbbd_plays_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_player.md),
[`cbbd_plays_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_team.md),
[`cbbd_plays_tournament()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_tournament.md)

## Examples

``` r
# \donttest{
  try(cbbd_plays_game(game_id = 5881))
#> ✖ 2026-06-09 12:13:55.938275: Invalid arguments or no play data available for 5881!
#> ✖ Args: game_id = 5881, shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
