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

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gamepage_period_scores")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
#> ℹ Data updated: 2026-11-13 18:15:44 UTC
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
