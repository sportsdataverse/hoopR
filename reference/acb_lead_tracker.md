# **Get ACB Lead Tracker**

Score through a game, one row per scoring moment, with the margin.

One row per point on the lead chart: the period, the clock left, both
scores and `margin` = `home_score - away_score`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lead-tracker`

## Usage

``` r
acb_lead_tracker(match_id)
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
are always these, in this order (sportsdataverse-py `acb_lead_tracker`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| quarter | integer | Period: 1-4, 5+ overtime |
| minute | integer | Game clock left in the period, minutes part. |
| second | integer | Game clock left in the period, seconds part. |
| clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
| home_score | integer | Home score at that moment. |
| away_score | integer | Away score at that moment. |
| margin | integer | Home score minus away score at that moment (positive = the home team leads). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_lead_tracker(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
