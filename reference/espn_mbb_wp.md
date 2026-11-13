# **Men's College Basketball win probability chart data from ESPN**

**Men's College Basketball win probability chart data from ESPN**

**Get NBA win probability chart data from ESPN**

## Usage

``` r
espn_mbb_wp(game_id)

espn_nba_wp(game_id)
```

## Arguments

- game_id:

  (*Integer* required): Game ID filter for querying a single game

## Value

A `hoopR_data` tibble with one row per play.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Referencing game ID (should be same as `game_id` from other functions). |
| play_id | character | Referencing play ID. |
| period | integer | Clock (time) left in the game. |
| time_left | character | Clock (time) left in the game. |
| period_seconds_left | integer | Seconds left in the period. |
| game_seconds_left | integer | Seconds left in the game. |
| home_win_percentage | double | The probability of the home team winning the game. |
| away_win_percentage | double | The probability of the away team winning the game (calculated as 1 - `home_win_percentage` - `tie_percentage`). |
| tie_percentage | double | The probability of the game ending the final period in a tie. |

A `hoopR_data` tibble with one row per play.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | numeric | Unique game identifier. |
| play_id | character | Unique play identifier within a game. |
| home_win_percentage | numeric | Home win percentage (0-1 decimal). |
| away_win_percentage | numeric | Away win percentage (0-1 decimal). |
| tie_percentage | numeric | Tie percentage (0-1 decimal). |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score at the time of the play. |
| home_score | integer | Home team score at the time of the play. |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the play (2 / 3 / 1). |
| participants | list | Participants. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| type_id | character | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| period_display_value | character | Period display label (e.g. '1st Quarter', 'OT'). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| team_id | character | Unique team identifier. |
| coordinate_x | integer | X coordinate on the court (half-court layout). |
| coordinate_y | integer | Y coordinate on the court (half-court layout). |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
espn_mbb_wp(game_id = 401256760)
#> ── ESPN MBB Win Probability Information from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:52 UTC
#> # A tibble: 352 × 9
#>    game_id   play_id      period time_left period_seconds_left game_seconds_left
#>  * <chr>     <chr>         <dbl> <chr>                   <dbl>             <dbl>
#>  1 401256760 40125676010…      1 19:40                    1180              2380
#>  2 401256760 40125676010…      1 19:36                    1176              2376
#>  3 401256760 40125676010…      1 19:36                    1176              2376
#>  4 401256760 40125676010…      1 19:11                    1151              2351
#>  5 401256760 40125676010…      1 19:09                    1149              2349
#>  6 401256760 40125676010…      1 18:54                    1134              2334
#>  7 401256760 40125676010…      1 18:54                    1134              2334
#>  8 401256760 40125676010…      1 18:29                    1109              2309
#>  9 401256760 40125676010…      1 18:17                    1097              2297
#> 10 401256760 40125676010…      1 18:17                    1097              2297
#> # ℹ 342 more rows
#> # ℹ 3 more variables: home_win_percentage <dbl>, away_win_percentage <dbl>,
#> #   tie_percentage <dbl>
# }

# \donttest{
espn_nba_wp(game_id = 401283399)
#> ── ESPN NBA Win Probability Information from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:53 UTC
#> # A tibble: 472 × 24
#>      game_id play_id     home_win_percentage away_win_percentage tie_percentage
#>        <dbl> <chr>                     <dbl>               <dbl>          <dbl>
#>  1 401283399 4012833994                0.615               0.385              0
#>  2 401283399 4012833997                0.6                 0.4                0
#>  3 401283399 4012833998                0.595               0.405              0
#>  4 401283399 4012833999                0.594               0.406              0
#>  5 401283399 40128339911               0.61                0.39               0
#>  6 401283399 40128339912               0.615               0.385              0
#>  7 401283399 40128339913               0.599               0.401              0
#>  8 401283399 40128339914               0.593               0.407              0
#>  9 401283399 40128339915               0.54                0.46               0
#> 10 401283399 40128339916               0.577               0.423              0
#> # ℹ 462 more rows
#> # ℹ 19 more variables: sequence_number <chr>, text <chr>, away_score <int>,
#> #   home_score <int>, scoring_play <lgl>, score_value <int>,
#> #   participants <list>, wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <chr>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <chr>, coordinate_x <int>, …
# }
```
