# **Get Four Factors Data**

**Get Four Factors Data**

## Usage

``` r
kp_fourfactors(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of four factors ratings

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| team            | character |
| conf            | character |
| adj_t           | numeric   |
| adj_t_rk        | numeric   |
| adj_o           | numeric   |
| adj_o_rk        | numeric   |
| off_e_fg_pct    | numeric   |
| off_e_fg_pct_rk | numeric   |
| off_to_pct      | numeric   |
| off_to_pct_rk   | numeric   |
| off_or_pct      | numeric   |
| off_or_pct_rk   | numeric   |
| off_ft_rate     | numeric   |
| off_ft_rate_rk  | numeric   |
| adj_d           | numeric   |
| adj_d_rk        | numeric   |
| def_e_fg_pct    | numeric   |
| def_e_fg_pct_rk | numeric   |
| def_to_pct      | numeric   |
| def_to_pct_rk   | numeric   |
| def_or_pct      | numeric   |
| def_or_pct_rk   | numeric   |
| def_ft_rate     | numeric   |
| def_ft_rate_rk  | numeric   |
| ncaa_seed       | numeric   |
| year            | numeric   |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_fourfactors(min_year = 2020, max_year = 2021))
#> 2026-03-24 04:18:07.601645: Invalid arguments or no four factors data for 2020 - 2021 available!
#> Error in kp_fourfactors(min_year = 2020, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
