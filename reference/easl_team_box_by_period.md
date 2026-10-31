# **Get EASL Team Box Score By Period**

Team totals of a finished game by period, one row per team and period
(overtimes after the fourth).

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/teamstats/by/period`

## Usage

``` r
easl_team_box_by_period(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Team totals of a finished game by period, one row
per team and period (overtimes after the fourth). An empty answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `easl_team_box_by_period`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| fixture_id | character | DataCore fixture (game) UUID v1 from the request. |
| team_id | character | DataCore team UUID v1 (the wire's team.teamId). |
| team_name | character | Team display name (English / Latin script, the wire's nameFullLocal). |
| team_name_native | character | Team name in native script (the wire's nameFullLatin; blank for most clubs). |
| period | integer | Period number: 1-4 for regulation, overtimes after (the wire's `period_{n}` key). |
| period_label | character | Q1-Q4 for periods 1-4; OT1, OT2 ... for overtimes (the server numbers the first overtime 11 in team totals; periods 5-10 are read as `OT{n-4}`, unverified). |
| assists | integer | Assists: passes that directly lead to a made field goal. Team total for the period. |
| assists_against | integer | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Team total for the period. Absent on some rows. |
| assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Team total for the period. |
| assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Team total for the period. Absent on some rows. |
| biggest_lead | integer | Largest lead the team held during the game, in points. A season total sums the per-game maxima. Team total for the period. |
| biggest_scoring_run | integer | Longest unanswered scoring run of the team, in points. A season total sums the per-game maxima. Team total for the period. |
| blocks | integer | Shots blocked (made by this player or team). Team total for the period. |
| blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Team total for the period. |
| dunks | integer | Dunks made. Team total for the period. |
| efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Team total for the period. |
| efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Team total for the period. |
| field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Team total for the period. |
| field_goals_attempted_against | integer | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Team total for the period. Absent on some rows. |
| field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Team total for the period. |
| field_goals_made | integer | Field goals made (2- and 3-point shots). Team total for the period. |
| field_goals_made_against | integer | Opponent's figure in the same games: field goals made (2- and 3-point shots). Team total for the period. Absent on some rows. |
| field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the period. |
| field_goals_percentage_against | double | Opponent's figure in the same games: field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the period. Absent on some rows. |
| fouls_bench_technical | integer | Technical fouls called on the bench (not a player). Team total for the period. |
| fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Team total for the period. |
| fouls_coach_technical | integer | Technical fouls on the coach. Team total for the period. |
| fouls_disqualifying | integer | Disqualifying fouls. Team total for the period. |
| fouls_disruptive | integer | Disruptive fouls (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
| fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Team total for the period. |
| fouls_flagrant | integer | Flagrant fouls (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
| fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Team total for the period. |
| fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the period. |
| fouls_personal_against | integer | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the period. Absent on some rows. |
| fouls_technical | integer | Technical fouls committed by the player or team. Team total for the period. |
| fouls_technical_against | integer | Opponent's figure in the same games: technical fouls committed by the player or team. Team total for the period. Absent on some rows. |
| fouls_technical_cat1 | integer | Technical fouls of category 1 (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
| fouls_technical_cat2 | integer | Technical fouls of category 2 (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
| fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Team total for the period. |
| fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Team total for the period. |
| free_throws_attempted | integer | Free throws attempted. Team total for the period. |
| free_throws_attempted_against | integer | Opponent's figure in the same games: free throws attempted. Team total for the period. Absent on some rows. |
| free_throws_made | integer | Free throws made. Team total for the period. |
| free_throws_made_against | integer | Opponent's figure in the same games: free throws made. Team total for the period. Absent on some rows. |
| free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
| free_throws_percentage_against | double | Opponent's figure in the same games: free-throw percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
| index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Team total for the period. |
| lead_changes | integer | Times the lead changed hands during the game (a season total sums the games). Team total for the period. |
| minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Team total for the period. |
| pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Team total for the period. |
| points | integer | Points scored. Team total for the period. |
| points_against | integer | Opponent's figure in the same games: points scored. Team total for the period. |
| points_fast_break | integer | Points scored on fast breaks. Team total for the period. |
| points_fast_break_against | integer | Opponent's figure in the same games: points scored on fast breaks. Team total for the period. Absent on some rows. |
| points_fast_break_attempted | integer | Fast-break field goals attempted. Team total for the period. |
| points_fast_break_made | integer | Fast-break field goals made. Team total for the period. |
| points_four_attempted | integer | 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the period. Absent on some rows. |
| points_four_attempted_against | integer | Opponent's figure in the same games: 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the period. Absent on some rows. |
| points_four_made | integer | 4-point shots made (see pointsFourAttempted). Team total for the period. Absent on some rows. |
| points_four_made_against | integer | Opponent's figure in the same games: 4-point shots made (see pointsFourAttempted). Team total for the period. Absent on some rows. |
| points_from_bench | integer | Points scored by players who did not start (a team figure). Team total for the period. |
| points_from_bench_against | integer | Opponent's figure in the same games: points scored by players who did not start (a team figure). Team total for the period. Absent on some rows. |
| points_from_turnover | integer | Points scored off opponent turnovers. Team total for the period. |
| points_from_turnover_against | integer | Opponent's figure in the same games: points scored off opponent turnovers. Team total for the period. Absent on some rows. |
| points_in_the_paint | integer | Points scored in the paint. Team total for the period. |
| points_in_the_paint_against | integer | Opponent's figure in the same games: points scored in the paint. Team total for the period. Absent on some rows. |
| points_in_the_paint_attempted | integer | Field goals attempted in the paint. Team total for the period. |
| points_in_the_paint_made | integer | Field goals made in the paint. Team total for the period. |
| points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Team total for the period. |
| points_second_chance_against | integer | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Team total for the period. Absent on some rows. |
| points_second_chance_attempted | integer | Second-chance field goals attempted. Team total for the period. |
| points_second_chance_made | integer | Second-chance field goals made. Team total for the period. |
| points_three_attempted | integer | 3-point field goals attempted. Team total for the period. |
| points_three_attempted_against | integer | Opponent's figure in the same games: 3-point field goals attempted. Team total for the period. Absent on some rows. |
| points_three_made | integer | 3-point field goals made. Team total for the period. |
| points_three_made_against | integer | Opponent's figure in the same games: 3-point field goals made. Team total for the period. Absent on some rows. |
| points_three_percentage | double | 3-point percentage on a 0-100 scale. Team total for the period. |
| points_three_percentage_against | double | Opponent's figure in the same games: 3-point percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
| points_two_attempted | integer | 2-point field goals attempted. Team total for the period. |
| points_two_attempted_against | integer | Opponent's figure in the same games: 2-point field goals attempted. Team total for the period. Absent on some rows. |
| points_two_made | integer | 2-point field goals made. Team total for the period. |
| points_two_made_against | integer | Opponent's figure in the same games: 2-point field goals made. Team total for the period. Absent on some rows. |
| points_two_percentage | double | 2-point percentage on a 0-100 scale. Team total for the period. |
| points_two_percentage_against | double | Opponent's figure in the same games: 2-point percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
| power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Team total for the period. |
| power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Team total for the period. |
| rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the period. |
| rebounds_against | integer | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the period. Absent on some rows. |
| rebounds_defensive | integer | Defensive rebounds. Team total for the period. |
| rebounds_defensive_against | integer | Opponent's figure in the same games: defensive rebounds. Team total for the period. Absent on some rows. |
| rebounds_offensive | integer | Offensive rebounds. Team total for the period. |
| rebounds_offensive_against | integer | Opponent's figure in the same games: offensive rebounds. Team total for the period. Absent on some rows. |
| rebounds_team_defensive | integer | Defensive rebounds credited to the team as a whole (not to a player). Team total for the period. |
| rebounds_team_defensive_against | integer | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Team total for the period. Absent on some rows. |
| rebounds_team_offensive | integer | Offensive rebounds credited to the team as a whole. Team total for the period. |
| rebounds_team_offensive_against | integer | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Team total for the period. Absent on some rows. |
| rebounds_team_total | integer | Team rebounds credited to the team as a whole (offensive + defensive). Team total for the period. |
| rebounds_team_total_against | integer | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Team total for the period. Absent on some rows. |
| steals | integer | Steals. Team total for the period. |
| steals_against | integer | Opponent's figure in the same games: steals. Team total for the period. Absent on some rows. |
| time_in_lead | character | Time the team led, as an ISO 8601 duration `PT{m}M{s}S` (unwrapped minutes). Team total for the period. |
| timeouts_used | integer | Timeouts taken by the team (present from 2025-26). Team total for the period. Absent on some rows. |
| times_score_level | integer | Times the score was tied during the game. Team total for the period. |
| turnovers | integer | Turnovers committed by players. Team total for the period. |
| turnovers_against | integer | Opponent's figure in the same games: turnovers committed by players. Team total for the period. Absent on some rows. |
| turnovers_team | integer | Team turnovers not charged to a player (shot-clock and similar violations). Team total for the period. |
| turnovers_team_against | integer | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Team total for the period. Absent on some rows. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_team_box_by_period(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3")

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
