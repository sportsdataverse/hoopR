# **FIBA GAMEPAGE: shots**

Shot attempts of one FIBA game (two- and three-pointers and free throws)
with their x/y.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_shots(game_id, comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gamepage_shots")`) and in the
searchable [return
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
  try(fiba_gamepage_shots(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_shots from fiba.basketball ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:23 UTC
#> # A tibble: 161 × 19
#>    game_id competition_id statistic_system period period_number action_id order
#>      <int>          <int> <chr>            <chr>          <int> <chr>     <int>
#>  1  100720         208182 OVR              Q1                 1 3:0015        5
#>  2  100720         208182 OVR              Q1                 1 3:0017        7
#>  3  100720         208182 OVR              Q1                 1 3:0019        9
#>  4  100720         208182 OVR              Q1                 1 3:0020       10
#>  5  100720         208182 OVR              Q1                 1 3:0022       12
#>  6  100720         208182 OVR              Q1                 1 3:0023       13
#>  7  100720         208182 OVR              Q1                 1 3:0025       15
#>  8  100720         208182 OVR              Q1                 1 3:0027       17
#>  9  100720         208182 OVR              Q1                 1 3:0031       21
#> 10  100720         208182 OVR              Q1                 1 3:0032       23
#> # ℹ 151 more rows
#> # ℹ 12 more variables: clock <chr>, clock_seconds <int>, action_code <chr>,
#> #   organisation_id <int>, team_side <chr>, player_id <int>, shot_type <chr>,
#> #   points_attempted <int>, made <lgl>, shot_x <int>, shot_y <int>,
#> #   has_location <lgl>
# }
```
