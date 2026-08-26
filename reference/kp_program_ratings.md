# **Get KenPom's program ratings**

**Get KenPom's program ratings**

## Usage

``` r
kp_program_ratings()
```

## Value

A data frame with 17 columns:

|           |           |                                     |
|-----------|-----------|-------------------------------------|
| col_name  | types     | description                         |
| rk        | numeric   | Rk.                                 |
| team      | character | Team-side label or team identifier. |
| conf      | character | character.                          |
| rtg       | numeric   | Rtg.                                |
| best_rk   | numeric   | Best rk.                            |
| best_yr   | numeric   | Best yr.                            |
| worst_rk  | numeric   | Worst rk.                           |
| worst_yr  | numeric   | Worst yr.                           |
| kp_median | numeric   | Kp median.                          |
| top10     | numeric   | Top10.                              |
| top25     | numeric   | Top25.                              |
| top50     | numeric   | Top50.                              |
| ch        | numeric   | Ch.                                 |
| f4        | numeric   | F4.                                 |
| s16       | numeric   | S16.                                |
| r1        | numeric   | R1.                                 |
| chg       | numeric   | Chg.                                |

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
#> ✖ 2026-08-26 19:56:00.975719: Invalid arguments or no program ratings available!
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
