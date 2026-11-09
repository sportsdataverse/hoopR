# **IBBA Games by Team**

**Every game of a club in a season, domestic and external, in one
frame.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesByTeam`

## Usage

``` r
ibba_games_by_team(team_uid, season)
```

## Arguments

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_games_by_team")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_games_by_team(season = 2026, team_uid = 10)

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
