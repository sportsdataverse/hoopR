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
#> 2026-03-24 04:18:12.434949: Invalid arguments or no team history data for Florida St. available!
#> Error in kp_team_history(team = "Florida St.") : 
#>   object 'kenpom' not found
  # }
```
