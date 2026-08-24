# **Get Team Player Stats**

**Get Team Player Stats**

## Usage

``` r
kp_team_player_stats(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a list of named data frames: all_games, conference_games

**all_games**

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| role         | character | Role.                                   |
| number       | numeric   | Number.                                 |
| player       | character | Player.                                 |
| ht           | character | Ht.                                     |
| wt           | numeric   | Wt.                                     |
| yr           | character | Yr.                                     |
| g            | numeric   | Games played.                           |
| min_pct      | numeric   | Min percentage (0-1 decimal).           |
| o_rtg        | numeric   | O rtg.                                  |
| poss_pct     | numeric   | Poss percentage (0-1 decimal).          |
| shots_pct    | numeric   | Shots percentage (0-1 decimal).         |
| e_fg_pct     | numeric   | E field goals percentage (0-1 decimal). |
| ts_pct       | numeric   | True shooting percentage (0-1).         |
| or_pct       | numeric   | Or percentage (0-1 decimal).            |
| dr_pct       | numeric   | Dr percentage (0-1 decimal).            |
| a_rate       | numeric   | A rate.                                 |
| to_rate      | numeric   | To rate.                                |
| blk_pct      | numeric   | Blocks percentage (0-1 decimal).        |
| stl_pct      | numeric   | Steals percentage (0-1 decimal).        |
| f_cper40     | numeric   | F cper40.                               |
| f_dper40     | numeric   | F dper40.                               |
| ft_rate      | numeric   | Ft rate.                                |
| ftm          | numeric   | Free throws made.                       |
| fta          | numeric   | Free throw attempts.                    |
| ft_pct       | numeric   | Free throw percentage (0-1).            |
| fgm_2        | numeric   | Fgm 2.                                  |
| fga_2        | numeric   | Fga 2.                                  |
| fg_2_pct     | numeric   | Field goals 2 percentage (0-1 decimal). |
| fgm_3        | numeric   | Fgm 3.                                  |
| fga_3        | numeric   | Fga 3.                                  |
| fg_3_pct     | numeric   | Field goals 3 percentage (0-1 decimal). |
| category     | character | Category label.                         |
| min_pct_rk   | numeric   | Min pct rk.                             |
| o_rtg_rk     | numeric   | O rtg rk.                               |
| poss_pct_rk  | numeric   | Poss pct rk.                            |
| shots_pct_rk | numeric   | Shots pct rk.                           |
| e_fg_pct_rk  | numeric   | E fg pct rk.                            |
| ts_pct_rk    | numeric   | Ts pct rk.                              |
| or_pct_rk    | numeric   | Or pct rk.                              |
| dr_pct_rk    | numeric   | Dr pct rk.                              |
| a_rate_rk    | numeric   | A rate rk.                              |
| to_rate_rk   | numeric   | To rate rk.                             |
| blk_pct_rk   | numeric   | Blk pct rk.                             |
| stl_pct_rk   | numeric   | Stl pct rk.                             |
| f_cper40_rk  | numeric   | F cper40 rk.                            |
| f_dper40_rk  | numeric   | F dper40 rk.                            |
| ft_rate_rk   | numeric   | Ft rate rk.                             |
| ft_pct_rk    | numeric   | Ft pct rk.                              |
| fg_2_pct_rk  | numeric   | Fg 2 pct rk.                            |
| fg_3_pct_rk  | numeric   | Fg 3 pct rk.                            |
| group_rank   | character | League/season rank for group.           |
| team         | character | Team-side label or team identifier.     |
| year         | numeric   | 4-digit year.                           |
| player_id    | numeric   | Unique player identifier.               |

**conference_games**

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| role         | character | Role.                                   |
| number       | numeric   | Number.                                 |
| player       | character | Player.                                 |
| ht           | character | Ht.                                     |
| wt           | numeric   | Wt.                                     |
| yr           | character | Yr.                                     |
| g            | numeric   | Games played.                           |
| min_pct      | numeric   | Min percentage (0-1 decimal).           |
| o_rtg        | numeric   | O rtg.                                  |
| poss_pct     | numeric   | Poss percentage (0-1 decimal).          |
| shots_pct    | numeric   | Shots percentage (0-1 decimal).         |
| e_fg_pct     | numeric   | E field goals percentage (0-1 decimal). |
| ts_pct       | numeric   | True shooting percentage (0-1).         |
| or_pct       | numeric   | Or percentage (0-1 decimal).            |
| dr_pct       | numeric   | Dr percentage (0-1 decimal).            |
| a_rate       | numeric   | A rate.                                 |
| to_rate      | numeric   | To rate.                                |
| blk_pct      | numeric   | Blocks percentage (0-1 decimal).        |
| stl_pct      | numeric   | Steals percentage (0-1 decimal).        |
| f_cper40     | numeric   | F cper40.                               |
| f_dper40     | numeric   | F dper40.                               |
| ft_rate      | numeric   | Ft rate.                                |
| ftm          | numeric   | Free throws made.                       |
| fta          | numeric   | Free throw attempts.                    |
| ft_pct       | numeric   | Free throw percentage (0-1).            |
| fgm_2        | numeric   | Fgm 2.                                  |
| fga_2        | numeric   | Fga 2.                                  |
| fg_2_pct     | numeric   | Field goals 2 percentage (0-1 decimal). |
| fgm_3        | numeric   | Fgm 3.                                  |
| fga_3        | numeric   | Fga 3.                                  |
| fg_3_pct     | numeric   | Field goals 3 percentage (0-1 decimal). |
| category     | character | Category label.                         |
| min_pct_rk   | numeric   | Min pct rk.                             |
| o_rtg_rk     | numeric   | O rtg rk.                               |
| poss_pct_rk  | numeric   | Poss pct rk.                            |
| shots_pct_rk | numeric   | Shots pct rk.                           |
| e_fg_pct_rk  | numeric   | E fg pct rk.                            |
| ts_pct_rk    | numeric   | Ts pct rk.                              |
| or_pct_rk    | numeric   | Or pct rk.                              |
| dr_pct_rk    | numeric   | Dr pct rk.                              |
| a_rate_rk    | numeric   | A rate rk.                              |
| to_rate_rk   | numeric   | To rate rk.                             |
| blk_pct_rk   | numeric   | Blk pct rk.                             |
| stl_pct_rk   | numeric   | Stl pct rk.                             |
| f_cper40_rk  | numeric   | F cper40 rk.                            |
| f_dper40_rk  | numeric   | F dper40 rk.                            |
| ft_rate_rk   | numeric   | Ft rate rk.                             |
| ft_pct_rk    | numeric   | Ft pct rk.                              |
| fg_2_pct_rk  | numeric   | Fg 2 pct rk.                            |
| fg_3_pct_rk  | numeric   | Fg 3 pct rk.                            |
| group_rank   | character | League/season rank for group.           |
| team         | character | Team-side label or team identifier.     |
| year         | numeric   | 4-digit year.                           |
| player_id    | numeric   | Unique player identifier.               |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_player_stats(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-24 19:11:56.058825: 2026-08-24 19:11:56.058537 - Florida St. - 2021 team player stats are missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }
```
