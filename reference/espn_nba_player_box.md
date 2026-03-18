# **Get ESPN NBA player box scores**

**Get ESPN NBA player box scores**

## Usage

``` r
espn_nba_player_box(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A player boxscore data frame

**Player**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | integer   |
| season                            | integer   |
| season_type                       | integer   |
| game_date                         | Date      |
| game_date_time                    | POSIXct   |
| athlete_id                        | integer   |
| athlete_display_name              | character |
| team_id                           | integer   |
| team_name                         | character |
| team_location                     | character |
| team_short_display_name           | character |
| minutes                           | numeric   |
| field_goals_made                  | integer   |
| field_goals_attempted             | integer   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| free_throws_made                  | integer   |
| free_throws_attempted             | integer   |
| offensive_rebounds                | integer   |
| defensive_rebounds                | integer   |
| rebounds                          | integer   |
| assists                           | integer   |
| steals                            | integer   |
| blocks                            | integer   |
| turnovers                         | integer   |
| fouls                             | integer   |
| plus_minus                        | character |
| points                            | integer   |
| starter                           | logical   |
| ejected                           | logical   |
| did_not_play                      | logical   |
| reason                            | character |
| active                            | logical   |
| athlete_jersey                    | character |
| athlete_short_name                | character |
| athlete_headshot_href             | character |
| athlete_position_name             | character |
| athlete_position_abbreviation     | character |
| team_display_name                 | character |
| team_uid                          | character |
| team_slug                         | character |
| team_logo                         | character |
| team_abbreviation                 | character |
| team_color                        | character |
| team_alternate_color              | character |
| home_away                         | character |
| team_winner                       | logical   |
| team_score                        | integer   |
| opponent_team_id                  | integer   |
| opponent_team_name                | character |
| opponent_team_location            | character |
| opponent_team_display_name        | character |
| opponent_team_abbreviation        | character |
| opponent_team_logo                | character |
| opponent_team_color               | character |
| opponent_team_alternate_color     | character |
| opponent_team_score               | integer   |

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_nba_player_box(game_id = 401071880))
#> ── ESPN NBA Player Box Information from ESPN.com ──────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 18:14:45 UTC
#> # A tibble: 26 × 57
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3058254
#>  2 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3135048
#>  3 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2489785
#>  4 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2583639
#>  5 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3133626
#>  6 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3919335
#>  7 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2488958
#>  8 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2585637
#>  9 401071880   2019           2 2019-04-07 2019-04-07 21:00:00       6583
#> 10 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3064514
#> # ℹ 16 more rows
#> # ℹ 51 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
```
