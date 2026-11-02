# **FEB Play-by-Play**

**Play-by-play of one FEB game (KeyFacts): every shot, rebound, foul,
substitution and timeout, in Spanish text with coded actions, oldest
play first.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/KeyFacts/{game_id}`

A body whose plays name another game is refused (`hoopR_asset_fetch`),
not returned. 2020-21 games are text only: `action`, the ids, the
parameters, the position and the log times are `NA` there.

## Usage

``` r
feb_pbp(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| play_num | integer | Play sequence number, 1 = the first play of the game; unique per game. The parser sorts by it (the feed lists newest first). |
| period | integer | Period number of the play. |
| clock | character | Game clock REMAINING in the period as 'mm:ss' (it counts down from 10:00). |
| clock_seconds | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
| team_side | character | Side of the acting team: home (feed code 1) or away (2); null on period lines. |
| team_id | integer | Team-season id of the acting team (new every season); null on period lines and 2020-21 games. |
| player_id | integer | FEB person id of the actor (stable across seasons); null on team, period and 2020-21 lines. |
| license_id | integer | Per-season player licence id of the actor (changes when the player re-registers; A. Jorda Rodriguez = 10901171 in 2025-26, 11266668 in 2026-27). Null on team and period lines and 2020-21 games. |
| action | character | Action code: shoot, fthrow, rebound, assist, recovery (steal), lose (turnover), blockshot, foul, subst, timeout, period. Null on 2020-21 games. |
| text | character | Play description in Spanish: '(TEAM) I. SURNAME: ACTION (running count)'; 2020-21 games use older wording and are text only. |
| score_home | integer | Home score AFTER the play; filled on scoring plays only. |
| score_away | integer | Away score AFTER the play; filled on scoring plays only. |
| x | double | Court x position of a shoot line: percent (0-100) of the length of a horizontal full-court image, origin top-left (the same scale as feb_shots). Null when the action has none and on 2020-21 games. |
| y | double | Court y position of a shoot line: percent (0-100) of the width from the top edge (the same scale as feb_shots). Null when the action has none and on 2020-21 games. |
| log_param1 | character | Action parameter 1 (string). Team and player actions: a pseudo-GUID '00000000-0000-000{side}-0000-{game id, 12 digits}' (side 1 home, 2 away); period lines: the period number. |
| log_param2 | character | Action parameter 2 (string). The actor's licence id on shoot, fthrow, foul, rebound, assist, recovery and blockshot lines; period lines: '0' start, '1' end; lose: '0' or '1' (meaning unverified). |
| log_param3 | character | Action parameter 3 (string). fthrow: '1' made, '0' missed; subst: the outgoing player's licence; foul: a foul-type code. Others unverified. |
| log_param4 | character | Action parameter 4 (string). shoot and fthrow: '1' made, '0' missed; foul: the licence of the fouled player; lose: a licence (role unverified). |
| log_param5 | character | Action parameter 5 (string); action-dependent, meaning unverified. |
| log_param6 | character | Action parameter 6 (string). shoot: shot value '2' or '3'; fthrow: '1'; foul: free throws awarded. |
| log_param7 | character | Action parameter 7 (string); action-dependent, meaning unverified. |
| log_param8 | character | Action parameter 8 (string): a small integer on shoot, foul and lose lines (by distribution a zone or sub-type code); unverified. |
| log_param9 | character | Action parameter 9 (string); blank or null in every sampled game. |
| log_param10 | character | Action parameter 10 (string): '1' on almost every foul; meaning unverified. |
| log_time | POSIXct | Wall-clock time the play was logged, Spanish local time (POSIXct, tz Europe/Madrid). NA on 2020-21 games. |
| log_time_utc | POSIXct | The log time in UTC (POSIXct, tz UTC). NA on 2020-21 games. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_pbp(game_id = 2535725))
#> ── FEB pbp from intrafeb.feb.es ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:52:48 UTC
#> # A tibble: 570 × 27
#>    game_id play_num period clock clock_seconds team_side team_id player_id
#>      <int>    <int>  <int> <chr>         <int> <chr>       <int>     <int>
#>  1 2535725        1      1 10:00           600 home      1009716   1981843
#>  2 2535725        2      1 10:00           600 home      1009716   2500822
#>  3 2535725        3      1 10:00           600 away      1010207   2650859
#>  4 2535725        4      1 10:00           600 home      1009716   1371559
#>  5 2535725        5      1 10:00           600 away      1010207   2217440
#>  6 2535725        6      1 10:00           600 home      1009716   2813013
#>  7 2535725        7      1 10:00           600 home      1009716   2880241
#>  8 2535725        8      1 10:00           600 away      1010207   1890908
#>  9 2535725        9      1 10:00           600 away      1010207   2533871
#> 10 2535725       10      1 10:00           600 away      1010207   2640789
#> # ℹ 560 more rows
#> # ℹ 19 more variables: license_id <int>, action <chr>, text <chr>,
#> #   score_home <int>, score_away <int>, x <dbl>, y <dbl>, log_param1 <chr>,
#> #   log_param2 <chr>, log_param3 <chr>, log_param4 <chr>, log_param5 <chr>,
#> #   log_param6 <chr>, log_param7 <chr>, log_param8 <chr>, log_param9 <chr>,
#> #   log_param10 <chr>, log_time <dttm>, log_time_utc <dttm>
# }
```
