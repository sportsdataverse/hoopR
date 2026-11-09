# **Get BBL / DBBL Season-Average Records**

All-time season-average records (points, rebounds, assists, ...), one
row per record.

Endpoint:
`GET https://api.basketball-bundesliga.de/records/season-averages`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_records_season_averages(league = "bbl")
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: All-time season-average records (points,
rebounds, assists, ...), one row per record. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_records_season_averages`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| stat | character | The record's stat list: assist_average, block_average, efficiency_average, foul_average, free_throws_success_percentage, points_average, rebound_average, steal_average, three_point_shot_average or turnover_average. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| place | integer | Rank within the list (1 = best); 0 on some rows. |
| order_id | integer | Sort order within the list. |
| value | double | The record value. A STRING in /records/per-game ('52'); a number in /records/season-averages. |
| ratio | double | \[made, attempted\] as strings, on percentage records only; null otherwise. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| team_name | character | Team name as listed that season (sponsor names included). |
| team_tlc | character | The player's team code. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_records_season_averages()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
