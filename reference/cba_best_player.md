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

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
