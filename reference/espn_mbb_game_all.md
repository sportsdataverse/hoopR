# **Get ESPN men's college basketball data (Pbp, Team and Player Box)**

**Get ESPN men's college basketball data (Pbp, Team and Player Box)**

**Get ESPN men's college basketball PBP data**

**Get ESPN men's college basketball team box scores**

**Get ESPN men's college basketball player box scores**

**Get ESPN men's college basketball game rosters**

**Get ESPN MBB's Betting information**

## Usage

``` r
espn_mbb_game_all(game_id)

espn_mbb_pbp(game_id)

espn_mbb_team_box(game_id)

espn_mbb_player_box(game_id)

espn_mbb_game_rosters(game_id)

espn_mbb_betting(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A named list of data frames: Plays, Team, Player

**Plays**

Columns as documented in the shared
[espn_mbb_game_all_plays_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_plays_schema.md)
table.

**Team**

Columns as documented in the shared
[espn_mbb_game_all_team_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_team_schema.md)
table.

**Player**

Columns as documented in the shared
[espn_mbb_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_player_schema.md)
table.

A play-by-play data frame.

**Plays**

Columns as documented in the shared
[espn_mbb_game_all_plays_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_plays_schema.md)
table.

A team boxscore data frame

**Team**

Columns as documented in the shared
[espn_mbb_game_all_team_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_team_schema.md)
table.

A player boxscore data frame

**Player**

Columns as documented in the shared
[espn_mbb_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_player_schema.md)
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
| birth_place_city | character | Birth place city. |
| birth_place_state | character | Birth place state. |
| birth_place_country | character | Birth place country. |
| slug | character | URL-safe identifier. |
| headshot_href | character | Headshot image URL. |
| headshot_alt | character | Alternative-text label for the headshot. |
| jersey | character | Jersey number worn by the player. |
| hand_type | character | Hand type. |
| hand_abbreviation | character | Hand abbreviation. |
| hand_display_value | character | Hand display value. |
| position_id | integer | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_display_name | character | Position display name. |
| position_abbreviation | character | Position abbreviation ('G' / 'F' / 'C'). |
| position_leaf | logical | Position leaf. |
| linked | logical | TRUE if the record is linked to a related entity. |
| experience_years | integer | Experience years. |
| experience_display_value | character | Experience display value. |
| experience_abbreviation | character | Experience abbreviation. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
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
| ejected | logical | TRUE if the player was ejected from the game. |
| team_id | integer | Unique team identifier. |
| team_guid | character | ESPN team GUID. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_sdr | integer | ESPN team SDR identifier. |
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
| game_id | integer | Unique game identifier. |
| order | integer | Display order within the result set. |
| home_away | character | Game venue label ('home' or 'away'). |
| winner | logical | Winner. |
| roster_href | character | URL for roster. |

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

Other ESPN MBB Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
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
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
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
try(espn_mbb_game_all(game_id = 401479672))
#> $Plays
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:31 UTC
#> # A tibble: 360 × 53
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4014796… 101799901       Jump…          0          0 FALSE                  0
#>  2 4014796… 101805501       Jess…          0          0 FALSE                  2
#>  3 4014796… 101805502       RJ M…          0          0 FALSE                  0
#>  4 4014796… 101805503       Skyy…          0          0 FALSE                  0
#>  5 4014796… 101808101       Terr…          0          0 FALSE                  3
#>  6 4014796… 101808102       RJ M…          0          0 FALSE                  0
#>  7 4014796… 101809301       RJ M…          0          0 FALSE                  2
#>  8 4014796… 101809302       Benn…          0          0 FALSE                  0
#>  9 4014796… 101809501       Foul…          0          0 FALSE                  0
#> 10 4014796… 101814601       Juda…          0          0 FALSE                  2
#> # ℹ 350 more rows
#> # ℹ 46 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
#> 
#> $Team
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:31 UTC
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
#> 
#> $Player
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:31 UTC
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
#> 
# }
# \donttest{
try(espn_mbb_pbp(game_id = 401479672))
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:32 UTC
#> # A tibble: 360 × 53
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4014796… 101799901       Jump…          0          0 FALSE                  0
#>  2 4014796… 101805501       Jess…          0          0 FALSE                  2
#>  3 4014796… 101805502       RJ M…          0          0 FALSE                  0
#>  4 4014796… 101805503       Skyy…          0          0 FALSE                  0
#>  5 4014796… 101808101       Terr…          0          0 FALSE                  3
#>  6 4014796… 101808102       RJ M…          0          0 FALSE                  0
#>  7 4014796… 101809301       RJ M…          0          0 FALSE                  2
#>  8 4014796… 101809302       Benn…          0          0 FALSE                  0
#>  9 4014796… 101809501       Foul…          0          0 FALSE                  0
#> 10 4014796… 101814601       Juda…          0          0 FALSE                  2
#> # ℹ 350 more rows
#> # ℹ 46 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
# }

# \donttest{
try(espn_mbb_team_box(game_id = 401479672))
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:33 UTC
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
# \donttest{
try(espn_mbb_player_box(game_id = 401479672))
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:33 UTC
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
# \donttest{
try(espn_mbb_game_rosters(game_id = 401256760))
#> ── ESPN MBB Game Roster Information from ESPN.com ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:35 UTC
#> # A tibble: 34 × 151
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    4277850 s:40~l:41~a… 7b156c52-fa… basketball   4.28e6 RaiQuan    Gray     
#>  2    4432829 s:40~l:41~a… 2734604d-09… basketball   4.43e6 Balsa      Koprivica
#>  3    4433134 s:40~l:41~a… dd0bb1da-07… basketball   4.43e6 Scottie    Barnes   
#>  4    4277854 s:40~l:41~a… f44291c9-0d… basketball   4.28e6 MJ         Walker   
#>  5    4277852 s:40~l:41~a… f376da3f-46… basketball   4.28e6 Anthony    Polite   
#>  6    4279098 s:40~l:41~a… 89f097ed-f5… basketball   4.28e6 Malik      Osborne  
#>  7    4701240 s:40~l:41~a… f35c5378-4b… basketball   4.70e6 Tanor      Ngom     
#>  8    4683134 s:40~l:41~a… f878c598-70… basketball   4.68e6 Quincy     Ballard  
#>  9    4701239 s:40~l:41~a… 88820814-39… basketball   4.70e6 Sardaar    Calhoun  
#> 10    4592191 s:40~l:41~a… 066a390d-78… basketball   4.59e6 Nathanael  Jack     
#> # ℹ 24 more rows
#> # ℹ 144 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   birth_country_alternate_id <chr>, birth_country_abbreviation <chr>,
#> #   slug <chr>, headshot_href <chr>, headshot_alt <chr>, …
# }
# \donttest{
try(espn_mbb_betting(game_id = 401256760))
#> $pickcenter
#> ── ESPN MBB Pickcenter Information from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:35 UTC
#> # A tibble: 3 × 66
#>   details  over_under spread over_odds under_odds provider_id provider_name
#> * <chr>         <dbl>  <dbl>     <dbl>      <dbl>       <int> <chr>        
#> 1 FSU -1.5       136.   -1.5    -112       -108          1004 consensus    
#> 2 FSU -1.5       134.   -1.5      62.6       37.4        1003 numberfire   
#> 3 FSU -1         134.   -1      -115       -105          1002 teamrankings 
#> # ℹ 59 more variables: provider_priority <int>,
#> #   away_team_odds_win_percentage <dbl>, away_team_odds_favorite <lgl>,
#> #   away_team_odds_underdog <lgl>, away_team_odds_money_line <int>,
#> #   away_team_odds_spread_odds <dbl>, away_team_odds_team_id <int>,
#> #   away_team_odds_average_score <dbl>, away_team_odds_money_line_odds <dbl>,
#> #   away_team_odds_spread_return <dbl>,
#> #   away_team_odds_current_point_spread_alternate_display_value <chr>, …
#> 
#> $againstTheSpread
#> ── ESPN MBB Against the Spread Information from ESPN.com ──────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:35 UTC
#> # A tibble: 2 × 9
#>      id uid        display_name abbreviation logo  logos records game_id team_id
#> * <int> <chr>      <chr>        <chr>        <chr> <lis> <list>    <int>   <int>
#> 1    57 s:40~l:41… Florida Gat… FLA          http… <df>  <list>   4.01e8      57
#> 2    52 s:40~l:41… Florida Sta… FSU          http… <df>  <list>   4.01e8      52
#> 
#> $predictor
#> data frame with 0 columns and 0 rows
#> 
# }
```
