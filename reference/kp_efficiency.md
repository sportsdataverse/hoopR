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

|                        |           |
|------------------------|-----------|
| col_name               | types     |
| team                   | character |
| conf                   | character |
| adj_t                  | numeric   |
| adj_t_rk               | numeric   |
| raw_t                  | numeric   |
| raw_t_rk               | numeric   |
| avg_poss_length_off    | numeric   |
| avg_poss_length_off_rk | numeric   |
| avg_poss_length_def    | numeric   |
| avg_poss_length_def_rk | numeric   |
| adj_o                  | numeric   |
| adj_o_rk               | numeric   |
| raw_o                  | numeric   |
| raw_o_rk               | numeric   |
| adj_d                  | numeric   |
| adj_d_rk               | numeric   |
| raw_d                  | numeric   |
| raw_d_rk               | numeric   |
| ncaa_seed              | numeric   |
| year                   | numeric   |

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
#> Error in kp_efficiency(min_year = 2020, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
