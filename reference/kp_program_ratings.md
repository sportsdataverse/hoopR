# **Get KenPom's program ratings**

**Get KenPom's program ratings**

## Usage

``` r
kp_program_ratings()
```

## Value

A data frame with 17 columns:

|           |           |
|-----------|-----------|
| col_name  | types     |
| rk        | numeric   |
| team      | character |
| conf      | character |
| rtg       | numeric   |
| best_rk   | numeric   |
| best_yr   | numeric   |
| worst_rk  | numeric   |
| worst_yr  | numeric   |
| kp_median | numeric   |
| top10     | numeric   |
| top25     | numeric   |
| top50     | numeric   |
| ch        | numeric   |
| f4        | numeric   |
| s16       | numeric   |
| r1        | numeric   |
| chg       | numeric   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_program_ratings())
#> 2026-03-24 01:20:59.843469: Invalid arguments or no program ratings available!
#> Error in kp_program_ratings() : object 'kenpom' not found
# }
```
