# **CBD Scoreboard**

**Get the current scoreboard from the CollegeBasketballData API.**

## Usage

``` r
cbbd_scoreboard(conference = NULL)
```

## Arguments

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per game. The `home_team`,
`away_team` and `betting` objects are flattened into `home_team_*`,
`away_team_*` and `betting_*` columns. Key identifying columns:

|                 |           |                                        |
|-----------------|-----------|----------------------------------------|
| col_name        | types     | description                            |
| id              | integer   | CollegeBasketballData game id.         |
| start_date      | character | Game start date (ISO 8601).            |
| tv              | character | Broadcast TV network.                  |
| neutral_site    | logical   | Whether the game is at a neutral site. |
| conference_game | logical   | Whether the game is a conference game. |
| status          | character | Game status.                           |
| period          | integer   | Current period.                        |
| clock           | character | Game clock.                            |
| venue           | character | Venue name.                            |

## See also

Other CBD Games Functions:
[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md),
[`cbbd_games_media()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
[`cbbd_games_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_players.md),
[`cbbd_games_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_teams.md)

## Examples

``` r
# \donttest{
  try(cbbd_scoreboard(conference = "ACC"))
#> ✖ 2026-06-09 09:57:45.180456: Invalid arguments or no scoreboard data available!
#> ✖ Args: conference = "ACC"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
