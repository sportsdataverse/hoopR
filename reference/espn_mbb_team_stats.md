# **Get ESPN men's college basketball team stats data**

**Get ESPN men's college basketball team stats data**

## Usage

``` r
espn_mbb_team_stats(team_id, year, season_type = "regular", total = FALSE)
```

## Arguments

- team_id:

  Team ID

- year:

  Year

- season_type:

  (character, default: regular): Season type - regular or postseason

- total:

  (boolean, default: FALSE): Totals

## Value

Returns a tibble with the team stats data

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| team_guid | character | ESPN team GUID. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_sdr | character | ESPN team SDR identifier. |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_nickname | character | Team nickname. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| is_active | logical | Is active. |
| is_all_star | logical | Is all star. |
| logo_href | character | Team or league logo URL. |
| logo_dark_href | character | Logo URL for dark backgrounds. |
| defensive_blocks | numeric | Short for blocked shot, number of times when a defensive player legally deflects a field goal attempt from an offensive player. |
| defensive_defensive_rebounds | numeric | The number of times when the defense obtains the possession of the ball after a missed shot by the offense. |
| defensive_steals | numeric | The number of times a defensive player forced a turnover by intercepting or deflecting a pass or a dribble of an offensive player. |
| defensive_turnover_points | numeric | The amount of points resulting from the possession following a turnover. |
| defensive_avg_defensive_rebounds | numeric | The average defensive rebounds per game. |
| defensive_avg_blocks | numeric | The average blocks per game. |
| defensive_avg_steals | numeric | The average steals per game. |
| general_disqualifications | numeric | The number of times a player reached the foul limit. |
| general_flagrant_fouls | numeric | The number of fouls that the officials thought were unnecessary or excessive. |
| general_fouls | numeric | The number of times a player had illegal contact with the opponent. |
| general_ejections | numeric | The number of times a player or coach is removed from the game as a result of a serious offense. |
| general_technical_fouls | numeric | The number of times an player or coach was called for a technical foul (unsportsmanlike conduct or violations). |
| general_rebounds | numeric | The total number of rebounds (offensive and defensive). |
| general_minutes | numeric | The total number of minutes played. |
| general_avg_minutes | numeric | The average number of minutes per game. |
| general_fantasy_rating | numeric | The Fantasy Rating of a player. |
| general_avg_rebounds | numeric | The average rebounds per game. |
| general_avg_fouls | numeric | The average fouls committed per game. |
| general_avg_flagrant_fouls | numeric | The average number of flagrant fouls per game. |
| general_avg_technical_fouls | numeric | The average number of technical fouls per game. |
| general_avg_ejections | numeric | The average ejections per game. |
| general_avg_disqualifications | numeric | The average number of disqualifications per game. |
| general_assist_turnover_ratio | numeric | The average number of assists a player or team records per turnover. |
| general_steal_foul_ratio | numeric | The average number of steals a player or team records per foul committed. |
| general_block_foul_ratio | numeric | The average number of blocks a player or record per foul committed. |
| general_avg_team_rebounds | numeric | The average number of rebounds for a team per game. |
| general_total_rebounds | numeric | The total number of rebounds for a team or player. |
| general_total_technical_fouls | numeric | The total number of technical fouls for a team or player. |
| general_team_assist_turnover_ratio | numeric | The number of assists per turnover for a team. |
| general_team_rebounds | numeric | The total number of rebounds for a team. |
| general_steal_turnover_ratio | numeric | The number of steals per turnover. |
| general_games_played | numeric | Games Played. |
| general_games_started | numeric | The number of games started by an athlete. |
| general_double_double | numeric | The number of times double digit values were accumulated in 2 of the following categories: points, rebounds, assists, steals, and blocked shots. |
| general_triple_double | numeric | The number of times double digit values were accumulated in 3 of the following categories: points, rebounds, assists, steals, and blocked shots. |
| offensive_assists | numeric | The number of times a player who passes the ball to a teammate in a way that leads to a score by field goal, meaning that he or she was "assisting" in the basket. There is some judgment involved in deciding whether a passer should be credited with an assist. |
| offensive_field_goals | numeric | Field Goal makes and attempts. |
| offensive_field_goals_attempted | numeric | The number of times a 2pt field goal was attempted. |
| offensive_field_goals_made | numeric | The number of times a 2pt field goal was made. |
| offensive_field_goal_pct | numeric | The ratio of field goals made to field goals attempted: FGM / FGA. |
| offensive_free_throws | numeric | Free Throw makes and attempts. |
| offensive_free_throw_pct | numeric | The ratio of free throws made to free throws attempted: FTM / FTA. |
| offensive_free_throws_attempted | numeric | The number of times a free throw was attempted. |
| offensive_free_throws_made | numeric | The number of times a free throw was made. |
| offensive_offensive_rebounds | numeric | The number of times when the offense obtains the possession of the ball after a missed shot. |
| offensive_points | numeric | The number of points scored. |
| offensive_turnovers | numeric | The number of times a player loses possession to the other team. |
| offensive_three_point_field_goals_attempted | numeric | The number of times a 3pt field goal was attempted. |
| offensive_three_point_field_goals_made | numeric | The number of times a 3pt field goal was made. |
| offensive_team_turnovers | numeric | The number of turnovers for the team. |
| offensive_total_turnovers | numeric | The number of turnovers plus team turnovers for the team. |
| offensive_fast_break_points | numeric | The number of points scored on fast breaks. |
| offensive_avg_field_goals_made | numeric | The average field goals made per game. |
| offensive_avg_field_goals_attempted | numeric | The average field goals attempted per game. |
| offensive_avg_three_point_field_goals_made | numeric | The average three point field goals made per game. |
| offensive_avg_three_point_field_goals_attempted | numeric | The average three point field goals attempted per game. |
| offensive_avg_free_throws_made | numeric | The average free throw shots made per game. |
| offensive_avg_free_throws_attempted | numeric | The average free throw shots attempted per game. |
| offensive_avg_points | numeric | The average number of points scored per game. |
| offensive_avg_offensive_rebounds | numeric | The average offensive rebounds per game. |
| offensive_avg_assists | numeric | The average assists per game. |
| offensive_avg_turnovers | numeric | The average turnovers committed per game. |
| offensive_offensive_rebound_pct | numeric | The percentage of the number of times they obtain the possession of the ball after a missed shot. |
| offensive_estimated_possessions | numeric | An estimation of the number of possessions for a team or player. |
| offensive_avg_estimated_possessions | numeric | The average number of estimated possessions per game for a team or player. |
| offensive_points_per_estimated_possessions | numeric | The number of points per estimated possession for a team or player. |
| offensive_avg_team_turnovers | numeric | The average number of turnovers for a team per game. |
| offensive_avg_total_turnovers | numeric | The average number of total turnovers for a team per game. |
| offensive_three_point_field_goal_pct | numeric | The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA. |
| offensive_two_point_field_goals_made | numeric | The number of 2-point field goals made for a team or player. |
| offensive_two_point_field_goals_attempted | numeric | The number of 2-point field goals attempted for a team or player. |
| offensive_avg_two_point_field_goals_made | numeric | The number of 2-point field goals made per game for a team or player. |
| offensive_avg_two_point_field_goals_attempted | numeric | The number of 2-point field goals attempted per game for a team or player. |
| offensive_two_point_field_goal_pct | numeric | The percentage of 2-points fields goals made by a team or player. |
| offensive_shooting_efficiency | numeric | The efficiency with which a team or player shoots the basketball. |
| offensive_scoring_efficiency | numeric | The efficiency with which a team or player scores the basketball. |

## See also

Other ESPN MBB Functions:
[`espn_mbb_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_awards.md),
[`espn_mbb_athlete_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_career_stats.md),
[`espn_mbb_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog.md),
[`espn_mbb_athlete_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog_v2.md),
[`espn_mbb_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_gamelog.md),
[`espn_mbb_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_info.md),
[`espn_mbb_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_overview.md),
[`espn_mbb_athlete_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_seasons.md),
[`espn_mbb_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_splits.md),
[`espn_mbb_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_statisticslog.md),
[`espn_mbb_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_stats.md),
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_broadcasts.md),
[`espn_mbb_event_competitor_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_leaders.md),
[`espn_mbb_event_competitor_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_linescores.md),
[`espn_mbb_event_competitor_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_records.md),
[`espn_mbb_event_competitor_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_roster.md),
[`espn_mbb_event_competitor_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_roster_entry.md),
[`espn_mbb_event_competitor_score()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_score.md),
[`espn_mbb_event_competitor_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_statistics.md),
[`espn_mbb_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_odds.md),
[`espn_mbb_event_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_official_detail.md),
[`espn_mbb_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_officials.md),
[`espn_mbb_event_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_play.md),
[`espn_mbb_event_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_play_personnel.md),
[`espn_mbb_event_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_player_box.md),
[`espn_mbb_event_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_powerindex.md),
[`espn_mbb_event_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_predictor.md),
[`espn_mbb_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_probabilities.md),
[`espn_mbb_event_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_propbets.md),
[`espn_mbb_event_situation()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_situation.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
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
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
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
try(espn_mbb_team_stats(team_id = 150, year = 2020))
#> ── ESPN MBB Team Season Stats from ESPN.com ───────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-30 17:55:01 UTC
#> # A tibble: 1 × 168
#>   team_id team_guid          team_uid team_sdr team_slug team_location team_name
#>     <int> <chr>              <chr>       <int> <chr>     <chr>         <chr>    
#> 1     150 c4430c6c-5998-47d… s:40~l:…     5847 duke-blu… Duke          Blue Dev…
#> # ℹ 161 more variables: team_nickname <chr>, team_abbreviation <chr>,
#> #   team_display_name <chr>, team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, is_active <lgl>, is_all_star <lgl>,
#> #   logo_href <chr>, logo_dark_href <chr>, logos_href_2 <chr>,
#> #   logos_rel_primary_logo_on_white_color <chr>, logos_href_3 <chr>,
#> #   logos_rel_primary_logo_on_black_color <chr>, logos_href_4 <chr>,
#> #   logos_width_4 <int>, logos_height_4 <int>, logos_alt_4 <chr>, …
# }
```
