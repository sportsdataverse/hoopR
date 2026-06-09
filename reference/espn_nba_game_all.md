# **Get ESPN NBA game data (Pbp, Team and Player Box)**

**Get ESPN NBA game data (Pbp, Team and Player Box)**

## Usage

``` r
espn_nba_game_all(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A named list of data frames: Plays, Team, Player

**Plays**

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | Id. |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score at the time of the play. |
| home_score | integer | Home team score at the time of the play. |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the play (2 / 3 / 1). |
| wallclock | character | Wallclock. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| period_display_value | character | Period display label (e.g. '1st Quarter', 'OT'). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| team_id | integer | Unique team identifier. |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| play_id | character | Unique play identifier within a game. |
| athlete_id_1 | integer | Primary athlete identifier (e.g. shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| athlete_id_3 | integer | Athlete id 3. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_mascot | character | Home team mascot. |
| home_team_name | character | Home team name. |
| home_team_abbrev | character | Home team three-letter abbreviation. |
| home_team_logo | character | Home team logo URL. |
| home_team_logo_dark | character | Home team logo URL for dark backgrounds. |
| home_team_full_name | character | Full home team name (e.g. 'Las Vegas Aces'). |
| home_team_color | character | Home team primary color (hex). |
| home_team_alternate_color | character | Home team alternate color (hex). |
| home_team_score | integer | Home team's score. |
| home_team_winner | logical | TRUE if the home team won this game. |
| home_team_record | character | Home team's win-loss record. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_mascot | character | Away team mascot. |
| away_team_name | character | Away team name. |
| away_team_abbrev | character | Away team three-letter abbreviation. |
| away_team_logo | character | Away team logo URL. |
| away_team_logo_dark | character | Away team logo URL for dark backgrounds. |
| away_team_full_name | character | Full away team name (e.g. 'Las Vegas Aces'). |
| away_team_color | character | Away team primary color (hex). |
| away_team_alternate_color | character | Away team alternate color (hex). |
| away_team_score | integer | Away team's score. |
| away_team_winner | logical | TRUE if the away team won this game. |
| away_team_record | character | Away team's win-loss record. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |

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
| fast_break_points | character | Fast-break points scored. |
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
| points_in_paint | character | Points scored in the paint. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnover_points | character | Turnover points. |
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
| plus_minus | character | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| reason | character | Reason. |
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

Other ESPN NBA Functions:
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md),
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md),
[`espn_nba_draft_athletes()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athletes.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md),
[`espn_nba_draft_status()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_status.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md),
[`espn_nba_game_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_broadcasts.md),
[`espn_nba_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_odds.md),
[`espn_nba_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_official_detail.md),
[`espn_nba_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_officials.md),
[`espn_nba_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play.md),
[`espn_nba_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play_personnel.md),
[`espn_nba_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_player_box.md),
[`espn_nba_game_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_powerindex.md),
[`espn_nba_game_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_predictor.md),
[`espn_nba_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_probabilities.md),
[`espn_nba_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_propbets.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_game_situation()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_situation.md),
[`espn_nba_game_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_leaders.md),
[`espn_nba_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_linescores.md),
[`espn_nba_game_team_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_records.md),
[`espn_nba_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster.md),
[`espn_nba_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster_entry.md),
[`espn_nba_game_team_score()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_score.md),
[`espn_nba_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_statistics.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_awards.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_career_stats.md),
[`espn_nba_player_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contract.md),
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md),
[`espn_nba_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog.md),
[`espn_nba_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog_v2.md),
[`espn_nba_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_gamelog.md),
[`espn_nba_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_info.md),
[`espn_nba_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_overview.md),
[`espn_nba_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_seasons.md),
[`espn_nba_player_splits()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_splits.md),
[`espn_nba_player_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_statisticslog.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_player_stats_v3()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats_v3.md),
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md),
[`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
[`espn_nba_season_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_draft.md),
[`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md),
[`espn_nba_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_children.md),
[`espn_nba_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_teams.md),
[`espn_nba_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_groups.md),
[`espn_nba_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_info.md),
[`espn_nba_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_leaders.md),
[`espn_nba_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_ranking.md),
[`espn_nba_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_rankings.md),
[`espn_nba_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_type.md),
[`espn_nba_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_types.md),
[`espn_nba_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_week.md),
[`espn_nba_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_weeks.md),
[`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md),
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_profile.md),
[`espn_nba_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_roster.md),
[`espn_nba_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_statistics.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament.md),
[`espn_nba_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_season.md),
[`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_seasons.md),
[`espn_nba_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournaments.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md),
[`espn_nba_venues()`](https://hoopR.sportsdataverse.org/reference/espn_nba_venues.md),
[`espn_nba_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_ranking.md),
[`espn_nba_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_rankings.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_nba_game_all(game_id = 401283399))
#> $Plays
#> ── ESPN NBA Play-by-Play Information from ESPN.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 22:02:56 UTC
#> # A tibble: 472 × 54
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4012833… 4               Isai…          0          0 FALSE                  0
#>  2 4012833… 7               Jona…          0          0 FALSE                  0
#>  3 4012833… 8               Dari…          0          0 FALSE                  0
#>  4 4012833… 9               Dill…          0          0 FALSE                  0
#>  5 4012833… 11              Dari…          0          0 FALSE                  0
#>  6 4012833… 12              Ja M…          0          0 FALSE                  0
#>  7 4012833… 13              Gray…          0          0 FALSE                  0
#>  8 4012833… 14              Isai…          0          0 FALSE                  0
#>  9 4012833… 15              Shai…          3          0 TRUE                   3
#> 10 4012833… 16              Theo…          3          0 FALSE                  0
#> # ℹ 462 more rows
#> # ℹ 47 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
#> 
#> $Team
#> ── ESPN NBA Team Box Information from ESPN.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 22:02:56 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401283399   2021           2 2021-02-17 2021-02-17 21:00:00      25 s:40~l:46…
#> 2 401283399   2021           2 2021-02-17 2021-02-17 21:00:00      29 s:40~l:46…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
#> 
#> $Player
#> ── ESPN NBA Player Box Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 22:02:57 UTC
#> # A tibble: 24 × 57
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4066392
#>  2 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4423545
#>  3 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4683027
#>  4 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4278073
#>  5 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4397020
#>  6 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    3138156
#>  7 401283399   2021           2 2021-02-17 2021-02-17 21:00:00       6610
#>  8 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    2490089
#>  9 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    3133626
#> 10 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4080610
#> # ℹ 14 more rows
#> # ℹ 51 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
#> 
# }
```
