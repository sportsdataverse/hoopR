# **Get Lineups Last 5 Games from Team Page**

**Get Lineups Last 5 Games from Team Page**

## Usage

``` r
kp_team_lineups(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|                      |           |                                     |
|----------------------|-----------|-------------------------------------|
| col_name             | types     | description                         |
| year                 | numeric   | 4-digit year.                       |
| team                 | character | Team-side label or team identifier. |
| min_pct              | numeric   | Min percentage (0-1 decimal).       |
| pg_number            | numeric   | Pg number.                          |
| pg_player_first_name | character | Pg player first name.               |
| pg_player_last_name  | character | Pg player last name.                |
| pg_hgt               | character | Pg hgt.                             |
| pg_wgt               | numeric   | Pg wgt.                             |
| pg_yr                | character | Pg yr.                              |
| sg_number            | numeric   | Sg number.                          |
| sg_player_first_name | character | Sg player first name.               |
| sg_player_last_name  | character | Sg player last name.                |
| sg_hgt               | character | Sg hgt.                             |
| sg_wgt               | numeric   | Sg wgt.                             |
| sg_yr                | character | Sg yr.                              |
| sf_number            | numeric   | Sf number.                          |
| sf_player_first_name | character | Sf player first name.               |
| sf_player_last_name  | character | Sf player last name.                |
| sf_hgt               | character | Sf hgt.                             |
| sf_wgt               | numeric   | Sf wgt.                             |
| sf_yr                | character | Sf yr.                              |
| pf_number            | numeric   | Pf number.                          |
| pf_player_first_name | character | Personal fouls player first name.   |
| pf_player_last_name  | character | Personal fouls player last name.    |
| pf_hgt               | character | Pf hgt.                             |
| pf_wgt               | numeric   | Pf wgt.                             |
| pf_yr                | character | Pf yr.                              |
| c_number             | numeric   | C number.                           |
| c_player_first_name  | character | C player first name.                |
| c_player_last_name   | character | C player last name.                 |
| c_hgt                | character | C hgt.                              |
| c_wgt                | numeric   | C wgt.                              |
| c_yr                 | character | C yr.                               |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_lineups(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-06 04:00:55.156101: 2026-08-06 04:00:55.155856 - Florida St. - 2021 Team Lineups are missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }
```
