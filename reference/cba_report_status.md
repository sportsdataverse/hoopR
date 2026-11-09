# **Get CBA Report Status**

Whether the game report page exists for the game.

Endpoint:
`GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReportStatues/{schedule_id}`

## Usage

``` r
cba_report_status(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row with the is_report flag. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `cba_report_status`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| is_report | logical | True when the game report page exists (equals schedules/day isReport == 1 in every sample). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_report_status(schedule_id = 100105799)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
