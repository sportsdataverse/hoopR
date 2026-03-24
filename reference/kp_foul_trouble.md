# **Get 2-Foul Participation Stats**

**Get 2-Foul Participation Stats**

## Usage

``` r
kp_foul_trouble(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of foul participation stats

|                              |           |
|------------------------------|-----------|
| col_name                     | types     |
| team                         | character |
| conf                         | character |
| two_foul_particpation_pct    | numeric   |
| two_foul_particpation_pct_rk | numeric   |
| adj2fp                       | numeric   |
| adj2fp_rk                    | numeric   |
| two_foul_total_time          | character |
| two_foul_total_time_rk       | character |
| two_foul_time_on             | character |
| two_foul_time_on_rk          | character |
| bench_pct                    | numeric   |
| bench_pct_rk                 | numeric   |
| ncaa_seed                    | numeric   |
| year                         | integer   |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
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
try(kp_foul_trouble(min_year = 2020, max_year = most_recent_mbb_season()))
#> 2026-03-24 04:18:07.321862: Invalid arguments or no foul trouble data for 2020 - 2026 available!
#> Error in kp_foul_trouble(min_year = 2020, max_year = most_recent_mbb_season()) : 
#>   object 'kenpom' not found
# }
```
