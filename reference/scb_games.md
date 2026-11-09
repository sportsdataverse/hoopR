# **Get BBL / DBBL Games**

Games of a season (the whole season in one page): teams, score by
period, officials, venue and top scorer.

Endpoint: `GET https://api.basketball-bundesliga.de/games` (DBBL: the
same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_games(
  league = "bbl",
  season = NULL,
  competition = NULL,
  game_type = NULL,
  team_id = NULL,
  page_size = 500
)
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- season:

  (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent
  to the API as its START-year seasonId (season - 1). Omitted = the
  season in progress.

- competition:

  (default `NULL`) Competition filter: BBL, BBL_CUP (Pokal), ALLSTAR,
  CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host.
  Omitted = all. The other host's competition answers an empty page.

- game_type:

  (default `NULL`) Finished, scheduled or all games. Omitted = all.

- team_id:

  (default `NULL`) Only the games of this team, home or guest (the club
  id equals the season-team id).

- page_size:

  (default `500`) Rows per page. The wrapper reads page 1 and refuses a
  result that needs more pages, so keep it large enough for the whole
  result (500 covers a season).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_games")`) and in the searchable
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
  try(scb_games())
#> ── BBL/DBBL Games from the SCB API ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:16:22 UTC
#> # A tibble: 325 × 89
#>    league season season_id game_id competition stage       status scheduled_time
#>    <chr>   <int>     <int> <chr>   <chr>       <chr>       <chr>  <chr>         
#>  1 bbl      2027      2026 2006720 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-10T16…
#>  2 bbl      2027      2026 2006724 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-10T18…
#>  3 bbl      2027      2026 2006728 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-11T18…
#>  4 bbl      2027      2026 2006722 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-12T16…
#>  5 bbl      2027      2026 2006721 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-12T18…
#>  6 bbl      2027      2026 2006723 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T13…
#>  7 bbl      2027      2026 2006727 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T14…
#>  8 bbl      2027      2026 2006725 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T16…
#>  9 bbl      2027      2026 2006920 BBL         MAIN_ROUND  OFFIC… 2026-09-18T18…
#> 10 bbl      2027      2026 2006923 BBL         MAIN_ROUND  OFFIC… 2026-09-19T16…
#> # ℹ 315 more rows
#> # ℹ 81 more variables: match_day <int>, is_tbd <lgl>, is_hidden <lgl>,
#> #   home_team_id <chr>, home_season_team_id <chr>, home_team_name <chr>,
#> #   home_tlc <chr>, home_is_foreign <lgl>, home_rank <int>, home_streak <chr>,
#> #   home_streak_count <int>, home_last10_victories <int>,
#> #   home_last10_losses <int>, home_total_games <int>, guest_team_id <chr>,
#> #   guest_season_team_id <chr>, guest_team_name <chr>, guest_tlc <chr>, …
# }
```
