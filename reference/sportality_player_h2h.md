# **Get Basketligaen Player Head-to-Head**

Player head-to-head of a matchup with per-game and season lines.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/player-h2h-v2/{ssgt_uuid}/{home_team_uuid}/{away_team_uuid}`

## Usage

``` r
sportality_player_h2h(
  ssgt_uuid,
  home_team_uuid,
  away_team_uuid,
  game_uuid = NULL
)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

- home_team_uuid:

  (required) Home team uuid of the game.

- away_team_uuid:

  (required) Away team uuid of the game.

- game_uuid:

  (default `NULL`) Game uuid; selects the game whose box-score lines the
  head-to-head carries.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_player_h2h")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_player_h2h(
       away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",
       ssgt_uuid = "xs07bd3fmp"
     )

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
