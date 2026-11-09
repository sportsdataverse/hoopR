# **FIBA GDAP: roster latest**

A team's latest roster (same shape as the roster).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamlatestrosterbyteamid`

## Usage

``` r
fiba_gdap_roster_latest(team_id, return_parsed = TRUE)
```

## Arguments

- team_id:

  (integer, required) Required. Competition team id: one per team per
  competition (teamA.teamId of a game row; Germany is 279569 at the 2023
  World Cup and 281545 at Paris 2024). Not the federation organisationId

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_roster_latest")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_roster_latest(team_id = 282183)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
