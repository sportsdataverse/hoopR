# **Get BNXT League Team**

One competition team with its season scoring averages.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/find/{competition_team_id}`

## Usage

``` r
sportpress_team_find(competition_team_id)
```

## Arguments

- competition_team_id:

  (required) Competition-team id (integer): a team in ONE competition,
  so new every season (e.g. 541 = Antwerp in 2026-27); from
  [`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_team_find")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_team_find(competition_team_id = 541)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
