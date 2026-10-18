# **Get KZS Player Profile**

Player profile: names, year of birth, nationality and positions.

Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}`

## Usage

``` r
kzs_player(player_id)
```

## Arguments

- player_id:

  (required) Player registry id (player_id in a box score or roster),
  e.g. 106285. Not the person id.

## Value

A `hoopR_data` tibble: Player profile: names, year of birth, nationality
and positions. An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sdv-py `kzs_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
| person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| first_name | character | The player's given name. |
| last_name | character | The player's family name. |
| year_of_birth | integer | Year of birth (players: public bio). |
| nationality_id | integer | Country id (FMS internal; use the ISO codes). |
| nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
| nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
| nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
| nationality_eng_name | character | Country name in English. |
| homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
| photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |

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
  try(kzs_player(player_id = 106285))
#> ── KZS Player Profile from api.kzs.si ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:02 UTC
#> # A tibble: 1 × 14
#>   player_id identification_number person_id first_name   last_name year_of_birth
#>       <int>                 <int>     <int> <chr>        <chr>             <int>
#> 1    106285                915164    109521 Wendell Jer… Green jr           2002
#> # ℹ 8 more variables: nationality_id <int>, nationality_alpha2_code <chr>,
#> #   nationality_alpha3_code <chr>, nationality_name <chr>,
#> #   nationality_eng_name <chr>, homegrown <lgl>, photo_uuid <chr>,
#> #   positions <chr>
# }
```
