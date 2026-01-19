# **Get KenPom's conference comparison stats**

**Get KenPom's conference comparison stats**

## Usage

``` r
kp_confstats(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year (YYYY)

## Value

A data frame with the following columns:

|              |           |
|--------------|-----------|
| col_name     | types     |
| conf         | character |
| eff          | numeric   |
| eff_rk       | numeric   |
| tempo        | numeric   |
| tempo_rk     | numeric   |
| e_fg_pct     | numeric   |
| e_fg_pct_rk  | numeric   |
| to_pct       | numeric   |
| to_pct_rk    | numeric   |
| or_pct       | numeric   |
| or_pct_rk    | numeric   |
| ft_rate      | numeric   |
| ft_rate_rk   | numeric   |
| blk_pct      | numeric   |
| blk_pct_rk   | numeric   |
| stl_pct      | numeric   |
| stl_pct_rk   | numeric   |
| fg_2_pct     | numeric   |
| fg_2_pct_rk  | numeric   |
| fg_3_pct     | numeric   |
| fg_3_pct_rk  | numeric   |
| ft_pct       | numeric   |
| ft_pct_rk    | numeric   |
| fg_3a_pct    | numeric   |
| fg_3a_pct_rk | numeric   |
| a_pct        | numeric   |
| a_pct_rk     | numeric   |
| home_w_l     | character |
| home_w_l_pct | numeric   |
| home_w_l_rk  | numeric   |
| close        | numeric   |
| close_rk     | numeric   |
| blowouts     | numeric   |
| blowouts_rk  | numeric   |
| year         | numeric   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_confstats(year=most_recent_mbb_season()))
#> Error in kp_confstats(year = most_recent_mbb_season()) : 
#>   object 'kenpom' not found
# }
```
