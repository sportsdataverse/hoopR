# **IBBA Segev Play-by-Play**

**Play-by-play of a finished game: every action with shot coordinates,
running scores and jersey numbers.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getActions`

## Usage

``` r
ibba_segev_pbp(game_id)
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
| action_id | integer | Action id (key space: Segev actions; unique and increasing within one game, 500001 ... for game 50). |
| parent_action_id | integer | Id of the action this one follows from (rebound -\> missed shot, steal -\> turnover, assist or block -\> shot); null when none. |
| period | integer | Period number (1-4 regulation, 5+ overtime). |
| clock | character | Game clock remaining in the period as 'mm:ss', counting down from 10:00. |
| user_time_utc | character | Wall-clock time the scorer logged the action, 'HH:MM:SS', UTC (inferred: game 50 tipped at 18:40 Israel time and its first tick reads 15:42). |
| type | character | Action type: game, quarter, clock, substitution, shot, freeThrow, rebound, assist, steal, turnover, block, deflection, foul, foul-drawn or timeout. |
| subtype | character | Subtype by type: shot jump-shot / lay-up / dunk; rebound offensive / defensive; turnover bad-pass, ball-handling, travelling, ...; foul personal / technical / unsportsmanlike; start-of-game, end-of-quarter, ... |
| team_id | integer | Segev team id of the acting side (stable across seasons); null on game-level actions. |
| player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
| team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
| jersey | character | Jersey number (a string, not an id) of the acting player; null when none (team rebound, timeout). |
| score_away | integer | Away running score after a scoring action (the feed's score reads away-home); null otherwise. |
| score_home | integer | Home running score after a scoring action; null otherwise. |
| player_points | integer | The scorer's running points after a scoring action; null otherwise. |
| points | integer | Shot value, 2 or 3; null on other actions. |
| made | character | Shot or free-throw result: made, missed, or blocked (shots only). |
| x | double | Shot x: across the half court, sideline to sideline, 0-1470, basket near 735; which sideline is 0 and the metric scale are unverified. |
| y | double | Shot y: distance out from the baseline, rim near 112-140, deepest observed 1176; metric scale unverified. |
| fast_break | logical | True when the shot or free throw came on a fast break. |
| second_chance | logical | True when the attempt followed an offensive rebound. |
| points_from_turnover | logical | True when the attempt came off an opponent turnover. |
| free_throw_number | integer | Which free throw of the set (1, 2, 3). |
| free_throws_awarded | integer | Free throws in the set. |
| foul_kind | character | Foul kind, shooting or offensive; absent on some fouls. 'shooting' also appears on technical and offensive-unsportsmanlike fouls, so it does not prove a shooting foul. |
| fouled_on_jersey | character | Jersey number (string) of the fouled player. |
| foul_free_throws | integer | Free throws the foul awards (the feed sends a string when non-zero, 0 otherwise). |
| is_coach_foul | logical | True on a foul charged to the coach or bench (player_id null); null otherwise. |
| player_in_jersey | character | Substitution: jersey of the player coming in; null on the row that records the player going out. |
| player_out_jersey | character | Substitution: jersey of the player going out; null on the row that records the player coming in. |

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
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_pbp(game_id = 50))
#> ── IBBA Segev play-by-play ───────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:41:14 UTC
#> # A tibble: 768 × 30
#>    game_id action_id parent_action_id period clock user_time_utc type    subtype
#>      <int>     <int>            <int>  <int> <chr> <chr>         <chr>   <chr>  
#>  1      50    500001               NA      1 10:00 15:21:43      game    start-…
#>  2      50    500002               NA      1 10:00 15:29:07      quarter start-…
#>  3      50    500003               NA      1 10:00 15:29:51      substi… NA     
#>  4      50    500004               NA      1 10:00 15:29:52      substi… NA     
#>  5      50    500005               NA      1 10:00 15:29:53      substi… NA     
#>  6      50    500006               NA      1 10:00 15:29:57      substi… NA     
#>  7      50    500007               NA      1 10:00 15:29:58      substi… NA     
#>  8      50    500008               NA      1 10:00 15:31:26      substi… NA     
#>  9      50    500009               NA      1 10:00 15:31:28      substi… NA     
#> 10      50    500010               NA      1 10:00 15:31:30      substi… NA     
#> # ℹ 758 more rows
#> # ℹ 22 more variables: team_id <int>, player_id <int>, team_side <chr>,
#> #   jersey <chr>, score_away <int>, score_home <int>, player_points <int>,
#> #   points <int>, made <chr>, x <dbl>, y <dbl>, fast_break <lgl>,
#> #   second_chance <lgl>, points_from_turnover <lgl>, free_throw_number <int>,
#> #   free_throws_awarded <int>, foul_kind <chr>, fouled_on_jersey <chr>,
#> #   foul_free_throws <int>, is_coach_foul <lgl>, player_in_jersey <chr>, …
# }
```
