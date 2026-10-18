# **Get KBL Current Standings**

Current standings of the active season (no parameter): record, games
behind, streaks, splits.

Endpoint: `GET https://api.kbl.or.kr/league/rank/team`

## Usage

``` r
kbl_current_standings()
```

## Value

A `hoopR_data` tibble: Current standings of the active season (no
parameter): record, games behind, streaks, splits. The columns are
always these, in this order (sdv-py `kbl_current_standings`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| rank | integer | Standing (1 = first). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| team_name_full | character | Team full name (Korean, e.g. Changwon LG Sakers). |
| wins | integer | Wins (a count on this route; on `/league/rank/{glkey}` win is a boolean about the latest game). |
| losses | integer | Losses (a count on this route). |
| draws | integer | Draws (always 0 in basketball). |
| win_diff | double | Games behind the leader. |
| home_wins | integer | Wins in the team's home games. |
| home_losses | integer | Losses in the team's home games. |
| away_wins | integer | Wins in the team's away games. |
| away_losses | integer | Losses in the team's away games. |
| conti_win | integer | Current winning streak (0 when the last game was a loss). |
| conti_loss | integer | Current losing streak (0 when the last game was a win). |
| max_win | integer | Longest winning streak of the season. |
| max_loss | integer | Longest losing streak of the season. |
| last_five | character | The last five results as a comma-separated string, most recent first: 1 win, 0 loss. |

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
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_current_standings())
#> ── KBL Current Standings from api.kbl.or.kr ──────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:41:22 UTC
#> # A tibble: 10 × 17
#>     rank team_code team_name         team_name_full   wins losses draws win_diff
#>    <int> <chr>     <chr>             <chr>           <int>  <int> <int>    <dbl>
#>  1     1 35        서울 삼성         서울 삼성 썬더스……     5      0     0      0  
#>  2     2 70        안양 정관장       안양 정관장 레드부스터스……     6      1     0      0  
#>  3     3 64        대구 한국가스공사 대구 한국가스공사 페가수스…     3      3     0      2.5
#>  4     4 66        고양 소노         고양 소노 스카이거너스……     3      4     0      3  
#>  5     4 06        수원 KT           수원 KT 소닉붐      3      4     0      3  
#>  6     6 16        원주 DB           원주 DB 프로미      2      3     0      3  
#>  7     7 50        창원 LG           창원 LG 세이커스……     2      4     0      3.5
#>  8     7 60        부산 KCC          부산 KCC 이지스     2      4     0      3.5
#>  9     7 10        울산 현대모비스   울산 현대모비스 피버스……     2      4     0      3.5
#> 10    10 55        서울 SK           서울 SK 나이츠      0      1     0      3  
#> # ℹ 9 more variables: home_wins <int>, home_losses <int>, away_wins <int>,
#> #   away_losses <int>, conti_win <int>, conti_loss <int>, max_win <int>,
#> #   max_loss <int>, last_five <chr>
# }
```
