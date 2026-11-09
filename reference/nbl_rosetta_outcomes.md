# **NBL Rosetta Outcomes**

Win-loss record and last 10, 5 and 3 results per team, keyed by team
name.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/outcomes/for/{org}/teams/in/season/{season}/{season_type}`

## Usage

``` r
nbl_rosetta_outcomes(season, org = "nbl", season_type = "regular")
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- season_type:

  (*character* default `"regular"`): Season type: all (every type of the
  year), regular (includes finals), preseason, in_season (cups, Blitz,
  NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`,
  `"preseason"`, `"in_season"`, `"test"`.

## Value

A `hoopR_data` tibble (one row per team name):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| team_name | character | Name of the team, the key of Rosetta's outcomes map (the body carries no team id). |
| wins | integer | Wins of the team in the season type asked for. |
| losses | integer | Losses of the team in the season type asked for. |
| last10 | character | Results of the team's last 10 games as a W/L string, oldest first. |
| last5 | character | Results of the team's last 5 games as a W/L string, oldest first. |
| last3 | character | Results of the team's last 3 games as a W/L string, oldest first. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_outcomes(org = "nbl", season = 2026, season_type = "regular")

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.
