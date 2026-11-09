# **Get ACB Team Comparison**

Team-versus-team comparison bars of a game per period.

One row per period and statistic. `quarter` 0 is the whole game.
`home_value` / `away_value` parse the bar's display value (Spanish
decimal comma, `'79,17%'` becomes 79.17; a count stays a count); for the
shooting statistics `*_made` / `*_attempted` parse the `'19/24'`
subtitle. `*_is_highlighted` marks the side the site highlights.

Endpoint:
`GET https://api2.acb.com/api/matchdata/Overview/match-team-comparison`

## Usage

``` r
acb_team_comparison(match_id)
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
are always these, in this order (sportsdataverse-py
`acb_team_comparison`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| quarter | integer | Period of the bar: 0 = the whole game, 1-4 quarters. |
| stat | character | Compared statistic (free_throws, two_pointers, three_pointers, field_goals, rebounds, assists, steals, turnovers, personal_fouls, time_outs, points_off_turnover, paint_points, second_chance_points, fast_break_points, bench_points ...). |
| home_value | double | Home value of the bar: a percentage 0-100 for the shooting statistics (the API's `'79,17%'` decimal comma parsed), a count otherwise. |
| away_value | double | Away value of the bar, same units as home_value. |
| home_made | integer | Home shots made, from the 'made/attempted' subtitle; null for the non-shooting statistics. |
| home_attempted | integer | Home shots attempted, from the subtitle; null for the non-shooting statistics. |
| away_made | integer | Away shots made, from the subtitle; null for the non-shooting statistics. |
| away_attempted | integer | Away shots attempted, from the subtitle; null for the non-shooting statistics. |
| home_is_highlighted | logical | True when the site highlights the home bar as the better value. |
| away_is_highlighted | logical | True when the site highlights the away bar as the better value. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_comparison(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
