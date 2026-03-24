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

|               |           |
|---------------|-----------|
| col_name      | types     |
| year          | numeric   |
| team_rk       | numeric   |
| team          | character |
| number        | numeric   |
| name          | character |
| position      | character |
| hgt           | character |
| wgt           | numeric   |
| yr            | character |
| g             | numeric   |
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
| group_rank    | character |
| team_finish   | character |
| ncaa_seed     | numeric   |
| hometown      | character |
| date_of_birth | character |
| age           | character |
| comparisons   | character |

**gamelog**

|                |           |
|----------------|-----------|
| col_name       | types     |
| year           | numeric   |
| team           | character |
| name           | character |
| position       | character |
| opponent_tier  | logical   |
| date           | character |
| opponent_rk    | numeric   |
| opponent       | character |
| result         | character |
| ot             | character |
| location       | character |
| game_type      | character |
| mvp            | character |
| start          | character |
| minutes_played | numeric   |
| o_rtg          | numeric   |
| poss_pct       | numeric   |
| pts            | numeric   |
| fgm_2          | numeric   |
| fga_2          | numeric   |
| fgm_3          | numeric   |
| fga_3          | numeric   |
| ftm            | numeric   |
| fta            | numeric   |
| or             | numeric   |
| dr             | numeric   |
| a              | numeric   |
| to             | numeric   |
| blk            | numeric   |
| stl            | numeric   |
| pf             | numeric   |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_player_career(player_id = '41180'))
#> 2026-03-24 04:18:10.143195 - No Player Career Data available for 41180
#> Error in kp_player_career(player_id = "41180") : 
#>   object 'kenpom' not found
  # }
```
