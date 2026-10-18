# **Get CBA Player Advanced**

Advanced player box of a finished game (usage, true shooting,
rebound/steal/block rates, zone splits), one row per player.

Endpoint:
`POST https://data-server.cbaleague.com/api/player-match-datas/advance-count`
(JSON body)

## Usage

``` r
cba_player_advanced(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per player (deduplicated on player_id,
first row kept). An empty valid answer is a zero-row tibble with these
columns, in this order (sdv-py `cba_player_advanced`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| assists_percentage | double | assist rate: the share of teammates' made field goals the player assisted while on the court. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| assists_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: assist rate: the share of teammates' made field goals the player assisted while on the court. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| assists_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: assist rate: the share of teammates' made field goals the player assisted while on the court. |
| blocked_percentage | double | block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| blocked_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| blocked_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). |
| cn_alias | character | Player name (Chinese). |
| field_goals_at_rim_percentage | character | At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| field_goals_at_rim_percentage_rank | character | Unobserved: null in every sample. When filled: colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. |
| field_goals_at_rim_percentage_sort | character | Unobserved: null in every sample. When filled: unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. |
| field_goals_mid_percentage | character | Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| field_goals_mid_percentage_rank | character | Unobserved: null in every sample. When filled: colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. |
| field_goals_mid_percentage_sort | character | Unobserved: null in every sample. When filled: unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. |
| game_start | integer | Starter flag: 1 = started the game. |
| is_color | integer | Highlight flag, 1 on every sampled row (unverified meaning; the site uses it to colour the row). |
| number | character | Jersey number as a string. |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
| player_times | integer | 0 on every sampled row; meaning unverified (a games-played slot the game route does not fill). |
| position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| rebounds_defensive_percentage | double | defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| rebounds_defensive_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| rebounds_defensive_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). |
| rebounds_offensive_percentage | double | offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| rebounds_offensive_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| rebounds_offensive_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). |
| steals_percentage | double | steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| steals_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| steals_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| true_shooting_percentage | double | true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| true_shooting_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| true_shooting_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. |
| turn_share | double | 'possession share': the share of the team's possessions the player ends while on the court. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| turn_share_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: 'possession share': the share of the team's possessions the player ends while on the court. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| turn_share_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: 'possession share': the share of the team's possessions the player ends while on the court. |
| turnovers_percentage | double | turnover rate: the share of the player's possession-ending plays that are turnovers. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| turnovers_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: turnover rate: the share of the player's possession-ending plays that are turnovers. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
| turnovers_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: turnover rate: the share of the player's possession-ending plays that are turnovers. |
| type | integer | Side flag: 0 on every home row, 1 on every visiting row (differs from best_quota, where the visiting side is 2). |
| up_time | integer | Time on court in SECONDS (1692 = 28:12). |

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
  `cba_player_advanced()` and
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

     cba_player_advanced(schedule_id = 100105799)

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
