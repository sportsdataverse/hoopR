# **Get TPBL Games**

Every game of one season, all divisions, played and scheduled, with
teams, venue, status and score.

Endpoint: `GET https://api.tpbl.basketball/api/seasons/{season}/games`

## Usage

``` r
tpbl_games(season, team_id = NULL, verify = NULL)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season; 2025 is the
  first). The API keys a season by its own small integer (1, 2, 3 =
  2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the
  same number): the runtime reads /seasons once and sends that id, so
  the example URL shows the year. A year the list lacks raises
  `hoopR_no_data`.

- team_id:

  TPBL team id (2-8): keep only that team's games (the API's own
  filter). Cannot be combined with `verify`. Default `NULL`: every team.

- verify:

  Default `NULL` (off). Cross-check the list for completeness: every
  division's completed games must equal the matches of its own standings
  (one extra request per division; a division whose standings are empty
  is checked against the team-filtered lists instead). A mismatch raises
  `hoopR_asset_fetch`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_games")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tpbl_games(season = 2026))
#> ── TPBL Games from api.tpbl.basketball ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:59:50 UTC
#> # A tibble: 150 × 34
#>    season season_id game_id gohoops_game_id division_id gohoops_division_id
#>     <int>     <int>   <int>           <int>       <int>               <int>
#>  1   2026         2    1371            8062           9                 358
#>  2   2026         2    1372            8063           9                 358
#>  3   2026         2    1373            8064           9                 358
#>  4   2026         2    1374            8065           9                 358
#>  5   2026         2    1375            8066           9                 358
#>  6   2026         2    1376            8067           9                 358
#>  7   2026         2    1377            8068           9                 358
#>  8   2026         2    1378            8069           9                 358
#>  9   2026         2    1379            8070           9                 358
#> 10   2026         2    1380            8071           9                 358
#> # ℹ 140 more rows
#> # ℹ 28 more variables: gohoops_season_id <int>, gohoops_event_id <int>,
#> #   code <chr>, status <chr>, is_live <lgl>, periods <int>, game_date <date>,
#> #   game_day_of_week <chr>, game_time <chr>, tipoff <dttm>, venue <chr>,
#> #   attendance <int>, home_team_id <int>, home_gohoops_team_id <int>,
#> #   home_gohoops_squad_id <int>, home_team <chr>, home_alt_name <chr>,
#> #   home_score <int>, away_team_id <int>, away_gohoops_team_id <int>, …
# }
```
