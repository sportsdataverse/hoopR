# **Get ACB Playoff Series**

The playoff series a game belongs to, one row per game of the series
(HTTP 204 outside a series).

One row per game of the series: `match_id` is that game and
`requested_match_id` the game asked for (every row repeats it).
`home_team_id` / `away_team_id` are the team entries of THAT game,
`series_home_*` the team with home court. `series_home_wins` /
`series_away_wins` are the series wins, `best_of` the series length as
sent (0 in the 2016-17 final sample: read it as unknown). A game outside
a series answers HTTP 204 (`hoopR_no_data`).

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/serie`

## Usage

``` r
acb_serie(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_serie`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| requested_match_id | integer | The match asked for (any game of the series); every row of the series repeats it. |
| phase_id | integer | Phase id of the series (111 = Play Off Titulo). |
| subphase_id | integer | Sub-phase id of the series (the playoff stage). |
| series_home_team_id | integer | Season-team entry of the series' home-court team (new every season). |
| series_home_club_id | integer | Stable club id of the series' home-court team. |
| series_away_team_id | integer | Season-team entry of the other team of the series. |
| series_away_club_id | integer | Stable club id of the other team of the series. |
| series_home_wins | integer | Games won by the home-court team in the series (the API's homeScore). |
| series_away_wins | integer | Games won by the other team in the series (the API's awayScore). |
| series_finished | logical | True once the series is decided. |
| best_of | integer | Series length (best of N) as sent; 0 in the 2016-17 final sample, so read 0 as unknown. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| match_id | integer | ACB match id of this game of the series. |
| home_team_id | integer | Home season-team entry of THIS game (the series' home-court team is series_home_team_id). |
| away_team_id | integer | Away season-team entry of THIS game. |
| home_score | integer | Home points of this game. |
| away_score | integer | Away points of this game. |
| start | POSIXct | Tip-off instant (UTC). |
| status | character | Game state: FINALIZED once over. |
| is_on_half_time | logical | True during the half-time break of a live game. |
| current_quarter | integer | Current or last period of the game (4 for a finished regulation game). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_serie(match_id = 17718)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
