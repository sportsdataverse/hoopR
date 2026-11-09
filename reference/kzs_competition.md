# **Get KZS Competition**

One competition: season, gender, category, rank and type (its phases are
kzs_phases).

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`

## Usage

``` r
kzs_competition(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: One competition: season, gender, category, rank
and type (its phases are kzs_phases). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_competition`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| name | character | Competition name, Slovenian (glossary in kzs-returns.md). |
| season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
| season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
| season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
| season_active | logical | Same as `isActive`. |
| gender | character | MALE or FEMALE. |
| category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
| rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
| type | character | Competition type (code table). |
| season | integer | Season of the record: opaque id and 'START/END' name. |
| social_medias | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_competition(competition_id = 579))
#> ── KZS Competition from api.kzs.si ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:06:29 UTC
#> # A tibble: 1 × 12
#>   competition_id name       season_id season_name season_is_active season_active
#>            <int> <chr>          <int> <chr>       <lgl>            <lgl>        
#> 1            579 Liga OTP …        26 2025/2026   FALSE            FALSE        
#> # ℹ 6 more variables: gender <chr>, category <chr>, rank <chr>, type <chr>,
#> #   season <int>, social_medias <chr>
# }
```
