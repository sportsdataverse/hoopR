# **Get Team Points Distribution**

**Get Team Points Distribution**

## Usage

``` r
kp_pointdist(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of team points distributions

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| team            | character |
| conf            | character |
| off_ft_pct      | numeric   |
| off_ft_pct_rk   | numeric   |
| off_fg_2_pct    | numeric   |
| off_fg_2_pct_rk | numeric   |
| off_fg_3_pct    | numeric   |
| off_fg_3_pct_rk | numeric   |
| def_ft_pct      | numeric   |
| def_ft_pct_rk   | numeric   |
| def_fg_2_pct    | numeric   |
| def_fg_2_pct_rk | numeric   |
| def_fg_3_pct    | numeric   |
| def_fg_3_pct_rk | numeric   |
| ncaa_seed       | numeric   |
| year            | numeric   |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_pointdist(min_year = 2020, max_year = 2021))
#> 2026-03-24 01:20:59.010736: Invalid arguments or no point distribution data for 2020 - 2021 available!
#> Error in kp_pointdist(min_year = 2020, max_year = 2021) : 
#>   object 'kenpom' not found
# }
```
