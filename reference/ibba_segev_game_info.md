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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
| start_time | POSIXct | Scheduled tip-off in Israel local time as a naive datetime (the feed has no offset; it can differ from the IBBA tip_off by minutes). |
| competition | character | Competition name ('Winner League', 'Winner Cup', 'Women', 'Leumit', 'Noar', 'School', 'Preparation Games'): the reliable men's / women's discriminator. |
| home_team_id | integer | Home Segev team id (key space: Segev teams, stable across seasons and competitions; Maccabi Tel Aviv = 2). Not an IBBA team-season id. |
| home_team | character | Home team name in English, upper case; some women's teams end in ' (W)', not all. |
| home_team_local | character | Home team name in Hebrew (Latin sponsor words kept). |
| home_short_name | character | Home team short name in English, upper case. |
| away_team_id | integer | Away Segev team id (key space: Segev teams, stable across seasons and competitions). |
| away_team | character | Away team name in English, upper case. |
| away_team_local | character | Away team name in Hebrew (Latin sponsor words kept). |
| away_short_name | character | Away team short name in English, upper case. |
| periods | integer | Regulation periods in the game (4). |
| finished | logical | True once the game is final (the wrappers read finished games only). |
| current_period | integer | Current period, the last one played for a finished game (5+ means overtime). |
| clock | character | Game clock remaining as 'mm:ss' ('00:00' for a finished game). |

## Details

The `ibba_segev_*()` wrappers read Segev Stats, the live-stats vendor
behind basket.co.il's game pages
(`stats.segevstats.com/realtimestat_heb/api/`, a JSON-RPC API served as
text/html): the game header, rosters, box score, period scores and
play-by-play with shot coordinates, from 2025-26. They mirror sdv-py's
`ibba_segev_*` wrappers of the same names: same arguments, the same
snake_case columns and types, one row per sdv-py row.

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
#> ℹ Data updated: 2026-10-31 20:13:43 UTC
#> # A tibble: 1 × 15
#>   game_id start_time          competition home_team_id home_team home_team_local
#>     <int> <dttm>              <chr>              <int> <chr>     <chr>          
#> 1      50 2025-10-12 18:40:00 Winner Lea…           11 BEER SHE… "אלטשולר ב\"ש/…
#> # ℹ 9 more variables: home_short_name <chr>, away_team_id <int>,
#> #   away_team <chr>, away_team_local <chr>, away_short_name <chr>,
#> #   periods <int>, finished <lgl>, current_period <int>, clock <chr>
# }
```
