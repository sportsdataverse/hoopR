# **Get Depth Chart Last 5 Games from Team Page**

**Get Depth Chart Last 5 Games from Team Page**

## Usage

``` r
kp_team_depth_chart(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

A data frame with one row per rostered player, with the following
columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| team | character | Team-side label or team identifier. |
| year | numeric | 4-digit year. |
| player_id | integer | KenPom player identifier. |
| player_name | character | Player full name. |
| class_year | character | Class year (e.g. 'Fr', 'So', 'Jr', 'Sr'). |
| height | character | Height (e.g. '6-9'). |
| weight | numeric | Weight in pounds. |
| pct_pg | numeric | Percentage of the player's minutes played at point guard (0-1 decimal). |
| pct_sg | numeric | Percentage of the player's minutes played at shooting guard (0-1 decimal). |
| pct_sf | numeric | Percentage of the player's minutes played at small forward (0-1 decimal). |
| pct_pf | numeric | Percentage of the player's minutes played at power forward (0-1 decimal). |
| pct_c | numeric | Percentage of the player's minutes played at center (0-1 decimal). |
| pct_poss | numeric | Percentage of team possessions used while the player was on the floor (0-1 decimal). |
| fta | integer | Season free throw attempts. |
| fg2a | integer | Season 2-point field goal attempts. |
| fg3a | integer | Season 3-point field goal attempts. |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
#> ✖ 2026-08-24 19:11:55.378964: 2026-08-24 19:11:55.378711 - Florida St. - 2021 Team Depth Chart is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }

```
