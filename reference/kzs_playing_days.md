# **Get KZS Playing Days**

Match days of a competition and the number of games on each.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{competition_id}/playingDays`

## Usage

``` r
kzs_playing_days(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: Match days of a competition and the number of
games on each. An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sportsdataverse-py `kzs_playing_days`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| date | character | Calendar date of the match day, 'YYYY-MM-DD'. |
| no_of_games | integer | Matches on that day. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_playing_days(competition_id = 579)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
