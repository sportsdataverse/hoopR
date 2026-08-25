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

|           |           |                                     |
|-----------|-----------|-------------------------------------|
| col_name  | types     | description                         |
| rk        | numeric   | Rk.                                 |
| team      | character | Team-side label or team identifier. |
| conf      | character | character.                          |
| arena     | character | Arena.                              |
| alternate | character | Alternate.                          |
| year      | numeric   | 4-digit year.                       |

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
#> ✖ 2026-08-25 01:42:44.494029: Invalid arguments or no arenas data available!
#> ✖ Args: year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
