# **FIBA GAMEPAGE: lineup**

Lineup card (the players who were registered for the game) of both teams
of one FIBA game.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_lineup(game_id, comp, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) FIBA game id (global): gameId of a gdap schedule
  row, e.g. 100720 = the World Cup 2023 final.

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). The
  game must belong to it. Find it with fiba_gdap_editions or
  fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list (the game-page objects `game`, `playByPlay`,
  `gameDetails`, `playersTeamA`, `playersTeamB`).

## Value

A `hoopR_data` tibble with one row per player in the lineup. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gamepage_lineup")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

     fiba_gamepage_lineup(game_id = 100720, comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
