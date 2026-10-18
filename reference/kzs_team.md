# **Get KZS Team Profile**

Team profile: club, home hall, colours and the competitions the team
entered.

Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}`

## Usage

``` r
kzs_team(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in kzs_teams): one club team in one
  season, e.g. 17551. Not the match-team id nor the club id.

## Value

A `hoopR_data` tibble: Team profile: club, home hall, colours and the
competitions the team entered. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`kzs_team`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
| team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
| club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
| club_member | logical | True when the club is a KZS member (false on nested copies that omit it). |
| category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
| rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
| gender | character | MALE or FEMALE. |
| sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
| sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
| sport_hall_address_id | integer | Id of the venue's address record. |
| sport_hall_address_post_office_id | integer | Post-office id (FMS internal). |
| sport_hall_address_post_office_zip_code | character | Postal code (REDACTED under a club `addresses[]` row; kept for venues). |
| sport_hall_address_post_office_name | character | Post-office town. |
| sport_hall_address_post_office_municipality | character | Municipality, upper case. |
| sport_hall_address_post_office_country | character | Country, ISO 3166-1 alpha-2 (SI). |
| sport_hall_address_street | character | Venue street (a public sports hall). |
| sport_hall_address_house_number | character | Venue house number, a string ('6 A'). |
| name | character | Team name for the season (sponsor name included). |
| code | character | Team 3-letter code. |
| season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
| season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
| season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
| season_active | logical | Same as `isActive`. |
| short_name | character | Team short name (” when none). |
| home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
| guest_jersey_color | character | Away jersey colour, hex. |
| logo_uuid | character | Logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| season | integer | Season of the registration. |
| competitions | character | Competitions of the team this season (id, name, rule, phases). |

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
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_team(team_id = 17551))
#> ── KZS Team Profile from api.kzs.si ──────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:14 UTC
#> # A tibble: 1 × 29
#>   team_id team_application_id club_id club_member category rank  gender
#>     <int>               <int>   <int> <lgl>       <chr>    <chr> <chr> 
#> 1   17551               45242      16 TRUE        ABSOLUTE FIRST MALE  
#> # ℹ 22 more variables: sport_hall_id <int>, sport_hall_name <chr>,
#> #   sport_hall_address_id <int>, sport_hall_address_post_office_id <int>,
#> #   sport_hall_address_post_office_zip_code <chr>,
#> #   sport_hall_address_post_office_name <chr>,
#> #   sport_hall_address_post_office_municipality <chr>,
#> #   sport_hall_address_post_office_country <chr>,
#> #   sport_hall_address_street <chr>, sport_hall_address_house_number <chr>, …
# }
```
