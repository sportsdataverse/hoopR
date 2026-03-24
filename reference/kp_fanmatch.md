# **Get FanMatch by date**

**Get FanMatch by date**

## Usage

``` r
kp_fanmatch(date)
```

## Arguments

- date:

  Date of games to pull (YYYY-MM-DD)

## Value

A data frame with the following columns:

|              |           |
|--------------|-----------|
| col_name     | types     |
| prediction   | character |
| time_et      | character |
| location     | character |
| thrill_score | numeric   |
| comeback     | numeric   |
| excitement   | numeric   |
| road_rk      | numeric   |
| road_team    | character |
| home_rk      | numeric   |
| home_team    | character |
| win_rk       | numeric   |
| win_team     | character |
| win_score    | numeric   |
| loss_rk      | numeric   |
| loss_team    | character |
| loss_score   | numeric   |
| poss         | numeric   |
| mvp          | character |
| event        | character |
| date         | character |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_fanmatch(date = "2022-02-22"))
#> 2026-03-24 01:20:55.409475: Invalid arguments or no Fan Match data for 2022-02-22 available!
#> Error in kp_fanmatch(date = "2022-02-22") : object 'kenpom' not found
# }
```
