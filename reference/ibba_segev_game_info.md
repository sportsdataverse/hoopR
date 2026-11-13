# **IBBA Segev Game Info**

**Game header: tip-off, competition, both teams and the game state
(scores are in the box score).**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`

## Usage

``` r
ibba_segev_game_info(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_segev_game_info")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

The `ibba_segev_*()` wrappers read Segev Stats, the live-stats vendor
behind basket.co.il's game pages
(`stats.segevstats.com/realtimestat_heb/api/`, a JSON-RPC API served as
text/html): the game header, rosters, box score, period scores and
play-by-play with shot coordinates, from 2025-26. They mirror
sportsdataverse-py's `ibba_segev_*` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per
sportsdataverse-py row.

**Unofficial and unsupported.** The API is keyless, unofficial and not
documented for outside use. Requests are spaced at least one second
apart per host (429 / 502 / 503 / 504 are retried three times, a 500 is
not); only finished games are read.

**Games and ids.** `game_id` is one flat Segev id space across seasons
AND competitions (men's Winner League, Winner Cup, women's, Leumit,
youth, school and pre-season games), so read `competition` from
`ibba_segev_game_info()`. There is no game list: league game ids come
from
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md)
`segev_game_id` (2025-26 on; see
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md)).
Segev team and player ids are stable across seasons (Jaylen Hoard =
player 1000 in games 50 and 419), unlike the IBBA season registrations,
and are not IBBA ids.

**Play-by-play.** Actions name the player by Segev id and by JERSEY
number, `score` reads away-home, and shot `x` / `y` are one half-court
frame (x 0-1470 across, basket near 735; y out from the baseline, rim
near 112-140); which sideline is x = 0 and the metric scale are
unverified. Segev renamed its team game stats between 2025-26 and
2026-27; the frames unify them. `start_time` is the scheduled tip-off in
Israel local time (POSIXct, tz Asia/Jerusalem; the feed carries no
offset).

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, "game not found", a finished game with no
actions), `hoopR_bad_request` (HTTP 400 / 422, or a `game_id` that is
not a positive integer) and `hoopR_asset_fetch` (any other failure:
another status, a transport error, an empty or non-JSON body, an error
or changed envelope, a body for another game, a game that is not final).
All inherit `hoopR_error`.

## See also

Other IBBA Segev Functions:
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_game_info(game_id = 50))
#> ── IBBA Segev game info ───────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:59:17 UTC
#> # A tibble: 1 × 15
#>   game_id start_time          competition home_team_id home_team home_team_local
#>     <int> <dttm>              <chr>              <int> <chr>     <chr>          
#> 1      50 2025-10-12 18:40:00 Winner Lea…           11 BEER SHE… "אלטשולר ב\"ש/…
#> # ℹ 9 more variables: home_short_name <chr>, away_team_id <int>,
#> #   away_team <chr>, away_team_local <chr>, away_short_name <chr>,
#> #   periods <int>, finished <lgl>, current_period <int>, clock <chr>
# }
```
