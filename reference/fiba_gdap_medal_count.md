# **FIBA GDAP: medal count**

All-time medal table of a competition family.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapmedalcount`

## Usage

``` r
fiba_gdap_medal_count(family_id, return_parsed = TRUE)
```

## Arguments

- family_id:

  (integer, required) Required. Competition family id
  (competitionMarketingName.competitionMarketingNameId): 201 = World
  Cup, 320 = men's Olympics, 306 = Women's World Cup, 112 = BCL tier 1,
  211 = EuroLeague Women.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_medal_count")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_medal_count(family_id = 201)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
