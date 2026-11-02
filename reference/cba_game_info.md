# **Get CBA Game Info**

Game report header: both teams, score, tip-off time and colours.

Endpoint:
`GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/baseInfo/{schedule_id}`

## Usage

``` r
cba_game_info(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row: both teams, score, tip-off time and
colours. An empty valid answer is a zero-row tibble with these columns,
in this order (sportsdataverse-py `cba_game_info`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| count | integer | Unverified: an integer shown in the report header (83 in the 2025-26 sample, 99 in 2017-18). Not the play-by-play row count; plausibly possessions per team, which the bundle does not confirm. |
| guest_color | character | Visiting team colour as a '#RRGGBB' hex string. |
| guest_score | integer | Visiting team final points. |
| guest_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Visiting team. |
| guest_team_logo | character | Absolute URL of the visiting team logo. |
| guest_team_name | character | Visiting team name (Chinese) at the time of the game. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| host_color | character | Home team colour as a '#RRGGBB' hex string (the game report's theme colour). |
| host_score | integer | Home team final points. |
| host_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Home team. |
| host_team_logo | character | Absolute URL of the home team logo. |
| host_team_name | character | Home team name (Chinese) at the time of the game (e.g. in 2017-18). Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| schedule_time | character | Tip-off as 'YYYY-MM-DD HH:MM:SS' (China local time); equals schedules/day scheduleTime. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

Other CBA Functions:
[`cba_best_player()`](https://hoopR.sportsdataverse.org/reference/cba_best_player.md),
[`cba_best_stats()`](https://hoopR.sportsdataverse.org/reference/cba_best_stats.md),
[`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md),
[`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md),
[`cba_match_types()`](https://hoopR.sportsdataverse.org/reference/cba_match_types.md),
[`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md),
[`cba_period_scores()`](https://hoopR.sportsdataverse.org/reference/cba_period_scores.md),
[`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md),
[`cba_player_base()`](https://hoopR.sportsdataverse.org/reference/cba_player_base.md),
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
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
  try(cba_game_info(schedule_id = 100105799))
#> ── CBA Game Info from data-server.cbaleague.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:50:37 UTC
#> # A tibble: 1 × 13
#>   schedule_id count guest_color guest_score guest_team_id guest_team_logo       
#>         <int> <int> <chr>             <int>         <int> <chr>                 
#> 1   100105799    83 #7E040C              74         29132 https://image.cbaleag…
#> # ℹ 7 more variables: guest_team_name <chr>, host_color <chr>,
#> #   host_score <int>, host_team_id <int>, host_team_logo <chr>,
#> #   host_team_name <chr>, schedule_time <chr>
# }
```
