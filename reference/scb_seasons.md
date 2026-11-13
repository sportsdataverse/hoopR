# **Get BBL / DBBL Seasons**

Seasons, newest first, with the active flag (BBL back to 1966, DBBL 2024
on).

Endpoint: `GET https://api.basketball-bundesliga.de/seasons` (DBBL: the
same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_seasons(league = "bbl")
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_seasons")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Unofficial use of a public source: these wrappers read the front-end
  API of the German Bundesliga sites (easycredit-bbl.de,
  toyota-dbbl.de), run by SCB.

- Legal notice: the BBL Impressum forbids storing BBL content
  (`Inhalte`) in an information system without BBL's written permission.
  That is a copyright term, not a robots rule (the API host has no
  robots.txt). Check it before you store or republish the data, and keep
  requests slow (the runtime waits at least 1 s per host). The DBBL host
  is the same operator and API.

- Both hosts need two headers: a constant `x-api-key` and an
  `x-api-secret` that rotates. The runtime derives the secret on first
  use from the key embedded in an easycredit-bbl.de page (reversed, `:`
  turned into `-`) and never logs or returns it. The derivation was
  reverse-engineered from observed requests and responses and has not
  been checked against the site's own front-end code; if the site
  changes how it signs requests, every call fails with
  `hoopR_asset_fetch`.

- Id key spaces: seasonId is the START year (2025 = 2025-26), so a
  wrapper's END-year `season` is sent as `season - 1`. Teams are keyed
  by teamId (seasonTeamId equals it in every sample). seasonPlayerId is
  per player per season and per club (a player traded mid-season has
  two); realPlayerId is the person. playerId is ambiguous (the
  seasonPlayerId in box scores, records and /season-players; the person
  in /transfers). Game ids are strings.

- Errors are classed conditions: `hoopR_no_data` (404, 204, a 400 "not a
  valid" id, no rows, a box score of a game not yet started),
  `hoopR_bad_request` (a bad argument, another 400 / 422) and
  `hoopR_asset_fetch` (a refused secret after one re-derive, any other
  non-2xx, an HTML / non-JSON / error-shaped body, a truncated page, a
  body for another game, season, club or league, a box score still in
  play), all inheriting `hoopR_error`. Wrappers raise; they never return
  an empty frame.

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(scb_seasons())
#> ── BBL/DBBL Seasons from the SCB API ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:54:39 UTC
#> # A tibble: 61 × 4
#>    league season season_id is_active
#>    <chr>   <int>     <int> <lgl>    
#>  1 bbl      2027      2026 TRUE     
#>  2 bbl      2026      2025 FALSE    
#>  3 bbl      2025      2024 FALSE    
#>  4 bbl      2024      2023 FALSE    
#>  5 bbl      2023      2022 FALSE    
#>  6 bbl      2022      2021 FALSE    
#>  7 bbl      2021      2020 FALSE    
#>  8 bbl      2020      2019 FALSE    
#>  9 bbl      2019      2018 FALSE    
#> 10 bbl      2018      2017 FALSE    
#> # ℹ 51 more rows
# }
```
