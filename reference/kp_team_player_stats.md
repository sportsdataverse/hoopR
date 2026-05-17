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
```
