# **NBL1 (Australia) (Atrium shortcuts)**

**Per-competition shortcuts over the Atrium embed API for NBL1
(Australia) (`website_id = 3`; men's and women's).**

Thin bindings of the parameterised `atrium_*()` wrappers to this site,
minted from the competition registry (sdv-py
`tools/codegen/basketball_competitions.yaml`); the full surface stays on
the `atrium_*()` wrappers.

## Usage

``` r
nbl1_seasons(locale = NULL)
nbl1_schedule(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_standings(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_teams(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_player_box(fixture_id, locale = NULL)
nbl1_team_box(fixture_id, locale = NULL)
nbl1_pbp(fixture_id, locale = NULL)
nbl1_shots(fixture_id, locale = NULL)
```

## Arguments

- season:

  (*integer* optional): Season END year (season rule below). Omit
  `season` and `season_id` for the site's current season.

- season_id:

  (*character* optional): Season UUID (`season_id` in the seasons
  listing); skips the END-year lookup.

- competition_id:

  (*character* optional): Competition UUID (a site carries many:
  conferences, cups); needed when several share the season.

- locale:

  (*character* optional): Label locale, e.g. `"en-EN"`; omitted = the
  site's own language.

- fixture_id:

  (*character* required): Fixture UUID (`fixture_id` in the schedule).

## Value

A `hoopR_data` tibble with the columns of the base wrapper, one table
per function:

### `nbl1_seasons()`

The columns of
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID; pass it as season_id to any season-scoped wrapper. |
| competition_id | character | Competition UUID; pass it as competition_id to pick one of several seasons of an END year. |
| competition_name | character | Competition name in the site's language; the same name can appear for several years. |
| season_name | character | Season name in the site's language, e.g. Betclic ELITE 2025. |
| abbreviation_local | character | Local abbreviation of the season; null in every body seen. |
| year | integer | The site's own year of the season: the START year on LNB (site 12), the calendar year elsewhere. |
| season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
| is_default_season | logical | True for the season the body is about (the site's default when none was asked). |

### `nbl1_schedule()`

The columns of
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID the page is about (the site's default season when none was asked). |
| competition_id | character | Competition UUID of the season. |
| competition_name | character | Competition name in the site's language, e.g. Betclic ELITE or LIGA CALIENTE.MX LNBP. |
| season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| fixture_type | character | Kind of game as sent: REGULAR, PLAYOFF, ... (the set is open). |
| name | character | Fixture name as the site prints it (e.g. Paris - Lyon-Villeurbanne); null on LNBP. |
| round | character | Round of the game as the site words it, e.g. Journee: 30. |
| round_code | character | Round code; null in every body seen. |
| pool | character | Pool the game belongs to; null when the competition has none. |
| series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
| stage_code | character | Opaque 30-hex stage code of the game; null in every body seen. |
| status | character | Status code of the game, e.g. CONFIRMED (final), as sent. |
| status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
| start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
| start_time_local | character | Scheduled start in the venue's local time, as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; timezone gives the zone, which varies per row). |
| timezone | character | IANA time zone of the venue (e.g. Europe/Paris, Mexico/General) that start_time_local is in. |
| times_unconfirmed | logical | True while the start time is not final. |
| venue | character | Name of the arena where the game is played. |
| venue_id | character | Venue UUID; joins no other route. |
| attendance | integer | Spectators at the game; null when not reported. |
| home_entity_id | character | Team UUID of the home team. |
| home_code | character | Short code of the home team (e.g. PAB). |
| home_name | character | Name of the home team. |
| home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
| home_result_place | integer | Result place of the home team: 1 for the winner, 2 for the loser. |
| home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
| home_draw | logical | True when the game ended level for the home team. |
| home_shootout_attempts | character | Shootout attempts of the home team as sent (an empty string becomes null). |
| home_secondary_score | character | Secondary score of the home team (unused in the samples; shown as text). |
| away_entity_id | character | Team UUID of the away team. |
| away_code | character | Short code of the away team (e.g. PAB). |
| away_name | character | Name of the away team. |
| away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
| away_result_place | integer | Result place of the away team: 1 for the winner, 2 for the loser. |
| away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
| away_draw | logical | True when the game ended level for the away team. |
| away_shootout_attempts | character | Shootout attempts of the away team as sent (an empty string becomes null). |
| away_secondary_score | character | Secondary score of the away team (unused in the samples; shown as text). |

### `nbl1_standings()`

The columns of
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID of the table. |
| season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
| group | character | Label of the table when the standings hold several groups; null for a single table. |
| position | integer | League table position (1 = first). |
| entity_id | character | Team UUID of the row. |
| team_name | character | Team name as the site prints it. |
| is_current_team | logical | True for the team the page was opened for (team context); false on a plain standings request. |
| logo_url | character | URL of the team logo image. |
| wins | integer | Games won; -1 for two teams in the 2025-26 LNB table (an administrative ranking, unverified), kept as sent (team, this table). |
| losses | integer | Games lost (team, this table). |
| played | integer | Games played (LNBP and the compact standings) (team, this table). |
| standing_points | integer | League table points (LNBP) (team, this table). |
| win_percentage | double | Share of games won as a 0-1 fraction (not 0-100) (team, this table). |
| scored_for | integer | Points scored over the season (team, this table). |
| scored_against | integer | Points conceded over the season (team, this table). |
| point_difference | integer | Point differential over the season (team, this table). |
| result_string_home | character | Home results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
| scored_for_home | integer | Points scored in home games (team, this table). |
| scored_against_home | integer | Points conceded in home games (team, this table). |
| point_difference_home | integer | Point differential in home games (team, this table). |
| result_string_away | character | Away results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
| scored_for_away | integer | Points scored in away games (team, this table). |
| scored_against_away | integer | Points conceded in away games (team, this table). |
| point_difference_away | integer | Point differential in away games (team, this table). |
| streak | integer | Length of the current run of results (the win / loss sign convention is unverified) (team, this table). |
| streak_home | integer | Length of the current run of home results (sign convention unverified) (team, this table). |
| streak_away | integer | Length of the current run of away results (sign convention unverified) (team, this table). |

### `nbl1_teams()`

The columns of
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID of the team list. |
| entity_id | character | Team UUID (entity): one id per club across seasons, shared by every site that shows the team. |
| name | character | Team name in the site's language. |
| image_url | character | URL of the Sportradar-hosted image (400 px). |

### `nbl1_player_box()`

The columns of
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| entity_id | character | Team UUID the player is rostered with for this game. |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| person_id | character | Player UUID (person), shared across seasons and sites. |
| person_name | character | Player name as the site prints it (upper case on LNBP and NBL1). |
| bib | character | Jersey number the player wears, as text. |
| position | character | Position code on the roster (LNB, e.g. PG); null on LNBP. |
| starter | logical | True when the player started the game. |
| active | logical | True when the player is on the court in a live game. |
| participated | logical | True when the player entered the game; false rows have null statistics. |
| did_not_play_reason | character | Reason the player did not play; null in every body seen. |
| minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (player, this game). |
| seconds_played | integer | Time played in whole seconds, parsed from minutes (player, this game). |
| points | integer | Points scored (player, this game). |
| rebounds | integer | Total rebounds (player, this game). |
| rebounds_offensive | integer | Offensive rebounds (player, this game). |
| rebounds_defensive | integer | Defensive rebounds (player, this game). |
| assists | integer | Assists (player, this game). |
| steals | integer | Steals (player, this game). |
| blocks | integer | Shots blocked (player, this game). |
| blocks_received | integer | Own shots blocked by an opponent (LNB only) (player, this game). |
| turnovers | integer | Turnovers (player, this game). |
| fouls_total | integer | Fouls committed (player, this game). |
| fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (player, this game). |
| plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (player, this game). |
| efficiency | integer | Efficiency rating, from the site's own formula (player, this game). |
| field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (player, this game). |
| field_goals_attempted | integer | Field goals attempted (LNBP only) (player, this game). |
| field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (player, this game). |
| points_two_made | integer | Two-point field goals made (player, this game). |
| points_two_attempted | integer | Two-point field goals attempted (player, this game). |
| points_two_percentage | double | Two-point percentage, 0-100 (player, this game). |
| points_three_made | integer | Three-point field goals made (player, this game). |
| points_three_attempted | integer | Three-point field goals attempted (player, this game). |
| points_three_percentage | double | Three-point percentage, 0-100 (player, this game). |
| free_throws_made | integer | Free throws made (player, this game). |
| free_throws_attempted | integer | Free throws attempted (player, this game). |
| free_throws_percentage | double | Free-throw percentage, 0-100 (player, this game). |
| points_fast_break | integer | Fast-break points (LNBP only) (player, this game). |

### `nbl1_team_box()`

The columns of
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| entity_id | character | Team UUID (from the fixture's isHome flag). |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (team, this game). |
| seconds_played | integer | Time played in whole seconds, parsed from minutes (team, this game). |
| points | integer | Points scored (team, this game). |
| rebounds | integer | Total rebounds (team, this game). |
| rebounds_offensive | integer | Offensive rebounds (team, this game). |
| rebounds_defensive | integer | Defensive rebounds (team, this game). |
| assists | integer | Assists (team, this game). |
| steals | integer | Steals (team, this game). |
| blocks | integer | Shots blocked (team, this game). |
| blocks_received | integer | Own shots blocked by an opponent (LNB only) (team, this game). |
| turnovers | integer | Turnovers (team, this game). |
| fouls_total | integer | Fouls committed (team, this game). |
| fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (team, this game). |
| plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (team, this game). |
| efficiency | integer | Efficiency rating, from the site's own formula (team, this game). |
| field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (team, this game). |
| field_goals_attempted | integer | Field goals attempted (LNBP only) (team, this game). |
| field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, this game). |
| points_two_made | integer | Two-point field goals made (team, this game). |
| points_two_attempted | integer | Two-point field goals attempted (team, this game). |
| points_two_percentage | double | Two-point percentage, 0-100 (team, this game). |
| points_three_made | integer | Three-point field goals made (team, this game). |
| points_three_attempted | integer | Three-point field goals attempted (team, this game). |
| points_three_percentage | double | Three-point percentage, 0-100 (team, this game). |
| free_throws_made | integer | Free throws made (team, this game). |
| free_throws_attempted | integer | Free throws attempted (team, this game). |
| free_throws_percentage | double | Free-throw percentage, 0-100 (team, this game). |
| points_fast_break | integer | Fast-break points (LNBP only) (team, this game). |
| extra_fouls_total | integer | Fouls committed (team, credited to the team rather than a player). |
| extra_rebounds | integer | Total rebounds (team, credited to the team rather than a player). |
| extra_rebounds_defensive | integer | Defensive rebounds (team, credited to the team rather than a player). |
| extra_rebounds_offensive | integer | Offensive rebounds (team, credited to the team rather than a player). |
| extra_turnovers | integer | Turnovers (team, credited to the team rather than a player). |
| total_biggest_lead | integer | Biggest lead of the game, in points (team, game total). |
| total_biggest_scoring_run | integer | Longest unanswered scoring run of the game, in points (team, game total). |
| total_field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, game total). |
| total_free_throws_percentage | double | Free-throw percentage, 0-100 (team, game total). |
| total_lead_changes | integer | Number of lead changes in the game (team, game total). |
| total_points_fast_break | integer | Fast-break points (LNBP only) (team, game total). |
| total_points_from_bench | integer | Points scored by non-starters (LNBP only) (team, game total). |
| total_points_from_turnover | integer | Points scored off opponent turnovers (LNBP only) (team, game total). |
| total_time_in_lead | character | Time the team led, as an ISO 8601 duration (PT36M11S) (team, game total). |
| total_time_in_lead_seconds | integer | Time the team led, in whole seconds (team, game total). |
| total_turnovers | integer | Turnovers (team, game total). |

### `nbl1_pbp()`

The columns of
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| sequence | integer | 1-based position of the event in the game (periods in order, events chronological). |
| event_id | character | Event UUID, shared with the same event in atrium_shots. |
| period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
| clock | character | Time REMAINING in the period as an ISO 8601 duration (PT10M0S at the start). |
| clock_seconds | integer | Seconds remaining in the period, parsed from clock. |
| entity_id | character | Team UUID the event is credited to. |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| person_id | character | Player UUID; null for team events (time-outs, team rebounds). |
| person_name | character | Player the event is credited to; null for team events (time-outs, team rebounds). |
| bib | character | Jersey number of the player, as text; null for team events. |
| event_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, ... (language-independent). |
| event_sub_type | character | Event detail: jumpShot, layup, offensive, defensive, in, out, 1Of2, personal, ...; null when none. |
| description | character | The event's text in the site's language (e.g. Entre-deux remporte). |
| success | logical | True when a shot or free throw was made, false when missed; null for other events. |
| success_label | character | The made / missed label in the site's language; sent on shot events only. |
| x | double | Shot location along the 28 m court length as percent of the court (0-100, origin at a corner); the home team attacks the low-x basket all game; null for non-shots. |
| y | double | Shot location across the 15 m width as percent of the court (0-100); which sideline is 0 is unverified; null for non-shots. |
| home_score | integer | Home team's running score after the event. |
| away_score | integer | Away team's running score after the event. |

### `nbl1_shots()`

The columns of
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| sequence | integer | 1-based position of the shot among the shots of the game (not the pbp sequence). |
| event_id | character | Event UUID of the shot; the same event in atrium_pbp. |
| period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
| clock | character | Time REMAINING in the period as an ISO 8601 duration (PT10M0S at the start). |
| clock_seconds | integer | Seconds remaining in the period, parsed from clock. |
| entity_id | character | Team UUID the event is credited to. |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| person_id | character | Player UUID of the shooter. |
| person_name | character | Name of the shooter. |
| bib | character | Jersey number of the player, as text; null for team events. |
| event_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, ... (language-independent). |
| event_sub_type | character | Event detail: jumpShot, layup, offensive, defensive, in, out, 1Of2, personal, ...; null when none. |
| description | character | The event's text in the site's language (e.g. Entre-deux remporte). |
| success | logical | True when the shot was made, false when missed. |
| success_label | character | The made / missed label in the site's language; sent on shot events only. |
| x | double | Shot location along the 28 m court length as percent of the court (0-100, origin at a corner); the home team attacks the low-x basket all game; LNBP and NBL1 clamp rim attempts to 5 / 95. |
| y | double | Shot location across the 15 m width as percent of the court (0-100); which sideline is 0 is unverified. |
| home_score | integer | Home team's running score after the event. |
| away_score | integer | Away team's running score after the event. |

## Details

Season rule: calendar year, Mar-Aug (END year); conferences are
competition_ids.

Errors and terms of use are those of
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md):
unofficial use of the public widget endpoint, at least 1 s between
requests, not republished as release assets. The site also serves
women's competitions (pass their `competition_id`).

     nbl1_seasons()
     nbl1_schedule()

## See also

Other Atrium:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md),
[`atrium_standings_summary()`](https://hoopR.sportsdataverse.org/reference/atrium_standings_summary.md),
[`atrium_team()`](https://hoopR.sportsdataverse.org/reference/atrium_team.md),
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md)
