# **Get Team Stats**

**Get Team Stats**

## Usage

``` r
kp_teamstats(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of team stats

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| team               | character |
| conf               | character |
| off_fg_3_pct       | numeric   |
| off_fg_3_pct_rk    | numeric   |
| off_fg_2_pct       | numeric   |
| off_fg_2_pct_rk    | numeric   |
| off_ft_pct         | numeric   |
| off_ft_pct_rk      | numeric   |
| off_blk_pct        | numeric   |
| off_blk_pct_rk     | numeric   |
| off_stl_pct        | numeric   |
| off_stl_pct_rk     | numeric   |
| off_non_stl_pct    | numeric   |
| off_non_stl_pct_rk | numeric   |
| off_a_pct          | numeric   |
| off_a_pct_rk       | numeric   |
| off_fg_3a_pct      | numeric   |
| off_fg_3a_pct_rk   | numeric   |
| adj_o              | numeric   |
| adj_o_rk           | numeric   |
| ncaa_seed          | numeric   |
| year               | numeric   |
| def_fg_3_pct       | numeric   |
| def_fg_3_pct_rk    | numeric   |
| def_fg_2_pct       | numeric   |
| def_fg_2_pct_rk    | numeric   |
| def_ft_pct         | numeric   |
| def_ft_pct_rk      | numeric   |
| def_blk_pct        | numeric   |
| def_blk_pct_rk     | numeric   |
| def_stl_pct        | numeric   |
| def_stl_pct_rk     | numeric   |
| def_non_stl_pct    | numeric   |
| def_non_stl_pct_rk | numeric   |
| def_a_pct          | numeric   |
| def_a_pct_rk       | numeric   |
| def_fg_3a_pct      | numeric   |
| def_fg_3a_pct_rk   | numeric   |
| adj_d              | numeric   |
| adj_d_rk           | numeric   |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md)

## Examples

``` r
# \donttest{
try(kp_teamstats(min_year = 2019, max_year = 2021))
#> 2026-03-24 01:21:02.131542: Invalid arguments or no team stats data for 2019 - 2021 available!
#> Error in kp_teamstats(min_year = 2019, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
