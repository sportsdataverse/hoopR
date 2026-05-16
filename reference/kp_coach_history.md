# **Get KenPom's coaching resume data**

**Get KenPom's coaching resume data**

## Usage

``` r
kp_coach_history(coach)
```

## Arguments

- coach:

  Coach filter to select.

## Value

A data frame with 30 columns:

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| year               | numeric   |
| team_rk            | numeric   |
| team               | character |
| coach              | character |
| conf               | character |
| adj_t              | character |
| adj_o              | character |
| adj_d              | character |
| off_e_fg_pct       | character |
| off_to_pct         | character |
| off_or_pct         | character |
| off_ft_rate        | character |
| off_fg_2_pct       | character |
| off_fg_3_pct       | character |
| off_ft_pct         | character |
| off_fg_3a_pct      | character |
| off_a_pct          | character |
| off_apl            | character |
| def_e_fg_pct       | character |
| def_to_pct         | character |
| def_or_pct         | character |
| def_ft_rate        | character |
| def_fg_2_pct       | character |
| def_fg_3_pct       | character |
| def_blk_pct        | character |
| def_fg_3a_pct      | character |
| def_a_pct          | character |
| def_apl            | character |
| foul2partic_pct    | character |
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
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
  # \donttest{
   try(kp_coach_history(coach = 'Leonard Hamilton'))
#> # A tibble: 27 × 57
#>     year team_rk team      coach conf  adj_t adj_o adj_d off_e_fg_pct off_to_pct
#>    <dbl>   <dbl> <chr>     <chr> <chr> <chr> <chr> <chr> <chr>        <chr>     
#>  1  2025      NA Florida … Leon… ACC   69.7  108.8 100.6 50.7         17.5      
#>  2  2024      NA Florida … Leon… ACC   71.1  110.9 100.6 50.3         16.4      
#>  3  2023      NA Florida … Leon… ACC   68.6  105.4 107.8 49.3         17.6      
#>  4  2022      NA Florida … Leon… ACC   67.8  105.3 99.1  49.0         18.1      
#>  5  2021      NA Florida … Leon… ACC   69.9  114.9 92.8  54.0         20.4      
#>  6  2020      NA Florida … Leon… ACC   69.9  111.7 91.5  51.9         18.9      
#>  7  2019      NA Florida … Leon… ACC   68.6  112.8 90.4  50.5         18.9      
#>  8  2018      NA Florida … Leon… ACC   71.2  114.3 96.5  53.2         17.8      
#>  9  2017      NA Florida … Leon… ACC   71.3  115.5 95.5  53.7         16.4      
#> 10  2016      NA Florida … Leon… ACC   71.6  113.1 98.9  51.8         18.0      
#> # ℹ 17 more rows
#> # ℹ 47 more variables: off_or_pct <chr>, off_ft_rate <chr>, off_fg_2_pct <chr>,
#> #   off_fg_3_pct <chr>, off_ft_pct <chr>, off_fg_3a_pct <chr>, off_a_pct <chr>,
#> #   off_apl <chr>, def_e_fg_pct <chr>, def_to_pct <chr>, def_or_pct <chr>,
#> #   def_ft_rate <chr>, def_fg_2_pct <chr>, def_fg_3_pct <chr>,
#> #   def_blk_pct <chr>, def_fg_3a_pct <chr>, def_a_pct <chr>, def_apl <chr>,
#> #   foul2partic_pct <chr>, wl <chr>, wl_conf <chr>, adj_t_rk <dbl>, …
  # }

```
