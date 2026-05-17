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
[`espn_mbb_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_awards.md),
[`espn_mbb_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog.md),
[`espn_mbb_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_gamelog.md),
[`espn_mbb_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_info.md),
[`espn_mbb_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_overview.md),
[`espn_mbb_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_splits.md),
[`espn_mbb_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_statisticslog.md),
[`espn_mbb_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_stats.md),
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_broadcasts.md),
[`espn_mbb_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_odds.md),
[`espn_mbb_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_officials.md),
[`espn_mbb_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_probabilities.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md)

## Examples

``` r
# \donttest{
espn_mbb_wp(game_id = 401256760)
#> ── ESPN MBB Win Probability Information from ESPN.com ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:10 UTC
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
