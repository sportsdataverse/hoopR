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

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| prediction   | character | Prediction.                |
| time_et      | character | Time et.                   |
| location     | character | Location.                  |
| thrill_score | numeric   | Thrill score.              |
| comeback     | numeric   | Comeback.                  |
| excitement   | numeric   | Excitement.                |
| road_rk      | numeric   | Road rk.                   |
| road_team    | character | Road team.                 |
| home_rk      | numeric   | Home team's rk.            |
| home_team    | character | Home team's team.          |
| win_rk       | numeric   | Win rk.                    |
| win_team     | character | Win team.                  |
| win_score    | numeric   | Win score.                 |
| loss_rk      | numeric   | Loss rk.                   |
| loss_team    | character | Loss team.                 |
| loss_score   | numeric   | Loss score.                |
| poss         | numeric   | Poss.                      |
| mvp          | character | Mvp.                       |
| event        | character | Event.                     |
| date         | character | Date in YYYY-MM-DD format. |

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
#> # A tibble: 28 × 20
#>    prediction          time_et location thrill_score comeback excitement road_rk
#>    <chr>               <chr>   <chr>           <dbl>    <dbl>      <dbl>   <dbl>
#>  1 Connecticut 68-67 … "box\n… "Hartfo…         78.6        5       2.83      NA
#>  2 Arkansas 69-68 (52… "box\n… "Gaines…         69.9        8       1.97      NA
#>  3 Alabama 77-74 (60%) "box\n… "Nashvi…         67.7        9       1.85      NA
#>  4 Boise St. 59-56 (5… "box\n… "Boise,…         65.3        6       1.98      NA
#>  5 Iowa 81-75 (71%)    "box\n… "Iowa C…         65.2        2      -0.1       NA
#>  6 UNLV 75-74 (51%)    "box\n… "Reno, …         53.7        6       1.3       NA
#>  7 Texas Tech 70-60 (… "box\n… "Lubboc…         51.5        0      -0.09      NA
#>  8 Miami FL 72-68 (65… "box\n… "Pittsb…         46.1        0      -0.3       NA
#>  9 Kansas 78-66 (86%)  "box\n… "Lawren…         45.6        3       0.3       NA
#> 10 Tennessee 71-60 (8… "box\n… "Columb…         41.9        4       0.35      NA
#> # ℹ 18 more rows
#> # ℹ 13 more variables: road_team <chr>, home_rk <dbl>, home_team <chr>,
#> #   win_rk <dbl>, win_team <chr>, win_score <dbl>, loss_rk <dbl>,
#> #   loss_team <chr>, loss_score <dbl>, poss <dbl>, mvp <chr>, event <chr>,
#> #   date <chr>
# }
```
