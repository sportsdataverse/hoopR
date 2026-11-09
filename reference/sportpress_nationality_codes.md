# **Get BNXT League Nationality Codes**

Distinct player nationality codes of a season (dirty: lower case, pairs,
empty).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/roster/season-nationality-codes/{season}`

## Usage

``` r
sportpress_nationality_codes(season)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

## Value

A `hoopR_data` tibble with one row per nationality code. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_nationality_codes")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_nationality_codes(season = 2026)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
