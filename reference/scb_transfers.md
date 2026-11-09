# **Get BBL Transfers**

Latest transfers, one row per move (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/transfers`

## Usage

``` r
scb_transfers()
```

## Value

A `hoopR_data` tibble: Latest transfers, one row per move (BBL only). An
empty valid answer raises `hoopR_no_data`; the columns are always these,
in this order (sportsdataverse-py `scb_transfers`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| transfer_date | character | Date of the transfer, YYYY-MM-DD (the API's `sortingDate`). |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
| real_player_id | integer | Global person id (integer): the same player across clubs and seasons. Join players across seasons on this. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| source_team_id | character | Club id the player left; null when the source is not a league club. |
| source_team_name | character | Name of the club the player left (the free-text field, else the short club name). |
| destination_team_id | character | Club id the player joined; null when the destination is not a league club. |
| destination_team_name | character | Name of the club the player joined (the free-text field, else the short club name). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_transfers()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
