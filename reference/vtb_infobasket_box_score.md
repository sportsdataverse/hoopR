# **Get VTB Infobasket Box Score**

Player box score of a finished game (one row per player of each team,
DNPs included).

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_box_score(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: Player box score of a finished game (one row per
player of each team, DNPs included). The columns are always these, in
this order (sportsdataverse-py `vtb_infobasket_box_score`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Infobasket GameID of the game (the v2 matches' match_id); global across seasons. |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| is_home | logical | True for team 1, the team listed first (team A, the home side in the calendar); the body has no explicit home flag (unverified). |
| person_id | integer | Infobasket person id (PersonID): one person (player, coach or official) across clubs and seasons. Joins to /Widget/PlayerPage/{personId} (players) and /Widget/CoachPage/{personId} (coaches). |
| team_number | integer | Side of the player's team: 1 team A (home), 2 team B (away). |
| player_number | integer | Shirt number as an integer (-1 when none). |
| display_number | character | Shirt number as displayed ('0' and '00' differ). |
| last_name_ru | character | Last name in Russian. |
| last_name_en | character | Last name in English. |
| first_name_ru | character | First name in Russian. |
| first_name_en | character | First name in English. |
| person_name_ru | character | Name 'Last First' in Russian. |
| person_name_en | character | Name 'Last First' in English. |
| is_captain | logical | 1 for the team captain, else 0. |
| birth_date | character | Birth date (ISO 8601 date) of a player: public bio, kept; coaches' and officials' birth data is never output. |
| pos_id | integer | Position code: players 1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 centre; coaches 1000 head coach, 1001 assistant; officials 101-103 referees, 104 commissioner, 111-123 table officials (exact roles unverified). |
| country_code_ioc | character | Nationality code: ISO 3166 alpha-2 in most rows ('RU', 'US'), IOC alpha-3 in some ('BLR'). |
| country_name_ru | character | Nationality code (same as CountryCodeIOC), not a name. |
| country_name_en | character | Nationality code (same as CountryCodeIOC), not a name. |
| rank_ru | character | Sporting title, Russian; empty or null in the samples. |
| rank_en | character | Sporting title, English; empty or null in the samples. |
| height | integer | Height in centimetres. |
| weight | integer | Weight in kilograms. |
| points | integer | Points. The wire's null is 0 here (null counts are filled). |
| shot1 | integer | Free throws attempted. The wire's null is 0 here (null counts are filled). |
| goal1 | integer | Free throws made. The wire's null is 0 here (null counts are filled). |
| shot1_percent | double | Free-throw percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot2 | integer | 2-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal2 | integer | 2-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot2_percent | double | 2-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot3 | integer | 3-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal3 | integer | 3-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot3_percent | double | 3-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| assist | integer | Assists. The wire's null is 0 here (null counts are filled). |
| blocks | integer | Blocked shots. The wire's null is 0 here (null counts are filled). |
| def_rebound | integer | Defensive rebounds. The wire's null is 0 here (null counts are filled). |
| off_rebound | integer | Offensive rebounds. The wire's null is 0 here (null counts are filled). |
| rebound | integer | Total rebounds. The wire's null is 0 here (null counts are filled). |
| steal | integer | Steals. The wire's null is 0 here (null counts are filled). |
| turnover | integer | Turnovers. The wire's null is 0 here (null counts are filled). |
| foul | integer | Personal fouls committed. The wire's null is 0 here (null counts are filled). |
| opponent_foul | integer | Fouls drawn. The wire's null is 0 here (null counts are filled). |
| plus_minus | integer | Plus-minus: point differential while on the court. Null where the host sends none. |
| seconds | integer | Playing time in seconds. |
| played_time | character | Playing time as 'minutes:seconds' (team rows sum the five players: '200:00' = 40 minutes x 5). |
| is_start | logical | True for a starter. |
| start_mark | character | '+' for a starter, else empty. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_comp_issue()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_comp_issue.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff.md),
[`vtb_infobasket_playoff_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff_games.md),
[`vtb_infobasket_roster()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster.md),
[`vtb_infobasket_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster_coaches.md),
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md),
[`vtb_infobasket_standings()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_standings.md),
[`vtb_infobasket_team()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team.md),
[`vtb_infobasket_team_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_box_score.md),
[`vtb_infobasket_team_coach_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_coach_stats.md),
[`vtb_infobasket_team_comps()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_comps.md),
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_infobasket_team_stats_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_players.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_infobasket_box_score(game_id = 921391))
#> ── VTB Infobasket Box Score from org.infobasket.su ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:57:45 UTC
#> # A tibble: 24 × 47
#>    game_id team_id is_home person_id team_number player_number display_number
#>      <int>   <int> <lgl>       <int>       <int>         <int> <chr>         
#>  1  921391    2650 TRUE       423011           1             2 2             
#>  2  921391    2650 TRUE       337028           1             0 0             
#>  3  921391    2650 TRUE       393326           1             5 5             
#>  4  921391    2650 TRUE       490452           1             3 3             
#>  5  921391    2650 TRUE       377837           1            17 17            
#>  6  921391    2650 TRUE        55701           1            99 99            
#>  7  921391    2650 TRUE        24712           1            27 27            
#>  8  921391    2650 TRUE        39197           1            16 16            
#>  9  921391    2650 TRUE        51909           1            37 37            
#> 10  921391    2650 TRUE        39489           1            38 38            
#> # ℹ 14 more rows
#> # ℹ 40 more variables: last_name_ru <chr>, last_name_en <chr>,
#> #   first_name_ru <chr>, first_name_en <chr>, person_name_ru <chr>,
#> #   person_name_en <chr>, is_captain <lgl>, birth_date <chr>, pos_id <int>,
#> #   country_code_ioc <chr>, country_name_ru <chr>, country_name_en <chr>,
#> #   rank_ru <chr>, rank_en <chr>, height <int>, weight <int>, points <int>,
#> #   shot1 <int>, goal1 <int>, shot1_percent <dbl>, shot2 <int>, goal2 <int>, …
# }
```
