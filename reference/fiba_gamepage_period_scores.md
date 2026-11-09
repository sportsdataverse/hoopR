# **FIBA GAMEPAGE: period scores**

Points by period of both teams of one FIBA game.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_period_scores(game_id, comp, return_parsed = TRUE)
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
| period | character | Period name: Q1..Q4, then OT1, OT2... |
| period_number | integer | 1-based position of the period in the game. |
| points | integer | Points the team scored in the period. |
| points_first_five_min | integer | Points the team scored in the first five minutes of the period (matches the play-by-play except free throws on the 5:00 boundary); null when absent. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gamepage_period_scores(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_period_scores from fiba.basketball ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:05:15 UTC
#> # A tibble: 8 × 8
#>   game_id competition_id team_side organisation_id period period_number points
#>     <int>          <int> <chr>               <int> <chr>          <int>  <int>
#> 1  100720         208182 A                      64 Q1                 1     23
#> 2  100720         208182 A                      64 Q2                 2     24
#> 3  100720         208182 A                      64 Q3                 3     22
#> 4  100720         208182 A                      64 Q4                 4     14
#> 5  100720         208182 B                    8323 Q1                 1     26
#> 6  100720         208182 B                    8323 Q2                 2     21
#> 7  100720         208182 B                    8323 Q3                 3     10
#> 8  100720         208182 B                    8323 Q4                 4     20
#> # ℹ 1 more variable: points_first_five_min <int>
# }
```
