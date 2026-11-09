# **Get KBL Season Leaders**

Current season leaders per category (no parameter): points, rebounds,
assists, steals, blocks, shooting.

Endpoint: `GET https://api.kbl.or.kr/league/season-leader`

## Usage

``` r
kbl_season_leaders()
```

## Value

A `hoopR_data` tibble with one row per leaderboard entry. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_season_leaders")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_season_leaders()

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
