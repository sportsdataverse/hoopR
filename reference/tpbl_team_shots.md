# **Get TPBL Team Shots**

Every field-goal attempt of one team in one division with its court
position (optionally per quarter).

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/shooting-spots`

## Usage

``` r
tpbl_team_shots(division_id, team_id, rounds = NULL)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- team_id:

  Required. TPBL team id (the franchise, 2-8, stable across seasons);
  `team_id` in tpbl_teams. Not the GoHoops id.

- rounds:

  Quarter filter: a quarter number or a vector of them (1-4, 5 and 6 for
  overtimes); the runtime sends it as the API's repeatable `rounds[]`.
  `NULL` (the default) for all quarters.

## Value

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_team_shots")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_team_shots(division_id = 2, team_id = 4, rounds = 1)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
