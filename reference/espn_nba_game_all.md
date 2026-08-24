# **Get ESPN NBA game data (Pbp, Team and Player Box)**

**Get ESPN NBA game data (Pbp, Team and Player Box)**

**Get ESPN NBA PBP data**

**Get ESPN NBA team box scores**

**Get ESPN NBA player box scores**

**Get ESPN NBA game rosters**

**Get ESPN NBA's Betting information**

## Usage

``` r
espn_nba_game_all(game_id)

espn_nba_pbp(game_id)

espn_nba_team_box(game_id)

espn_nba_player_box(game_id)

espn_nba_game_rosters(game_id)

espn_nba_betting(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A named list of data frames: Plays, Team, Player

**Plays**

Columns as documented in the shared
[espn_nba_game_all_plays_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_plays_schema.md)
table.

**Team**

Columns as documented in the shared
[espn_nba_game_all_team_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_team_schema.md)
table.

**Player**

Columns as documented in the shared
[espn_nba_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_player_schema.md)
table.

A play-by-play data frame.

**Plays**

Columns as documented in the shared
[espn_nba_game_all_plays_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_plays_schema.md)
table.

A team boxscore data frame

**Team**

Columns as documented in the shared
[espn_nba_game_all_team_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_team_schema.md)
table.

A player boxscore data frame

**Player**

Columns as documented in the shared
[espn_nba_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_player_schema.md)
table.

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

Returns a named list of data frames: pickcenter, againstTheSpread,
predictor

**pickcenter**

Columns as documented in the shared
[espn_mbb_betting_pickcenter_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting_pickcenter_schema.md)
table.

**againstTheSpread**

Columns as documented in the shared
[espn_mbb_betting_againstthespread_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting_againstthespread_schema.md)
table.

**predictor**

Columns as documented in the shared
[espn_mbb_betting_predictor_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting_predictor_schema.md)
table.

## See also

Other ESPN NBA Functions:
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md),
[`espn_nba_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_odds.md),
[`espn_nba_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_official_detail.md),
[`espn_nba_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play.md),
[`espn_nba_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play_personnel.md),
[`espn_nba_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_player_box.md),
[`espn_nba_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_probabilities.md),
[`espn_nba_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_propbets.md),
[`espn_nba_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_linescores.md),
[`espn_nba_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster_entry.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_awards.md),
[`espn_nba_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_career_stats.md),
[`espn_nba_player_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contract.md),
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md),
[`espn_nba_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog_v2.md),
[`espn_nba_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_info.md),
[`espn_nba_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_overview.md),
[`espn_nba_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_seasons.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md),
[`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
[`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md),
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
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
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
#> ℹ Data updated: 2026-08-24 20:40:07 UTC
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
#> ℹ Data updated: 2026-08-24 20:40:07 UTC
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
#> ℹ Data updated: 2026-08-24 20:40:07 UTC
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

# \donttest{
try(espn_nba_pbp(game_id = 401071880))
#> ── ESPN NBA Play-by-Play Information from ESPN.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:08 UTC
#> # A tibble: 475 × 54
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4010718… 4               Jahl…          0          0 FALSE                  0
#>  2 4010718… 7               Nema…          0          3 TRUE                   3
#>  3 4010718… 9               Elfr…          2          3 TRUE                   2
#>  4 4010718… 10              Ian …          2          3 FALSE                  0
#>  5 4010718… 12              Kenr…          2          3 FALSE                  0
#>  6 4010718… 13              Jahl…          4          3 TRUE                   2
#>  7 4010718… 15              Harr…          4          5 TRUE                   2
#>  8 4010718… 16              King…          4          5 FALSE                  0
#>  9 4010718… 17              Ian …          7          5 TRUE                   3
#> 10 4010718… 19              Chri…          7          5 FALSE                  0
#> # ℹ 465 more rows
#> # ℹ 47 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
# }

# \donttest{
try(espn_nba_team_box(game_id = 401071880))
#> ── ESPN NBA Team Box Information from ESPN.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:09 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401071880   2019           2 2019-04-07 2019-04-07 21:00:00       3 s:40~l:46…
#> 2 401071880   2019           2 2019-04-07 2019-04-07 21:00:00      23 s:40~l:46…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
# }

# \donttest{
try(espn_nba_player_box(game_id = 401071880))
#> ── ESPN NBA Player Box Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:09 UTC
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

# \donttest{
try(espn_nba_game_rosters(game_id = 401283399))
#> ✖ 2026-08-24 20:40:09.659308: Invalid arguments or no game roster data for 401283399 available!
#> ✖ Args: game_id = 401283399
#> ✖ Error: ℹ In index: 1. Caused by error in `dplyr::rename()`: ! Can't rename columns that don't exist. ✖ Column `jersey` doesn't exist.
#> ── ESPN NBA Game Roster Information from ESPN.com ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:09 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
try(espn_nba_betting(game_id = 401283399))
#> $pickcenter
#> ── ESPN NBA Pickcenter Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:09 UTC
#> # A tibble: 3 × 66
#>   details over_under spread over_odds under_odds provider_id provider_name
#> * <chr>        <int>  <int>     <dbl>      <dbl>       <int> <chr>        
#> 1 MEM -7         227     -7    -110       -110          1004 consensus    
#> 2 MEM -7         228     -7      30.9       67.4        1003 numberfire   
#> 3 MEM -7         228     -7    -110       -110          1002 teamrankings 
#> # ℹ 59 more variables: provider_priority <int>,
#> #   away_team_odds_win_percentage <dbl>, away_team_odds_favorite <lgl>,
#> #   away_team_odds_underdog <lgl>, away_team_odds_money_line <int>,
#> #   away_team_odds_spread_odds <dbl>, away_team_odds_team_id <int>,
#> #   away_team_odds_average_score <dbl>, away_team_odds_money_line_odds <dbl>,
#> #   away_team_odds_spread_return <dbl>,
#> #   away_team_odds_current_point_spread_alternate_display_value <chr>, …
#> 
#> $againstTheSpread
#> ── ESPN NBA Against the Spread Information from ESPN.com ──────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:09 UTC
#> # A tibble: 2 × 9
#>      id uid        display_name abbreviation logo  logos records game_id team_id
#> * <int> <chr>      <chr>        <chr>        <chr> <lis> <list>    <int>   <int>
#> 1    25 s:40~l:46… Oklahoma Ci… OKC          http… <df>  <list>   4.01e8      25
#> 2    29 s:40~l:46… Memphis Gri… MEM          http… <df>  <list>   4.01e8      29
#> 
#> $predictor
#> data frame with 0 columns and 0 rows
#> 
# }
```
