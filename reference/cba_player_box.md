# **Get CBA Player Box**

Player box score of a finished game, both sides, plus a team
rebounds/turnovers row per side (null player_id).

Endpoint:
`POST https://data-server.cbaleague.com/api/player-match-datas/data-count`
(JSON body)

## Usage

``` r
cba_player_box(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per player and a team rebounds/turnovers
row per side (null player_id). An empty valid answer is a zero-row
tibble with these columns, in this order (sportsdataverse-py
`cba_player_box`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| assists | integer | Assists in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| blocked | integer | Blocks in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| cn_alias | character | Player name (Chinese). The team row reads 'team rebounds / turnovers' (rebounds and turnovers not credited to a player; that row does not exist in the 2009-10 sample). |
| field_goals | integer | Field goals made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| field_goals_attempted | integer | Field goals attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| field_goals_percentage | double | Field-goal percentage as a FRACTION 0-1 (0.308), null when no attempt (0/0) as well as on the team row. |
| fouls | integer | Personal fouls in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws | integer | Free throws made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws_attempted | integer | Free throws attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws_percentage | double | Free-throw percentage as a FRACTION 0-1, null on the team row. |
| game_start | integer | Starter flag: 1 = started the game. Null on the team row. |
| number | character | Jersey number as a string. Null on the team row. |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. Null on the team row. |
| plus_minus | integer | Plus-minus while on court. Null on the team row and on every row of the 2009-10 sample (not tracked then). |
| points | integer | Points in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| rebounds | integer | Total rebounds in this game (integer). The team row carries the team's own total here. |
| rebounds_defensive | integer | Defensive rebounds in this game (integer). The team row carries the team's own total here. |
| rebounds_offensive | integer | Offensive rebounds in this game (integer). The team row carries the team's own total here. |
| steals | integer | Steals in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| three_point_attempted | integer | Three-pointers attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| three_point_goals | integer | Three-pointers made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| three_point_percentage | double | Three-point percentage as a FRACTION 0-1, null on the team row. |
| turnovers | integer | Turnovers in this game (integer). The team row carries the team's own total here. |
| up_time | integer | Time on court in SECONDS (1692 = 28:12). Null on the team row. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

Other CBA Functions:
[`cba_best_player()`](https://hoopR.sportsdataverse.org/reference/cba_best_player.md),
[`cba_best_stats()`](https://hoopR.sportsdataverse.org/reference/cba_best_stats.md),
[`cba_game_info()`](https://hoopR.sportsdataverse.org/reference/cba_game_info.md),
[`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md),
[`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md),
[`cba_match_types()`](https://hoopR.sportsdataverse.org/reference/cba_match_types.md),
[`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md),
[`cba_period_scores()`](https://hoopR.sportsdataverse.org/reference/cba_period_scores.md),
[`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md),
[`cba_player_base()`](https://hoopR.sportsdataverse.org/reference/cba_player_base.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
[`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md),
[`cba_schedule_day()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_day.md),
[`cba_schedule_month()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_month.md),
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md),
[`cba_team_basic()`](https://hoopR.sportsdataverse.org/reference/cba_team_basic.md),
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)

## Examples

``` r
# \donttest{
  try(cba_player_box(schedule_id = 100105799))
#> ── CBA Player Box from data-server.cbaleague.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:38:42 UTC
#> # A tibble: 26 × 26
#>    schedule_id side  assists blocked cn_alias field_goals field_goals_attempted
#>          <int> <chr>   <int>   <int> <chr>          <int>                 <int>
#>  1   100105799 home        4       2 朱俊龙             3                     5
#>  2   100105799 home        2       0 胡金秋             6                    10
#>  3   100105799 home        3       0 布朗               4                    13
#>  4   100105799 home        3       0 孙铭徽             2                     5
#>  5   100105799 home        2       0 卡尔顿             3                     5
#>  6   100105799 home        3       1 林秉圣             3                     5
#>  7   100105799 home        1       1 桑普森             3                     5
#>  8   100105799 home        2       1 塔克               4                    11
#>  9   100105799 home        1       0 赵嘉仁             0                     2
#> 10   100105799 home        1       0 吴骁               0                     0
#> # ℹ 16 more rows
#> # ℹ 19 more variables: field_goals_percentage <dbl>, fouls <int>,
#> #   free_throws <int>, free_throws_attempted <int>,
#> #   free_throws_percentage <dbl>, game_start <int>, number <chr>,
#> #   player_id <int>, plus_minus <int>, points <int>, rebounds <int>,
#> #   rebounds_defensive <int>, rebounds_offensive <int>, steals <int>,
#> #   three_point_attempted <int>, three_point_goals <int>, …
# }
```
