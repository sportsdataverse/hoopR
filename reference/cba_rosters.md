# **Get CBA Rosters**

Registered rosters of both sides with player bio fields (the season
registration, not the game box).

Endpoint:
`GET https://data-server.cbaleague.com/api/schedules/getPlayersByScheduleId/{schedule_id}`

## Usage

``` r
cba_rosters(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per registered player (season
registration, not the game box). An empty valid answer is a zero-row
tibble with these columns, in this order (sdv-py `cba_rosters`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| age | integer | Age in years as registered (0 on every sampled row: not maintained). |
| birth_date | character | Date of birth 'YYYY-MM-DD'. A public player bio field of the roster (kept; officials' and coaches' dates would be redacted by the capture). |
| body_data | character | JSON string of physical-testing results as the league stores it (wingspan, standing reach, vertical reach, hand size); null where not tested. |
| cn_alias | character | Player short name (Chinese). |
| cn_alias_show | character | Display name (Chinese); '—' for a placeholder row. |
| cn_name | character | Player full name (Chinese; may include a first-name form for foreigners). |
| created_date | character | Audit field: row creation time 'YYYY-MM-DD HH:MM:SS'. |
| first_name | character | Given name in Latin letters as registered, in capitals (e.g. 'CAI S.L.S.'). |
| height | integer | Height in cm (integer). |
| id | character | Internal row id of the (player, team, season) registration, a 19-digit integer beyond 2^53: read it as a string/int64, never as a JS number. Not the playerId. |
| is_captain | logical | Team captain flag (false on every sampled row). |
| is_delete | logical | Soft-delete flag (false on every sampled row). |
| is_injury | logical | Injury flag (false on every sampled row). |
| is_three | integer | Flag, 2 on every sampled row; meaning unverified. |
| last_modified_date | character | Audit field: last modification time; null on rows never modified. |
| last_name | character | Family name in Latin letters; ” when none, and null on some older rows. |
| match_type_id | integer | Match type id (1 = regular season) of the registration. |
| nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
| number | character | Jersey number as a string. |
| player_cba_id | integer | A registration id from the league's own system (e.g. 502672); 0 when unset (27 of 101 sampled rows). Not the playerId (unverified beyond that). |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
| player_pic | character | Absolute URL of the player's photo; null when there is none. |
| position | character | Position code as registered: SG, SF, PG, PF, C and their '/' pairs, or the coarse G (guard) / F (forward) on older rows (see positionDescription). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| position_description | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| position_string | character | Unobserved: null in every sample. |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| season_id | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. Same value as season. |
| season_name | character | Unobserved: null in every sample. |
| season_year | character | Unobserved: null in every sample. |
| team_cba_id | integer | teamId again as an integer (29128); meaning unverified beyond equalling team_id in the sample. |
| team_cn_alias | character | Team short name (Chinese) in that season. |
| team_cn_name | character | Team full legal name (Chinese), e.g. 'Zhejiang Guangsha Lions Club Zheshang Securities basketball team'. |
| team_en_alias | character | Team code or English city name as registered: a three-letter code on recent rows ('ZGL', 'SBW'), an English city name on older ones ('Guangdong', 'Sichuan'), ” when none. |
| team_en_name | character | Team English name as the league registers it (the sample reads 'GUANG SHA'). |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| weight | integer | Weight in kg (integer). |

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
  `id` of `cba_rosters()` is a 19-digit integer that an R integer or
  double cannot hold exactly, so it is kept as its exact digits
  (character).

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
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
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
  try(cba_rosters(schedule_id = 100105799))
#> ── CBA Rosters from data-server.cbaleague.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:35:17 UTC
#> # A tibble: 32 × 38
#>    schedule_id side    age birth_date body_data   cn_alias cn_alias_show cn_name
#>          <int> <chr> <int> <chr>      <chr>       <chr>    <chr>         <chr>  
#>  1   100105799 home      0 2006-01-24 "{\"cNName… 蔡束林森 蔡束林森      蔡束林森……
#>  2   100105799 home      0 2006-02-07 "{\"cNName… 崔新泉   ---           崔新泉 
#>  3   100105799 home      0 2006-12-23 "{\"cNName… 侯孟泽   侯孟泽        侯孟泽 
#>  4   100105799 home      0 1997-09-24 "{\"cNName… 胡金秋   胡金秋        胡金秋 
#>  5   100105799 home      0 1997-04-16 "{\"cNName… 李金效   李金效        李金效 
#>  6   100105799 home      0 2006-03-21 "{\"cNName… 连宇     --            连宇   
#>  7   100105799 home      0 1996-04-26 "{\"cNName… 孙铭徽   孙铭徽        孙铭徽 
#>  8   100105799 home      0 2003-06-06 "{\"cNName… 王欣瑞   王欣瑞        王欣瑞 
#>  9   100105799 home      0 1999-06-02 "{\"cNName… 吴骁     吴骁          吴骁   
#> 10   100105799 home      0 2004-03-19 "{\"cNName… 续峻玮   续峻玮        续峻玮 
#> # ℹ 22 more rows
#> # ℹ 30 more variables: created_date <chr>, first_name <chr>, height <int>,
#> #   id <chr>, is_captain <lgl>, is_delete <lgl>, is_injury <lgl>,
#> #   is_three <int>, last_modified_date <chr>, last_name <chr>,
#> #   match_type_id <int>, nationality <chr>, number <chr>, player_cba_id <int>,
#> #   player_id <int>, player_pic <chr>, position <chr>,
#> #   position_description <chr>, position_string <chr>, season <int>, …
# }
```
