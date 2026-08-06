# **Get KenPom Ratings**

**Get KenPom Ratings**

## Usage

``` r
kp_pomeroy_ratings(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of ratings

|                 |           |                                     |
|-----------------|-----------|-------------------------------------|
| col_name        | types     | description                         |
| year            | integer   | 4-digit year.                       |
| rk              | numeric   | Rk.                                 |
| team            | character | Team-side label or team identifier. |
| conf            | character | character.                          |
| w_l             | character | W l.                                |
| adj_em          | numeric   | Adj em.                             |
| adj_o           | numeric   | Adj o.                              |
| adj_o_rk        | numeric   | Adj o rk.                           |
| adj_d           | numeric   | Adj d.                              |
| adj_d_rk        | numeric   | Adj d rk.                           |
| adj_t           | numeric   | Adj t.                              |
| adj_t_rk        | numeric   | Adj t rk.                           |
| luck            | numeric   | Luck.                               |
| luck_rk         | numeric   | Luck rk.                            |
| sos_adj_em      | numeric   | Sos adj em.                         |
| sos_adj_em_rk   | numeric   | Sos adj em rk.                      |
| sos_opp_o       | numeric   | Sos opp o.                          |
| sos_opp_o_rk    | numeric   | Sos opp o rk.                       |
| sos_opp_d       | numeric   | Sos opp d.                          |
| sos_opp_d_rk    | numeric   | Sos opp d rk.                       |
| ncsos_adj_em    | numeric   | Ncsos adj em.                       |
| ncsos_adj_em_rk | numeric   | Ncsos adj em rk.                    |
| ncaa_seed       | numeric   | Ncaa seed.                          |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_pomeroy_ratings(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-06 04:00:54.27126: Invalid arguments or no pomeroy ratings data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
