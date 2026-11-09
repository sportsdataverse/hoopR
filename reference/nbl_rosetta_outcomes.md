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

A `hoopR_data` tibble with one row per team name. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_outcomes")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_outcomes(org = "nbl", season = 2026, season_type = "regular")

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.
