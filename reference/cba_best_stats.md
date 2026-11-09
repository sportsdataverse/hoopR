# **Get CBA Best Stats**

Single-category leaders of each side in the game report.

Endpoint:
`GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/bestDataQuota/{schedule_id}`

## Usage

``` r
cba_best_stats(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per side and category. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `cba_best_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| ctype | character | Statistic the row leads: points, assists, steals, rebounds, blocked (five rows per side in every sample). See the code table. |
| cvalue | character | The leader's value of ctype, as a STRING ('16'). |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. A STRING here ('100005271'), an integer on every box route. |
| player_name | character | Player name (Chinese). Null on rows whose name the report does not repeat (the same player's earlier row carries it). |
| player_no | character | Jersey number as a string. Null where playerName is null. |
| seconds | integer | The leader's time on court in SECONDS. |
| team_id | integer | Unobserved: null in every sample (the side is the enclosing list). |
| type | integer | Side flag: 0 on home rows, 2 on visiting rows (differs from advance-count, where the visiting side is 1). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_best_stats(schedule_id = 100105799)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
