# **Get Heights, Experience, Bench and Continuity Data**

**Get Heights, Experience, Bench and Continuity Data**

## Usage

``` r
kp_height(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of heights

|               |           |
|---------------|-----------|
| col_name      | types     |
| team          | character |
| conf          | character |
| avg_hgt       | numeric   |
| avg_hgt_rk    | numeric   |
| eff_hgt       | numeric   |
| eff_hgt_rk    | numeric   |
| c_hgt         | numeric   |
| c_hgt_rk      | numeric   |
| pf_hgt        | numeric   |
| pf_hgt_rk     | numeric   |
| sf_hgt        | numeric   |
| sf_hgt_rk     | numeric   |
| sg_hgt        | numeric   |
| sg_hgt_rk     | numeric   |
| pg_hgt        | numeric   |
| pg_hgt_rk     | numeric   |
| experience    | numeric   |
| experience_rk | numeric   |
| bench         | numeric   |
| bench_rk      | numeric   |
| continuity    | numeric   |
| continuity_rk | numeric   |
| ncaa_seed     | numeric   |
| year          | integer   |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_height(min_year = 2020, max_year = 2021))
#> 2026-03-24 01:20:57.073785: Invalid arguments or no height data for 2020 - 2021 available!
#> Error in kp_height(min_year = 2020, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
