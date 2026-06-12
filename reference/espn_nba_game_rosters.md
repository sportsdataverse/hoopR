# **Get ESPN NBA game rosters**

**Get ESPN NBA game rosters**

## Usage

``` r
espn_nba_game_rosters(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A game rosters data frame

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_uid | character | ESPN athlete UID (universal identifier). |
| athlete_guid | character | ESPN athlete GUID. |
| athlete_type | character | Athlete type / class. |
| sdr | integer | Sdr. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| full_name | character | Player's full name. |
| athlete_display_name | character | Athlete display name (full). |
| short_name | character | Short display name. |
| weight | integer | Player weight in pounds. |
| display_weight | character | Player weight in display format (e.g. '180 lbs'). |
| height | integer | Player height (string e.g. '6-2' or inches). |
| display_height | character | Player height in display format (e.g. '6-2'). |
| age | integer | Player age (in years). |
| date_of_birth | character | Date of birth (YYYY-MM-DD). |
| debut_year | integer | Year of professional debut. |
| birth_place_city | character | Birth place city. |
| birth_place_state | character | Birth place state. |
| birth_place_country | character | Birth place country. |
| slug | character | URL-safe identifier. |
| headshot_href | character | Headshot image URL. |
| headshot_alt | character | Alternative-text label for the headshot. |
| jersey | character | Jersey number worn by the player. |
| position_id | integer | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_display_name | character | Position display name. |
| position_abbreviation | character | Position abbreviation ('G' / 'F' / 'C'). |
| position_leaf | logical | Position leaf. |
| linked | logical | TRUE if the record is linked to a related entity. |
| years | integer | Years. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| contract_bird_status | integer | Contract bird status. |
| contract_active | logical | Contract active. |
| contract_active_1 | logical | Contract active 1. |
| contract_incoming_trade_value | integer | Contract incoming trade value. |
| contract_outgoing_trade_value | integer | Contract outgoing trade value. |
| contract_minimum_salary_exception | logical | Contract minimum salary exception. |
| contract_option_type | integer | Contract option type. |
| contract_salary | integer | Contract salary. |
| contract_salary_remaining | integer | Contract salary remaining. |
| contract_years_remaining | integer | Contract years remaining. |
| contract_trade_kicker_active | logical | Contract trade kicker active. |
| contract_trade_kicker_percentage | integer | Contract trade kicker percentage (0-1 decimal). |
| contract_trade_kicker_value | integer | Contract trade kicker value. |
| contract_trade_kicker_trade_value | integer | Contract trade kicker trade value. |
| contract_trade_restriction | logical | Contract trade restriction. |
| contract_unsigned_foreign_pick | logical | Contract unsigned foreign pick. |
| contract_active_2 | logical | Contract active 2. |
| draft_display_text | character | Draft display text. |
| draft_round | integer | Round of the draft selection. |
| draft_year | integer | Draft year (4-digit). |
| draft_selection | integer | Draft selection. |
| status_id | integer | Status identifier. |
| status_name | character | Status label. |
| status_type | character | Status type. |
| status_abbreviation | character | Status abbreviation. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| valid | logical | Valid. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| display_name | character | Display name. |
| reason | character | Reason. |
| ejected | logical | TRUE if the player was ejected from the game. |
| team_id | integer | Unique team identifier. |
| team_guid | character | ESPN team GUID. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_is_active | logical | TRUE if the team is currently active. |
| team_is_all_star | logical | TRUE if the row represents an All-Star team. |
| logo_href | character | Team or league logo URL. |
| logo_dark_href | character | Logo URL for dark backgrounds. |
| logos_href_2 | character | Logos href 2. |
| logos_href_3 | character | Logos href 3. |
| game_id | integer | Unique game identifier. |
| order | integer | Display order within the result set. |
| home_away | character | Game venue label ('home' or 'away'). |
| winner | logical | Winner. |
| citizenship | character | Citizenship. |
| contract_base_year_compensation_active | logical | Contract base year compensation active. |
| contract_base_year_compensation_expiration | character | Contract base year compensation expiration. |
| hand_type | character | Hand type. |
| hand_abbreviation | character | Hand abbreviation. |
| hand_display_value | character | Hand display value. |

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
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
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
try(espn_nba_game_rosters(game_id = 401283399))
#> ── ESPN NBA Game Roster Information from ESPN.com ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 23:28:19 UTC
#> # A tibble: 24 × 175
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    2993874 s:40~l:46~a… 0b5e3fdc-79… basketball   2.99e6 Kyle       Anderson 
#>  2    3155526 s:40~l:46~a… 653c07b5-85… basketball   3.16e6 Dillon     Brooks   
#>  3       6477 s:40~l:46~a… 585a3d05-44… basketball   2.56e6 Jonas      Valanciu…
#>  4    3135045 s:40~l:46~a… fedd8adf-a9… basketball   3.14e6 Grayson    Allen    
#>  5    4279888 s:40~l:46~a… de5f87e0-85… basketball   4.28e6 Ja         Morant   
#>  6    3906665 s:40~l:46~a… ac9aa77d-db… basketball   3.91e6 Brandon    Clarke   
#>  7    3908903 s:40~l:46~a… 6445df83-a2… basketball   3.91e6 Sean       McDermott
#>  8    4277964 s:40~l:46~a… 4b87dfe2-26… basketball   4.28e6 Xavier     Tillman  
#>  9    3134932 s:40~l:46~a… d4c8df92-1b… basketball   3.13e6 John       Konchar  
#> 10    3135046 s:40~l:46~a… c4cddbcc-95… basketball   3.14e6 Tyus       Jones    
#> # ℹ 14 more rows
#> # ℹ 168 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>, debut_year <int>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   citizenship <chr>, slug <chr>, headshot_href <chr>, headshot_alt <chr>,
#> #   athlete_jersey_number <chr>, position_id <int>, position_name <chr>, …
# }
```
