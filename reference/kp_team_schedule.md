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
#>    team_rk        team opponent_rk          opponent    result poss ot pre_wp
#> 1       24 Florida St.         211              Penn W, 105-70   80 NA     NA
#> 2       23 Florida St.          59           Florida  L, 71-55   68 NA     NA
#> 3       31 Florida St.          98            Tulane  W, 59-54   63 NA     NA
#> 4       32 Florida St.         203  Loyola Marymount  W, 73-45   70 NA     NA
#> 5       27 Florida St.         137          Missouri  W, 81-58   67 NA     NA
#> 6       23 Florida St.         218 Boston University  W, 81-80   74  1     NA
#> 7       29 Florida St.          14            Purdue  L, 93-65   68 NA     NA
#> 8       32 Florida St.          69          Syracuse  L, 63-60   69 NA     NA
#> 9       40 Florida St.          99    South Carolina  L, 66-65   71 NA     NA
#> 10      41 Florida St.         264          Lipscomb  W, 97-60   77 NA     NA
#> 11      39 Florida St.         128        N.C. State  W, 83-81   71 NA     NA
#> 12      42 Florida St.          35       Wake Forest  L, 76-54   78 NA     NA
#> 13      47 Florida St.         127        Louisville  W, 79-70   68 NA     NA
#> 14      46 Florida St.          41          Miami FL  W, 65-64   62 NA     NA
#> 15      53 Florida St.          69          Syracuse  W, 76-71   63 NA     NA
#> 16      54 Florida St.           8              Duke  W, 79-78   71  1     NA
#> 17      49 Florida St.         272     North Florida  W, 86-73   72 NA     NA
#> 18      53 Florida St.          41          Miami FL  W, 61-60   64 NA     NA
#> 19      53 Florida St.         156      Georgia Tech  L, 75-61   66 NA     NA
#> 20      71 Florida St.          19     Virginia Tech  L, 85-72   62 NA     NA
#> 21      78 Florida St.          71           Clemson  L, 75-69   66 NA     NA
#> 22      85 Florida St.          35       Wake Forest  L, 68-60   76 NA     NA
#> 23      86 Florida St.         195        Pittsburgh  L, 56-51   66 NA     NA
#> 24      95 Florida St.          16    North Carolina  L, 94-74   75 NA     NA
#> 25     100 Florida St.          71           Clemson  W, 81-80   70 NA     NA
#> 26     101 Florida St.           8              Duke  L, 88-70   67 NA     NA
#> 27     100 Florida St.         114    Boston College  L, 71-55   67 NA     NA
#> 28     110 Florida St.          72          Virginia  W, 64-63   62 NA     NA
#> 29     104 Florida St.          38        Notre Dame  W, 74-70   69 NA     NA
#> 30     105 Florida St.         128        N.C. State  W, 89-76   69 NA     NA
#> 31     101 Florida St.          69          Syracuse  L, 96-57   71 NA     NA
#>     location  w  l w_conference l_conference conference_game
#> 1       Home  1  0           NA           NA           FALSE
#> 2       Away  1  1           NA           NA           FALSE
#> 3       Home  2  1           NA           NA           FALSE
#> 4    Neutral  3  1           NA           NA           FALSE
#> 5    Neutral  4  1           NA           NA           FALSE
#> 6       Home  5  1           NA           NA           FALSE
#> 7       Away  5  2           NA           NA           FALSE
#> 8       Home  5  3            0            1            TRUE
#> 9  Semi-Away  5  4           NA           NA           FALSE
#> 10      Home  6  4           NA           NA           FALSE
#> 11      Away  7  4            1            1            TRUE
#> 12      Away  7  5            1            2            TRUE
#> 13      Home  8  5            2            2            TRUE
#> 14      Home  9  5            3            2            TRUE
#> 15      Away 10  5            4            2            TRUE
#> 16      Home 11  5            5            2            TRUE
#> 17      Home 12  5           NA           NA           FALSE
#> 18      Away 13  5            6            2            TRUE
#> 19      Away 13  6            6            3            TRUE
#> 20      Home 13  7            6            4            TRUE
#> 21      Away 13  8            6            5            TRUE
#> 22      Home 13  9            6            6            TRUE
#> 23      Home 13 10            6            7            TRUE
#> 24      Away 13 11            6            8            TRUE
#> 25      Home 14 11            7            8            TRUE
#> 26      Away 14 12            7            9            TRUE
#> 27      Away 14 13            7           10            TRUE
#> 28      Away 15 13            8           10            TRUE
#> 29      Home 16 13            9           10            TRUE
#> 30      Home 17 13           10           10            TRUE
#> 31   Neutral 17 14           NA           NA           FALSE
#>                              postseason year   day_date game_date w_proj l_proj
#> 1                               Regular 2022 Wed Nov 10  20211110      1      0
#> 2                               Regular 2022 Sun Nov 14  20211114      1      1
#> 3                               Regular 2022 Wed Nov 17  20211117      2      1
#> 4                               Regular 2022 Sun Nov 21  20211121      3      1
#> 5                               Regular 2022 Mon Nov 22  20211122      4      1
#> 6                               Regular 2022 Wed Nov 24  20211124      5      1
#> 7                               Regular 2022 Tue Nov 30  20211130      5      2
#> 8                               Regular 2022  Sat Dec 4  20211204      5      3
#> 9                               Regular 2022 Sun Dec 12  20211212      5      4
#> 10                              Regular 2022 Wed Dec 15  20211215      6      4
#> 11                              Regular 2022  Sat Jan 1  20220101      7      4
#> 12                              Regular 2022  Tue Jan 4  20220104      7      5
#> 13                              Regular 2022  Sat Jan 8  20220108      8      5
#> 14                              Regular 2022 Tue Jan 11  20220111      9      5
#> 15                              Regular 2022 Sat Jan 15  20220115     10      5
#> 16                              Regular 2022 Tue Jan 18  20220118     11      5
#> 17                              Regular 2022 Thu Jan 20  20220120     12      5
#> 18                              Regular 2022 Sat Jan 22  20220122     13      5
#> 19                              Regular 2022 Wed Jan 26  20220126     13      6
#> 20                              Regular 2022 Sat Jan 29  20220129     13      7
#> 21                              Regular 2022  Wed Feb 2  20220202     13      8
#> 22                              Regular 2022  Sat Feb 5  20220205     13      9
#> 23                              Regular 2022  Wed Feb 9  20220209     13     10
#> 24                              Regular 2022 Sat Feb 12  20220212     13     11
#> 25                              Regular 2022 Tue Feb 15  20220215     14     11
#> 26                              Regular 2022 Sat Feb 19  20220219     14     12
#> 27                              Regular 2022 Mon Feb 21  20220221     14     13
#> 28                              Regular 2022 Sat Feb 26  20220226     15     13
#> 29                              Regular 2022  Wed Mar 2  20220302     16     13
#> 30                              Regular 2022  Sat Mar 5  20220305     17     13
#> 31 Atlantic Coast Conference Tournament 2022  Wed Mar 9  20220309     17     14
#>    w_conference_proj l_conference_proj       date game_id tiers_of_joy
#> 1                  0                 0 2021-11-10     188         <NA>
#> 2                  0                 0 2021-11-14     425            A
#> 3                  0                 0 2021-11-17     574         <NA>
#> 4                  0                 0 2021-11-21     790         <NA>
#> 5                  0                 0 2021-11-22    5602         <NA>
#> 6                  0                 0 2021-11-24     945         <NA>
#> 7                  0                 0 2021-11-30    1193            A
#> 8                  0                 1 2021-12-04    1358         <NA>
#> 9                  0                 1 2021-12-12    1766            B
#> 10                 0                 1 2021-12-15    1860         <NA>
#> 11                 1                 1 2022-01-01    2443            B
#> 12                 1                 2 2022-01-04    2587            A
#> 13                 2                 2 2022-01-08    2833         <NA>
#> 14                 3                 2 2022-01-11    2936            B
#> 15                 4                 2 2022-01-15    3203            A
#> 16                 5                 2 2022-01-18    3249            A
#> 17                 5                 2 2022-01-20    2491         <NA>
#> 18                 6                 2 2022-01-22    3528            A
#> 19                 6                 3 2022-01-26    3641         <NA>
#> 20                 6                 4 2022-01-29    3842            A
#> 21                 6                 5 2022-02-02    3956            A
#> 22                 6                 6 2022-02-05    4154            B
#> 23                 6                 7 2022-02-09    4312         <NA>
#> 24                 6                 8 2022-02-12    4543            A
#> 25                 7                 8 2022-02-15    4605         <NA>
#> 26                 7                 9 2022-02-19    4798            A
#> 27                 7                10 2022-02-21    2402            B
#> 28                 8                10 2022-02-26    5236            A
#> 29                 9                10 2022-03-02    5301            B
#> 30                10                10 2022-03-05    5438         <NA>
#> 31                10                10 2022-03-09    3845            B
# }
# \donttest{
   try(kp_gameplan(team='Florida St.', year=2021))
#> $gameplan
#>          date opponent_rk       opponent    result location pace off_eff
#> 1  2020-12-02         297  North Florida  W, 86-58        H   72   118.9
#> 2  2020-12-09          50        Indiana  W, 69-67        H   62    99.1
#> 3  2020-12-12          41        Florida  W, 83-71        H   76   108.6
#> 4  2020-12-15          37   Georgia Tech  W, 74-61        H   64   115.0
#> 5  2020-12-19         100            UCF  L, 86-74        H   69   106.7
#> 6  2020-12-21         182   Gardner Webb  W, 72-59        H   74    97.5
#> 7  2020-12-29          45        Clemson  L, 77-67        A   73    91.2
#> 8  2021-01-13          71     N.C. State W, 105-73        H   69   153.3
#> 9  2021-01-16          34 North Carolina  W, 82-75        H   70   116.8
#> 10 2021-01-18          59     Louisville  W, 78-65        A   66   117.9
#> 11 2021-01-23          45        Clemson  W, 80-61        H   70   115.1
#> 12 2021-01-27         138       Miami FL  W, 81-59        H   68   118.5
#> 13 2021-01-30          37   Georgia Tech  L, 76-65        A   73    89.2
#> 14 2021-02-13         175    Wake Forest  W, 92-85        H   67   121.5
#> 15 2021-02-15          19       Virginia  W, 81-60        H   62   130.8
#> 16 2021-02-20          97     Pittsburgh  W, 79-72        A   71   111.1
#> 17 2021-02-24         138       Miami FL  W, 88-71        A   70   126.3
#> 18 2021-02-27          34 North Carolina  L, 78-70        A   75    92.9
#> 19 2021-03-03         148 Boston College  W, 93-64        H   78   119.8
#> 20 2021-03-06          85     Notre Dame  L, 83-73        A   77    94.4
#> 21 2021-03-12          34 North Carolina  W, 69-66        N   71    97.0
#> 22 2021-03-13          37   Georgia Tech  L, 80-75        N   69   108.7
#> 23 2021-03-20         108 UNC Greensboro  W, 64-54        N   66    96.5
#> 24 2021-03-22           8       Colorado  W, 71-53        N   65   109.9
#> 25 2021-03-28           3       Michigan  L, 76-58        N   68    85.4
#>    off_eff_rk off_e_fg_pct off_to_pct off_or_pct off_ftr off_fgm_2 off_fga_2
#> 1           5         50.7       13.8       47.2    30.0        25        46
#> 2          16         42.0       14.4       39.6    30.4        17        49
#> 3           8         55.6       20.9       25.0    55.6        18        38
#> 4           3         60.8       20.2       29.2    31.4        19        34
#> 5           8         56.9       20.2       26.7    51.0        14        28
#> 6          16         39.3       21.7       43.9    52.5        15        28
#> 7          15         49.2       23.1       21.1    14.5        17        30
#> 8           1         81.0       16.1       37.5    19.0        29        40
#> 9           3         56.0       24.2       36.0    54.0        16        34
#> 10          4         57.3       18.1       33.3    16.1        22        41
#> 11          4         58.3       20.1       35.3    23.3        17        32
#> 12          5         56.5       21.9       48.4    22.6        26        44
#> 13         24         45.5       28.8       44.1    41.1        21        42
#> 14          6         55.9       15.8       36.1    59.3        15        34
#> 15          2         61.2        8.1       25.0    22.4        16        34
#> 16          7         48.3       15.5       33.3    50.0        22        44
#> 17          3         60.1       15.8       42.4    10.1        28        44
#> 18         20         42.5       22.6       42.9    29.9        21        50
#> 19          4         65.9       21.9       26.7    20.6        22        36
#> 20         21         45.3       18.1       25.0    31.2        20        40
#> 21         17         50.0       25.3       32.3    41.5        19        40
#> 22          8         64.0       36.2       54.5    28.0        20        35
#> 23         15         52.1       22.6       19.2    41.7        25        39
#> 24          7         58.7       23.2       24.0    45.6        18        29
#> 25         23         44.2       20.6       25.7    10.0        19        40
#>    off_fg_2_pct off_fgm_3 off_fga_3 off_fg_3_pct off_fg_3a_pct def_eff
#> 1          54.3         7        24         29.2          34.3    80.2
#> 2          34.7         8        20         40.0          29.0    96.2
#> 3          47.4         8        16         50.0          29.6    92.9
#> 4          55.9         8        17         47.1          33.3    94.8
#> 5          50.0        10        23         43.5          45.1   124.0
#> 6          53.6         6        33         18.2          54.1    79.9
#> 7          56.7         9        32         28.1          51.6   104.8
#> 8          72.5        12        18         66.7          31.0   106.5
#> 9          47.1         8        16         50.0          32.0   106.8
#> 10         53.7         9        21         42.9          33.9    98.3
#> 11         53.1        12        28         42.9          46.7    87.8
#> 12         59.1         6        18         33.3          29.0    86.3
#> 13         50.0         3        14         21.4          25.0   104.2
#> 14         44.1        12        25         48.0          42.4   112.2
#> 15         47.1        13        24         54.2          41.4    96.9
#> 16         50.0         4        14         28.6          24.1   101.2
#> 17         63.6         9        25         36.0          36.2   101.9
#> 18         42.0         5        17         29.4          25.4   103.5
#> 19         61.1        13        27         48.1          42.9    82.5
#> 20         50.0         6        24         25.0          37.5   107.3
#> 21         47.5         5        13         38.5          24.5    92.8
#> 22         57.1         8        15         53.3          30.0   116.0
#> 23         64.1         0         9          0.0          18.8    81.4
#> 24         62.1         6        17         35.3          37.0    82.0
#> 25         47.5         5        20         25.0          33.3   112.0
#>    def_eff_rk def_e_fg_pct def_to_pct def_or_pct def_ftr def_fgm_2 def_fga_2
#> 1           2         49.0       33.2       24.2    24.0         8        23
#> 2           9         40.4       20.1       37.5    49.1        17        42
#> 3           5         50.9       26.2       28.6    27.1        15        36
#> 4           4         48.0       18.6       21.4    29.4        17        31
#> 5          23         58.3       18.8       37.0    48.1        18        35
#> 6           2         38.8       18.9       16.7    31.0         9        25
#> 7          16         42.1       16.3       41.3    52.4        16        39
#> 8          14         53.2       16.1       25.7    12.7        17        37
#> 9          17         51.6       19.9       38.2    22.6        17        38
#> 10          6         47.4       18.1       35.1    31.6        21        41
#> 11          5         34.8       17.3       25.6    46.4        12        26
#> 12          5         45.4       19.0       18.9    31.5        11        31
#> 13         11         50.0       19.2       29.4    43.9        18        33
#> 14         20         55.8       18.5       25.7    41.7        14        33
#> 15          5         56.4       21.0       14.3    25.5        13        24
#> 16         11         41.2       11.2       32.6    32.4        22        51
#> 17         18         40.0       11.5       35.4    27.1        16        47
#> 18         14         42.5       27.9       52.6    50.0        18        37
#> 19          4         46.7       29.6       34.1    28.3        10        29
#> 20         14         50.9       19.4       24.2    63.0        14        27
#> 21          5         38.2       16.9       42.0    36.8        17        50
#> 22         20         47.6       10.2       36.8    45.2        22        39
#> 23          3         37.5       15.1       25.0    21.7        12        33
#> 24          2         41.1       29.4       43.2    19.6        14        31
#> 25         13         51.7       13.3       33.3    39.0        26        48
#>    def_fg_2_pct def_fgm_3 def_fga_3 def_fg_3_pct def_fg_3a_pct wl team_score
#> 1          34.8        11        27         40.7          54.0  W         86
#> 2          40.5         4        15         26.7          26.3  W         69
#> 3          41.7        10        23         43.5          39.0  W         83
#> 4          54.8         5        20         25.0          39.2  W         74
#> 5          51.4         9        19         47.4          35.2  L         74
#> 6          36.0         9        33         27.3          56.9  W         72
#> 7          41.0         7        24         29.2          38.1  L         67
#> 8          45.9        11        26         42.3          41.3  W        105
#> 9          44.7        10        24         41.7          38.7  W         82
#> 10         51.2         4        16         25.0          28.1  W         78
#> 11         46.2         5        30         16.7          53.6  W         80
#> 12         35.5         9        23         39.1          42.6  W         81
#> 13         54.5         7        24         29.2          42.1  L         65
#> 14         42.4        13        27         48.1          45.0  W         92
#> 15         54.2         9        23         39.1          48.9  W         81
#> 16         43.1         4        17         23.5          25.0  W         79
#> 17         34.0         8        23         34.8          32.9  W         88
#> 18         48.6         5        23         21.7          38.3  L         70
#> 19         34.5        12        31         38.7          51.7  W         93
#> 20         51.9         9        27         33.3          50.0  L         73
#> 21         34.0         6        18         33.3          26.5  W         69
#> 22         56.4         5        23         21.7          37.1  L         75
#> 23         36.4         7        27         25.9          45.0  W         64
#> 24         45.2         6        25         24.0          44.6  W         71
#> 25         54.2         3        11         27.3          18.6  L         58
#>    opponent_score   day_date game_date
#> 1              58  Wed Dec 2  20201202
#> 2              67  Wed Dec 9  20201209
#> 3              71 Sat Dec 12  20201212
#> 4              61 Tue Dec 15  20201215
#> 5              86 Sat Dec 19  20201219
#> 6              59 Mon Dec 21  20201221
#> 7              77 Tue Dec 29  20201229
#> 8              73 Wed Jan 13  20210113
#> 9              75 Sat Jan 16  20210116
#> 10             65 Mon Jan 18  20210118
#> 11             61 Sat Jan 23  20210123
#> 12             59 Wed Jan 27  20210127
#> 13             76 Sat Jan 30  20210130
#> 14             85 Sat Feb 13  20210213
#> 15             60 Mon Feb 15  20210215
#> 16             72 Sat Feb 20  20210220
#> 17             71 Wed Feb 24  20210224
#> 18             78 Sat Feb 27  20210227
#> 19             64  Wed Mar 3  20210303
#> 20             83  Sat Mar 6  20210306
#> 21             66 Fri Mar 12  20210312
#> 22             80 Sat Mar 13  20210313
#> 23             54 Sat Mar 20  20210320
#> 24             53 Mon Mar 22  20210322
#> 25             76 Sun Mar 28  20210328
#> 
#> $correlations
#>        correlations_r_x_100 pace off_e_fg_pct off_to_pct off_or_pct off_ftr
#> 27 to offensive efficiency:  -28          +84        -44        +16     -15
#> 28 to defensive efficiency:   -2           +7        +13         +3      +0
#>    def_e_fg_pct def_to_pct def_or_pct def_ftr
#> 27          +30         +4        -34     -61
#> 28          +57        -48        +30     +46
#> 
#> $position_distributions
#>          team   category c_pct pf_pct sf_pct sg_pct pg_pct c_pct_rk pf_pct_rk
#> 1 Florida St.   % Points  20.2   19.1   21.8   20.8   18.1      169       188
#> 2 Florida St. % Off Rebs  35.7   21.3   18.5   15.5    9.0      173       279
#> 3 Florida St. % Def Rebs  28.9   17.5   25.3   16.1   12.0       81       324
#>   sf_pct_rk sg_pct_rk pg_pct_rk c_pct_d1_avg pf_pct_d1_avg sf_pct_d1_avg
#> 1       101       144       237         20.2          19.6          19.6
#> 2       123        73       131         36.1          27.1          16.8
#> 3        21       175       278         25.9          23.5          19.5
#>   sg_pct_d1_avg pg_pct_d1_avg
#> 1          20.2          20.4
#> 2          11.6           8.4
#> 3          16.6          14.4
#> 
# }
# \donttest{
  try(kp_opptracker(team = 'Florida St.', year = 2021))
#> ✖ 2026-10-26 19:20:06.452628: 2026-10-26 19:20:06.452224 - Florida St. - 2021 Team opponent tracker data is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: subscript out of bounds
#> NULL
# }
  # \donttest{
    try(kp_team_players(team = 'Florida St.', year = 2024))
#> # A tibble: 13 × 54
#>    role       number player ht       wt yr        g     s min_pct o_rtg poss_pct
#>    <chr>       <dbl> <chr>  <chr> <dbl> <chr> <dbl> <dbl>   <dbl> <dbl>    <dbl>
#>  1 Go-to Guys      2 "Jami… 6-7     210 Jr       33    33    70.2 110.      28.2
#>  2 Major Con…     23 "Prim… 6-3     185 Jr       24    NA    41.3  92.4     27.1
#>  3 Role Play…     22 "Dari… 6-5     195 Sr       32    32    72.4 106.      17.1
#>  4 Role Play…     11 "Baba… 6-11    204 So       33    32    61.7  98.3     17.8
#>  5 Role Play…      1 "Jale… 6-7     205 Jr       33    32    60.1 106.      18.5
#>  6 Role Play…      3 "Cam … 6-10    225 So       28    12    45.2 122.      18.5
#>  7 Role Play…      0 "Chan… 6-5     220 So       31     1    34.2 113.      16.4
#>  8 Role Play…      5 "De'A… 6-9     210 So       31    20    27.8 106       19.8
#>  9 Role Play…     10 "Tayl… 6-10    195 Fr       31    NA    25.7 101.      16.4
#> 10 Limited R…     20 "Josh… 6-5     200 Sr       32     1    22.5  92.6     14.9
#> 11 Limited R…     33 "Jayl… 6-10    230 Sr       28     1    22.3 103       13.3
#> 12 Benchwarm…     21 "Cam'… 6-7     220 Sr        7    NA     8.4  86.2     27.9
#> 13 Benchwarm…     12 "Tom … 6-7     200 So       23    NA     6.3 110.      19.6
#> # ℹ 43 more variables: shots_pct <dbl>, e_fg_pct <dbl>, ts_pct <dbl>,
#> #   or_pct <dbl>, dr_pct <dbl>, a_rate <dbl>, to_rate <dbl>, blk_pct <dbl>,
#> #   stl_pct <dbl>, f_cper40 <dbl>, f_dper40 <dbl>, ft_rate <dbl>, ftm <dbl>,
#> #   fta <dbl>, ft_pct <dbl>, fgm_2 <dbl>, fga_2 <dbl>, fg_2_pct <dbl>,
#> #   fgm_3 <dbl>, fga_3 <dbl>, fg_3_pct <dbl>, min_pct_rk <dbl>, o_rtg_rk <dbl>,
#> #   poss_pct_rk <dbl>, shots_pct_rk <dbl>, e_fg_pct_rk <dbl>, ts_pct_rk <dbl>,
#> #   or_pct_rk <dbl>, dr_pct_rk <dbl>, a_rate_rk <dbl>, to_rate_rk <dbl>, …
  # }

  # \donttest{
    try(kp_player_career(player_id = '41180'))
#> $player_stats
#> # A tibble: 19 × 41
#>     year team_rk team      number name  position hgt     wgt yr        g min_pct
#>    <dbl>   <dbl> <chr>      <dbl> <chr> <chr>    <chr> <dbl> <chr> <dbl>   <dbl>
#>  1  2022     105 Florida …     10 Mali… "C·PF"   "6-9"   225 "Sr"     17    37.4
#>  2  2022     105 Conferen…     10 Mali… "C·PF"   "6-9"   225 "Sr"      8    27.4
#>  3  2022     105 vs. Tier…     10 Mali… "C·PF"   "6-9"   225 "Sr"      8    34.5
#>  4  2022     105 vs. Tier…     10 Mali… "C·PF"   "6-9"   225 "Sr"      5    38  
#>  5  2021      15 Florida …     10 Mali… "PF"     "6-9"   225 "Jr"     24    47.8
#>  6  2021      15 Conferen…     10 Mali… "PF"     "6-9"   225 "Jr"     14    45.8
#>  7  2021      15 vs. Tier…     10 Mali… "PF"     "6-9"   225 "Jr"     17    53.9
#>  8  2021      15 vs. Tier…     10 Mali… "PF"     "6-9"   225 "Jr"     10    55.5
#>  9  2020      15 Florida …     10 Mali… "PF·C"   "6-9"   225 "So"     31    48.2
#> 10  2020      15 Conferen…     10 Mali… "PF·C"   "6-9"   225 "So"     20    48.9
#> 11  2020      15 vs. Tier…     10 Mali… "PF·C"   "6-9"   225 "So"     17    53.3
#> 12  2020      15 vs. Tier…     10 Mali… "PF·C"   "6-9"   225 "So"     10    55.1
#> 13  2018     289 Rice          10 Mali… "C"      "6-8"   200 "Fr"     29    68.4
#> 14  2018     289 Conferen…     10 Mali… "C"      "6-8"   200 "Fr"     18    71.9
#> 15  2018     289 vs. Tier…     10 Mali… "C"      "6-8"   200 "Fr"     11    71.5
#> 16  2018     289 vs. Tier…     10 Mali… "C"      "6-8"   200 "Fr"      2    58.8
#> 17    NA      NA Career        NA NA    ""       ""       NA ""      101    NA  
#> 18    NA      NA vs. Tier…     NA NA    ""       ""       NA ""       53    NA  
#> 19    NA      NA vs. Tier…     NA NA    ""       ""       NA ""       27    NA  
#> # ℹ 30 more variables: o_rtg <dbl>, poss_pct <dbl>, shots_pct <dbl>,
#> #   e_fg_pct <dbl>, ts_pct <dbl>, or_pct <dbl>, dr_pct <dbl>, a_rate <dbl>,
#> #   to_rate <dbl>, blk_pct <dbl>, stl_pct <dbl>, f_cper40 <dbl>,
#> #   f_dper40 <dbl>, ft_rate <dbl>, ftm <dbl>, fta <dbl>, ft_pct <dbl>,
#> #   fgm_2 <dbl>, fga_2 <dbl>, fg_2_pct <dbl>, fgm_3 <dbl>, fga_3 <dbl>,
#> #   fg_3_pct <dbl>, group_rank <chr>, team_finish <chr>, ncaa_seed <dbl>,
#> #   hometown <chr>, date_of_birth <chr>, age <chr>, comparisons <chr>
#> 
#> $gamelog
#>     year        team          name position opponent_tier   date opponent_rk
#> 1   2022 Florida St. Malik Osborne     C·PF            NA  Mar 9          69
#> 2   2022 Florida St. Malik Osborne     C·PF            NA  Mar 5         128
#> 3   2022 Florida St. Malik Osborne     C·PF            NA  Mar 2          38
#> 4   2022 Florida St. Malik Osborne     C·PF            NA Feb 26          72
#> 5   2022 Florida St. Malik Osborne     C·PF            NA Feb 21         114
#> 6   2022 Florida St. Malik Osborne     C·PF            NA Feb 19           8
#> 7   2022 Florida St. Malik Osborne     C·PF            NA Feb 15          71
#> 8   2022 Florida St. Malik Osborne     C·PF            NA Feb 12          16
#> 9   2022 Florida St. Malik Osborne     C·PF            NA  Feb 9         195
#> 10  2022 Florida St. Malik Osborne     C·PF            NA  Feb 5          35
#> 11  2022 Florida St. Malik Osborne     C·PF            NA  Feb 2          71
#> 12  2022 Florida St. Malik Osborne     C·PF            NA Jan 29          19
#> 13  2022 Florida St. Malik Osborne     C·PF            NA Jan 26         156
#> 14  2022 Florida St. Malik Osborne     C·PF            NA Jan 22          41
#> 15  2022 Florida St. Malik Osborne     C·PF            NA Jan 20         272
#> 16  2022 Florida St. Malik Osborne     C·PF            NA Jan 18           8
#> 17  2022 Florida St. Malik Osborne     C·PF            NA Jan 15          69
#> 18  2022 Florida St. Malik Osborne     C·PF            NA Jan 11          41
#> 19  2022 Florida St. Malik Osborne     C·PF            NA  Jan 8         127
#> 20  2022 Florida St. Malik Osborne     C·PF            NA  Jan 4          35
#> 21  2022 Florida St. Malik Osborne     C·PF            NA  Jan 1         128
#> 22  2022 Florida St. Malik Osborne     C·PF            NA Dec 15         264
#> 23  2022 Florida St. Malik Osborne     C·PF            NA Dec 12          99
#> 24  2022 Florida St. Malik Osborne     C·PF            NA  Dec 4          69
#> 25  2022 Florida St. Malik Osborne     C·PF            NA Nov 30          14
#> 26  2022 Florida St. Malik Osborne     C·PF            NA Nov 24         218
#> 27  2022 Florida St. Malik Osborne     C·PF            NA Nov 22         137
#> 28  2022 Florida St. Malik Osborne     C·PF            NA Nov 21         203
#> 29  2022 Florida St. Malik Osborne     C·PF            NA Nov 17          98
#> 30  2022 Florida St. Malik Osborne     C·PF            NA Nov 14          59
#> 31  2022 Florida St. Malik Osborne     C·PF            NA Nov 10         211
#> 32  2021 Florida St. Malik Osborne       PF            NA Mar 28           3
#> 33  2021 Florida St. Malik Osborne       PF            NA Mar 22           8
#> 34  2021 Florida St. Malik Osborne       PF            NA Mar 20         108
#> 35  2021 Florida St. Malik Osborne       PF            NA Mar 13          37
#> 36  2021 Florida St. Malik Osborne       PF            NA Mar 12          34
#> 37  2021 Florida St. Malik Osborne       PF            NA  Mar 6          85
#> 38  2021 Florida St. Malik Osborne       PF            NA  Mar 3         148
#> 39  2021 Florida St. Malik Osborne       PF            NA Feb 27          34
#> 40  2021 Florida St. Malik Osborne       PF            NA Feb 24         138
#> 41  2021 Florida St. Malik Osborne       PF            NA Feb 20          97
#> 42  2021 Florida St. Malik Osborne       PF            NA Feb 15          19
#> 43  2021 Florida St. Malik Osborne       PF            NA Feb 13         175
#> 44  2021 Florida St. Malik Osborne       PF            NA Jan 30          37
#> 45  2021 Florida St. Malik Osborne       PF            NA Jan 27         138
#> 46  2021 Florida St. Malik Osborne       PF            NA Jan 23          45
#> 47  2021 Florida St. Malik Osborne       PF            NA Jan 18          59
#> 48  2021 Florida St. Malik Osborne       PF            NA Jan 16          34
#> 49  2021 Florida St. Malik Osborne       PF            NA Jan 13          71
#> 50  2021 Florida St. Malik Osborne       PF            NA Dec 29          45
#> 51  2021 Florida St. Malik Osborne       PF            NA Dec 21         182
#> 52  2021 Florida St. Malik Osborne       PF            NA Dec 19         100
#> 53  2021 Florida St. Malik Osborne       PF            NA Dec 15          37
#> 54  2021 Florida St. Malik Osborne       PF            NA Dec 12          41
#> 55  2021 Florida St. Malik Osborne       PF            NA  Dec 9          50
#> 56  2021 Florida St. Malik Osborne       PF            NA  Dec 2         297
#> 57  2020 Florida St. Malik Osborne     PF·C            NA  Mar 7         179
#> 58  2020 Florida St. Malik Osborne     PF·C            NA  Mar 4          57
#> 59  2020 Florida St. Malik Osborne     PF·C            NA Feb 29          72
#> 60  2020 Florida St. Malik Osborne     PF·C            NA Feb 24           9
#> 61  2020 Florida St. Malik Osborne     PF·C            NA Feb 22          50
#> 62  2020 Florida St. Malik Osborne     PF·C            NA Feb 18         111
#> 63  2020 Florida St. Malik Osborne     PF·C            NA Feb 15          51
#> 64  2020 Florida St. Malik Osborne     PF·C            NA Feb 10           5
#> 65  2020 Florida St. Malik Osborne     PF·C            NA  Feb 8         104
#> 66  2020 Florida St. Malik Osborne     PF·C            NA  Feb 3          84
#> 67  2020 Florida St. Malik Osborne     PF·C            NA  Feb 1         105
#> 68  2020 Florida St. Malik Osborne     PF·C            NA Jan 28          42
#> 69  2020 Florida St. Malik Osborne     PF·C            NA Jan 25          57
#> 70  2020 Florida St. Malik Osborne     PF·C            NA Jan 18         104
#> 71  2020 Florida St. Malik Osborne     PF·C            NA Jan 15          42
#> 72  2020 Florida St. Malik Osborne     PF·C            NA  Jan 8         103
#> 73  2020 Florida St. Malik Osborne     PF·C            NA  Jan 4           9
#> 74  2020 Florida St. Malik Osborne     PF·C            NA Dec 31          64
#> 75  2020 Florida St. Malik Osborne     PF·C            NA Dec 28         284
#> 76  2020 Florida St. Malik Osborne     PF·C            NA Dec 21         125
#> 77  2020 Florida St. Malik Osborne     PF·C            NA Dec 17         166
#> 78  2020 Florida St. Malik Osborne     PF·C            NA  Dec 8          72
#> 79  2020 Florida St. Malik Osborne     PF·C            NA  Dec 3          34
#> 80  2020 Florida St. Malik Osborne     PF·C            NA Nov 30          24
#> 81  2020 Florida St. Malik Osborne     PF·C            NA Nov 29          68
#> 82  2020 Florida St. Malik Osborne     PF·C            NA Nov 25         353
#> 83  2020 Florida St. Malik Osborne     PF·C            NA Nov 23         176
#> 84  2020 Florida St. Malik Osborne     PF·C            NA Nov 20         147
#> 85  2020 Florida St. Malik Osborne     PF·C            NA Nov 15         156
#> 86  2020 Florida St. Malik Osborne     PF·C            NA Nov 10          32
#> 87  2020 Florida St. Malik Osborne     PF·C            NA  Nov 6         111
#> 88  2018        Rice Malik Osborne        C            NA  Mar 3         174
#> 89  2018        Rice Malik Osborne        C            NA  Mar 1         240
#> 90  2018        Rice Malik Osborne        C            NA Feb 24         222
#> 91  2018        Rice Malik Osborne        C            NA Feb 22         233
#> 92  2018        Rice Malik Osborne        C            NA Feb 17          47
#> 93  2018        Rice Malik Osborne        C            NA Feb 15         105
#> 94  2018        Rice Malik Osborne        C            NA Feb 10         109
#> 95  2018        Rice Malik Osborne        C            NA  Feb 8          45
#> 96  2018        Rice Malik Osborne        C            NA  Feb 3         146
#> 97  2018        Rice Malik Osborne        C            NA Jan 27         233
#> 98  2018        Rice Malik Osborne        C            NA Jan 25         222
#> 99  2018        Rice Malik Osborne        C            NA Jan 20         149
#> 100 2018        Rice Malik Osborne        C            NA Jan 18         206
#> 101 2018        Rice Malik Osborne        C            NA Jan 13         146
#> 102 2018        Rice Malik Osborne        C            NA  Jan 6         308
#> 103 2018        Rice Malik Osborne        C            NA  Jan 4          64
#> 104 2018        Rice Malik Osborne        C            NA Dec 30         240
#> 105 2018        Rice Malik Osborne        C            NA Dec 28         174
#> 106 2018        Rice Malik Osborne        C            NA Dec 22         228
#> 107 2018        Rice Malik Osborne        C            NA Dec 19         106
#> 108 2018        Rice Malik Osborne        C            NA Dec 16          11
#> 109 2018        Rice Malik Osborne        C            NA Dec 14          NA
#> 110 2018        Rice Malik Osborne        C            NA  Dec 9         112
#> 111 2018        Rice Malik Osborne        C            NA  Dec 2         260
#> 112 2018        Rice Malik Osborne        C            NA Nov 29         128
#> 113 2018        Rice Malik Osborne        C            NA Nov 25          NA
#> 114 2018        Rice Malik Osborne        C            NA Nov 22         108
#> 115 2018        Rice Malik Osborne        C            NA Nov 20         107
#> 116 2018        Rice Malik Osborne        C            NA Nov 17         345
#> 117 2018        Rice Malik Osborne        C            NA Nov 14         101
#> 118 2018        Rice Malik Osborne        C            NA Nov 10         286
#>                 opponent    result ot  location game_type  mvp        start
#> 1               Syracuse  L, 96-57      Neutral     ACC-T      Did not play
#> 2             N.C. State  W, 89-76         Home       ACC      Did not play
#> 3             Notre Dame  W, 74-70         Home       ACC      Did not play
#> 4               Virginia  W, 64-63         Away       ACC      Did not play
#> 5         Boston College  L, 71-55         Away       ACC      Did not play
#> 6                   Duke  L, 88-70         Away       ACC      Did not play
#> 7                Clemson  W, 81-80         Home       ACC      Did not play
#> 8         North Carolina  L, 94-74         Away       ACC      Did not play
#> 9             Pittsburgh  L, 56-51         Home       ACC      Did not play
#> 10           Wake Forest  L, 68-60         Home       ACC      Did not play
#> 11               Clemson  L, 75-69         Away       ACC      Did not play
#> 12         Virginia Tech  L, 85-72         Home       ACC      Did not play
#> 13          Georgia Tech  L, 75-61         Away       ACC                  
#> 14              Miami FL  W, 61-60         Away       ACC                  
#> 15         North Florida  W, 86-73         Home                Did not play
#> 16                  Duke  W, 79-78 OT      Home       ACC                  
#> 17              Syracuse  W, 76-71         Away       ACC      Did not play
#> 18              Miami FL  W, 65-64         Home       ACC                 •
#> 19            Louisville  W, 79-70         Home       ACC                 •
#> 20           Wake Forest  L, 76-54         Away       ACC                 •
#> 21            N.C. State  W, 83-81         Away       ACC                 •
#> 22              Lipscomb  W, 97-60         Home                           •
#> 23        South Carolina  L, 66-65    Semi-Away            MVP            •
#> 24              Syracuse  L, 63-60         Home       ACC                 •
#> 25                Purdue  L, 93-65         Away                           •
#> 26     Boston University  W, 81-80 OT      Home                           •
#> 27              Missouri  W, 81-58      Neutral                           •
#> 28      Loyola Marymount  W, 73-45      Neutral            MVP            •
#> 29                Tulane  W, 59-54         Home                           •
#> 30               Florida  L, 71-55         Away                           •
#> 31                  Penn W, 105-70         Home            MVP            •
#> 32              Michigan  L, 76-58      Neutral    NCAA-T <NA>             
#> 33              Colorado  W, 71-53      Neutral    NCAA-T <NA>             
#> 34        UNC Greensboro  W, 64-54      Neutral    NCAA-T <NA>             
#> 35          Georgia Tech  L, 80-75      Neutral     ACC-T <NA>             
#> 36        North Carolina  W, 69-66      Neutral     ACC-T <NA>             
#> 37            Notre Dame  L, 83-73         Away       ACC <NA>             
#> 38        Boston College  W, 93-64         Home       ACC <NA> Did not play
#> 39        North Carolina  L, 78-70         Away       ACC <NA>             
#> 40              Miami FL  W, 88-71         Away       ACC <NA>            •
#> 41            Pittsburgh  W, 79-72         Away       ACC <NA>            •
#> 42              Virginia  W, 81-60         Home       ACC <NA>            •
#> 43           Wake Forest  W, 92-85 OT      Home       ACC <NA>            •
#> 44          Georgia Tech  L, 76-65         Away       ACC <NA>             
#> 45              Miami FL  W, 81-59         Home       ACC <NA>             
#> 46               Clemson  W, 80-61         Home       ACC <NA>             
#> 47            Louisville  W, 78-65         Away       ACC <NA>             
#> 48        North Carolina  W, 82-75         Home       ACC <NA>             
#> 49            N.C. State W, 105-73         Home       ACC <NA>             
#> 50               Clemson  L, 77-67         Away       ACC <NA>             
#> 51          Gardner Webb  W, 72-59         Home           <NA>             
#> 52                   UCF  L, 86-74         Home           <NA>             
#> 53          Georgia Tech  W, 74-61         Home       ACC <NA>             
#> 54               Florida  W, 83-71         Home           <NA>             
#> 55               Indiana  W, 69-67 OT      Home           <NA>             
#> 56         North Florida  W, 86-58         Home           <NA>             
#> 57        Boston College  W, 80-62         Home       ACC <NA>             
#> 58            Notre Dame  W, 73-71         Away       ACC <NA>            •
#> 59               Clemson  L, 70-69         Away       ACC <NA>            •
#> 60            Louisville  W, 82-67         Home       ACC <NA>            •
#> 61            N.C. State  W, 67-61         Away       ACC <NA>            •
#> 62            Pittsburgh  W, 82-67         Home       ACC <NA>            •
#> 63              Syracuse  W, 80-77         Home       ACC <NA>            •
#> 64                  Duke  L, 70-65         Away       ACC <NA>            •
#> 65              Miami FL  W, 99-81         Home       ACC <NA>            •
#> 66        North Carolina  W, 65-59         Home       ACC <NA>            •
#> 67         Virginia Tech  W, 74-63         Away       ACC <NA>            •
#> 68              Virginia  L, 61-56         Away       ACC <NA>            •
#> 69            Notre Dame  W, 85-84         Home       ACC <NA>            •
#> 70              Miami FL  W, 83-79 OT      Away       ACC <NA>            •
#> 71              Virginia  W, 54-50         Home       ACC <NA>            •
#> 72           Wake Forest  W, 78-68         Away       ACC <NA>            •
#> 73            Louisville  W, 78-65         Away       ACC <NA>            •
#> 74          Georgia Tech  W, 70-58         Home       ACC <NA>            •
#> 75         North Alabama  W, 88-71         Home           <NA>            •
#> 76         South Florida  W, 66-60      Neutral           <NA>             
#> 77         North Florida  W, 98-81         Home           <NA>             
#> 78               Clemson  W, 72-53         Home       ACC <NA>            •
#> 79               Indiana  L, 80-64         Away           <NA>            •
#> 80                Purdue  W, 63-60 OT   Neutral           <NA>            •
#> 81             Tennessee  W, 60-57      Neutral           <NA>            •
#> 82           Chicago St. W, 113-56         Home           <NA>            •
#> 83        St. Francis PA  W, 80-65         Home           <NA>            •
#> 84           Chattanooga  W, 89-53         Home           <NA>            •
#> 85      Western Carolina  W, 79-74         Home           <NA>            •
#> 86               Florida  W, 63-51         Away           <NA>            •
#> 87            Pittsburgh  L, 63-61         Away       ACC <NA>            •
#> 88                  UTSA  L, 79-60         Home      CUSA                 •
#> 89                  UTEP  W, 76-70         Home      CUSA                 •
#> 90                   FIU  L, 67-64         Away      CUSA                 •
#> 91      Florida Atlantic  W, 79-76 OT      Away      CUSA                 •
#> 92      Western Kentucky  L, 85-66         Home      CUSA                 •
#> 93              Marshall  L, 93-80         Home      CUSA                 •
#> 94                   UAB  L, 61-56         Away      CUSA                 •
#> 95      Middle Tennessee  L, 94-75         Away      CUSA                 •
#> 96           North Texas  L, 74-70         Away      CUSA                 •
#> 97      Florida Atlantic  L, 63-62         Home      CUSA                 •
#> 98                   FIU  W, 73-64         Home      CUSA                 •
#> 99        Louisiana Tech  L, 69-54         Away      CUSA                 •
#> 100        Southern Miss  L, 86-75         Away      CUSA                 •
#> 101          North Texas  L, 85-78         Home      CUSA                 •
#> 102            Charlotte  W, 73-64         Home      CUSA  MVP            •
#> 103         Old Dominion  L, 82-75 OT      Home      CUSA                 •
#> 104                 UTEP  L, 80-62         Away      CUSA                 •
#> 105                 UTSA  L, 79-66         Away      CUSA                 •
#> 106            Texas St.  L, 74-66         Home                           •
#> 107           New Mexico  L, 78-69         Away                           •
#> 108           Texas Tech  L, 73-53         Away                           •
#> 109          St. Edwards  W, 91-86         Home                           •
#> 110    Stephen F. Austin  L, 81-62         Away                           •
#> 111 UT Rio Grande Valley  L, 69-67         Home                           •
#> 112         UT Arlington  L, 69-49         Away                           •
#> 113        St. Thomas TX  W, 70-59         Home                           •
#> 114          Mississippi  L, 79-62      Neutral                           •
#> 115                 UNLV  L, 95-68    Semi-Away                            
#> 116     Northwestern St.  W, 87-65         Away                            
#> 117          Georgia St.  L, 75-54         Home                            
#> 118     Eastern Kentucky  L, 73-72         Home                            
#>     minutes_played o_rtg poss_pct pts fgm_2 fga_2 fgm_3 fga_3 ftm fta or dr  a
#> 1               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 2               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 3               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 4               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 5               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 6               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 7               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 8               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 9               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 10              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 11              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 12              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 13              19    65       16   3     1     3     0     2   1   3  0  2  1
#> 14              23    66       22   4     1     8     0     2   2   2  4  4  0
#> 15              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 16              32   100       16   7     0     1     1     6   4   4  1  6  3
#> 17              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 18              32   110       14   7     1     4     1     3   2   2  2  6  2
#> 19              24   108       18   6     1     3     0     3   4   4  2  4  2
#> 20              32    74       13   6     2     4     0     4   2   2  1  7  0
#> 21              31   139       21  19     3     6     2     4   7   8  1  6  0
#> 22              22   184       15  12     2     3     2     3   2   2  2  3  2
#> 23              33   132       18  15     1     2     3     6   4   6  3  6  0
#> 24              28   102       20  10     0     2     2     7   4   4  2  6  1
#> 25              34   122        9   6     2     3     0     2   2   2  2  2  0
#> 26              30   146       12  10     4     4     0     1   2   2  2  5  0
#> 27              19   137       17  10     2     3     2     3   0   0  1  6  0
#> 28              20   181       15  10     0     2     2     2   4   4  1  2  2
#> 29              32   128       12   9     2     4     1     1   2   3  4  6  0
#> 30              33   118       24  18     3     6     3     4   3   5  2  4  2
#> 31              23   171       22  18     3     3     1     3   9  12  7  6  0
#> 32              31   124       15  12     0     2     4     7   0   0  0  6  1
#> 33              20   120       23  11     3     4     1     4   2   3  1  4  0
#> 34              14   135       12   4     0     0     0     0   4   4  0  5  0
#> 35              22   122        7   3     0     1     1     1   0   0  0  3  1
#> 36              20   223        7   9     0     0     3     4   0   0  0  2  0
#> 37               8    NA       NA   0     0     0     0     0   0   0  0  1  0
#> 38              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 39              20    79       11   3     1     3     0     0   1   2  2  0  0
#> 40               9    NA       NA   2     1     1     0     1   0   0  1  3  0
#> 41              24   170       15  12     3     3     0     1   6   7  2  7  0
#> 42              24   100       17   7     2     4     1     4   0   0  1  1  0
#> 43              25   140       21  12     0     3     3     4   3   4  4  4  1
#> 44              21    23       11   1     0     3     0     3   1   2  0  3  0
#> 45              19   167       18  11     3     5     1     2   2   2  2  8  0
#> 46              24   142       10   8     1     2     2     4   0   0  0  4  0
#> 47              25   120       21  12     4     5     0     3   4   4  1  2  0
#> 48              15   146       21  10     1     2     2     3   2   2  1  1  0
#> 49              20    46        7   0     0     1     0     2   0   0  1  3  0
#> 50              24    67       14   2     1     2     0     3   0   0  2  6  2
#> 51              17    79       34   8     3     5     0     2   2   3  6  2  0
#> 52              13    82        7   0     0     0     0     0   0   0  2  3  0
#> 53              19    68       12   2     1     3     0     0   0   0  0  1  1
#> 54              21    48       13   2     1     4     0     1   0   0  1  1  0
#> 55              31   164        8   5     0     2     1     1   2   2  4  5  1
#> 56              17   124       16   6     2     2     0     2   2   2  3  0  0
#> 57              12    88       11   2     0     1     0     0   2   4  1  3  0
#> 58              20    78       22   4     1     3     0     2   2   2  3  2  1
#> 59              14    91       38  11     1     3     3     3   0   3  2  6  0
#> 60              15   108       19   4     2     2     0     2   0   0  2  5  1
#> 61              30   102       20   9     4     5     0     3   1   6  5  7  0
#> 62              11   117       22   5     2     2     0     2   1   1  1  0  1
#> 63              17   124       11   4     1     4     0     0   2   2  2  1  0
#> 64              23   109       29  14     4     7     2     6   0   0  4  1  0
#> 65              12   223        8   6     0     1     2     2   0   0  1  2  0
#> 66              15   158       17   8     2     4     1     1   1   1  2  4  0
#> 67              11   104        5   1     0     0     0     0   1   2  0  2  0
#> 68              25    76       17   5     2     5     0     2   1   1  1  3  0
#> 69              14     0       12   0     0     1     0     1   0   0  0  1  0
#> 70              31   122        8   6     2     3     0     1   2   3  1  4  0
#> 71              26   125       10   5     1     2     1     3   0   0  3  1  0
#> 72              21   129       19   9     2     5     1     1   2   2  3  2  0
#> 73              30   121       15   7     2     4     1     3   0   0  4  5  1
#> 74              22   154       11   7     2     4     1     1   0   0  0  4  2
#> 75              18   132       28  14     4     7     2     5   0   0  3  1  0
#> 76              14    87       12   2     1     1     0     1   0   0  1  0  1
#> 77              10   101       23   2     1     4     0     1   0   0  3  2  1
#> 78              22   102       15   5     1     1     1     4   0   0  1  5  1
#> 79              22   126       15   7     2     3     1     2   0   0  1  2  1
#> 80              18   123       12   4     1     2     0     1   2   2  2  4  0
#> 81              16   128       10   4     0     0     1     1   1   4  2  4  0
#> 82              15   208        8   4     2     2     0     0   0   0  2  3  1
#> 83              24   131       12   9     0     2     3     5   0   0  1  3  0
#> 84              20   103       25  10     3     7     1     3   1   1  0  3  2
#> 85              25   150       12   6     2     2     0     0   2   3  4  5  1
#> 86              26   137       15  10     4     7     0     0   2   2  2  2  0
#> 87              23    62       12   2     1     2     0     2   0   0  2  7  0
#> 88              31    96       18   9     2     4     1     6   2   2  3  5  0
#> 89              27    81       29  10     2     5     1     5   3   8  4  6  1
#> 90              35   116       26  20     5     9     2     5   4   6  4  2  2
#> 91              26    57       30   8     3     7     0     5   2   3  1  5  0
#> 92              34   122       16  15     3     6     3     4   0   1  1  3  1
#> 93              32   105       33  22     4     8     3     9   5   9  3 10  1
#> 94              27    73       19   6     3     4     0     4   0   0  2  7  1
#> 95              24    81       30  11     4     7     0     3   3   4  2  3  0
#> 96              25    59       27   7     2     3     0     2   3   7  1  2  0
#> 97              33    88       26  10     3     8     1     6   1   2  4  4  1
#> 98              30   114       22  16     2     5     3     5   3   5  1  4  2
#> 99              33    96       19  11     2     6     2     4   1   1  2  5  0
#> 100             29   158       19  17     5     7     1     2   4   4  2  6  1
#> 101             26    75       17   4     0     2     0     1   4   6  2  2  1
#> 102             24   126       32  18     3     3     1     2   9  11  2  4  1
#> 103             30   113       11   5     2     4     0     0   1   3  1  4  2
#> 104             26   101       18   7     2     5     0     1   3   3  2  4  1
#> 105             33    87       14   7     3     4     0     1   1   4  4  9  0
#> 106             25   113       14   8     2     4     1     1   1   2  1  1  0
#> 107             32   137       16  12     4     7     0     0   4   4  5  6  0
#> 108             23    85       17   4     1     3     0     1   2   2  2  2  2
#> 109             24    88       20   9     1     2     0     1   7   8  0  3  1
#> 110             36    62       19   8     3     3     0     2   2   6  3  6  1
#> 111             30   128       18  14     1     4     3     5   3   3  2  4  0
#> 112             29    10        9   0     0     1     0     2   0   2  0  3  1
#> 113             17    95       16   4     2     3     0     1   0   1  3  4  1
#> 114             25    78       16   4     0     2     0     2   4   4  3  3  2
#> 115             25   108       10   4     2     3     0     1   0   0  5  4  0
#> 116             19    67       25   4     2     6     0     1   0   0  3  5  1
#> 117             26    97       15   5     2     4     0     1   1   2  3  5  2
#> 118              5    NA       NA   1     0     0     0     0   1   2  0  0  0
#>     to blk stl pf
#> 1   NA  NA  NA NA
#> 2   NA  NA  NA NA
#> 3   NA  NA  NA NA
#> 4   NA  NA  NA NA
#> 5   NA  NA  NA NA
#> 6   NA  NA  NA NA
#> 7   NA  NA  NA NA
#> 8   NA  NA  NA NA
#> 9   NA  NA  NA NA
#> 10  NA  NA  NA NA
#> 11  NA  NA  NA NA
#> 12  NA  NA  NA NA
#> 13   0   0   0  1
#> 14   0   0   2  4
#> 15  NA  NA  NA NA
#> 16   1   0   0  2
#> 17  NA  NA  NA NA
#> 18   1   0   1  1
#> 19   0   0   2  1
#> 20   0   0   1  0
#> 21   1   0   1  0
#> 22   0   1   0  0
#> 23   1   1   2  2
#> 24   1   0   2  3
#> 25   0   0   1  2
#> 26   1   0   0  4
#> 27   1   0   0  0
#> 28   0   0   1  0
#> 29   1   2   0  1
#> 30   3   0   3  1
#> 31   0   0   1  1
#> 32   1   0   0  3
#> 33   0   0   1  1
#> 34   1   0   0  1
#> 35   1   0   0  2
#> 36   0   0   1  2
#> 37   2   0   1  1
#> 38  NA  NA  NA NA
#> 39   1   0   2  4
#> 40   0   0   0  0
#> 41   0   0   0  2
#> 42   0   0   0  1
#> 43   1   0   0  3
#> 44   0   2   1  4
#> 45   0   0   0  1
#> 46   0   1   2  1
#> 47   1   0   1  2
#> 48   1   1   0  1
#> 49   0   0   0  2
#> 50   1   1   0  2
#> 51   4   1   0  4
#> 52   1   0   0  2
#> 53   1   0   0  3
#> 54   1   0   1  4
#> 55   0   1   2  3
#> 56   1   0   2  1
#> 57   0   1   0  1
#> 58   2   0   0  3
#> 59   3   0   0  4
#> 60   1   0   0  0
#> 61   0   2   0  2
#> 62   1   1   1  0
#> 63   0   0   2  1
#> 64   2   2   0  3
#> 65   0   0   0  2
#> 66   0   0   0  1
#> 67   0   0   0  0
#> 68   0   2   1  2
#> 69   2   0   0  2
#> 70   0   1   1  3
#> 71   0   1   0  0
#> 72   1   0   3  2
#> 73   1   1   0  4
#> 74   0   1   2  1
#> 75   0   1   1  2
#> 76   1   0   2  2
#> 77   0   1   0  0
#> 78   1   2   0  3
#> 79   1   0   2  1
#> 80   0   0   0  2
#> 81   0   0   3  1
#> 82   0   0   0  1
#> 83   1   2   0  2
#> 84   1   0   0  1
#> 85   1   1   0  2
#> 86   0   0   1  4
#> 87   1   4   0  5
#> 88   1   1   0  1
#> 89   2   1   1  4
#> 90   2   0   1  2
#> 91   2   1   0  4
#> 92   1   1   0  0
#> 93   2   0   0  1
#> 94   2   0   2  4
#> 95   3   1   0  1
#> 96   4   2   0  4
#> 97   0   3   1  1
#> 98   2   0   0  3
#> 99   2   2   1  0
#> 100  1   0   1  1
#> 101  2   2   1  2
#> 102  4   3   1  4
#> 103  0   1   0  4
#> 104  1   0   0  1
#> 105  2   0   1  3
#> 106  1   0   0  5
#> 107  1   1   0  1
#> 108  2   0   1  5
#> 109  4   0   1  2
#> 110  6   1   4  2
#> 111  1   0   0  3
#> 112  1   0   2  2
#> 113  1   0   0  2
#> 114  2   1   0  1
#> 115  1   2   1  1
#> 116  3   0   0  3
#> 117  1   1   0  1
#> 118  0   0   0  1
#> 
  # }

  # \donttest{
    try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
#>          date opponent_rk       opponent    result justin_lindner
#> 1   Wed Dec 2         297  North Florida  W, 86-58               
#> 2   Wed Dec 9          50        Indiana  W, 69-67               
#> 3  Sat Dec 12          41        Florida  W, 83-71               
#> 4  Tue Dec 15          37   Georgia Tech  W, 74-61               
#> 5  Sat Dec 19         100            UCF  L, 86-74               
#> 6  Mon Dec 21         182   Gardner Webb  W, 72-59              1
#> 7  Tue Dec 29          45        Clemson  L, 77-67               
#> 8  Wed Jan 13          71     N.C. State W, 105-73              6
#> 9  Sat Jan 16          34 North Carolina  W, 82-75               
#> 10 Mon Jan 18          59     Louisville  W, 78-65              1
#> 11 Sat Jan 23          45        Clemson  W, 80-61              3
#> 12 Wed Jan 27         138       Miami FL  W, 81-59              2
#> 13 Sat Jan 30          37   Georgia Tech  L, 76-65               
#> 14 Sat Feb 13         175    Wake Forest  W, 92-85               
#> 15 Mon Feb 15          19       Virginia  W, 81-60              1
#> 16 Sat Feb 20          97     Pittsburgh  W, 79-72               
#> 17 Wed Feb 24         138       Miami FL  W, 88-71              2
#> 18 Sat Feb 27          34 North Carolina  L, 78-70               
#> 19  Wed Mar 3         148 Boston College  W, 93-64              5
#> 20  Sat Mar 6          85     Notre Dame  L, 83-73               
#> 21 Fri Mar 12          34 North Carolina  W, 69-66               
#> 22 Sat Mar 13          37   Georgia Tech  L, 80-75               
#> 23 Sat Mar 20         108 UNC Greensboro  W, 64-54               
#> 24 Mon Mar 22           8       Colorado  W, 71-53               
#> 25 Sun Mar 28           3       Michigan  L, 76-58              1
#>    ray_quan_evans mj_walker nathanael_jack anthony_polite sardaar_calhoun
#> 1              16        27             11             24              15
#> 2              13        41                            33              14
#> 3              18        29              3             27               7
#> 4                        35              5             34               6
#> 5              15        37                            31               8
#> 6              24        23             11             28              10
#> 7              21        33              4             27              11
#> 8              19        22             12             21              15
#> 9              31        32              2             27              16
#> 10             27        32              7                             16
#> 11             18        17             22                             17
#> 12             18        27             13                             25
#> 13             27        25              4                             17
#> 14             17        37              3             30              10
#> 15             19        29              2             15              19
#> 16             22        28                            20              14
#> 17             15                       15             24              24
#> 18             17        29                            26              20
#> 19             16        24             12             25              11
#> 20             31        26              2             26              20
#> 21             13        28              4             24              20
#> 22             12        27                            32              12
#> 23             16        32                            30              11
#> 24             18        31              9             28              11
#> 25             16        26              4             25               9
#>    travis_light will_miles harrison_prieto rai_quan_gray wyatt_wilkes
#> 1                                                     18           16
#> 2                                        1            31            7
#> 3                                                     23           18
#> 4                                                     30           11
#> 5                                        3            26           15
#> 6             0          0               0            25           12
#> 7                                                     21           15
#> 8             3          3                            22           15
#> 9                                                     30           10
#> 10            1          1                            30           16
#> 11            3          3                            11           18
#> 12            2          2                            22           20
#> 13                                                    34           26
#> 14                                                    37           20
#> 15            1          1                            28           13
#> 16                                                    29           13
#> 17            2          2                            26           22
#> 18                                                    32            9
#> 19            5          5               5            19           16
#> 20                                                    35            8
#> 21                                                    27            6
#> 22                                                    21           11
#> 23                                                    31            6
#> 24            1          1               1            28           11
#> 25            1                          1            20            9
#>    malik_osborne scottie_barnes quincy_ballard balsa_koprivica tanor_ngom
#> 1             17             24              7              18          7
#> 2             31             30              1              21          2
#> 3             21             28              2              16          6
#> 4             19             30              4              26           
#> 5             13             29              2              14          5
#> 6             17             22              2              23          2
#> 7             24             21                             19          3
#> 8             20             13              5              14         10
#> 9             15                                            30          7
#> 10            25             22              1              14          8
#> 11            24             23              5              23         12
#> 12            19             19              4              17          9
#> 13            21             23                             17          6
#> 14            25             33              7                          6
#> 15            24             24              2              14          8
#> 16            24             26                             15          9
#> 17             9             24             11              23           
#> 18            20             22              0              24          1
#> 19                           21              5              23          8
#> 20             8             32                              6          5
#> 21            20             25              1              28          5
#> 22            22             29                             26          8
#> 23            14             26                             24         10
#> 24            20             22              1              11          7
#> 25            31             25              1              23          5
#>    starting_lineup_number        team year
#> 1                       1 Florida St. 2021
#> 2                       1 Florida St. 2021
#> 3                       1 Florida St. 2021
#> 4                       1 Florida St. 2021
#> 5                       1 Florida St. 2021
#> 6                       1 Florida St. 2021
#> 7                       1 Florida St. 2021
#> 8                       2 Florida St. 2021
#> 9                       2 Florida St. 2021
#> 10                      3 Florida St. 2021
#> 11                      3 Florida St. 2021
#> 12                      3 Florida St. 2021
#> 13                      3 Florida St. 2021
#> 14                      4 Florida St. 2021
#> 15                      4 Florida St. 2021
#> 16                      4 Florida St. 2021
#> 17                      5 Florida St. 2021
#> 18                      3 Florida St. 2021
#> 19                      6 Florida St. 2021
#> 20                      2 Florida St. 2021
#> 21                      2 Florida St. 2021
#> 22                      2 Florida St. 2021
#> 23                      2 Florida St. 2021
#> 24                      2 Florida St. 2021
#> 25                      2 Florida St. 2021
  # }


  # \donttest{
    try(kp_team_player_stats(team = 'Florida St.', year = 2021))
#> $all_games
#> # A tibble: 13 × 54
#>    role   number player ht       wt yr        g min_pct o_rtg poss_pct shots_pct
#>    <chr>   <dbl> <chr>  <chr> <dbl> <chr> <dbl>   <dbl> <dbl>    <dbl>     <dbl>
#>  1 Major…      4 Scott… 6-9     227 Fr       24    58.7 108.      25.4      22.7
#>  2 Signi…     23 MJ Wa… 6-5     213 Sr       24    69   106.      21.9      21.6
#>  3 Signi…      1 RaiQu… 6-8     260 Jr       25    65   110.      23.6      22.2
#>  4 Signi…      5 Balsa… 7-1     240 So       24    46.4 117.      22        21.7
#>  5 Signi…     11 Natha… 6-5     195 Sr       19    14.4 109.      21.1      26.7
#>  6 Role …      2 Antho… 6-6     215 Jr       21    55.1 122.      17.1      18.6
#>  7 Role …      0 RayQu… 6-4     210 Sr       24    45.5  97.5     16.7      15.2
#>  8 Role …     24 Sarda… 6-6     220 Jr       25    35.5 106.      17.8      22.4
#>  9 Role …     34 Tanor… 7-2     236 Sr       23    14.8  98.2     19        15.3
#> 10 Limit…     10 Malik… 6-9     225 Jr       24    47.8 115.      14.3      15.6
#> 11 Limit…     31 Wyatt… 6-8     220 Jr       25    34   112.      14.2      17.3
#> 12 Bench…     15 Quinc… 6-11    240 Fr       18     6    95       19.1      15.9
#> 13 Bench…     12 Justi… 6-1     180 Sr        9     2.2 104.      27.9      31.4
#> # ℹ 43 more variables: e_fg_pct <dbl>, ts_pct <dbl>, or_pct <dbl>,
#> #   dr_pct <dbl>, a_rate <dbl>, to_rate <dbl>, blk_pct <dbl>, stl_pct <dbl>,
#> #   f_cper40 <dbl>, f_dper40 <dbl>, ft_rate <dbl>, ftm <dbl>, fta <dbl>,
#> #   ft_pct <dbl>, fgm_2 <dbl>, fga_2 <dbl>, fg_2_pct <dbl>, fgm_3 <dbl>,
#> #   fga_3 <dbl>, fg_3_pct <dbl>, category <chr>, min_pct_rk <dbl>,
#> #   o_rtg_rk <dbl>, poss_pct_rk <dbl>, shots_pct_rk <dbl>, e_fg_pct_rk <dbl>,
#> #   ts_pct_rk <dbl>, or_pct_rk <dbl>, dr_pct_rk <dbl>, a_rate_rk <dbl>, …
#> 
#> $conference_games
#> # A tibble: 11 × 54
#>    role   number player ht       wt yr        g min_pct o_rtg poss_pct shots_pct
#>    <chr>   <dbl> <chr>  <chr> <dbl> <chr> <dbl>   <dbl> <dbl>    <dbl>     <dbl>
#>  1 Major…      1 RaiQu… 6-8     260 Jr       15    67.1  112.     25.9      22.9
#>  2 Major…      4 Scott… 6-9     227 Fr       14    55    114      26.2      23.6
#>  3 Signi…     23 MJ Wa… 6-5     213 Sr       14    65.5  111.     20.5      21.6
#>  4 Signi…     11 Natha… 6-5     195 Sr       13    17    114.     21.4      27.4
#>  5 Role …      0 RayQu… 6-4     210 Sr       14    49.3  110.     16.9      15.8
#>  6 Role …      2 Antho… 6-6     215 Jr       11    45.5  115.     16.6      17.6
#>  7 Role …      5 Balsa… 7-1     240 So       14    43.8  124.     19.9      19.6
#>  8 Role …     24 Sarda… 6-6     220 Jr       15    39.8  111      18.6      22.6
#>  9 Role …     34 Tanor… 7-2     236 Sr       13    15.2  108      16.8      13.9
#> 10 Limit…     10 Malik… 6-9     225 Jr       14    45.8  114.     14.5      16.3
#> 11 Limit…     31 Wyatt… 6-8     220 Jr       15    38.4  122.     14.3      16.5
#> # ℹ 43 more variables: e_fg_pct <dbl>, ts_pct <dbl>, or_pct <dbl>,
#> #   dr_pct <dbl>, a_rate <dbl>, to_rate <dbl>, blk_pct <dbl>, stl_pct <dbl>,
#> #   f_cper40 <dbl>, f_dper40 <dbl>, ft_rate <dbl>, ftm <dbl>, fta <dbl>,
#> #   ft_pct <dbl>, fgm_2 <dbl>, fga_2 <dbl>, fg_2_pct <dbl>, fgm_3 <dbl>,
#> #   fga_3 <dbl>, fg_3_pct <dbl>, category <chr>, min_pct_rk <dbl>,
#> #   o_rtg_rk <dbl>, poss_pct_rk <dbl>, shots_pct_rk <dbl>, e_fg_pct_rk <dbl>,
#> #   ts_pct_rk <dbl>, or_pct_rk <dbl>, dr_pct_rk <dbl>, a_rate_rk <dbl>, …
#> 
  # }
  # \donttest{
    try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
#>           team year player_id     player_name class_year height weight pct_pg
#> 1  Florida St. 2021     40660 Harrison Prieto         Sr    6-8    230  0.000
#> 2  Florida St. 2021     39830      Will Miles         Sr    6-6    220  0.007
#> 3  Florida St. 2021     39730    Travis Light         Sr    6-6    190  0.000
#> 4  Florida St. 2021     41002  Justin Lindner         Sr    6-1    180  0.009
#> 5  Florida St. 2021     50422  Quincy Ballard         Fr   6-11    240  0.000
#> 6  Florida St. 2021     46224  Nathanael Jack         Sr    6-5    195  0.000
#> 7  Florida St. 2021     50424      Tanor Ngom         Sr    7-2    236  0.000
#> 8  Florida St. 2021     41756    Wyatt Wilkes         Jr    6-8    220  0.000
#> 9  Florida St. 2021     50423 Sardaar Calhoun         Jr    6-6    220  0.000
#> 10 Florida St. 2021     46222   RayQuan Evans         Sr    6-4    210  0.058
#> 11 Florida St. 2021     45361 Balsa Koprivica         So    7-1    240  0.000
#> 12 Florida St. 2021     41180   Malik Osborne         Jr    6-9    225  0.000
#> 13 Florida St. 2021     40132  Anthony Polite         Jr    6-6    215  0.000
#> 14 Florida St. 2021     50421  Scottie Barnes         Fr    6-9    227  0.218
#> 15 Florida St. 2021     41441    RaiQuan Gray         Jr    6-8    260  0.000
#> 16 Florida St. 2021     41310       MJ Walker         Sr    6-5    213  0.709
#>    pct_sg pct_sf pct_pf pct_c pct_poss fta fg2a fg3a
#> 1   0.000  0.008  0.007 0.000   0.1685   2    1    1
#> 2   0.000  0.000  0.000 0.000   0.2521   0    7    0
#> 3   0.009  0.007  0.000 0.000   0.1405   0    1    5
#> 4   0.000  0.000  0.000 0.000   0.2786   0    6    4
#> 5   0.000  0.000  0.000 0.020   0.1910   7   14    0
#> 6   0.077  0.000  0.000 0.000   0.2112   8   10   46
#> 7   0.000  0.000  0.000 0.181   0.1904  19   30    3
#> 8   0.016  0.128  0.059 0.001   0.1421   5   23   63
#> 9   0.261  0.066  0.000 0.000   0.1777  14   58   58
#> 10  0.294  0.021  0.000 0.000   0.1670  46   76   25
#> 11  0.000  0.000  0.000 0.539   0.2200  61  146    1
#> 12  0.000  0.000  0.499 0.023   0.1432  37   57   52
#> 13  0.345  0.353  0.001 0.000   0.1705  42   72   78
#> 14  0.000  0.416  0.029 0.000   0.2545  66  155   40
#> 15  0.000  0.000  0.405 0.236   0.2359  93  181   30
#> 16  0.000  0.000  0.000 0.000   0.2186  74  114  104
  # }


  # \donttest{
    try(kp_team_lineups(team = 'Florida St.', year = 2021))
#> ✖ 2026-10-26 19:20:40.310136: 2026-10-26 19:20:40.309724 - Florida St. - 2021 Team Lineups are missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: subscript out of bounds
#> NULL
  # }
```
