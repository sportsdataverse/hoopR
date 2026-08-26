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

|                |           |                                     |
|----------------|-----------|-------------------------------------|
| col_name       | types     | description                         |
| adj_em_rk      | numeric   | Adj em rk.                          |
| team           | character | Team-side label or team identifier. |
| conf           | character | character.                          |
| adj_em         | numeric   | Adj em.                             |
| adj_o          | numeric   | Adj o.                              |
| adj_o_rk       | numeric   | Adj o rk.                           |
| adj_d          | numeric   | Adj d.                              |
| adj_d_rk       | numeric   | Adj d rk.                           |
| adj_t          | numeric   | Adj t.                              |
| adj_t_rk       | numeric   | Adj t rk.                           |
| final_rk       | numeric   | Final rk.                           |
| final_adj_em   | numeric   | Final adj em.                       |
| final_adj_o    | numeric   | Final adj o.                        |
| final_adj_o_rk | numeric   | Final adj o rk.                     |
| final_adj_d    | numeric   | Final adj d.                        |
| final_adj_d_rk | numeric   | Final adj d rk.                     |
| final_adj_t    | numeric   | Final adj t.                        |
| final_adj_t_rk | numeric   | Final adj t rk.                     |
| rk_chg         | numeric   | Rk chg.                             |
| em_chg         | numeric   | Em chg.                             |
| adj_t_chg      | numeric   | Adj t chg.                          |
| ncaa_seed      | numeric   | Ncaa seed.                          |

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
#> ✖ 2026-08-26 19:09:57.587867: Invalid arguments or no kp_pomeroy_archive_ratings data for 2018-11-22 available!
#> ✖ Args: date = "2018-11-22"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
