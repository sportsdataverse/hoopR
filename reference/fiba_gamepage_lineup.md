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

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64), global across competitions: gdapGameId, the `<gameId>` of a game-page URL. |
| competition_id | integer | FIBA competition id (Int64) of the game's edition; the comp argument. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| player_id | integer | FIBA person id (Int64), global across competitions and roles: the page's P\_`<id>`, play-by-play pId, roster personId and fiba_gdap_roster.player_id. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name as registered with FIBA. |
| jersey | character | Jersey number as a string. |
| position | character | Playing position code from the lineup card (PG, SG, SF, PF, C). |
| is_captain | logical | True for the team captain. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

     fiba_gamepage_lineup(game_id = 100720, comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
