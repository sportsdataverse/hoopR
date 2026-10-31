# **Get BNXT League Team Player Averages**

Per-game averages of each player of a competition team.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/player-averages/{competition_team_id}`

## Usage

``` r
sportpress_team_player_averages(competition_team_id)
```

## Arguments

- competition_team_id:

  (required) Competition-team id (integer): a team in ONE competition,
  so new every season (e.g. 541 = Antwerp in 2026-27); from
  [`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md).

## Value

A `hoopR_data` tibble: Per-game averages of each player of a competition
team. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py
`sportpress_team_player_averages`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| played_games | integer | Games the player played in the season. |
| games_started | integer | Games started (a count, not a mean). |
| minute | double | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). Per-game mean over the games played (fractional). |
| foul | double | Personal fouls committed. Per-game mean over the games played (fractional). |
| defensive_foul | double | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. Per-game mean over the games played (fractional). |
| dunk_made | double | Dunks made (a subset of the two-point field goals). Per-game mean over the games played (fractional). |
| dunk_all | double | Dunks attempted. Per-game mean over the games played (fractional). |
| dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. Per-game mean over the games played (fractional). |
| two_point_made | double | Two-point field goals made. Per-game mean over the games played (fractional). |
| two_point_all | double | Two-point field goals attempted. Per-game mean over the games played (fractional). |
| two_point_percent | double | Two-point percentage 0-100. Per-game mean over the games played (fractional). |
| three_point_made | double | Three-point field goals made. Per-game mean over the games played (fractional). |
| three_point_all | double | Three-point field goals attempted. Per-game mean over the games played (fractional). |
| three_point_percent | double | Three-point percentage 0-100. Per-game mean over the games played (fractional). |
| throw_made | double | All field goals made, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
| throw_all | double | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
| throw_percent | double | Field-goal percentage 0-100. Per-game mean over the games played (fractional). |
| free_throw_made | double | Free throws made. Per-game mean over the games played (fractional). |
| free_throw_all | double | Free throws attempted. Per-game mean over the games played (fractional). |
| free_throw_percent | double | Free-throw percentage 0-100. Per-game mean over the games played (fractional). |
| offensive_rebound | double | Offensive rebounds. Per-game mean over the games played (fractional). |
| defensive_rebound | double | Defensive rebounds. Per-game mean over the games played (fractional). |
| total_rebound | double | Total rebounds (offensive plus defensive). Per-game mean over the games played (fractional). |
| block | double | Shots blocked by the player. Per-game mean over the games played (fractional). |
| block_against | double | Own shots blocked by an opponent. Per-game mean over the games played (fractional). |
| turnover | double | Turnovers committed. Per-game mean over the games played (fractional). |
| steal | double | Steals (balls taken from an opponent). Per-game mean over the games played (fractional). |
| assist | double | Assists (passes leading directly to a made basket). Per-game mean over the games played (fractional). |
| points | double | Points scored (2 x two-pointers + 3 x three-pointers + free throws). Per-game mean over the games played (fractional). |
| value | double | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. Per-game mean over the games played (fractional). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_team_player_averages(competition_team_id = 541)

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
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)
