# **Get KenPom's team efficiency history**

**Get KenPom's team efficiency history**

## Usage

``` r
kp_team_history(team)
```

## Arguments

- team:

  Team filter to select.

## Value

A data frame with the following columns:

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| year               | numeric   |
| team_rk            | numeric   |
| team               | character |
| coach              | character |
| conf               | character |
| adj_t              | numeric   |
| adj_o              | numeric   |
| adj_d              | numeric   |
| off_e_fg_pct       | numeric   |
| off_to_pct         | numeric   |
| off_or_pct         | numeric   |
| off_ft_rate        | numeric   |
| off_fg_2_pct       | numeric   |
| off_fg_3_pct       | numeric   |
| off_ft_pct         | numeric   |
| off_fg_3a_pct      | numeric   |
| off_a_pct          | numeric   |
| off_apl            | numeric   |
| def_e_fg_pct       | numeric   |
| def_to_pct         | numeric   |
| def_or_pct         | numeric   |
| def_ft_rate        | numeric   |
| def_fg_2_pct       | numeric   |
| def_fg_3_pct       | numeric   |
| def_blk_pct        | numeric   |
| def_fg_3a_pct      | numeric   |
| def_a_pct          | numeric   |
| def_apl            | numeric   |
| foul2partic_pct    | numeric   |
| wl                 | character |
| wl_conf            | character |
| adj_t_rk           | numeric   |
| adj_o_rk           | numeric   |
| adj_d_rk           | numeric   |
| off_e_fg_pct_rk    | numeric   |
| off_to_pct_rk      | numeric   |
| off_or_pct_rk      | numeric   |
| off_ft_rate_rk     | numeric   |
| off_fg_2_pct_rk    | numeric   |
| off_fg_3_pct_rk    | numeric   |
| off_ft_pct_rk      | numeric   |
| off_fg_3a_pct_rk   | numeric   |
| off_a_pct_rk       | numeric   |
| off_apl_rk         | numeric   |
| def_e_fg_pct_rk    | numeric   |
| def_to_pct_rk      | numeric   |
| def_or_pct_rk      | numeric   |
| def_ft_rate_rk     | numeric   |
| def_fg_2_pct_rk    | numeric   |
| def_fg_3_pct_rk    | numeric   |
| def_blk_pct_rk     | numeric   |
| def_fg_3a_pct_rk   | numeric   |
| def_a_pct_rk       | numeric   |
| def_apl_rk         | numeric   |
| foul2partic_pct_rk | numeric   |
| team_finish        | character |
| ncaa_seed          | numeric   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md)

## Examples

``` r
  # \donttest{
    try(kp_team_history(team = 'Florida St.'))
#> # A tibble: 30 × 57
#>     year team_rk team      coach conf  adj_t adj_o adj_d off_e_fg_pct off_to_pct
#>    <dbl>   <dbl> <chr>     <chr> <chr> <dbl> <dbl> <dbl>        <dbl>      <dbl>
#>  1  2026      NA Florida … Luke… ACC    70.5  118. 105.          52.3       15.2
#>  2  2025      NA Florida … Leon… ACC    69.7  109. 101.          50.7       17.5
#>  3  2024      NA Florida … Leon… ACC    71.1  111. 101.          50.3       16.4
#>  4  2023      NA Florida … Leon… ACC    68.6  105. 108.          49.3       17.6
#>  5  2022      NA Florida … Leon… ACC    67.8  105.  99.1         49         18.1
#>  6  2021      NA Florida … Leon… ACC    69.9  115.  92.8         54         20.4
#>  7  2020      NA Florida … Leon… ACC    69.9  112.  91.5         51.9       18.9
#>  8  2019      NA Florida … Leon… ACC    68.6  113.  90.4         50.5       18.9
#>  9  2018      NA Florida … Leon… ACC    71.2  114.  96.5         53.2       17.8
#> 10  2017      NA Florida … Leon… ACC    71.3  116.  95.5         53.7       16.4
#> # ℹ 20 more rows
#> # ℹ 47 more variables: off_or_pct <dbl>, off_ft_rate <dbl>, off_fg_2_pct <dbl>,
#> #   off_fg_3_pct <dbl>, off_ft_pct <dbl>, off_fg_3a_pct <dbl>, off_a_pct <dbl>,
#> #   off_apl <dbl>, def_e_fg_pct <dbl>, def_to_pct <dbl>, def_or_pct <dbl>,
#> #   def_ft_rate <dbl>, def_fg_2_pct <dbl>, def_fg_3_pct <dbl>,
#> #   def_blk_pct <dbl>, def_fg_3a_pct <dbl>, def_a_pct <dbl>, def_apl <dbl>,
#> #   foul2partic_pct <dbl>, wl <chr>, wl_conf <chr>, adj_t_rk <dbl>, …
  # }
```
