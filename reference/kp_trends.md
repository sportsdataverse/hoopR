# **Get Division-I statistical trends**

**Get Division-I statistical trends**

## Usage

``` r
kp_trends()
```

## Value

A data frame with the following columns:

|              |         |
|--------------|---------|
| col_name     | types   |
| season       | numeric |
| efficiency   | numeric |
| tempo        | numeric |
| e_fg_pct     | numeric |
| to_pct       | numeric |
| or_pct       | numeric |
| ft_rate      | numeric |
| fg_2_pct     | numeric |
| fg_3_pct     | numeric |
| fg_3a_pct    | numeric |
| ft_pct       | numeric |
| a_pct        | numeric |
| blk_pct      | numeric |
| stl_pct      | numeric |
| non_stl_pct  | numeric |
| avg_hgt      | numeric |
| continuity   | numeric |
| home_win_pct | numeric |
| ppg          | numeric |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md)

## Examples

``` r
# \donttest{
try(kp_trends())
#> 2026-03-26 14:51:24.811396: Invalid arguments or no trends data available!
#> Error in kp_trends() : object 'kenpom' not found
# }
```
