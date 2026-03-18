# **Get NBA win probability chart data from ESPN**

**Get NBA win probability chart data from ESPN**

## Usage

``` r
espn_nba_wp(game_id)
```

## Arguments

- game_id:

  (*Integer* required): Game ID filter for querying a single game

## Value

`espn_nba_wp()` - A data frame with 21 variables:

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| game_id              | numeric   |
| play_id              | character |
| home_win_percentage  | numeric   |
| away_win_percentage  | numeric   |
| tie_percentage       | numeric   |
| sequence_number      | character |
| text                 | character |
| away_score           | integer   |
| home_score           | integer   |
| scoring_play         | logical   |
| score_value          | integer   |
| participants         | list      |
| shooting_play        | logical   |
| type_id              | character |
| type_text            | character |
| period_number        | integer   |
| period_display_value | character |
| clock_display_value  | character |
| team_id              | character |
| coordinate_x         | integer   |
| coordinate_y         | integer   |

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md)

## Examples

``` r
# \donttest{
  espn_nba_wp(game_id = 401283399)
#> ── ESPN NBA Win Probability Information from ESPN.com ─────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:19:04 UTC
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
