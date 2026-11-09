# **EuroLeague Game Stats (Competition Engine box score)**

**Get the box score of one game from the Competition Engine: one row
with the `local` and `road` sides flattened to prefixed columns; each
side's `players` list is kept JSON-encoded.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/stats`

For one row per player use
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md)
(the live API).

## Usage

``` r
euroleague_game_stats(competition_code, season_code, game_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_game_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sportsdataverse-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_game_stats(competition_code = "E", season_code = "E2025", game_code = 1)
  })
#> ── EuroLeague game stats from api-live.euroleague.net ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:53:35 UTC
#> # A tibble: 1 × 102
#>   local_coach_code local_coach_name local_players         local_team_time_played
#>   <chr>            <chr>            <chr>                                  <dbl>
#> 1 010561           KOKOSKOV, IGOR   "[{\"player\":{\"per…                      0
#> # ℹ 98 more variables: local_team_valuation <dbl>, local_team_points <dbl>,
#> #   local_team_field_goals_made2 <dbl>,
#> #   local_team_field_goals_attempted2 <dbl>,
#> #   local_team_field_goals_made3 <dbl>,
#> #   local_team_field_goals_attempted3 <dbl>, local_team_free_throws_made <dbl>,
#> #   local_team_free_throws_attempted <dbl>,
#> #   local_team_field_goals_made_total <dbl>, …
# }
```
