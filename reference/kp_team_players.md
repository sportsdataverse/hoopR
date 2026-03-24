# **Get KenPom's player stats from the team page**

**Get KenPom's player stats from the team page**

## Usage

``` r
kp_team_players(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of team player data

|               |           |
|---------------|-----------|
| col_name      | types     |
| role          | character |
| number        | numeric   |
| player        | character |
| ht            | character |
| wt            | numeric   |
| yr            | character |
| g             | numeric   |
| s             | numeric   |
| min_pct       | numeric   |
| o_rtg         | numeric   |
| poss_pct      | numeric   |
| shots_pct     | numeric   |
| e_fg_pct      | numeric   |
| ts_pct        | numeric   |
| or_pct        | numeric   |
| dr_pct        | numeric   |
| a_rate        | numeric   |
| to_rate       | numeric   |
| blk_pct       | numeric   |
| stl_pct       | numeric   |
| f_cper40      | numeric   |
| f_dper40      | numeric   |
| ft_rate       | numeric   |
| ftm           | numeric   |
| fta           | numeric   |
| ft_pct        | numeric   |
| fgm_2         | numeric   |
| fga_2         | numeric   |
| fg_2_pct      | numeric   |
| fgm_3         | numeric   |
| fga_3         | numeric   |
| fg_3_pct      | numeric   |
| min_pct_rk    | numeric   |
| o_rtg_rk      | numeric   |
| poss_pct_rk   | numeric   |
| shots_pct_rk  | numeric   |
| e_fg_pct_rk   | numeric   |
| ts_pct_rk     | numeric   |
| or_pct_rk     | numeric   |
| dr_pct_rk     | numeric   |
| a_rate_rk     | numeric   |
| to_rate_rk    | numeric   |
| blk_pct_rk    | numeric   |
| stl_pct_rk    | numeric   |
| f_cper40_rk   | numeric   |
| f_dper40_rk   | numeric   |
| ft_rate_rk    | numeric   |
| ft_pct_rk     | numeric   |
| fg_2_pct_rk   | numeric   |
| fg_3_pct_rk   | numeric   |
| national_rank | character |
| team          | character |
| year          | numeric   |
| player_id     | numeric   |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_players(team = 'Florida St.', year = 2024))
#> 2026-03-24 04:18:13.338675 - No Player Data available for Florida St. in 2024
#> Error in kp_team_players(team = "Florida St.", year = 2024) : 
#>   object 'kenpom' not found
  # }
```
