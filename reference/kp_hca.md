# **Get Home Court Advantage Estimates**

**Get Home Court Advantage Estimates**

## Usage

``` r
kp_hca()
```

## Value

A data frame with the following columns:

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| team     | character | Team-side label or team identifier. |
| conf     | character | character.                          |
| hca      | numeric   | Hca.                                |
| hca_rk   | numeric   | Hca rk.                             |
| pf       | numeric   | Personal fouls.                     |
| pf_rk    | numeric   | Pf rk.                              |
| pts      | numeric   | Points scored.                      |
| pts_rk   | numeric   | Pts rk.                             |
| nst      | numeric   | Nst.                                |
| nst_rk   | numeric   | Nst rk.                             |
| blk      | numeric   | Blocks.                             |
| blk_rk   | numeric   | Blk rk.                             |
| elev     | numeric   | Elev.                               |
| elev_rk  | numeric   | Elev rk.                            |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_hca())
#> ✖ 2026-08-25 01:42:46.372092: Invalid arguments or no home court advantage data available!
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
