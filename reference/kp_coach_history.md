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
#> 2026-03-26 14:51:16.237323: Invalid arguments or no coach history data for Leonard Hamilton available!
#> Error in kp_coach_history(coach = "Leonard Hamilton") : 
#>   object 'kenpom' not found
  # }

```
