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

|              |           |                                            |
|--------------|-----------|--------------------------------------------|
| col_name     | types     | description                                |
| conf         | character | character.                                 |
| eff          | numeric   | Eff.                                       |
| eff_rk       | numeric   | Eff rk.                                    |
| tempo        | numeric   | Tempo.                                     |
| tempo_rk     | numeric   | Tempo rk.                                  |
| e_fg_pct     | numeric   | E field goals percentage (0-1 decimal).    |
| e_fg_pct_rk  | numeric   | E fg pct rk.                               |
| to_pct       | numeric   | To percentage (0-1 decimal).               |
| to_pct_rk    | numeric   | To pct rk.                                 |
| or_pct       | numeric   | Or percentage (0-1 decimal).               |
| or_pct_rk    | numeric   | Or pct rk.                                 |
| ft_rate      | numeric   | Ft rate.                                   |
| ft_rate_rk   | numeric   | Ft rate rk.                                |
| blk_pct      | numeric   | Blocks percentage (0-1 decimal).           |
| blk_pct_rk   | numeric   | Blk pct rk.                                |
| stl_pct      | numeric   | Steals percentage (0-1 decimal).           |
| stl_pct_rk   | numeric   | Stl pct rk.                                |
| fg_2_pct     | numeric   | Field goals 2 percentage (0-1 decimal).    |
| fg_2_pct_rk  | numeric   | Fg 2 pct rk.                               |
| fg_3_pct     | numeric   | Field goals 3 percentage (0-1 decimal).    |
| fg_3_pct_rk  | numeric   | Fg 3 pct rk.                               |
| ft_pct       | numeric   | Free throw percentage (0-1).               |
| ft_pct_rk    | numeric   | Ft pct rk.                                 |
| fg_3a_pct    | numeric   | Field goals 3a percentage (0-1 decimal).   |
| fg_3a_pct_rk | numeric   | Fg 3a pct rk.                              |
| a_pct        | numeric   | A percentage (0-1 decimal).                |
| a_pct_rk     | numeric   | A pct rk.                                  |
| home_w_l     | character | Home team's wins losses.                   |
| home_w_l_pct | numeric   | Home wins losses percentage (0-1 decimal). |
| home_w_l_rk  | numeric   | Home team's wins losses rk.                |
| close        | numeric   | Close.                                     |
| close_rk     | numeric   | Close rk.                                  |
| blowouts     | numeric   | Blowouts.                                  |
| blowouts_rk  | numeric   | Blowouts rk.                               |
| year         | numeric   | 4-digit year.                              |

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
#> ✖ 2026-08-26 19:55:59.657531: Invalid arguments or no conference stats data for 2026 available!
#> ✖ Args: year = 2026
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
