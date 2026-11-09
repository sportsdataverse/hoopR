# **Get BNXT League Roster Entry**

One roster entry with its player, team and season.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/roster/find/{roster_id}`

## Usage

``` r
sportpress_roster_find(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble with one row per roster entry. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_roster_find")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_roster_find(roster_id = 11193)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
