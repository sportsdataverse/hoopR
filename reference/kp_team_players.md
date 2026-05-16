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
