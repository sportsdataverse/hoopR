# **Get CBA Schedule Day**

The games of one day: ids, teams, status, score, round and the data
flags.

Endpoint: `GET https://data-server.cbaleague.com/api/schedules/day`

## Usage

``` r
cba_schedule_day(day)
```

## Arguments

- day:

  (required) Required. Date 'YYYY-MM-DD'. The runtime always sends
  auto=0 (the site's auto mode jumps to the next game day) and refuses
  rows on another date.

## Value

A `hoopR_data` tibble: One row per game: ids, teams, status, score,
round and the data flags. An empty valid answer is a zero-row tibble
with these columns, in this order (sdv-py `cba_schedule_day`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| home_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| home_team_logo | character | Absolute URL of the home team logo (300x300 png). |
| home_team_lose | integer | Home team's cumulative losses after this game. An integer (the API sends it as digit text). |
| home_team_name | character | Home team name (Chinese) as of the game's season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| home_team_score | integer | Home team final points (a game not yet played has no score; a scheduled 2026-27 game outside the samples showed null). |
| home_team_win | integer | Home team's cumulative wins after this game in the match type. An integer (the API sends it as digit text). |
| is_events | integer | Play-by-play flag: 1 = play-by-play exists (2017-18 and later in the samples), 2 = none (the 2009-10 sample answers empty pages). |
| is_report | integer | Game-report flag: 1 = a game report page exists (every sample). |
| match_order | integer | Sequence number of the game within its season and match type (1-based). |
| match_type_id | integer | Match type id (1 regular season, 2 playoffs, 3 preseason, 4 all-star, 9 relegation; see getMatchType). |
| minutes | integer | Regulation length of the game in minutes: 40 (4 x 10) in the 2025-26 sample, 48 (4 x 12) in the 2009-10 and 2017-18 samples. |
| quarter | integer | Number of periods played (4 = no overtime; 5 and up would be overtime periods). |
| round | integer | Round number within the match type (1-based). |
| round_desc | character | Unobserved: null in every sample, so no meaning is claimed beyond its name (round description). |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| schedule_num | integer | Unobserved: null in every sample on this route (the game count is filled on schedules/month). Typed Int64 like the family's other routes. |
| schedule_time | character | Tip-off as 'YYYY-MM-DD HH:MM:SS' (China local time, no zone). |
| schedule_type_name | character | Round label (Chinese), e.g. (Chinese text)1regular season, round 1. |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| seconds | numeric | Unobserved: null in every sample (the clock seconds of a live game, by its name). Typed Float64 like the family's other routes. |
| status | integer | Game status: 4 = finished (every sampled game). 1 = not started and 2 = in progress are inferred from the site's polling logic; 3 is unobserved. See the code table. |
| visiting_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| visiting_team_logo | character | Absolute URL of the visiting team logo (300x300 png). |
| visiting_team_lose | integer | Visiting team's cumulative losses after this game. An integer (the API sends it as digit text). |
| visiting_team_name | character | Visiting team name (Chinese) as of the game's season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| visiting_team_score | integer | Visiting team final points. |
| visiting_team_win | integer | Visiting team's cumulative wins after this game. An integer (the API sends it as digit text). |

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
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
[`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md),
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
  try(cba_schedule_day(day = "2025-12-12"))
#> ── CBA Schedule Day from data-server.cbaleague.com ───────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:21:21 UTC
#> # A tibble: 1 × 27
#>   home_team_id home_team_logo      home_team_lose home_team_name home_team_score
#>          <int> <chr>                        <int> <chr>                    <int>
#> 1        29128 https://image.cbal…              0 浙江浙商证券                88
#> # ℹ 22 more variables: home_team_win <int>, is_events <int>, is_report <int>,
#> #   match_order <int>, match_type_id <int>, minutes <int>, quarter <int>,
#> #   round <int>, round_desc <chr>, schedule_id <int>, schedule_num <int>,
#> #   schedule_time <chr>, schedule_type_name <chr>, season <int>, seconds <dbl>,
#> #   status <int>, visiting_team_id <int>, visiting_team_logo <chr>,
#> #   visiting_team_lose <int>, visiting_team_name <chr>,
#> #   visiting_team_score <int>, visiting_team_win <int>
# }
```
