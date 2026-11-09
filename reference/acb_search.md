# **Get ACB Search**

Search players, teams and coaches by name.

One row per hit; `kind` is player, team or coach. The sample holds
players only (`teams` and `coaches` came back empty), so the team and
coach row shapes are unverified. `person_id` is the licence number for
players and coaches (a team hit carries its team entry id).

Endpoint: `GET https://api2.acb.com/api/seasondata/Search/search`

## Usage

``` r
acb_search(search_term, limit = NULL)
```

## Arguments

- search_term:

  (required) Name fragment (accent-insensitive on the player rows); a
  blank term is refused.

- limit:

  (default `NULL`) Maximum results per kind (players, teams, coaches). A
  whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per hit. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_search")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_search(limit = 5, search_term = "tavares")

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
