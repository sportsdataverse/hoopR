# **Get ACB League Zones**

League-wide shooting by court zone for a season.

One row per zone: `attempts`, `made` and `points_scored`. Zone names:
restricted_area, paint, mid_range_left / center / right,
corner_three_left / right, wing_three_left / right, top_three.

Endpoint:
`GET https://api2.acb.com/api/seasondata/ShotChart/league-zones`

## Usage

``` r
acb_league_zones(competition_id = NULL, season = NULL)
```

## Arguments

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_league_zones`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| phase_id | integer | Phase the statistics cover; null in the sample (read as all phases, unverified). |
| zone | character | Court zone (acb_codes.SHOT_ZONES): restricted_area, paint, mid_range\_*, corner_three\_*, wing_three\_\*, top_three. |
| attempts | integer | Field-goal attempts in the zone, league-wide. |
| made | integer | Field goals made in the zone, league-wide. |
| points_scored | integer | Points scored from the zone, league-wide. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_league_zones(season = 2027)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
