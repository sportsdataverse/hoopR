# **Get KZS Competitions**

Competitions of a season (leagues, cups, youth, 3x3, national teams), or
of every season.

Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/`

## Usage

``` r
kzs_competitions(season = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque
  season id. Omitted = every season (627 competitions).

## Value

A `hoopR_data` tibble: Competitions of a season (leagues, cups, youth,
3x3, national teams), or of every season. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`kzs_competitions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| name | character | Competition name, Slovenian; the sponsor name changes over the years (glossary in kzs-returns.md). |
| gender | character | MALE or FEMALE. |
| category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
| rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
| season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
| season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
| season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
| season_active | logical | Same as `isActive`. |
| type | character | Competition type (code table); absent on 2 competitions. |
| season | integer | The competition's season. |

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
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_player_leaderboard.md),
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
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
  try(kzs_competitions(season = 2026))
#> ── KZS Competitions from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:39:06 UTC
#> # A tibble: 44 × 11
#>    competition_id name               gender category rank  season_id season_name
#>             <int> <chr>              <chr>  <chr>    <chr>     <int> <chr>      
#>  1            579 Liga OTP banka     MALE   ABSOLUTE FIRST        26 2025/2026  
#>  2            553 Pripravljalne tek… MALE   ABSOLUTE FIRST        26 2025/2026  
#>  3            585 1. Ž SKL           FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  4            546 Pripravljalne tek… FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  5            581 2. SKL             MALE   ABSOLUTE SECO…        26 2025/2026  
#>  6            582 3. SKL             MALE   ABSOLUTE THIRD        26 2025/2026  
#>  7            583 4. SKL             MALE   ABSOLUTE FOUR…        26 2025/2026  
#>  8            584 Pokal Spar         MALE   ABSOLUTE TOUR…        26 2025/2026  
#>  9            580 Superpokal         MALE   ABSOLUTE TOUR…        26 2025/2026  
#> 10            586 Pokal članice      FEMALE ABSOLUTE TOUR…        26 2025/2026  
#> # ℹ 34 more rows
#> # ℹ 4 more variables: season_is_active <lgl>, season_active <lgl>, type <chr>,
#> #   season <int>
# }
```
