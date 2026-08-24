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
#> ✖ 2026-08-24 20:40:58.060101: Invalid arguments or no Fan Match data for 2022-02-22 available!
#> ✖ Args: date = "2022-02-22"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
