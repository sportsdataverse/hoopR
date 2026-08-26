# **Get team schedule results**

**Get team schedule results**

**Get KenPom's team game plan page**

**Get KenPom's team opponent tracker page**

**Get KenPom's player stats from the team page**

**Get KenPom's player career stats from the player page**

**Get Minutes Matrix from Expanded Player Page**

**Get Team Player Stats**

**Get Depth Chart Last 5 Games from Team Page**

**Get Lineups Last 5 Games from Team Page**

## Usage

``` r
kp_team_schedule(team, year = 2022)

kp_gameplan(team, year = 2021)

kp_opptracker(team, year = 2021)

kp_team_players(team, year = 2021)

kp_player_career(player_id)

kp_minutes_matrix(team, year = 2021)

kp_team_player_stats(team, year = 2021)

kp_team_depth_chart(team, year = 2021)

kp_team_lineups(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

- player_id:

  Player Id filter to select.

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

Returns a tibble of team opponent tracker data

|                  |           |                                              |
|------------------|-----------|----------------------------------------------|
| col_name         | types     | description                                  |
| date             | Date      | Date in YYYY-MM-DD format.                   |
| game_date        | numeric   | Game date (YYYY-MM-DD).                      |
| day_date         | character | Date in YYYY-MM-DD format.                   |
| wl               | character | Wl.                                          |
| team             | character | Team-side label or team identifier.          |
| team_score       | numeric   | Team's score / final score.                  |
| opponent         | character | Opponent.                                    |
| opponent_score   | numeric   | Opponent score.                              |
| result           | character | Result.                                      |
| adj_oe           | numeric   | Adj oe.                                      |
| adj_oe_rk        | integer   | Adj oe rk.                                   |
| off_e_fg_pct     | numeric   | Off e field goals percentage (0-1 decimal).  |
| off_e_fg_pct_rk  | integer   | Off e fg pct rk.                             |
| off_to_pct       | numeric   | Off to percentage (0-1 decimal).             |
| off_to_pct_rk    | integer   | Off to pct rk.                               |
| off_or_pct       | numeric   | Off or percentage (0-1 decimal).             |
| off_or_pct_rk    | integer   | Off or pct rk.                               |
| off_ft_rate      | numeric   | Off ft rate.                                 |
| off_ft_rate_rk   | integer   | Off ft rate rk.                              |
| off_fg_2_pct     | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fg_2_pct_rk  | integer   | Off fg 2 pct rk.                             |
| off_fg_3_pct     | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3_pct_rk  | integer   | Off fg 3 pct rk.                             |
| off_blk_pct      | numeric   | Off blocks percentage (0-1 decimal).         |
| off_blk_pct_rk   | integer   | Off blk pct rk.                              |
| off_fg_3a_pct    | numeric   | Off field goals 3a percentage (0-1 decimal). |
| off_fg_3a_pct_rk | integer   | Off fg 3a pct rk.                            |
| off_apl          | numeric   | Off apl.                                     |
| off_apl_rk       | integer   | Off apl rk.                                  |
| adj_de           | numeric   | Adj de.                                      |
| adj_de_rk        | integer   | Adj de rk.                                   |
| def_e_fg_pct     | numeric   | Def e field goals percentage (0-1 decimal).  |
| def_e_fg_pct_rk  | integer   | Def e fg pct rk.                             |
| def_to_pct       | numeric   | Def to percentage (0-1 decimal).             |
| def_to_pct_rk    | integer   | Def to pct rk.                               |
| def_or_pct       | numeric   | Def or percentage (0-1 decimal).             |
| def_or_pct_rk    | integer   | Def or pct rk.                               |
| def_ft_rate      | numeric   | Def ft rate.                                 |
| def_ft_rate_rk   | integer   | Def ft rate rk.                              |
| def_fg_2_pct     | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fg_2_pct_rk  | integer   | Def fg 2 pct rk.                             |
| def_fg_3_pct     | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3_pct_rk  | integer   | Def fg 3 pct rk.                             |
| def_blk_pct      | numeric   | Def blocks percentage (0-1 decimal).         |
| def_blk_pct_rk   | integer   | Def blk pct rk.                              |
| def_fg_3a_pct    | numeric   | Def field goals 3a percentage (0-1 decimal). |
| def_fg_3a_pct_rk | integer   | Def fg 3a pct rk.                            |
| def_apl          | numeric   | Def apl.                                     |
| def_apl_rk       | integer   | Def apl rk.                                  |

Returns a tibble of team player data

|               |           |                                         |
|---------------|-----------|-----------------------------------------|
| col_name      | types     | description                             |
| role          | character | Role.                                   |
| number        | numeric   | Number.                                 |
| player        | character | Player.                                 |
| ht            | character | Ht.                                     |
| wt            | numeric   | Wt.                                     |
| yr            | character | Yr.                                     |
| g             | numeric   | Games played.                           |
| s             | numeric   | S.                                      |
| min_pct       | numeric   | Min percentage (0-1 decimal).           |
| o_rtg         | numeric   | O rtg.                                  |
| poss_pct      | numeric   | Poss percentage (0-1 decimal).          |
| shots_pct     | numeric   | Shots percentage (0-1 decimal).         |
| e_fg_pct      | numeric   | E field goals percentage (0-1 decimal). |
| ts_pct        | numeric   | True shooting percentage (0-1).         |
| or_pct        | numeric   | Or percentage (0-1 decimal).            |
| dr_pct        | numeric   | Dr percentage (0-1 decimal).            |
| a_rate        | numeric   | A rate.                                 |
| to_rate       | numeric   | To rate.                                |
| blk_pct       | numeric   | Blocks percentage (0-1 decimal).        |
| stl_pct       | numeric   | Steals percentage (0-1 decimal).        |
| f_cper40      | numeric   | F cper40.                               |
| f_dper40      | numeric   | F dper40.                               |
| ft_rate       | numeric   | Ft rate.                                |
| ftm           | numeric   | Free throws made.                       |
| fta           | numeric   | Free throw attempts.                    |
| ft_pct        | numeric   | Free throw percentage (0-1).            |
| fgm_2         | numeric   | Fgm 2.                                  |
| fga_2         | numeric   | Fga 2.                                  |
| fg_2_pct      | numeric   | Field goals 2 percentage (0-1 decimal). |
| fgm_3         | numeric   | Fgm 3.                                  |
| fga_3         | numeric   | Fga 3.                                  |
| fg_3_pct      | numeric   | Field goals 3 percentage (0-1 decimal). |
| min_pct_rk    | numeric   | Min pct rk.                             |
| o_rtg_rk      | numeric   | O rtg rk.                               |
| poss_pct_rk   | numeric   | Poss pct rk.                            |
| shots_pct_rk  | numeric   | Shots pct rk.                           |
| e_fg_pct_rk   | numeric   | E fg pct rk.                            |
| ts_pct_rk     | numeric   | Ts pct rk.                              |
| or_pct_rk     | numeric   | Or pct rk.                              |
| dr_pct_rk     | numeric   | Dr pct rk.                              |
| a_rate_rk     | numeric   | A rate rk.                              |
| to_rate_rk    | numeric   | To rate rk.                             |
| blk_pct_rk    | numeric   | Blk pct rk.                             |
| stl_pct_rk    | numeric   | Stl pct rk.                             |
| f_cper40_rk   | numeric   | F cper40 rk.                            |
| f_dper40_rk   | numeric   | F dper40 rk.                            |
| ft_rate_rk    | numeric   | Ft rate rk.                             |
| ft_pct_rk     | numeric   | Ft pct rk.                              |
| fg_2_pct_rk   | numeric   | Fg 2 pct rk.                            |
| fg_3_pct_rk   | numeric   | Fg 3 pct rk.                            |
| national_rank | character | League/season rank for national.        |
| team          | character | Team-side label or team identifier.     |
| year          | numeric   | 4-digit year.                           |
| player_id     | numeric   | Unique player identifier.               |

Returns a named list of tibbles: player_stats, gamelog

**player_stats**

|               |           |                                         |
|---------------|-----------|-----------------------------------------|
| col_name      | types     | description                             |
| year          | numeric   | 4-digit year.                           |
| team_rk       | numeric   | Team rk.                                |
| team          | character | Team-side label or team identifier.     |
| number        | numeric   | Number.                                 |
| name          | character | Display name.                           |
| position      | character | Listed roster position (G, F, C, etc.). |
| hgt           | character | Hgt.                                    |
| wgt           | numeric   | Wgt.                                    |
| yr            | character | Yr.                                     |
| g             | numeric   | Games played.                           |
| min_pct       | numeric   | Min percentage (0-1 decimal).           |
| o_rtg         | numeric   | O rtg.                                  |
| poss_pct      | numeric   | Poss percentage (0-1 decimal).          |
| shots_pct     | numeric   | Shots percentage (0-1 decimal).         |
| e_fg_pct      | numeric   | E field goals percentage (0-1 decimal). |
| ts_pct        | numeric   | True shooting percentage (0-1).         |
| or_pct        | numeric   | Or percentage (0-1 decimal).            |
| dr_pct        | numeric   | Dr percentage (0-1 decimal).            |
| a_rate        | numeric   | A rate.                                 |
| to_rate       | numeric   | To rate.                                |
| blk_pct       | numeric   | Blocks percentage (0-1 decimal).        |
| stl_pct       | numeric   | Steals percentage (0-1 decimal).        |
| f_cper40      | numeric   | F cper40.                               |
| f_dper40      | numeric   | F dper40.                               |
| ft_rate       | numeric   | Ft rate.                                |
| ftm           | numeric   | Free throws made.                       |
| fta           | numeric   | Free throw attempts.                    |
| ft_pct        | numeric   | Free throw percentage (0-1).            |
| fgm_2         | numeric   | Fgm 2.                                  |
| fga_2         | numeric   | Fga 2.                                  |
| fg_2_pct      | numeric   | Field goals 2 percentage (0-1 decimal). |
| fgm_3         | numeric   | Fgm 3.                                  |
| fga_3         | numeric   | Fga 3.                                  |
| fg_3_pct      | numeric   | Field goals 3 percentage (0-1 decimal). |
| group_rank    | character | League/season rank for group.           |
| team_finish   | character | Team finish.                            |
| ncaa_seed     | numeric   | Ncaa seed.                              |
| hometown      | character | Player hometown.                        |
| date_of_birth | character | Date of birth (YYYY-MM-DD).             |
| age           | character | Player age (in years).                  |
| comparisons   | character | Comparisons.                            |

**gamelog**

|                |           |                                         |
|----------------|-----------|-----------------------------------------|
| col_name       | types     | description                             |
| year           | numeric   | 4-digit year.                           |
| team           | character | Team-side label or team identifier.     |
| name           | character | Display name.                           |
| position       | character | Listed roster position (G, F, C, etc.). |
| opponent_tier  | logical   | Opponent tier.                          |
| date           | character | Date in YYYY-MM-DD format.              |
| opponent_rk    | numeric   | Opponent rk.                            |
| opponent       | character | Opponent.                               |
| result         | character | Result.                                 |
| ot             | character | Ot.                                     |
| location       | character | Location.                               |
| game_type      | character | Game type.                              |
| mvp            | character | Mvp.                                    |
| start          | character | Start.                                  |
| minutes_played | numeric   | Minutes played.                         |
| o_rtg          | numeric   | O rtg.                                  |
| poss_pct       | numeric   | Poss percentage (0-1 decimal).          |
| pts            | numeric   | Points scored.                          |
| fgm_2          | numeric   | Fgm 2.                                  |
| fga_2          | numeric   | Fga 2.                                  |
| fgm_3          | numeric   | Fgm 3.                                  |
| fga_3          | numeric   | Fga 3.                                  |
| ftm            | numeric   | Free throws made.                       |
| fta            | numeric   | Free throw attempts.                    |
| or             | numeric   | Or.                                     |
| dr             | numeric   | Dr.                                     |
| a              | numeric   | A.                                      |
| to             | numeric   | To.                                     |
| blk            | numeric   | Blocks.                                 |
| stl            | numeric   | Steals.                                 |
| pf             | numeric   | Personal fouls.                         |

Returns a tibble of minutes matrix data

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

Same columns as the **all_games** table above.

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

## Examples

``` r
# \donttest{
  try(kp_team_schedule(team = 'Florida St.', year = 2022))
#> ✖ 2026-08-26 19:56:01.428211: 2026-08-26 - No team schedule tables available for Florida St. - 2022
#> ✖ Args: team = "Florida St.", year = 2022
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
   try(kp_gameplan(team='Florida St.', year=2021))
#> ✖ 2026-08-26 19:56:01.485401: 2026-08-26 - No Game Plan Points distribution tables available for Florida St. - 2021
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
  try(kp_opptracker(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-26 19:56:01.54082: 2026-08-26 19:56:01.54051 - Florida St. - 2021 Team opponent tracker data is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
  # \donttest{
    try(kp_team_players(team = 'Florida St.', year = 2024))
#> ✖ 2026-08-26 19:56:01.605867: 2026-08-26 19:56:01.605556 - No Player Data available for Florida St. in 2024
#> ✖ Args: team = "Florida St.", year = 2024
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }

  # \donttest{
    try(kp_player_career(player_id = '41180'))
#> ✖ 2026-08-26 19:56:01.66373: 2026-08-26 19:56:01.663449 - No Player Career Data available for 41180
#> ✖ Args: player_id = "41180"
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }

  # \donttest{
    try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-26 19:56:01.722762: 2026-08-26 19:56:01.722435 - Florida St. - 2021 minutes matrix is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }


  # \donttest{
    try(kp_team_player_stats(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-26 19:56:01.781745: 2026-08-26 19:56:01.781435 - Florida St. - 2021 team player stats are missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }
  # \donttest{
    try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
#> ✖ 2026-08-26 19:56:01.845227: 2026-08-26 19:56:01.84483 - Florida St. - 2021 Team Depth Chart is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }


  # \donttest{
    try(kp_team_lineups(team = 'Florida St.', year = 2021))
#> ✖ 2026-08-26 19:56:01.901584: 2026-08-26 19:56:01.901278 - Florida St. - 2021 Team Lineups are missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }
```
