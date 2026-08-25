# **Get KenPom's player career stats from the player page**

**Get KenPom's player career stats from the player page**

## Usage

``` r
kp_player_career(player_id)
```

## Arguments

- player_id:

  Player Id filter to select.

## Value

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

## See also

Other KenPom Team Functions:
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_player_career(player_id = '41180'))
#> ✖ 2026-08-25 00:24:44.41945: 2026-08-25 00:24:44.419156 - No Player Career Data available for 41180
#> ✖ Args: player_id = "41180"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
  # }
```
