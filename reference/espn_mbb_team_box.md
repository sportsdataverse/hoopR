# **Get ESPN men's college basketball team box scores**

**Get ESPN men's college basketball team box scores**

## Usage

``` r
espn_mbb_team_box(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A team boxscore data frame

**Team**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

## See also

Other ESPN MBB Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_broadcasts.md),
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_officials.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_powerindex.md),
[`espn_mbb_game_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_predictor.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_game_situation()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_situation.md),
[`espn_mbb_game_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_leaders.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_records.md),
[`espn_mbb_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_game_team_score()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_score.md),
[`espn_mbb_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_statistics.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_gamelog.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_splits.md),
[`espn_mbb_player_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_statisticslog.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_player_stats_v3()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats_v3.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
[`espn_mbb_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children.md),
[`espn_mbb_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams.md),
[`espn_mbb_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_groups.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md),
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md),
[`espn_mbb_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_rankings.md),
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md),
[`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md),
[`espn_mbb_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_week.md),
[`espn_mbb_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_weeks.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_profile.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_team_box(game_id = 401479672))
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 19:59:20 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401479672   2023           2 2022-11-29 2022-11-29 19:30:00     183 s:40~l:41…
#> 2 401479672   2023           2 2022-11-29 2022-11-29 19:30:00     356 s:40~l:41…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
# }
```
