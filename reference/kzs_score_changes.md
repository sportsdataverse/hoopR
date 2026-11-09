# **Get KZS Score by Minute**

The score at the end of each minute of a final game.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`

## Usage

``` r
kzs_score_changes(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: The score at the end of each minute of a final
game. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py `kzs_score_changes`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
| minute | integer | Game minute (1-40, then overtime minutes). |
| score1 | integer | First (home) team score at the end of the minute, an integer. |
| score2 | integer | Second (away) team score at the end of the minute, an integer. |
| total_minutes | integer | Game length in minutes (40, 45 with one overtime). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_score_changes(match_id = 101839)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
