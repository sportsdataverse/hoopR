# **FIBA GDAP: player stats**

A player's per-game averages, totals and highs at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapplayercompetitionstatisticsbyplayerid`

## Usage

``` r
fiba_gdap_player_stats(player_id, comp, return_parsed = TRUE)
```

## Arguments

- player_id:

  (integer, required) Required. FIBA person id (global): personId of a
  roster row, pId in play-by-play, P\_`<id>` in the game-page box

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_player_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_player_stats(player_id = 211501, comp = 208182))
#> ── FIBA gdap_player_stats from fiba.basketball ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:52 UTC
#> # A tibble: 1 × 64
#>   player_id competition_id points_per_game rebounds_per_game
#>       <int>          <int>           <dbl>             <dbl>
#> 1    211501         208182             7.8               2.3
#> # ℹ 60 more variables: rebounds_offensive_per_game <dbl>,
#> #   rebounds_defensive_per_game <dbl>, assists_per_game <dbl>,
#> #   blocks_per_game <dbl>, turnovers_per_game <dbl>, fouls_per_game <dbl>,
#> #   plus_minus_per_game <dbl>, efficiency_per_game <dbl>,
#> #   play_time_in_seconds_per_game <dbl>, field_goals_made_per_game <dbl>,
#> #   field_goals_attempted_per_game <dbl>, two_points_made_per_game <dbl>,
#> #   two_points_attempted_per_game <dbl>, three_points_made_per_game <dbl>, …
# }
```
