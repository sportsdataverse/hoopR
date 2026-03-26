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

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| year            | integer   |
| rk              | numeric   |
| team            | character |
| conf            | character |
| w_l             | character |
| adj_em          | numeric   |
| adj_o           | numeric   |
| adj_o_rk        | numeric   |
| adj_d           | numeric   |
| adj_d_rk        | numeric   |
| adj_t           | numeric   |
| adj_t_rk        | numeric   |
| luck            | numeric   |
| luck_rk         | numeric   |
| sos_adj_em      | numeric   |
| sos_adj_em_rk   | numeric   |
| sos_opp_o       | numeric   |
| sos_opp_o_rk    | numeric   |
| sos_opp_d       | numeric   |
| sos_opp_d_rk    | numeric   |
| ncsos_adj_em    | numeric   |
| ncsos_adj_em_rk | numeric   |
| ncaa_seed       | numeric   |

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
#> 2026-03-26 14:51:21.87196: Invalid arguments or no pomeroy ratings data for 2020 - 2021 available!
#> Error in kp_pomeroy_ratings(min_year = 2020, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
