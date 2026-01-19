# **Get Home Court Advantage Estimates**

**Get Home Court Advantage Estimates**

## Usage

``` r
kp_hca()
```

## Value

A data frame with the following columns:

|          |           |
|----------|-----------|
| col_name | types     |
| team     | character |
| conf     | character |
| hca      | numeric   |
| hca_rk   | numeric   |
| pf       | numeric   |
| pf_rk    | numeric   |
| pts      | numeric   |
| pts_rk   | numeric   |
| nst      | numeric   |
| nst_rk   | numeric   |
| blk      | numeric   |
| blk_rk   | numeric   |
| elev     | numeric   |
| elev_rk  | numeric   |

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
#> Error in kp_hca() : object 'kenpom' not found
# }
```
