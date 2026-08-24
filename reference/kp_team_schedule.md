# **Get team schedule results**

**Get team schedule results**

## Usage

``` r
kp_team_schedule(team, year = 2022)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of team schedules

|                   |           |                                     |
|-------------------|-----------|-------------------------------------|
| col_name          | types     | description                         |
| team_rk           | numeric   | Team rk.                            |
| team              | character | Team-side label or team identifier. |
| opponent_rk       | numeric   | Opponent rk.                        |
| opponent          | character | Opponent.                           |
| result            | character | Result.                             |
| poss              | numeric   | Poss.                               |
| ot                | numeric   | Ot.                                 |
| pre_wp            | numeric   | Pre wp.                             |
| location          | character | Location.                           |
| w                 | numeric   | Wins.                               |
| l                 | numeric   | Losses.                             |
| w_conference      | numeric   | W conference.                       |
| l_conference      | numeric   | L conference.                       |
| conference_game   | logical   | Conference game.                    |
| postseason        | character | Postseason.                         |
| year              | numeric   | 4-digit year.                       |
| day_date          | character | Date in YYYY-MM-DD format.          |
| game_date         | numeric   | Game date (YYYY-MM-DD).             |
| w_proj            | numeric   | W proj.                             |
| l_proj            | numeric   | L proj.                             |
| w_conference_proj | numeric   | W conference proj.                  |
| l_conference_proj | numeric   | L conference proj.                  |
| date              | character | Date in YYYY-MM-DD format.          |
| game_id           | numeric   | Unique game identifier.             |
| tiers_of_joy      | character | Tiers of joy.                       |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md)

## Examples

``` r
# \donttest{
  try(kp_team_schedule(team = 'Florida St.', year = 2022))
#> ✖ 2026-08-24 19:11:56.475452: 2026-08-24 - No team schedule tables available for Florida St. - 2022
#> ✖ Args: team = "Florida St.", year = 2022
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
