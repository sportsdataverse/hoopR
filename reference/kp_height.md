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

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| team          | character | Team-side label or team identifier. |
| conf          | character | character.                          |
| avg_hgt       | numeric   | Avg hgt.                            |
| avg_hgt_rk    | numeric   | Avg hgt rk.                         |
| eff_hgt       | numeric   | Eff hgt.                            |
| eff_hgt_rk    | numeric   | Eff hgt rk.                         |
| c_hgt         | numeric   | C hgt.                              |
| c_hgt_rk      | numeric   | C hgt rk.                           |
| pf_hgt        | numeric   | Pf hgt.                             |
| pf_hgt_rk     | numeric   | Pf hgt rk.                          |
| sf_hgt        | numeric   | Sf hgt.                             |
| sf_hgt_rk     | numeric   | Sf hgt rk.                          |
| sg_hgt        | numeric   | Sg hgt.                             |
| sg_hgt_rk     | numeric   | Sg hgt rk.                          |
| pg_hgt        | numeric   | Pg hgt.                             |
| pg_hgt_rk     | numeric   | Pg hgt rk.                          |
| experience    | numeric   | Years of professional experience.   |
| experience_rk | numeric   | Experience rk.                      |
| bench         | numeric   | Bench.                              |
| bench_rk      | numeric   | Bench rk.                           |
| continuity    | numeric   | Continuity.                         |
| continuity_rk | numeric   | Continuity rk.                      |
| ncaa_seed     | numeric   | Ncaa seed.                          |
| year          | integer   | 4-digit year.                       |

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
#> ✖ 2026-08-06 04:00:52.693048: Invalid arguments or no height data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
