# **Get KBL Schedule**

Every game (all competitions, KBL and D-League) of a season or of a date
window, with scores and venue.

Endpoint: `GET https://api.kbl.or.kr/match/list`

## Usage

``` r
kbl_schedule(season = NULL, from_date = NULL, to_date = NULL)
```

## Arguments

- season:

  Season END year (2026 = 2025-26): the window from the first to the
  last game of that END year's KBL and D-League editions, fetched as at
  most two requests (one per calendar year). Pass this or from_date and
  to_date.

- from_date:

  First date of a window, YYYYMMDD (KST). Needs to_date; inside one
  calendar year the API answers the whole window in one request (up to
  396 games a year, no paging).

- to_date:

  Last date of the window, YYYYMMDD (KST), not before from_date.

## Value

A `hoopR_data` tibble: Every game (all competitions, KBL and D-League)
of a season or of a date window, with scores and venue. The columns are
always these, in this order (sdv-py `kbl_schedule`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every `/match/{gmkey}` route. |
| glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the /leagues and /league/rank routes. |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
| season_name | character | Season label as sent: 'YYYY-YYYY' for a KBL season, '1997' for the inaugural one, a D-League edition label, or an empty string on EASL rows. |
| season_grade | integer | Division: 1 = the KBL itself, 2 = the KBL D-League (reserve league). |
| game_code | character | Competition type within the season (2-digit string; code table in the README and below): 01 regular season, 03 playoffs, 04 final, ... |
| game_no | integer | Game number within the competition (glkey); the N part of the gmkey. |
| season_category | character | Category code of the competition: R regular season, PO playoffs, CP final, D1/D2 D-League stages, AS All-Star, EG/CU cups, EA EASL, OM Open Match Day (table below). |
| season_category_name | character | Category name in Korean (regular season, playoffs, championship final, D-League stage 1 / 2, All-Star Game, cups, 'KBL' Cup, 'EASL', 'OPEN MATCH DAY'). |
| game_date | Date | Game date (KST). |
| week_day | character | Day of the week in Korean (one Hangul syllable, Monday to Sunday). |
| game_start | character | Tip-off time, HHMM (KST). |
| game_end | character | End time, HHMM (KST); '0000' or blanks when not recorded. |
| game_time | integer | Duration of the game in minutes (a numeric string on the wire; null on some rows). |
| home_team_code | character | Home team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| away_team_code | character | Away team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| home_team_name | character | Home team short name (Korean, e.g. Goyang Sono). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| away_team_name | character | Away team short name (Korean, e.g. Changwon LG). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| home_team_name_full | character | Home team full name (Korean). |
| away_team_name_full | character | Away team full name (Korean). |
| home_score | integer | Home team points (scoreH). |
| away_score | integer | Away team points (scoreA). |
| is_started | integer | 1 when the game has started. Unreliable for old games (0 on finished 1997-2006 games in /match/list). |
| is_ended | integer | 1 when the game is over. Unreliable: 0 on every finished game through 2005-06 and on some later ones (e.g. S45G01N95's header); the capture treats a past-dated game with scores as final. |
| playing_quarter | character | Period in progress: 'X' when none (before or after the game), else e.g. 'Q4' or 'EQ1'. Can stay stale after the game (the overtime sample says 'EQ1'). |
| stadium_name | character | Venue short name (Korean). |
| stadium_name_full | character | Venue full name (Korean). |
| stadium_name_en | character | Venue name in English; an empty string, or the Korean name, for some old venues. |
| tv | character | Broadcaster name(s), e.g. 'tvN SPORTS', 'SPOTV2 / SPOTV ON'. |
| tv_code | character | Broadcaster code(s), comma-separated (e.g. 'T24,T25'); the site uses it instead of `tv` from seasonCode 45. |
| article_id | integer | Id of the game's news article on kbl.or.kr; null when none. |
| challenge_id | integer | Id of the game in KBL Challenge (the site's prediction game); null when none. |

## Details

- Unofficial and unsupported: these wrappers read api.kbl.or.kr, the
  data API behind the www.kbl.or.kr React site (stats vendor sports2i).
  No key, cookie or proxy is needed, but two request headers must be
  present (Channel and TeamCode; the runtime sends WEB and XX).
  www.kbl.or.kr/robots.txt returns the SPA's HTML and
  api.kbl.or.kr/robots.txt a 500 error envelope, so no policy or
  Crawl-delay is published (checked 2026-10-12); the site's terms
  (/terms/list) were not reviewed for data reuse. The runtime waits at
  least 1 s before every request, retries included. Payloads are not
  redistributed as release assets.

- Not wrapped: the site's /record/\* and `/player/player/{pcode}` pages
  are rendered by the sports2i widget from two other hosts
  (kbl-api.sports2i.com and api-stats.kbl.or.kr: team four factors,
  clutch, hustle, shot dashboards, all-time leaders) and need their own
  intake. WKBL (the women's league) is out of scope by owner ruling.

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
[`kbl_score_track()`](https://hoopR.sportsdataverse.org/reference/kbl_score_track.md),
[`kbl_season_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_season_leaders.md),
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_schedule(from_date = "20251101", to_date = "20251102"))
#> ── KBL Schedule from api.kbl.or.kr ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:38:53 UTC
#> # A tibble: 6 × 33
#>   gmkey     glkey  season season_code season_name season_grade game_code game_no
#>   <chr>     <chr>   <int>       <int> <chr>              <int> <chr>       <int>
#> 1 S47G01N49 S47G01   2026          47 2025-2026              1 01             49
#> 2 S47G01N50 S47G01   2026          47 2025-2026              1 01             50
#> 3 S47G01N51 S47G01   2026          47 2025-2026              1 01             51
#> 4 S47G01N52 S47G01   2026          47 2025-2026              1 01             52
#> 5 S47G01N53 S47G01   2026          47 2025-2026              1 01             53
#> 6 S47G01N54 S47G01   2026          47 2025-2026              1 01             54
#> # ℹ 25 more variables: season_category <chr>, season_category_name <chr>,
#> #   game_date <date>, week_day <chr>, game_start <chr>, game_end <chr>,
#> #   game_time <int>, home_team_code <chr>, away_team_code <chr>,
#> #   home_team_name <chr>, away_team_name <chr>, home_team_name_full <chr>,
#> #   away_team_name_full <chr>, home_score <int>, away_score <int>,
#> #   is_started <int>, is_ended <int>, playing_quarter <chr>,
#> #   stadium_name <chr>, stadium_name_full <chr>, stadium_name_en <chr>, …
# }
```
