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

|               |           |
|---------------|-----------|
| col_name      | types     |
| rk            | integer   |
| official_name | character |
| ref_rating    | numeric   |
| gms           | numeric   |
| last_game     | character |
| last_game_1   | character |
| year          | numeric   |

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
#> 2026-03-24 01:20:57.88721: Invalid arguments or no officials data for 2021 available!
#> Error in kp_officials(year = 2021) : object 'kenpom' not found
# }
```
