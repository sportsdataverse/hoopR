# **Get BNXT League Player Games**

Game-by-game box lines of a roster entry (including games with 0
minutes).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/player/season-games/{roster_id}`

## Usage

``` r
sportpress_player_games(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble: Game-by-game box lines of a roster entry
(including games with 0 minutes). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_player_games`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| roster_id | integer | Roster id the lines were asked for. |
| game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
| game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
| status | character | Game status: finished, or ready for an upcoming game. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year of the game's competition. |
| phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
| phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
| round_name | character | Round label as entered in the CMS; often empty. |
| round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
| period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
| arena | character | Name of the arena where the game is played. |
| home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| home_score | integer | Home side. Final points of the side, including overtime. |
| away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| away_score | integer | Away side. Final points of the side, including overtime. |
| competition_team_id | integer | Competition-team id the player played for in the game. |
| starter | logical | True when the player started the game. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
| foul | integer | Personal fouls committed. |
| defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
| dunk_made | integer | Dunks made (a subset of the two-point field goals). |
| dunk_all | integer | Dunks attempted. |
| dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
| two_point_made | integer | Two-point field goals made. |
| two_point_all | integer | Two-point field goals attempted. |
| two_point_percent | double | Two-point percentage 0-100. |
| three_point_made | integer | Three-point field goals made. |
| three_point_all | integer | Three-point field goals attempted. |
| three_point_percent | double | Three-point percentage 0-100. |
| throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
| throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
| throw_percent | double | Field-goal percentage 0-100. |
| free_throw_made | integer | Free throws made. |
| free_throw_all | integer | Free throws attempted. |
| free_throw_percent | double | Free-throw percentage 0-100. |
| offensive_rebound | integer | Offensive rebounds. |
| defensive_rebound | integer | Defensive rebounds. |
| total_rebound | integer | Total rebounds (offensive plus defensive). |
| block | integer | Shots blocked by the player. |
| block_against | integer | Own shots blocked by an opponent. |
| turnover | integer | Turnovers committed. |
| steal | integer | Steals (balls taken from an opponent). |
| assist | integer | Assists (passes leading directly to a made basket). |
| points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
| value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_player_games(roster_id = 11193)

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md),
[`sportpress_game_film()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_film.md),
[`sportpress_game_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_find.md),
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
[`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md),
[`sportpress_player_career()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_career.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)
