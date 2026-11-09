# **IBBA External Games**

**A club's games of a season in external competitions (BoardsEx boards:
European cups, pre-season).**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesEx`

## Usage

``` r
ibba_games_ex(team_uid, season, board_id = 0)
```

## Arguments

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `0`): External board id from ibba_boards_ex (1001
  EuroLeague, 1003 Champions League, ...); 0 (default) for all.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_games_ex")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_games_ex(season = 2026, team_uid = 10)

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
