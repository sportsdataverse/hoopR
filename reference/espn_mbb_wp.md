# **Men's College Basketball win probability chart data from ESPN**

**Men's College Basketball win probability chart data from ESPN**

## Usage

``` r
espn_mbb_wp(game_id)
```

## Arguments

- game_id:

  (*Integer* required): Game ID filter for querying a single game

## Value

`espn_mbb_wp()` - A data frame with 9 variables:

- `game_id`: character.:

  Referencing game ID (should be same as `game_id` from other
  functions).

- `play_id`: character.:

  Referencing play ID.

- `period`: integer.:

  Clock (time) left in the game.

- `time_left`: character.:

  Clock (time) left in the game.

- `period_seconds_left`: integer.:

  Seconds left in the period.

- `game_seconds_left`: integer.:

  Seconds left in the game.

- `home_win_percentage`: double.:

  The probability of the home team winning the game.

- `away_win_percentage`: double.:

  The probability of the away team winning the game (calculated as 1 -
  `home_win_percentage` - `tie_percentage`).

- `tie_percentage`: double.:

  The probability of the game ending the final period in a tie.

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md)

## Examples

``` r
# \donttest{
  espn_mbb_wp(game_id = 401256760)
#> ── ESPN MBB Win Probability Information from ESPN.com ─────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:28:19 UTC
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
```
