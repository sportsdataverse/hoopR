# **Get KZS Competition Phases**

The phases of a competition (regular season, play-offs, finals) with
dates and type.

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`

## Usage

``` r
kzs_phases(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: The phases of a competition (regular season,
play-offs, finals) with dates and type. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_phases`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
| phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
| name | character | Phase name, Slovenian: 'Redni del' = regular season, 'Cetrtfinale' = quarterfinal, 'Polfinale' = semifinal, 'Finale' = final, '1. del' / '2. del' = first / second stage. |
| start_date | character | Phase start date (UTC midnight). |
| end_date | character | Phase end date (UTC midnight). |
| type | character | Phase format (code table). |
| groups | character | Groups of the phase (empty when the phase has one table). |
| wins_needed | integer | Wins needed to take a best-of series. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_phases(competition_id = 579)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
