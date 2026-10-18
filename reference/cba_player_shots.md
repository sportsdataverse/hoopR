# **Get CBA Player Shots**

Season player shot-zone profile (one page).

Endpoint: `POST https://data-server.cbaleague.com/api/player-shoot-list`
(JSON body)

## Usage

``` r
cba_player_shots(
  season,
  match_type_id = 1,
  count_ranger = 1,
  player_ranger = 1,
  team_id = NULL,
  sort = 3,
  rank = 1,
  page_number = 1,
  page_size = 100
)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- count_ranger:

  (default `1`) How counting statistics scale: 1 per game (default), 2
  season total, 3 per 36 minutes, 4 per 100 possessions.

- player_ranger:

  (default `1`) Which players: 1 all (default), 2 domestic (Chinese)
  only, 4 foreign only.

- team_id:

  (optional) Optional CBA team id (clubs, stable across seasons and
  renames) to list one team's players.

- sort:

  (default `3`) Sort column code the site sends (3 is the default
  order); the API answers an empty body without it.

- rank:

  (default `1`) Sort direction code the site sends (1 default); the API
  answers an empty body without it.

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble: One row per player of the requested page. An
empty valid answer is a zero-row tibble with these columns, in this
order (sdv-py `cba_player_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| age | integer | Age in years in that season. |
| at_rim_made_rate | numeric | at-rim frequency: restricted-area attempts per 100 possessions. A number (the API sends it as display text). |
| at_rim_made_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: at-rim frequency: restricted-area attempts per 100 possessions. |
| at_rim_made_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: at-rim frequency: restricted-area attempts per 100 possessions. |
| first_position | character | Primary position label (Chinese; see position for the label set). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| free_rate | numeric | free-throw frequency: free-throw attempts per 100 possessions (site definition). A number (the API sends it as display text). |
| free_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: free-throw frequency: free-throw attempts per 100 possessions (site definition). |
| free_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: free-throw frequency: free-throw attempts per 100 possessions (site definition). |
| hit_at_rim_made_rate | numeric | at-rim shooting percentage: restricted-area field-goal percentage (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| hit_at_rim_made_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: at-rim shooting percentage: restricted-area field-goal percentage (site definition). |
| hit_at_rim_made_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: at-rim shooting percentage: restricted-area field-goal percentage (site definition). |
| hit_free_rate | numeric | free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| hit_free_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: free-throw percentage. |
| hit_free_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: free-throw percentage. |
| hit_middle_rate | numeric | mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| hit_middle_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). |
| hit_middle_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). |
| hit_rate | numeric | effective field-goal percentage: all field-goal attempts converted to two-point attempts. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| hit_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: effective field-goal percentage: all field-goal attempts converted to two-point attempts. |
| hit_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: effective field-goal percentage: all field-goal attempts converted to two-point attempts. |
| hit_three_rate | numeric | three-point shooting percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| hit_three_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: three-point shooting percentage. |
| hit_three_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: three-point shooting percentage. |
| is_color | integer | Highlight flag, 1 or 2 (unverified meaning; the site uses it to colour the row). |
| middle_rate | numeric | mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). A number (the API sends it as display text). |
| middle_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). |
| middle_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). |
| minutes | integer | Minutes played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
| nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
| number | character | Jersey number as a string. |
| play_times | integer | Games played (Chinese text), integer. |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
| player_name | character | Player name (Chinese). |
| position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| position_num | numeric | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
| rank | character | Unobserved: null in every sample (a row-rank slot; the site numbers rows itself). |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| seconds | integer | Seconds played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
| team_cn_alias | character | Team short name (Chinese) in that season. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| three_rate | numeric | three-point frequency: three-point attempts per 100 possessions (site definition). A number (the API sends it as display text). |
| three_rate_rank | numeric | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: three-point frequency: three-point attempts per 100 possessions (site definition). |
| three_rate_sort | numeric | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: three-point frequency: three-point attempts per 100 possessions (site definition). |

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

     cba_player_shots(season = 2026, team_id = 29128)

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
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
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
