# **Get BNXT League Player Career**

Season-by-season per-game averages of the player of a roster entry.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/player/career-averages/{roster_id}`

## Usage

``` r
sportpress_player_career(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble: Season-by-season per-game averages of the player
of a roster entry. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_player_career`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| roster_id | integer | Roster id the career was asked for; the rows are the person's seasons, each with its own roster. |
| competition_id | integer | Competition id of the season row. |
| season | integer | Season END year of the row. |
| competition_name | character | Competition name of the season row. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
| club_name | character | Country name in English, Belgium or Netherlands. |
| position | character | Playing position; null in every sample. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| played_games | integer | Games played in the season. |
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

     sportpress_player_career(roster_id = 11193)

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
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
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
