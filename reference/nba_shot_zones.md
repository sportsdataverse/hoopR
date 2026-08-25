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
([`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md))
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
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    df <- nba_shot_zones(game_id = "0022200001")
    print(df[!is.na(df$shot_zone), c("shot_distance", "shot_zone")])
  })
#> ── NBA Shot Zones ─────────────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:32:25 UTC
#> # A tibble: 162 × 2
#>    shot_distance shot_zone          
#>            <int> <chr>              
#>  1            13 mid_range          
#>  2            13 mid_range          
#>  3            14 mid_range          
#>  4             0 restricted_area    
#>  5            24 corner_3           
#>  6            27 above_the_break_3  
#>  7             4 in_the_paint_non_ra
#>  8            12 mid_range          
#>  9             2 restricted_area    
#> 10             2 restricted_area    
#> # ℹ 152 more rows
# }
```
