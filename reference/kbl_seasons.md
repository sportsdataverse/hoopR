# **Get KBL Seasons**

Every KBL regular season (1997 to the next one) with its competition key
and date range, newest first.

Endpoint: `GET https://api.kbl.or.kr/season/list`

## Usage

``` r
kbl_seasons()
```

## Value

A `hoopR_data` tibble: Every KBL regular season (1997 to the next one)
with its competition key and date range, newest first. The columns are
always these, in this order (sportsdataverse-py `kbl_seasons`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
| glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the /leagues and /league/rank routes. |
| season_name | character | Season label: 'YYYY-YYYY' for a KBL season (e.g. '2025-2026'), '1997' for the inaugural season. |
| season_name_full | character | Division label in Korean: the first-team (top-division) season. |
| season_grade | integer | Division: 1 = the KBL itself, 2 = the KBL D-League (reserve league). |
| season_category | character | Category code of the competition: R regular season, PO playoffs, CP final, D1/D2 D-League stages, AS All-Star, EG/CU cups, EA EASL, OM Open Match Day (table below). |
| game_code | character | Competition type within the season: 01 regular season (the only value the list returns). |
| start_date | Date | First date of the season, YYYYMMDD. |
| end_date | Date | Last date of the season, YYYYMMDD. |

## Details

- Unofficial and unsupported: these wrappers read api.kbl.or.kr, the
  data API behind the www.kbl.or.kr React site (stats vendor sports2i).
  No key, cookie or proxy is needed, but two request headers must be
  present (Channel and TeamCode; the runtime sends WEB and XX).
  www.kbl.or.kr/robots.txt returns the SPA's HTML and
  api.kbl.or.kr/robots.txt a 500 error envelope, so no policy or
  Crawl-delay is published (checked 2026-10-12); the site's terms
  (/terms/list) were not reviewed for data reuse. The runtime waits at
  least 1 s before every request, retries included.

- Not wrapped: the site's /record/\* and `/player/player/{pcode}` pages
  are rendered by the sports2i widget from two other hosts
  (kbl-api.sports2i.com and api-stats.kbl.or.kr: team four factors,
  clutch, hustle, shot dashboards, all-time leaders). WKBL (the women's
  league) is not covered.

- Seasons are END years (2026 = 2025-26). KBL numbers seasons AND
  D-League (reserve league) editions with one sequential seasonCode;
  division picks 'kbl' or 'd_league' and game_code the competition
  inside the season, and the wrapper sends the API's glkey. The playoff
  routes take the REGULAR-SEASON key; the old route serves seasonCode
  below 45 and the new one 45 on, and the wrapper picks it.

- Ids: gmkey `S{seasonCode}G{gameCode}N{gameNo}` (a string, an object
  only inside the new playoff bracket), team_code (two-digit string with
  a leading zero, not stable across ownership changes) and pcode
  (six-digit string, the same on every route). The play-by-play carries
  no pcode: join its player_name to the game's box score on name and
  team_code. isEnded is unreliable (0 on every finished game through
  2005-06), so a game is final when isEnded is 1 or when it is dated
  before today (KST), both teams scored and its play-by-play reached the
  game-end row; anything else raises `hoopR_asset_fetch`. The first game
  call also fetches the header (and, for such a game, the play-by-play)
  once; the answer is cached for the process.

- Coverage: box scores and play-by-play from the first season (1997);
  shot x/y from 2006-07 (an earlier game's shot chart is empty: a
  zero-row tibble); advanced rates are filled from 1997-98 on (the
  vendor computes them from the box); screen assists and deflections are
  0 before the recent seasons. fg is TWO-point field goals made (dunks
  included), fgt all field goals, and a made dunk is its own row in the
  play-by-play. Shot x/y are pixels on the site's 726 x 412 full-court
  image; basket names the target end and teams switch at half-time, so
  normalise with basket before stacking shots.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or the API has nothing for the request: an
  empty list, a final game with no box score, no playoff bracket, no
  rounds, no schedule rows in the window), `hoopR_bad_request` (a
  malformed gmkey, a season that is not an END year between 1997 and
  2027, an unknown division or game_code, or bad schedule dates, raised
  before any request) and `hoopR_asset_fetch` (any other non-2xx
  including the unknown-id HTTP 500 and the HTTP 400 the API answers
  without its two headers, the KBL error envelope, an empty or non-JSON
  body, a game that is not final, or a body for another game, season or
  window than the one asked for). HTTP 500 is the API's deterministic
  answer to an unknown id and is not retried. Wrappers raise; they never
  warn and return empty.

## See also

Other KBL Functions:
[`kbl_current_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_current_standings.md),
[`kbl_game()`](https://hoopR.sportsdataverse.org/reference/kbl_game.md),
[`kbl_game_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_game_leaders.md),
[`kbl_pbp()`](https://hoopR.sportsdataverse.org/reference/kbl_pbp.md),
[`kbl_period_scores()`](https://hoopR.sportsdataverse.org/reference/kbl_period_scores.md),
[`kbl_player_box()`](https://hoopR.sportsdataverse.org/reference/kbl_player_box.md),
[`kbl_player_totals()`](https://hoopR.sportsdataverse.org/reference/kbl_player_totals.md),
[`kbl_players()`](https://hoopR.sportsdataverse.org/reference/kbl_players.md),
[`kbl_playoff_games()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_games.md),
[`kbl_playoff_seeds()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_seeds.md),
[`kbl_playoff_series()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_series.md),
[`kbl_round_mvps()`](https://hoopR.sportsdataverse.org/reference/kbl_round_mvps.md),
[`kbl_rounds()`](https://hoopR.sportsdataverse.org/reference/kbl_rounds.md),
[`kbl_schedule()`](https://hoopR.sportsdataverse.org/reference/kbl_schedule.md),
[`kbl_score_track()`](https://hoopR.sportsdataverse.org/reference/kbl_score_track.md),
[`kbl_season_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_season_leaders.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_seasons())
#> ── KBL Seasons from api.kbl.or.kr ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:48:28 UTC
#> # A tibble: 31 × 10
#>    season season_code glkey  season_name season_name_full season_grade
#>     <int>       <int> <chr>  <chr>       <chr>                   <int>
#>  1   2027          49 S49G01 2026-2027   1군시즌                     1
#>  2   2026          47 S47G01 2025-2026   1군시즌                     1
#>  3   2025          45 S45G01 2024-2025   1군시즌                     1
#>  4   2024          43 S43G01 2023-2024   1군시즌                     1
#>  5   2023          41 S41G01 2022-2023   1군시즌                     1
#>  6   2022          39 S39G01 2021-2022   1군시즌                     1
#>  7   2021          37 S37G01 2020-2021   1군시즌                     1
#>  8   2020          35 S35G01 2019-2020   1군시즌                     1
#>  9   2019          33 S33G01 2018-2019   1군시즌                     1
#> 10   2018          31 S31G01 2017-2018   1군시즌                     1
#> # ℹ 21 more rows
#> # ℹ 4 more variables: season_category <chr>, game_code <chr>,
#> #   start_date <date>, end_date <date>
# }
```
