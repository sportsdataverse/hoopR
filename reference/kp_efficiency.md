# **Get KenPom Efficiency and Tempo Summary**

**Get KenPom Efficiency and Tempo Summary**

## Usage

``` r
kp_efficiency(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of efficiency and tempo ratings

|                        |           |                                     |
|------------------------|-----------|-------------------------------------|
| col_name               | types     | description                         |
| team                   | character | Team-side label or team identifier. |
| conf                   | character | character.                          |
| adj_t                  | numeric   | Adj t.                              |
| adj_t_rk               | numeric   | Adj t rk.                           |
| raw_t                  | numeric   | Raw t.                              |
| raw_t_rk               | numeric   | Raw t rk.                           |
| avg_poss_length_off    | numeric   | Avg poss length off.                |
| avg_poss_length_off_rk | numeric   | Avg poss length off rk.             |
| avg_poss_length_def    | numeric   | Avg poss length def.                |
| avg_poss_length_def_rk | numeric   | Avg poss length def rk.             |
| adj_o                  | numeric   | Adj o.                              |
| adj_o_rk               | numeric   | Adj o rk.                           |
| raw_o                  | numeric   | Raw o.                              |
| raw_o_rk               | numeric   | Raw o rk.                           |
| adj_d                  | numeric   | Adj d.                              |
| adj_d_rk               | numeric   | Adj d rk.                           |
| raw_d                  | numeric   | Raw d.                              |
| raw_d_rk               | numeric   | Raw d rk.                           |
| ncaa_seed              | numeric   | Ncaa seed.                          |
| year                   | numeric   | 4-digit year.                       |

## See also

Other KenPom Ratings Functions:
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_efficiency(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-24 19:11:51.623003: Invalid arguments or no efficiency data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
