# **Get BNXT League Competition Staff**

Coaching staff (head coach, assistants) of every competition team of one
competition.

Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`

## Usage

``` r
sportpress_competition_staff(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

## Value

A `hoopR_data` tibble: Coaching staff (head coach, assistants) of every
competition team of one competition. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_competition_staff`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id of the team the staff member works for. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| staff_id | integer | Staff member id (key space: sportpress staff). |
| name | character | Staff member name 'First Last' (free text). |
| title_id | integer | Staff title id: 1 = Head coach; Assistant coach has its own id. |
| title_name | character | Staff title in English: Head coach or Assistant coach. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_competition_staff(competition_id = 24)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
