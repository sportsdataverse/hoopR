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

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| team_rk           | numeric   |
| team              | character |
| opponent_rk       | numeric   |
| opponent          | character |
| result            | character |
| poss              | numeric   |
| ot                | numeric   |
| pre_wp            | numeric   |
| location          | character |
| w                 | numeric   |
| l                 | numeric   |
| w_conference      | numeric   |
| l_conference      | numeric   |
| conference_game   | logical   |
| postseason        | character |
| year              | numeric   |
| day_date          | character |
| game_date         | numeric   |
| w_proj            | numeric   |
| l_proj            | numeric   |
| w_conference_proj | numeric   |
| l_conference_proj | numeric   |
| date              | character |
| game_id           | numeric   |
| tiers_of_joy      | character |

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
#> Error in kp_team_schedule(team = "Florida St.", year = 2022) : 
#>   object 'kenpom' not found
# }
```
