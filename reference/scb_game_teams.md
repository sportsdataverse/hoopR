# **Get BBL / DBBL Game Team Box Score**

Box score of a finished game: one row per team, with the head coach and
the team line.

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_teams(game_id, league = "bbl")
```

## Arguments

- game_id:

  (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or
  10130 (DBBL). One sequence per league.

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_game_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(scb_game_teams(game_id = "2006920"))
#> ── BBL/DBBL Game Team Box Score from the SCB API ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:58:40 UTC
#> # A tibble: 2 × 63
#>   league game_id season side  team_id head_coach_name status   scheduled_time   
#>   <chr>  <chr>    <int> <chr> <chr>   <chr>           <chr>    <chr>            
#> 1 bbl    2006920   2027 home  413     Pedro Calles    OFFICIAL 2026-09-18T18:00…
#> 2 bbl    2006920   2027 guest 485     Rodrigo Pastore OFFICIAL 2026-09-18T18:00…
#> # ℹ 55 more variables: season_team_id <chr>, season_id <int>, team_name <chr>,
#> #   team_tlc <chr>, competition <chr>, stage <chr>, seconds_played <int>,
#> #   points <int>, two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, three_point_shot_success_percent <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_success_percent <dbl>, free_throws_made <int>, …
# }
```
