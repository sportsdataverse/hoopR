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
```
