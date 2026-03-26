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

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| year                 | numeric   |
| team                 | character |
| min_pct              | numeric   |
| pg_number            | numeric   |
| pg_player_first_name | character |
| pg_player_last_name  | character |
| pg_hgt               | character |
| pg_wgt               | numeric   |
| pg_yr                | character |
| sg_number            | numeric   |
| sg_player_first_name | character |
| sg_player_last_name  | character |
| sg_hgt               | character |
| sg_wgt               | numeric   |
| sg_yr                | character |
| sf_number            | numeric   |
| sf_player_first_name | character |
| sf_player_last_name  | character |
| sf_hgt               | character |
| sf_wgt               | numeric   |
| sf_yr                | character |
| pf_number            | numeric   |
| pf_player_first_name | character |
| pf_player_last_name  | character |
| pf_hgt               | character |
| pf_wgt               | numeric   |
| pf_yr                | character |
| c_number             | numeric   |
| c_player_first_name  | character |
| c_player_last_name   | character |
| c_hgt                | character |
| c_wgt                | numeric   |
| c_yr                 | character |

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
#> 2026-03-26 14:51:23.305255 - Florida St. - 2021 Team Lineups are missing
#> Error in kp_team_lineups(team = "Florida St.", year = 2021) : 
#>   object 'kenpom' not found
  # }
```
