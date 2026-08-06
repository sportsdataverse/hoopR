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

|                |           |                                              |
|----------------|-----------|----------------------------------------------|
| col_name       | types     | description                                  |
| date           | Date      | Date in YYYY-MM-DD format.                   |
| opponent_rk    | numeric   | Opponent rk.                                 |
| opponent       | character | Opponent.                                    |
| result         | character | Result.                                      |
| location       | character | Location.                                    |
| pace           | numeric   | Possessions per 48 minutes.                  |
| off_eff        | numeric   | Off eff.                                     |
| off_eff_rk     | numeric   | Off eff rk.                                  |
| off_e_fg_pct   | numeric   | Off e field goals percentage (0-1 decimal).  |
| off_to_pct     | numeric   | Off to percentage (0-1 decimal).             |
| off_or_pct     | numeric   | Off or percentage (0-1 decimal).             |
| off_ftr        | numeric   | Off ftr.                                     |
| off_fgm_2      | numeric   | Off fgm 2.                                   |
| off_fga_2      | numeric   | Off fga 2.                                   |
| off_fg_2_pct   | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fgm_3      | numeric   | Off fgm 3.                                   |
| off_fga_3      | numeric   | Off fga 3.                                   |
| off_fg_3_pct   | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3a_pct  | numeric   | Off field goals 3a percentage (0-1 decimal). |
| def_eff        | numeric   | Def eff.                                     |
| def_eff_rk     | numeric   | Def eff rk.                                  |
| def_e_fg_pct   | numeric   | Def e field goals percentage (0-1 decimal).  |
| def_to_pct     | numeric   | Def to percentage (0-1 decimal).             |
| def_or_pct     | numeric   | Def or percentage (0-1 decimal).             |
| def_ftr        | numeric   | Def ftr.                                     |
| def_fgm_2      | numeric   | Def fgm 2.                                   |
| def_fga_2      | numeric   | Def fga 2.                                   |
| def_fg_2_pct   | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fgm_3      | numeric   | Def fgm 3.                                   |
| def_fga_3      | numeric   | Def fga 3.                                   |
| def_fg_3_pct   | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3a_pct  | numeric   | Def field goals 3a percentage (0-1 decimal). |
| wl             | character | Wl.                                          |
| team_score     | numeric   | Team's score / final score.                  |
| opponent_score | numeric   | Opponent score.                              |
| day_date       | character | Date in YYYY-MM-DD format.                   |
| game_date      | numeric   | Game date (YYYY-MM-DD).                      |

**correlations**

|                      |           |                                             |
|----------------------|-----------|---------------------------------------------|
| col_name             | types     | description                                 |
| correlations_r_x_100 | character | Correlations r x 100.                       |
| pace                 | character | Possessions per 48 minutes.                 |
| off_e_fg_pct         | character | Off e field goals percentage (0-1 decimal). |
| off_to_pct           | character | Off to percentage (0-1 decimal).            |
| off_or_pct           | character | Off or percentage (0-1 decimal).            |
| off_ftr              | character | Off ftr.                                    |
| def_e_fg_pct         | character | Def e field goals percentage (0-1 decimal). |
| def_to_pct           | character | Def to percentage (0-1 decimal).            |
| def_or_pct           | character | Def or percentage (0-1 decimal).            |
| def_ftr              | character | Def ftr.                                    |

**position_distributions**

|               |           |                                          |
|---------------|-----------|------------------------------------------|
| col_name      | types     | description                              |
| team          | character | Team-side label or team identifier.      |
| category      | character | Category label.                          |
| c_pct         | numeric   | C percentage (0-1 decimal).              |
| pf_pct        | numeric   | Personal fouls percentage (0-1 decimal). |
| sf_pct        | numeric   | Sf percentage (0-1 decimal).             |
| sg_pct        | numeric   | Sg percentage (0-1 decimal).             |
| pg_pct        | numeric   | Pg percentage (0-1 decimal).             |
| c_pct_rk      | numeric   | C pct rk.                                |
| pf_pct_rk     | numeric   | Pf pct rk.                               |
| sf_pct_rk     | numeric   | Sf pct rk.                               |
| sg_pct_rk     | numeric   | Sg pct rk.                               |
| pg_pct_rk     | numeric   | Pg pct rk.                               |
| c_pct_d1_avg  | numeric   | C pct d1 avg.                            |
| pf_pct_d1_avg | numeric   | Pf pct d1 avg.                           |
| sf_pct_d1_avg | numeric   | Sf pct d1 avg.                           |
| sg_pct_d1_avg | numeric   | Sg pct d1 avg.                           |
| pg_pct_d1_avg | numeric   | Pg pct d1 avg.                           |

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
#> ✖ 2026-08-06 04:00:52.331648: 2026-08-06 - No Game Plan Points distribution tables available for Florida St. - 2021
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
