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

A data frame with the following columns:

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| pg_number            | numeric   |
| pg_player_first_name | character |
| pg_player_last_name  | character |
| pg_hgt               | character |
| pg_wgt               | numeric   |
| pg_yr                | character |
| pg_min_pct           | numeric   |
| sg_number            | numeric   |
| sg_player_first_name | character |
| sg_player_last_name  | character |
| sg_hgt               | character |
| sg_wgt               | numeric   |
| sg_yr                | character |
| sg_min_pct           | numeric   |
| sf_number            | numeric   |
| sf_player_first_name | character |
| sf_player_last_name  | character |
| sf_hgt               | character |
| sf_wgt               | numeric   |
| sf_yr                | character |
| sf_min_pct           | numeric   |
| pf_number            | numeric   |
| pf_player_first_name | character |
| pf_player_last_name  | character |
| pf_hgt               | character |
| pf_wgt               | numeric   |
| pf_yr                | character |
| pf_min_pct           | numeric   |
| c_number             | numeric   |
| c_player_first_name  | character |
| c_player_last_name   | character |
| c_hgt                | character |
| c_wgt                | numeric   |
| c_yr                 | character |
| c_min_pct            | numeric   |
| team                 | character |
| year                 | numeric   |

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
#> 2026-03-24 01:21:00.374934 - Florida St. - 2021 Team Depth Chart is missing
#> Error in kp_team_depth_chart(team = "Florida St.", year = 2021) : 
#>   object 'kenpom' not found
  # }

```
