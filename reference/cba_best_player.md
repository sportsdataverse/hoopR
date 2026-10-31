# **Get CBA Best Player**

The best player of each side in the game report.

Endpoint:
`GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/bestPlayer/{schedule_id}`

## Usage

``` r
cba_best_player(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per side with the star player's line. An
empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_best_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| assists | integer | Assists by the player in this game. |
| blocked | integer | Blocks by the player in this game. |
| fouls | integer | Personal fouls by the player in this game. |
| free_throw_str | character | Free throws as the string 'made/attempted'. |
| minutes | integer | Minutes played (whole minutes). |
| number | character | Jersey number as a string. |
| player_img | character | Absolute URL of the player's photo; null when there is none. |
| player_name | character | Full player name (Chinese, may include the first name: (Chinese text)). Null on some rows (the short name is in playerNameStr). |
| player_name_str | character | Short display name (Chinese surname form: (Chinese text)). |
| points | integer | Points scored by the player in this game. |
| real_point_rate | double | true-shooting percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
| rebounds | integer | Total rebounds by the player in this game. |
| steals | integer | Steals by the player in this game. |
| three_points_str | character | Three-point field goals as the string 'made/attempted'. |
| turn_share | double | possession share (see advance-count turnShare). A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
| turnovers | integer | Turnovers by the player in this game. |
| two_points_str | character | Two-point field goals as the string 'made/attempted' ('3/5'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_best_player(schedule_id = 100105799)

## See also

Other CBA Functions:
[`cba_best_stats()`](https://hoopR.sportsdataverse.org/reference/cba_best_stats.md),
[`cba_game_info()`](https://hoopR.sportsdataverse.org/reference/cba_game_info.md),
[`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md),
[`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md),
[`cba_match_types()`](https://hoopR.sportsdataverse.org/reference/cba_match_types.md),
[`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md),
[`cba_period_scores()`](https://hoopR.sportsdataverse.org/reference/cba_period_scores.md),
[`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md),
[`cba_player_base()`](https://hoopR.sportsdataverse.org/reference/cba_player_base.md),
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
[`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md),
[`cba_schedule_day()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_day.md),
[`cba_schedule_month()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_month.md),
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md),
[`cba_team_basic()`](https://hoopR.sportsdataverse.org/reference/cba_team_basic.md),
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)
