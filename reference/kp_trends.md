# **Get Division-I statistical trends**

**Get Division-I statistical trends**

## Usage

``` r
kp_trends()
```

## Value

A data frame with the following columns:

|              |         |                                                       |
|--------------|---------|-------------------------------------------------------|
| col_name     | types   | description                                           |
| season       | numeric | Season identifier (4-digit year or 'YYYY-YY' string). |
| efficiency   | numeric | Efficiency.                                           |
| tempo        | numeric | Tempo.                                                |
| e_fg_pct     | numeric | E field goals percentage (0-1 decimal).               |
| to_pct       | numeric | To percentage (0-1 decimal).                          |
| or_pct       | numeric | Or percentage (0-1 decimal).                          |
| ft_rate      | numeric | Ft rate.                                              |
| fg_2_pct     | numeric | Field goals 2 percentage (0-1 decimal).               |
| fg_3_pct     | numeric | Field goals 3 percentage (0-1 decimal).               |
| fg_3a_pct    | numeric | Field goals 3a percentage (0-1 decimal).              |
| ft_pct       | numeric | Free throw percentage (0-1).                          |
| a_pct        | numeric | A percentage (0-1 decimal).                           |
| blk_pct      | numeric | Blocks percentage (0-1 decimal).                      |
| stl_pct      | numeric | Steals percentage (0-1 decimal).                      |
| non_stl_pct  | numeric | Non steals percentage (0-1 decimal).                  |
| avg_hgt      | numeric | Avg hgt.                                              |
| continuity   | numeric | Continuity.                                           |
| home_win_pct | numeric | Home win percentage (0-1 decimal).                    |
| ppg          | numeric | Points per game.                                      |

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
#> ✖ 2026-08-24 20:41:02.007532: Invalid arguments or no trends data available!
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
