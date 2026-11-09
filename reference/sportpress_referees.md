# **Get BNXT League Referees**

Referees of the league (staff title 2).

Endpoint: `GET https://bnxt.sportpress.info/api/v1/staff/list`

## Usage

``` r
sportpress_referees()
```

## Value

A `hoopR_data` tibble: Referees of the league (staff title 2). An empty
valid answer raises `hoopR_no_data`; the columns are always these, in
this order (sportsdataverse-py `sportpress_referees`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| staff_id | integer | Staff member id (key space: sportpress staff); the referees are title 2. |
| name | character | Referee name 'First Last' (free text). |
| title_id | integer | Staff title id: 1 = Head coach, 2 = Referee; Assistant coach has its own id. |
| title_name | character | Staff title in English: Head coach, Assistant coach or Referee. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_referees()

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
