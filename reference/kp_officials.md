# **Get officials rankings**

**Get officials rankings**

## Usage

``` r
kp_officials(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|               |           |                                 |
|---------------|-----------|---------------------------------|
| col_name      | types     | description                     |
| rk            | integer   | Rk.                             |
| official_name | character | Official name.                  |
| ref_rating    | numeric   | Ref rating.                     |
| gms           | numeric   | Gms.                            |
| last_game     | character | Last game date or score string. |
| last_game_1   | character | Last game 1.                    |
| year          | numeric   | 4-digit year.                   |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_officials(year = 2021))
#> ✖ 2026-08-25 00:24:44.207211: Invalid arguments or no officials data for 2021 available!
#> ✖ Args: year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
