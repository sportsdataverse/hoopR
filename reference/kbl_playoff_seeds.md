# **Get KBL Playoff Seeds**

The regular-season finish that seeds the playoffs (the top six).

Endpoint: `GET https://api.kbl.or.kr/league/playoff/{season}`

## Usage

``` r
kbl_playoff_seeds(season)
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

## Value

A `hoopR_data` tibble: The regular-season finish that seeds the playoffs
(the top six). The columns are always these, in this order
(sportsdataverse-py `kbl_playoff_seeds`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
| game_code | character | Competition type of the standings: '01' regular season. |
| seed | integer | Final regular-season standing, i.e. the playoff seed (1-6). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Team short name (Korean, e.g. Wonju DB). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| team_name_full | character | Team full name (Korean). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_playoff_seeds(season = 2025)

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
