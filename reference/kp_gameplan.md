# **Get KenPom's team game plan page**

**Get KenPom's team game plan page**

## Usage

``` r
kp_gameplan(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a named list of tibbles: gameplan, correlations,
position_distributions

**gameplan**

|                |           |
|----------------|-----------|
| col_name       | types     |
| date           | Date      |
| opponent_rk    | numeric   |
| opponent       | character |
| result         | character |
| location       | character |
| pace           | numeric   |
| off_eff        | numeric   |
| off_eff_rk     | numeric   |
| off_e_fg_pct   | numeric   |
| off_to_pct     | numeric   |
| off_or_pct     | numeric   |
| off_ftr        | numeric   |
| off_fgm_2      | numeric   |
| off_fga_2      | numeric   |
| off_fg_2_pct   | numeric   |
| off_fgm_3      | numeric   |
| off_fga_3      | numeric   |
| off_fg_3_pct   | numeric   |
| off_fg_3a_pct  | numeric   |
| def_eff        | numeric   |
| def_eff_rk     | numeric   |
| def_e_fg_pct   | numeric   |
| def_to_pct     | numeric   |
| def_or_pct     | numeric   |
| def_ftr        | numeric   |
| def_fgm_2      | numeric   |
| def_fga_2      | numeric   |
| def_fg_2_pct   | numeric   |
| def_fgm_3      | numeric   |
| def_fga_3      | numeric   |
| def_fg_3_pct   | numeric   |
| def_fg_3a_pct  | numeric   |
| wl             | character |
| team_score     | numeric   |
| opponent_score | numeric   |
| day_date       | character |
| game_date      | numeric   |

**correlations**

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| correlations_r_x_100 | character |
| pace                 | character |
| off_e_fg_pct         | character |
| off_to_pct           | character |
| off_or_pct           | character |
| off_ftr              | character |
| def_e_fg_pct         | character |
| def_to_pct           | character |
| def_or_pct           | character |
| def_ftr              | character |

**position_distributions**

|               |           |
|---------------|-----------|
| col_name      | types     |
| team          | character |
| category      | character |
| c_pct         | numeric   |
| pf_pct        | numeric   |
| sf_pct        | numeric   |
| sg_pct        | numeric   |
| pg_pct        | numeric   |
| c_pct_rk      | numeric   |
| pf_pct_rk     | numeric   |
| sf_pct_rk     | numeric   |
| sg_pct_rk     | numeric   |
| pg_pct_rk     | numeric   |
| c_pct_d1_avg  | numeric   |
| pf_pct_d1_avg | numeric   |
| sf_pct_d1_avg | numeric   |
| sg_pct_d1_avg | numeric   |
| pg_pct_d1_avg | numeric   |

## See also

Other KenPom Team Functions:
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
# \donttest{
   try(kp_gameplan(team='Florida St.', year=2021))
#> 2026-03-26 - No Game Plan Points distribution tables available for Florida St. - 2021
#> Error in kp_gameplan(team = "Florida St.", year = 2021) : 
#>   object 'kenpom' not found
# }
```
