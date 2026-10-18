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
tibble with these columns, in this order (sdv-py `cba_player_box`):

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
| field_goals_percentage | numeric | Field-goal percentage as a FRACTION 0-1 (0.308), null when no attempt (0/0) as well as on the team row. |
| fouls | integer | Personal fouls in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws | integer | Free throws made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws_attempted | integer | Free throws attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
| free_throws_percentage | numeric | Free-throw percentage as a FRACTION 0-1, null on the team row. |
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
| three_point_percentage | numeric | Three-point percentage as a FRACTION 0-1, null on the team row. |
| turnovers | integer | Turnovers in this game (integer). The team row carries the team's own total here. |
| up_time | integer | Time on court in SECONDS (1692 = 28:12). Null on the team row. |

## Details

- Unofficial and unsupported: these wrappers read the routes that
  cbaleague.com's own data site (a Vue single-page app) calls.
  SportsDataverse has not ruled on the site's terms, so payloads are not
  redistributed as release assets. Requests are spaced at least 1 s
  apart per host; keep use small.

- Access: every response body is AES-128-ECB encrypted with a public key
  shipped in the site's front-end bundle; the runtime decrypts it with
  [`digest::AES()`](https://eddelbuettel.github.io/digest/man/AES.html)
  (digest is a suggested package: install it to use these wrappers) and
  refuses anything that does not decrypt. The host blocks datacenter IPs
  at TCP: set the environment variable `CBA_PROXY` (or
  `options(hoopR.proxy = ...)`) to a residential proxy URL; it is never
  printed or put in a condition. Without a proxy the request goes direct
  and, from a datacenter, fails within seconds (a 5 s connect timeout,
  no retry of a refused or timed-out connect). Where direct access works
  (a residential IP), set `CBA_DIRECT=1` for the full 60 s timeout and
  retries.

- Seasons: the API's season is the START year; every `season` argument
  here is the END year (2026 = 2025-26) and is sent as `season - 1`.
  Columns named `season` keep the wire value (the START year, so the sdv
  END year is `season + 1`). The season list reaches 1995-96; box data
  before 2009-10 is unverified.

- Coverage: game wrappers serve FINISHED games only. Each first reads
  the game report header (cached per session), and an unfinished game
  raises `hoopR_asset_fetch`. Box, period, roster and best-player bodies
  are checked against that header (points sum to the score, team ids
  match, advanced rows are box players). Play-by-play is served one
  period per request: every period is fetched, and a partial set, an
  unordered clock or a final score the plays do not reach is refused.
  Play-by-play is verified on 2017-18 and 2025-26 only and is absent for
  2009-10 (`hoopR_no_data`). There are NO shot x/y coordinates in this
  API (shot location exists only as team and player zone splits), and
  play-by-play has no player or team ids (Chinese sentence text plus
  surnames). Box data has 12-minute quarters in 2009-10 and 2017-18 and
  10-minute quarters in 2025-26. The women's CBA is not covered (no
  official source).

- Not game data:
  [`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md)
  and
  [`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md)
  answer the two teams' SEASON tables (the shot zones are the teams'
  current profile; the four factors are the previous season), whichever
  game is asked for. The reference lists
  ([`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
  [`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md))
  and
  [`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md)
  are not echoed by the API, so their scope is unchecked.

- Duplicate rows: in some games (2025-26 game 100105799) the
  advanced-box and extras routes repeat player rows (26 rows for 12
  players), and the repeats are not always copies.
  [`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md)
  and
  [`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md)
  keep the FIRST row per `player_id`.

- Text fields are Chinese (names, play-by-play sentences, position and
  nationality labels). The column descriptions here are ASCII; sdv-py's
  `tools/codegen/notes/cba_glossary.yaml` holds the full English
  glossaries.

- Personal data: the operator ids (`createdBy` / `lastModifiedBy`, one
  holds a mobile number) and any bare mobile-number string are removed
  from every body. Players' public bio fields (birth date, height,
  weight) are kept.

- Ids: `schedule_id` (games, one global 9-digit sequence 100xxxxxx),
  `team_id` (clubs, stable across sponsor renames), `player_id`
  (persons) and `match_type_id` are integers. The roster registration
  `id` of
  [`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md)
  is a 19-digit integer that an R integer or double cannot hold exactly,
  so it is kept as its exact digits (character).

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, a game
  without play-by-play), `hoopR_bad_request` (a non-integer id or
  season, HTTP 400 / 422) and `hoopR_asset_fetch` (any other non-200,
  including HTTP 500, which this API answers for a body it dislikes and
  which is not retried; a dead connection; an empty or undecryptable
  body; an unfinished game; a body for another game, team, season or
  day), all inheriting `hoopR_error`. HTTP 429 / 502 / 503 / 504 are
  retried, up to three attempts. Wrappers raise; they never warn and
  return empty.

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
#> ℹ Data updated: 2026-10-18 19:24:33 UTC
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
