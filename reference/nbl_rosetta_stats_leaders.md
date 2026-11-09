# **NBL Rosetta Stats Leaders**

Player season totals and averages of a season (the leaderboard), one row
per player and period.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/stats/leaders/for/season/id/{season_id}`

## Usage

``` r
nbl_rosetta_stats_leaders(season_id, org = "nbl", limit = NULL)
```

## Arguments

- season_id:

  (*character* required): Season id: the DataCore season id (season_id
  of nbl_rosetta_seasons) or Rosetta's own id (rosetta_season_id);
  either is accepted. Not the year.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble with one row per player and period. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_stats_leaders")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_stats_leaders(org = "nbl", season_id = "1f8e4a79-e98b-457b-85a5-e4b898c6c0bd")

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.
