# **Get KenPom's ratings archive pages**

**Get KenPom's ratings archive pages**

## Usage

``` r
kp_pomeroy_archive_ratings(date)
```

## Arguments

- date:

  Date (YYYY-MM-DD)

## Value

A data frame with 22 columns:

|                |           |
|----------------|-----------|
| col_name       | types     |
| adj_em_rk      | numeric   |
| team           | character |
| conf           | character |
| adj_em         | numeric   |
| adj_o          | numeric   |
| adj_o_rk       | numeric   |
| adj_d          | numeric   |
| adj_d_rk       | numeric   |
| adj_t          | numeric   |
| adj_t_rk       | numeric   |
| final_rk       | numeric   |
| final_adj_em   | numeric   |
| final_adj_o    | numeric   |
| final_adj_o_rk | numeric   |
| final_adj_d    | numeric   |
| final_adj_d_rk | numeric   |
| final_adj_t    | numeric   |
| final_adj_t_rk | numeric   |
| rk_chg         | numeric   |
| em_chg         | numeric   |
| adj_t_chg      | numeric   |
| ncaa_seed      | numeric   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_pomeroy_archive_ratings(date='2018-11-22'))
#> 2026-03-24 04:18:11.003398: Invalid arguments or no kp_pomeroy_archive_ratings data for 2018-11-22 available!
#> Error in kp_pomeroy_archive_ratings(date = "2018-11-22") : 
#>   object 'kenpom' not found
# }
```
