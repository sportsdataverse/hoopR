# **Get ACB Match Advanced Stats**

Team advanced statistics of a game against the team's season and
win/loss splits.

One row per team (`team_side`), statistic group and statistic:
`match_value` is this game, `season_value` the team's season value,
`win_value` / `loss_value` its values in wins / losses, `*_diff` the
game minus that split. Groups: four_factors, game_rhythm, ball_handling,
shooting, points, ratings, rebounds. All are `Float64` (rates are
percentages 0-100 unless the stat is a ratio, such as
`pointsPerPossession`).

Endpoint:
`GET https://api2.acb.com/api/matchdata/AdvancedStats/match-advanced-stats`

## Usage

``` r
acb_match_advanced_stats(match_id)
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
`acb_match_advanced_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| group | character | Statistic group in snake_case (four_factors, game_rhythm, ball_handling, shooting, points, ratings, rebounds). |
| stat | character | Statistic in snake_case (efg_pct, orb_pct, tov_pct, f_tr = free-throw rate, possessions, pace, points_per_possession, ast_ratio, ..., net_rating, oer, der, trb_pct). |
| match_value | double | The statistic in this game (the API's partido). |
| season_value | double | The team's value over the season (the API's temporada). |
| win_value | double | The team's value in its wins (the API's win). |
| loss_value | double | The team's value in its losses (the API's loss). |
| season_diff | double | Game value minus season value (temporadaDiff). |
| win_diff | double | Game value minus the wins value (winDiff). |
| loss_diff | double | Game value minus the losses value (lossDiff). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_match_advanced_stats(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
