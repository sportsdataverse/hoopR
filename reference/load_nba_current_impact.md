# **Load NBA current-impact ratings**

Loads the `nba_current_impact` release: each NBA player's current
offensive/defensive impact (points per 100 possessions) as of opening
night and every 7 days after, from every game before that date – a
box-score prior plus a Kalman-filtered deviation carried across seasons.
Where
[`load_nba_player_impact()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md)
says what a player did in a season, this says what to expect from him on
a date. Produced by the sportsdataverse-py `nba_current_impact()` model
(published by `hoopR-nba-stats-data`'s
`nba_model_publish current-impact`); `player_id` is the NBA Stats
`person_id`. Coverage is 2007 (2006-07) to 2026.

## Usage

``` r
load_nba_current_impact(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_current_impact` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_current_impact>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit season-ending years (`2026` = 2025-26), like
  [`load_nba_player_impact()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md).
  Published coverage runs 2007 through 2026, with no gaps; the default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)
  falls back to the newest published season with a message. Pass
  `seasons = TRUE` for every published season. (Min: 2007)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per player per as-of date.

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_id | integer | NBA Stats player identifier (`person_id`). |
| as_of | Date | Date the rating is for: opening night, then every 7 days. Only games dated before it are used. |
| season | integer | Season END year (2026 = 2025-26) of the player's last game before `as_of`. |
| o_current_impact | numeric | Expected offensive impact per 100 possessions as of `as_of`: the box prior in force plus the filtered deviation from it. |
| d_current_impact | numeric | Expected defensive impact per 100 possessions as of `as_of` (positive = good defense). |
| current_impact | numeric | Total expected impact per 100 possessions: `o_current_impact + d_current_impact`. |
| o_prior | numeric | Offensive box-score prior per 100 possessions in force on `as_of`. |
| d_prior | numeric | Defensive box-score prior per 100 possessions in force on `as_of` (positive = good defense). |
| off_poss | integer | Offensive possessions the player played this season before `as_of` (0 when he has not played this season). |
| def_poss | integer | Defensive possessions the player played this season before `as_of` (0 when he has not played this season). |
| last_game_date | Date | Date of the player's last game before `as_of`. |

## See also

Other Model Dataset loader functions:
[`load_nba_player_impact()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_nba_current_impact(seasons = 2026))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 15,764 × 11
#>    player_id as_of      season o_current_impact d_current_impact current_impact
#>        <int> <date>      <int>            <dbl>            <dbl>          <dbl>
#>  1      2544 2025-10-21   2026           3.27             -0.541          2.73 
#>  2    101108 2025-10-21   2026           1.86              1.02           2.88 
#>  3    200768 2025-10-21   2026          -1.79              1.11          -0.680
#>  4    200782 2025-10-21   2026          -0.571            -1.21          -1.78 
#>  5    201142 2025-10-21   2026           2.97             -0.238          2.73 
#>  6    201143 2025-10-21   2026          -0.0942            1.33           1.24 
#>  7    201144 2025-10-21   2026           1.23              0.235          1.47 
#>  8    201145 2025-10-21   2026          -1.62             -2.12          -3.73 
#>  9    201566 2025-10-21   2026          -0.0533           -0.672         -0.725
#> 10    201567 2025-10-21   2026           0.566             1.39           1.96 
#> # ℹ 15,754 more rows
#> # ℹ 5 more variables: o_prior <dbl>, d_prior <dbl>, off_poss <int>,
#> #   def_poss <int>, last_game_date <date>
# }
```
