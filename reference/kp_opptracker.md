# **Get KenPom's team opponent tracker page**

**Get KenPom's team opponent tracker page**

## Usage

``` r
kp_opptracker(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

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

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
# \donttest{
  try(kp_opptracker(team = 'Florida St.', year = 2021))
#> ✖ 2026-06-04 12:23:34.419985: 2026-06-04 12:23:34.419632 - Florida St. - 2021 Team opponent tracker data is missing
#> ✖ Args: team = "Florida St.", year = 2021
#> ✖ Error: subscript out of bounds
#> NULL
# }
```
