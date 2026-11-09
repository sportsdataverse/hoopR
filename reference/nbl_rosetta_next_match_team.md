# **NBL Rosetta Next Match Team**

Next match; the team segment is ignored by Rosetta (the body is the
organisation's next match).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/next/match/for/team/{team_code}/{org}/{season}`

## Usage

``` r
nbl_rosetta_next_match_team(team_code, season, org = "nbl")
```

## Arguments

- team_code:

  (*character* required): Team code (team_code of nbl_rosetta_teams),
  e.g. PER for the Perth Wildcats.

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

## Value

A `hoopR_data` tibble with one row per match. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_next_match_team")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_next_match_team(org = "nbl", season = 2027, team_code = "PER")

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.
