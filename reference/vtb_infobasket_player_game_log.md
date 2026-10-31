# **Get VTB Infobasket Player Game Log**

A player's game log for one season and one team, one row per game.

Endpoint: `GET https://org.infobasket.su/Widget/PlayerStats/{person_id}`

## Usage

``` r
vtb_infobasket_player_game_log(
  person_id,
  season,
  team,
  filter = 1,
  tag = "vtb"
)
```

## Arguments

- person_id:

  Infobasket PersonID (person_id in a box score or roster): one person
  across clubs and seasons, e.g. 423011.

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached). Required.

- team:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban). Required: the body is the
  player's games for that club.

- filter:

  Site filter code; the widget always sends 1 (meaning unverified).

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: A player's game log for one season and one team,
one row per game. The columns are always these, in this order
(sportsdataverse-py `vtb_infobasket_player_game_log`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| person_id | integer | 0 on every game row (the player is the body's PersonID). |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. |
| game_number | character | Game number within the competition, e.g. 'RS-002' (RS = regular season); playoff games use the series code. |
| game_status | integer | Game status in the game-record code set: 21 completed. |
| team_id | integer | Infobasket TeamID the player played for in that game. |
| team_a_id | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| team_b_id | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| score_a | integer | Final points of team A (listed first). |
| score_b | integer | Final points of team B (listed second). |
| team_a_short_name_ru | character | The team A (the home side in the calendar)'s short name in Russian (as the competition names it). |
| team_a_short_name_en | character | The team A (the home side in the calendar)'s short name in English (as the competition names it). |
| team_a_name_ru | character | The team A (the home side in the calendar)'s name in Russian (as the competition names it). |
| team_a_name_en | character | The team A (the home side in the calendar)'s name in English (as the competition names it). |
| team_a_region_name_ru | character | The team A (the home side in the calendar)'s region or city in Russian (as the competition names it). |
| team_a_region_name_en | character | The team A (the home side in the calendar)'s region or city in English (as the competition names it). |
| team_b_short_name_ru | character | The team B (the away side)'s short name in Russian (as the competition names it). |
| team_b_short_name_en | character | The team B (the away side)'s short name in English (as the competition names it). |
| team_b_name_ru | character | The team B (the away side)'s name in Russian (as the competition names it). |
| team_b_name_en | character | The team B (the away side)'s name in English (as the competition names it). |
| team_b_region_name_ru | character | The team B (the away side)'s region or city in Russian (as the competition names it). |
| team_b_region_name_en | character | The team B (the away side)'s region or city in English (as the competition names it). |
| game_date | character | Game date as an ISO 8601 date (YYYY-MM-DD); the wire sends DD.MM.YYYY. |
| team_number | integer | Side (1 or 2) the player's team had in the game. |
| player_number | integer | Shirt number as an integer (-1 when none). |
| display_number | character | Shirt number as displayed ('0' and '00' differ). |
| points | integer | Points. The wire's null is 0 here (null counts are filled). |
| shot1 | integer | Free throws attempted. The wire's null is 0 here (null counts are filled). |
| goal1 | integer | Free throws made. The wire's null is 0 here (null counts are filled). |
| shot2 | integer | 2-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal2 | integer | 2-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot3 | integer | 3-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal3 | integer | 3-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot23 | integer | Field goals (2 + 3 points) attempted. The wire's null is 0 here (null counts are filled). |
| goal23 | integer | Field goals (2 + 3 points) made. The wire's null is 0 here (null counts are filled). |
| shot1_percent | double | Free-throw percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot2_percent | double | 2-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot3_percent | double | 3-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot23_percent | double | Field-goal percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| assist | integer | Assists. The wire's null is 0 here (null counts are filled). |
| blocks | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| def_rebound | integer | Defensive rebounds. The wire's null is 0 here (null counts are filled). |
| off_rebound | integer | Offensive rebounds. The wire's null is 0 here (null counts are filled). |
| rebound | integer | Total rebounds. The wire's null is 0 here (null counts are filled). |
| steal | integer | Steals. The wire's null is 0 here (null counts are filled). |
| turnover | integer | Turnovers. The wire's null is 0 here (null counts are filled). |
| foul | integer | Personal fouls committed. The wire's null is 0 here (null counts are filled). |
| opponent_foul | integer | Fouls drawn. The wire's null is 0 here (null counts are filled). |
| seconds | integer | Playing time in seconds. |
| played_time | character | Playing time as 'minutes:seconds' (team rows sum the five players: '200:00' = 40 minutes x 5). |
| plus_minus | integer | Plus-minus: point differential while on the court. Null where the host sends none. |
| is_start | logical | True for a starter. |
| start_mark | character | '+' for a starter, else empty. |
| kpi | integer | Efficiency index (KPI, the platform's 'KPI'); formula unverified. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_player_game_log(person_id = 423011, season = 2026, team = 2650)

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
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
