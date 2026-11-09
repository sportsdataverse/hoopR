# **Get BBL / DBBL Season Players**

Every player registered in a season: the id crosswalk (season_player_id,
real_player_id, season_team_id).

Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_season_players(season, league = "bbl")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26, the sdv key). Sent to the
  API as its START-year seasonId (season - 1).

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: Every player registered in a season: the id
crosswalk (season_player_id, real_player_id, season_team_id). An empty
valid answer raises `hoopR_no_data`; the columns are always these, in
this order (sportsdataverse-py `scb_season_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |

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
  try(scb_season_players(season = 2026))
#> ── BBL/DBBL Season Players from the SCB API ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:08:49 UTC
#> # A tibble: 376 × 8
#>    league season season_id season_player_id real_player_id season_team_id
#>    <chr>   <int>     <int> <chr>                     <int> <chr>         
#>  1 bbl      2026      2025 5595                  140178151 483           
#>  2 bbl      2026      2025 6158                  140178148 414           
#>  3 bbl      2026      2025 6606                  140178978 483           
#>  4 bbl      2026      2025 6638                      39486 426           
#>  5 bbl      2026      2025 6640                      22679 426           
#>  6 bbl      2026      2025 6732                      30631 414           
#>  7 bbl      2026      2025 6735                  140179138 414           
#>  8 bbl      2026      2025 6736                      44893 414           
#>  9 bbl      2026      2025 6749                  140180109 414           
#> 10 bbl      2026      2025 56377                     42293 413           
#> # ℹ 366 more rows
#> # ℹ 2 more variables: first_name <chr>, last_name <chr>
# }
```
