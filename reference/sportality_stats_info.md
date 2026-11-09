# **Get Basketligaen Stats Table**

Stats table of one module for a season (players, teams, games,
standings).

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/stats-info/{module}`

## Usage

``` r
sportality_stats_info(module, season, game_type = "regular")
```

## Arguments

- module:

  (required) Stats table: players\_\* (summary, fieldGoal, rebound,
  point, offensive, defensive, foul), teams\_\* (summary, attendance,
  possession, fieldGoal, point, rebound, offensive, defensive, foul),
  games_games or standings_standings. One of `games_games`,
  `players_defensive`, `players_fieldGoal`, `players_foul`,
  `players_offensive`, `players_point`, `players_rebound`,
  `players_summary`, `standings_standings`, `teams_attendance`,
  `teams_defensive`, `teams_fieldGoal`, `teams_foul`, `teams_offensive`,
  `teams_point`, `teams_possession`, `teams_rebound`, `teams_summary`.

- season:

  (required) Season END year (2026 = 2025/26). Mapped to the provider's
  ssgt through /statistics-v2/layout- info (Basketligaen 2002/03 on); a
  season it does not list raises `hoopR_no_data`.

- game_type:

  (default `"regular"`) Game type: regular (the league season) or finals
  (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble with one row per table row. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_stats_info")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_stats_info(module = "players_summary", season = 2026)

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
