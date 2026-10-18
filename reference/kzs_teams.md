# **Get KZS Teams**

Teams entered in a competition.

Endpoint: `GET https://api.kzs.si/api/v1/public/teams/`

## Usage

``` r
kzs_teams(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: Teams entered in a competition. An empty valid
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `kzs_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| team_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
| team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
| club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
| club_member | logical | True when the club is a KZS member (false on nested copies that omit it). |
| team_internal_ranking | character | The club's internal team letter for the category (A = first team, B = second team). |
| category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
| rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
| gender | character | MALE or FEMALE. |
| sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
| sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
| name | character | Team name for the season (sponsor name included). |
| code | character | Team 3-letter code. |
| home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
| guest_jersey_color | character | Away jersey colour, hex. |
| logo_uuid | character | Team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| home_team_color | character | Home colour, hex. |
| guest_team_color | character | Away colour, hex. |
| short_name | character | Team short name (” when none). |

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
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md)

## Examples

``` r
# \donttest{
  try(kzs_teams(competition_id = 579))
#> ── KZS Teams from api.kzs.si ─────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:18 UTC
#> # A tibble: 11 × 19
#>    competition_id team_id team_application_id club_id club_member
#>             <int>   <int>               <int>   <int> <lgl>      
#>  1            579   17548               45427     254 FALSE      
#>  2            579   17549               45359      55 FALSE      
#>  3            579   17550               45131      46 FALSE      
#>  4            579   17551               45242      16 FALSE      
#>  5            579   17552               45065      26 FALSE      
#>  6            579   17553               45218      49 FALSE      
#>  7            579   17554               45208      56 FALSE      
#>  8            579   17555               45018      45 FALSE      
#>  9            579   17556               45647      44 FALSE      
#> 10            579   17557               45625      59 FALSE      
#> 11            579   17558               45576       9 FALSE      
#> # ℹ 14 more variables: team_internal_ranking <chr>, category <chr>, rank <chr>,
#> #   gender <chr>, sport_hall_id <int>, sport_hall_name <chr>, name <chr>,
#> #   code <chr>, home_jersey_color <chr>, guest_jersey_color <chr>,
#> #   logo_uuid <chr>, home_team_color <chr>, guest_team_color <chr>,
#> #   short_name <chr>
# }
```
