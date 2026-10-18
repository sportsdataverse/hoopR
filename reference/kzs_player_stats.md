# **Get KZS Player Season Stats**

A player's totals and per-game averages in each competition of one
season.

Endpoint:
`GET https://api.kzs.si/api/v1/public/players/{player_id}/stats`

## Usage

``` r
kzs_player_stats(player_id, season)
```

## Arguments

- player_id:

  (required) Player registry id (player_id in a box score or roster),
  e.g. 106285. Not the person id.

- season:

  (required) Season END year (2027 = 2026/2027); the wrapper maps it to
  KZS' opaque season id.

## Value

A `hoopR_data` tibble: A player's totals and per-game averages in each
competition of one season. An empty valid answer raises `hoopR_no_data`;
the columns are always these, in this order (sdv-py `kzs_player_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player registry id of the request (the body does not echo it). |
| season_id | integer | Opaque KZS season id (27 = 2026/2027); the sdv season is the END year in season. |
| season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| a1 | integer | Season total: free throws attempted. |
| a2 | integer | Season total: two-pointers attempted. |
| a3 | integer | Season total: three-pointers attempted. |
| pts | integer | Season total: points. |
| ass | integer | Season total: assists. |
| blag | integer | Season total: own shots blocked (blocks against). |
| blfv | integer | Season total: blocks made (blocks in favour). |
| captain | integer | Games as captain. |
| m1 | integer | Season total: free throws made. |
| m2 | integer | Season total: two-pointers made. |
| m3 | integer | Season total: three-pointers made. |
| mins | double | Season total: minutes played (decimal minutes). |
| pfcm | integer | Season total: fouls committed. |
| pfrv | integer | Season total: fouls received. |
| rd | integer | Season total: defensive rebounds. |
| ro | integer | Season total: offensive rebounds. |
| st | integer | Season total: steals. |
| startinglineup | integer | Games the player started in the competition. |
| tov | integer | Season total: turnovers. |
| played | integer | Games the player played in the competition. |
| plus_minus | integer | Season total: the team's point difference while the player was on court. |
| efficiency | integer | Season total: efficiency (PIR). |
| avgpts | double | Per game: points. |
| avga1 | double | Per game: free throws attempted. |
| avga2 | double | Per game: two-pointers attempted. |
| avga3 | double | Per game: three-pointers attempted. |
| avgass | double | Per game: assists. |
| avgblag | double | Per game: own shots blocked (blocks against). |
| avgblfv | double | Per game: blocks made (blocks in favour). |
| avgm1 | double | Per game: free throws made. |
| avgm2 | double | Per game: two-pointers made. |
| avgm3 | double | Per game: three-pointers made. |
| avgmins | double | Per game: minutes played (decimal minutes). |
| avgpfcm | double | Per game: fouls committed. |
| avgpfrv | double | Per game: fouls received. |
| avgrd | double | Per game: defensive rebounds. |
| avgro | double | Per game: offensive rebounds. |
| avgsecs | integer | Per game: seconds (0 in every sample: unused). |
| avgst | double | Per game: steals. |
| avgtov | double | Per game: turnovers. |
| avgplus_minus | double | Per game: the team's point difference while the player was on court. |
| avgefficiency | double | Per game: efficiency (PIR). |
| live_stats | logical | True when the competition has live stats. |
| competition_name | character | Competition name, Slovenian (e.g. 'Liga OTP banka', 'Pokal Spar'). |
| competition_rank | character | Tier of the competition (code table). |
| competition_category | character | Category of the competition (code table). |
| competition_gender | character | MALE or FEMALE competition. |

## Details

- Unofficial and unsupported: these wrappers read the public read API
  (Java/Spring, built by OnixWeb) that the kzs.si site itself calls. No
  terms of use were located (unverified), api.kzs.si/robots.txt answers
  401 and www.kzs.si/robots.txt 404, so no policy or Crawl-delay is
  published. The runtime waits at least 1 s before every request,
  retries included. Payloads are not redistributed as release assets.

- Personal data: the API serves officials' and coaches' emails, phones
  and home towns, and clubs' bank accounts and addresses, publicly. The
  parsers never output them (officials appear by name only; club
  addresses, personnel and the commissioner report are dropped). Do not
  add them back.

- Seasons are END years (2027 = 2026/2027); KZS' own season ids are
  opaque (27 = 2026/2027) and the runtime maps them. Competition ids are
  per season. Three team keys are never interchangeable: the match-team
  id (per match and side), team_id (one club team in one season) and
  club_id (across seasons). player_id is the registry id, person_id the
  person behind it.

- Errors are HTTP 400 for everything (an unknown id and a bad parameter
  alike), so the runtime raises `hoopR_asset_fetch` for it, never
  `hoopR_bad_request` or an empty frame. List routes default to 150 rows
  with no truncation signal: every list wrapper asks for a large limit
  and refuses a full page. The play-by-play and box-score wrappers, the
  leaderboards, teams, rounds and playing days each make one extra,
  cached request (the match header or the competition) to prove the
  answer is the one asked for and the game is final.

- Coverage: scores from 2007/08; box scores and play-by-play from
  2015/16. Some 2020/21 men's games have a box score but no play-by-play
  (`hoopR_no_data`): the Genius data.json (genius_match_id in
  kzs_matches) is the fallback. Shot x/y are Genius court percent; side
  (LEFT/RIGHT) names the basket end and teams switch ends at half time,
  so normalise with side before stacking shots. Advanced box-score
  fields are 0 in every observed game.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (an empty answer or list, a competition without
  standings, a final game with no play-by-play or box score, HTTP 404),
  `hoopR_asset_fetch` (HTTP 400, the API's only error status for an
  unknown id and a bad parameter alike; any other non-2xx; a non-JSON or
  empty body; an envelope whose status is not OK; a full list page; a
  game that is not final; a body for another competition, match, team,
  player or season than the one asked for) and `hoopR_bad_request` (a
  bad argument, before any request). HTTP 500 is retried. Wrappers
  raise; they never return an empty frame for a failed fetch.

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_player_leaderboard.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_player_stats(player_id = 106285, season = 2026))
#> ── KZS Player Season Stats from api.kzs.si ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:31:52 UTC
#> # A tibble: 2 × 51
#>   player_id season_id season competition_id    a1    a2    a3   pts   ass  blag
#>       <int>     <int>  <int>          <int> <int> <int> <int> <int> <int> <int>
#> 1    106285        26   2026            579   108   175   162   432   148    16
#> 2    106285        26   2026            584     9     8    12    25     3     1
#> # ℹ 41 more variables: blfv <int>, captain <int>, m1 <int>, m2 <int>, m3 <int>,
#> #   mins <dbl>, pfcm <int>, pfrv <int>, rd <int>, ro <int>, st <int>,
#> #   startinglineup <int>, tov <int>, played <int>, plus_minus <int>,
#> #   efficiency <int>, avgpts <dbl>, avga1 <dbl>, avga2 <dbl>, avga3 <dbl>,
#> #   avgass <dbl>, avgblag <dbl>, avgblfv <dbl>, avgm1 <dbl>, avgm2 <dbl>,
#> #   avgm3 <dbl>, avgmins <dbl>, avgpfcm <dbl>, avgpfrv <dbl>, avgrd <dbl>,
#> #   avgro <dbl>, avgsecs <int>, avgst <dbl>, avgtov <dbl>, …
# }
```
