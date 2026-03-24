# **Get Home Court Arenas**

**Get Home Court Arenas**

## Usage

``` r
kp_arenas(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|           |           |
|-----------|-----------|
| col_name  | types     |
| rk        | numeric   |
| team      | character |
| conf      | character |
| arena     | character |
| alternate | character |
| year      | numeric   |

## See also

Other KP Misc. Functions:
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_arenas(year = 2021))
#> 2026-03-24 01:20:53.42364: Invalid arguments or no arenas data available!
#> Error in kp_arenas(year = 2021) : object 'kenpom' not found
# }
```
