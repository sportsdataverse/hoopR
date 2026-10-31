# **Get BNXT League Roster Entry**

One roster entry with its player, team and season.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/roster/find/{roster_id}`

## Usage

``` r
sportpress_roster_find(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble: One roster entry with its player, team and
season. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py
`sportpress_roster_find`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| weight | integer | Weight in kg; null when unknown. |
| height | integer | Height in cm; null when unknown. |
| active | logical | True for a current roster entry; former entries are false. |
| position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
| position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| uu_team_id | integer | Stable club key across seasons of the team. |
| team | character | Team display name including the sponsor. |
| team_short_name | character | Three-letter club code of the team. |
| competition_id | integer | Competition id the roster entry's team plays in. |
| season | integer | Season END year of the roster entry's competition. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_roster_find(roster_id = 11193)

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
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)
