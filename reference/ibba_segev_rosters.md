# **IBBA Segev Rosters**

**Both teams' game rosters with Segev player ids and names in English
and Hebrew.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`

## Usage

``` r
ibba_segev_rosters(game_id)
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
| team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
| team_id | integer | Segev team id of the roster's side (stable across seasons). |
| player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
| jersey_number | integer | Jersey number as an integer. |
| first_name | character | First name in English, upper case. |
| last_name | character | Last name in English, upper case. |
| first_name_local | character | First name in Hebrew. |
| last_name_local | character | Last name in Hebrew. |
| in_roster | integer | Roster flag, 0 or 2 in the samples; meaning unverified. |
| api_id | integer | External player id as an integer: null or equal to the Segev player_id (both occur within one game); its source is unverified. |

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
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).
There is no game list: league game ids come from
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

Other IBBA Segev:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_rosters(game_id = 50))
#> ── IBBA Segev rosters ────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:41:16 UTC
#> # A tibble: 31 × 11
#>    game_id team_side team_id player_id jersey_number first_name last_name 
#>      <int> <chr>       <int>     <int>         <int> <chr>      <chr>     
#>  1      50 home           11      1120            93 CODY       DEMPS     
#>  2      50 home           11      1111             0 NAVE       BEN SHEMEN
#>  3      50 home           11      1215            55 MATAN      FOGEL     
#>  4      50 home           11      1117            22 SAM        IORIO     
#>  5      50 home           11      1114            14 NETA       SEGAL     
#>  6      50 home           11      1266             6 TARYN      TODD      
#>  7      50 home           11      1249            17 AMIT       GERSHON   
#>  8      50 home           11      1115            16 C.J.       ELLEBY    
#>  9      50 home           11      1112             4 AKILI      VINING    
#> 10      50 home           11      1118            24 YOAV       VITLEM    
#> # ℹ 21 more rows
#> # ℹ 4 more variables: first_name_local <chr>, last_name_local <chr>,
#> #   in_roster <int>, api_id <int>
# }
```
