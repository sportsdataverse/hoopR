# **Fetch NBA Play-by-Play and Classify Field-Goal Attempts by Shot Zone**

**Fetch NBA Play-by-Play and Classify Field-Goal Attempts by Shot Zone**

**Fetch NBA Play-by-Play and Classify Field-Goal Attempts by Shot Zone**

## Usage

``` r
nba_shot_zones(game_id, ...)
```

## Arguments

- game_id:

  A length-1 character string — the ten-character NBA Stats game
  identifier (e.g. `"0022200001"` for the first game of the 2022-23
  regular season).

- ...:

  Reserved for future keyword arguments (currently ignored).

## Value

Returns a `data.frame` containing the full V3 play-by-play for `game_id`
with an appended `shot_zone` column:

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_type | character | Play event type code. `"1"` = MadeShot, `"2"` = MissedShot, `"3"` = FreeThrow, etc. |
| shot_value | integer | Point value of the shot attempt (2 or 3); 0 for non-FGA events. |
| x_legacy | numeric | Horizontal court coordinate (legacy units). Negative = left side of the court. |
| y_legacy | numeric | Vertical court coordinate (legacy units). Values near 0 = baseline. |
| shot_distance | numeric | Distance from the basket in feet. |
| shot_zone | character | Shot-zone classification. One of `"corner_3"`, `"above_the_break_3"`, `"restricted_area"`, `"in_the_paint_non_ra"`, `"mid_range"`. `NA` on non-field-goal rows. |

All other columns from the V3 PBP schema
([`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md))
are also present. Returns a 0-row frame when the game cannot be fetched
(never-raise).

**Shot zone definitions (pbpstats-core aligned):**

- `"corner_3"` — three-point attempt with `abs(x_legacy) >= 220` and
  `y_legacy <= 87.5` (baseline corner area).

- `"above_the_break_3"` — all other three-point attempts.

- `"restricted_area"` — two-point attempt within 4 ft of the basket.

- `"in_the_paint_non_ra"` — two-point attempt 4–8 ft from the basket and
  within 80 legacy units of the paint center (`abs(x_legacy) <= 80`).

- `"mid_range"` — all remaining two-point attempts.

## Details

     df <- nba_shot_zones(game_id = "0022200001")
     print(table(df$shot_zone, useNA = "ifany"))

## See also

Other NBA Lineup Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    df <- nba_shot_zones(game_id = "0022200001")
    print(df[!is.na(df$shot_zone), c("shot_distance", "shot_zone")])
  })
#> ✖ 2026-08-26 19:19:10.66682: Invalid arguments or no V3 play-by-play data for 0022200001 available!
#> ✖ Args: game_id = "0022200001", start_period = 0, end_period = 0
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60002 milliseconds with 0 bytes received
#> ✖ 2026-08-26 19:20:10.706401: Invalid arguments or no traditional boxscore v3 data for 0022200001 available!
#> ✖ Args: game_id = "0022200001", start_period = 0, end_period = 14, start_range = 0, end_range = 0, range_type = 0
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-08-26 19:20:10.762627: Invalid arguments or no V3 play-by-play data for 0022200001 available!
#> ✖ Args: game_id = "0022200001", on_court = FALSE, version = "v3", p = NULL
#> ✖ Error: incorrect number of dimensions
#> Error in if (nrow(pbp) == 0L) { : argument is of length zero
# }
```
