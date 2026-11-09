# **Get BBL / DBBL Game Player Box Score**

Box score of a finished game: one row per player line of both teams
(2002-03 on).

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_players(game_id, league = "bbl")
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

A `hoopR_data` tibble with one row per player line of both teams. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_game_players")`) and in the
searchable [return
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
  try(scb_game_players(game_id = "2006920"))
#> ── BBL/DBBL Game Player Box Score from the SCB API ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:57:07 UTC
#> # A tibble: 23 × 45
#>    league game_id season side  team_id season_player_id real_player_id
#>    <chr>  <chr>    <int> <chr> <chr>   <chr>                     <int>
#>  1 bbl    2006920   2027 home  413     56414                     37539
#>  2 bbl    2006920   2027 home  413     2001679                   40635
#>  3 bbl    2006920   2027 home  413     56377                     42293
#>  4 bbl    2006920   2027 home  413     1000868                   42321
#>  5 bbl    2006920   2027 home  413     2004104                   45523
#>  6 bbl    2006920   2027 home  413     2004358                   51576
#>  7 bbl    2006920   2027 home  413     2001680                   56949
#>  8 bbl    2006920   2027 home  413     57252                     57252
#>  9 bbl    2006920   2027 home  413     2002150               140180627
#> 10 bbl    2006920   2027 home  413     2004102               140181547
#> # ℹ 13 more rows
#> # ℹ 38 more variables: first_name <chr>, last_name <chr>, shirt_number <chr>,
#> #   position <chr>, season_team_id <chr>, team_name <chr>, team_tlc <chr>,
#> #   season_id <int>, seconds_played <int>, points <int>,
#> #   two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, …
# }
```
