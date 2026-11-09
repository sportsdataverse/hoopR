# **Get KZS Competition Rounds**

Number of rounds of each phase of a competition.

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/rounds`

## Usage

``` r
kzs_rounds(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: Number of rounds of each phase of a competition.
An empty valid answer raises `hoopR_no_data`; the columns are always
these, in this order (sportsdataverse-py `kzs_rounds`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
| rounds | integer | Number of rounds in the phase. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_rounds(competition_id = 579)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
