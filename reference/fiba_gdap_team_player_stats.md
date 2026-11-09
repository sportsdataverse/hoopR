# **FIBA GDAP: team player stats**

Per-game averages of every player of a team at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`

## Usage

``` r
fiba_gdap_team_player_stats(team_id, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per player of the team. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_team_player_stats")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_team_player_stats(team_id = 279569)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
