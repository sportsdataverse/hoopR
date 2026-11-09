# **FIBA GAMEPAGE: box teams**

Team box score of one FIBA game, with the game-level figures.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_box_teams(game_id, comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gamepage_box_teams")`) and in the
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
  try(fiba_gamepage_box_teams(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_box_teams from fiba.basketball ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:20 UTC
#> # A tibble: 2 × 57
#>   game_id competition_id statistic_system team_side organisation_id score points
#>     <int>          <int> <chr>            <chr>               <int> <int>  <int>
#> 1  100720         208182 OVR              A                      64    83     83
#> 2  100720         208182 OVR              B                    8323    77     77
#> # ℹ 50 more variables: fg_made <int>, fg_attempted <int>, fg_pct <dbl>,
#> #   fg2_made <int>, fg2_attempted <int>, fg2_pct <dbl>, fg3_made <int>,
#> #   fg3_attempted <int>, fg3_pct <dbl>, ft_made <int>, ft_attempted <int>,
#> #   ft_pct <dbl>, reb_offensive <int>, reb_defensive <int>, reb_total <int>,
#> #   assists <int>, steals <int>, blocks <int>, blocks_received <int>,
#> #   turnovers <int>, fouls <int>, fouls_drawn <int>, paint_fg_made <int>,
#> #   paint_fg_attempted <int>, paint_fg_pct <dbl>, efficiency <int>, …
# }
```
