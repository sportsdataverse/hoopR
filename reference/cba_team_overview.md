# **Get CBA Team Overview**

A team's overview table (record, pace, per-100 ratings), one row per
season of the team.

Endpoint:
`POST https://data-server.cbaleague.com/api/team-match-datas/team-entirety-list`
(JSON body)

## Usage

``` r
cba_team_overview(team_id, match_type_id = 1, page_number = 1, page_size = 100)
```

## Arguments

- team_id:

  (required) Required. CBA team id (clubs, stable across seasons and
  renames).

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble with one row per season of the team. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_team_overview")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_team_overview(team_id = 29128)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
