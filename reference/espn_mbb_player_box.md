# **Get ESPN men's college basketball player box scores**

**Get ESPN men's college basketball player box scores**

## Usage

``` r
espn_mbb_player_box(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A player boxscore data frame

**Player**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_player_box(game_id = 401479672))
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-05-17 15:19:48 UTC
#> # A tibble: 30 × 54
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684627
#>  2 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4575472
#>  3 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4431816
#>  4 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684729
#>  5 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4431746
#>  6 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4700878
#>  7 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    5105337
#>  8 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4592369
#>  9 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684746
#> 10 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4683860
#> # ℹ 20 more rows
#> # ℹ 48 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
```
