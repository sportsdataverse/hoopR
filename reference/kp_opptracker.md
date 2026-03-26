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

|                  |           |
|------------------|-----------|
| col_name         | types     |
| date             | Date      |
| game_date        | numeric   |
| day_date         | character |
| wl               | character |
| team             | character |
| team_score       | numeric   |
| opponent         | character |
| opponent_score   | numeric   |
| result           | character |
| adj_oe           | numeric   |
| adj_oe_rk        | integer   |
| off_e_fg_pct     | numeric   |
| off_e_fg_pct_rk  | integer   |
| off_to_pct       | numeric   |
| off_to_pct_rk    | integer   |
| off_or_pct       | numeric   |
| off_or_pct_rk    | integer   |
| off_ft_rate      | numeric   |
| off_ft_rate_rk   | integer   |
| off_fg_2_pct     | numeric   |
| off_fg_2_pct_rk  | integer   |
| off_fg_3_pct     | numeric   |
| off_fg_3_pct_rk  | integer   |
| off_blk_pct      | numeric   |
| off_blk_pct_rk   | integer   |
| off_fg_3a_pct    | numeric   |
| off_fg_3a_pct_rk | integer   |
| off_apl          | numeric   |
| off_apl_rk       | integer   |
| adj_de           | numeric   |
| adj_de_rk        | integer   |
| def_e_fg_pct     | numeric   |
| def_e_fg_pct_rk  | integer   |
| def_to_pct       | numeric   |
| def_to_pct_rk    | integer   |
| def_or_pct       | numeric   |
| def_or_pct_rk    | integer   |
| def_ft_rate      | numeric   |
| def_ft_rate_rk   | integer   |
| def_fg_2_pct     | numeric   |
| def_fg_2_pct_rk  | integer   |
| def_fg_3_pct     | numeric   |
| def_fg_3_pct_rk  | integer   |
| def_blk_pct      | numeric   |
| def_blk_pct_rk   | integer   |
| def_fg_3a_pct    | numeric   |
| def_fg_3a_pct_rk | integer   |
| def_apl          | numeric   |
| def_apl_rk       | integer   |

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
#> 2026-03-26 14:51:20.451736 - Florida St. - 2021 Team opponent tracker data is missing
#> Error in kp_opptracker(team = "Florida St.", year = 2021) : 
#>   object 'kenpom' not found
# }
```
