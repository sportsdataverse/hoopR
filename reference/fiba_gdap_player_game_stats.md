# **FIBA GDAP: player game stats**

A player's game log (full box lines) at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapplayergamestatisticsbyplayerid`

## Usage

``` r
fiba_gdap_player_game_stats(player_id, comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_player_game_stats")`) and in
the searchable [return
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
  try(fiba_gdap_player_game_stats(player_id = 211501, comp = 208182))
#> ── FIBA gdap_player_game_stats from fiba.basketball ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:51 UTC
#> # A tibble: 8 × 39
#>   player_id competition_id game_id game_day round_id round_code round_name    
#>       <int>          <int>   <int>    <int>    <int> <chr>      <chr>         
#> 1    211501         208182  100720        1    25283 F          Final         
#> 2    211501         208182  100723        1    25279 SF         Semi-Finals   
#> 3    211501         208182  100724        1    25277 QF         Quarter-Finals
#> 4    211501         208182  100743        2    25276 FR         First Round   
#> 5    211501         208182  100744        1    25276 FR         First Round   
#> 6    211501         208182  100748        3    25276 FR         First Round   
#> 7    211501         208182  100797        1    25285 SR         Second Round  
#> 8    211501         208182  100806        2    25285 SR         Second Round  
#> # ℹ 32 more variables: team_id <int>, team_name <chr>, team_code <chr>,
#> #   team_organisation_id <int>, versus_team_id <int>, versus_team_name <chr>,
#> #   versus_team_code <chr>, versus_team_organisation_id <int>,
#> #   play_duration_in_seconds <int>, points <int>, field_goals_made <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   two_points_made <int>, two_points_attempted <int>,
#> #   two_points_percentage <dbl>, three_points_made <int>, …
# }
```
