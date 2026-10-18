# **Get KZS Match Header**

Match header: teams, scores, venue, officials' names, best performers
and status.

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`

## Usage

``` r
kzs_match(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: Match header: teams, scores, venue, officials'
names, best performers and status. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`kzs_match`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| competition_name | character | Competition name (Slovenian; the sponsor name changes: Liga Telemach 2007-15, NovaKBM 2015-24, OTP banka 2024-). |
| competition_type | character | Competition type (code table). |
| competition_phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
| competition_phase_name | character | Phase name, Slovenian (see `phases[].name`). |
| transferred | logical | True when the match was carried over from an earlier phase (results transferred). |
| season_id | integer | Opaque KZS season id (27 = 2026/2027); the sdv season is the END year in season. |
| season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
| genius_match_id | integer | Genius LiveStats match id parsed from fiba_live_stats_url (org KZS); null before 2015/16. |
| organiser_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. The organising (home) team. |
| round | integer | Round (matchday) number within the phase. |
| fiba_live_stats_url | character | Genius Sports LiveStats URL `'https://fibalivestats.dcd.shared.geniussports.com/u/KZS/{geniusMatchId}/'`; the number is the Genius match id that keys genius-livestats/ data.json. Absent before 2015-16 (no live stats). |
| game_index | integer | Game number within the round (fixture order). |
| date_time | character | Tip-off, UTC (ISO 8601 'Z'). |
| attendance | integer | Spectators (0 when not recorded). |
| first_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. First (home) side. |
| first_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
| first_team_name | character | First (home) team name; absent on 2007-08 headers. |
| first_team_home_jersey_color | character | First team home colour, hex. |
| first_team_guest_jersey_color | character | First team away colour, hex. |
| first_team_logo_uuid | character | First (home) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| first_team_code | character | First team 3-letter code. |
| first_team_forfeited | logical | True when this team forfeited. |
| first_team_is_placeholder | logical | True when the slot is a bracket placeholder. |
| first_team_best_performer_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| first_team_best_performer_player_first_name | character | The player's given name as registered with KZS. |
| first_team_best_performer_player_last_name | character | The player's family name as registered with KZS. |
| first_team_best_performer_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| first_team_best_performer_efficiency | integer | Efficiency (PIR) in the match. |
| first_team_best_performer_points | integer | Points in the match. |
| first_team_best_performer_rebounds | integer | Rebounds in the match. |
| first_team_best_performer_assists | integer | Assists in the match. |
| first_team_best_performer_steals | integer | Steals in the match. |
| first_team_best_performer_blocks | integer | Blocks in the match. |
| second_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. Second (away) side. |
| second_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
| second_team_name | character | Second (away) team name; absent on 2007-08 headers. |
| second_team_home_jersey_color | character | Second team home colour, hex. |
| second_team_guest_jersey_color | character | Second team away colour, hex. |
| second_team_logo_uuid | character | Second (away) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| second_team_code | character | Second team 3-letter code. |
| second_team_forfeited | logical | True when this team forfeited. |
| second_team_is_placeholder | logical | True when the slot is a bracket placeholder. |
| second_team_best_performer_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| second_team_best_performer_player_first_name | character | The player's given name as registered with KZS. |
| second_team_best_performer_player_last_name | character | The player's family name as registered with KZS. |
| second_team_best_performer_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| second_team_best_performer_efficiency | integer | Efficiency (PIR) in the match. |
| second_team_best_performer_points | integer | Points in the match. |
| second_team_best_performer_rebounds | integer | Rebounds in the match. |
| second_team_best_performer_assists | integer | Assists in the match. |
| second_team_best_performer_steals | integer | Steals in the match. |
| second_team_best_performer_blocks | integer | Blocks in the match. |
| sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
| sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
| first_team_score | integer | First (home) team final score. |
| second_team_score | integer | Second (away) team final score. |
| score_inserted_manually | logical | True when the score was typed in by the federation rather than taken from the live-stats feed. |
| status | character | Match status: FINISHED in every sample (the capture banks final games only); the site also filters POSTPONED matches. |
| referee1_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
| referee1_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| referee1_person_first_name | character | The official's given name. |
| referee1_person_last_name | character | The official's family name. |
| referee1_person_gender | character | MALE or FEMALE. |
| referee1_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| referee2_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
| referee2_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| referee2_person_first_name | character | The official's given name. |
| referee2_person_last_name | character | The official's family name. |
| referee2_person_gender | character | MALE or FEMALE. |
| referee2_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| referee3_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
| referee3_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| referee3_person_first_name | character | The official's given name. |
| referee3_person_last_name | character | The official's family name. |
| referee3_person_gender | character | MALE or FEMALE. |
| referee3_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| commissioner_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
| commissioner_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| commissioner_person_first_name | character | The official's given name. |
| commissioner_person_last_name | character | The official's family name. |
| commissioner_person_gender | character | MALE or FEMALE. |
| commissioner_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| referee_controller_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
| referee_controller_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| referee_controller_person_first_name | character | The official's given name. |
| referee_controller_person_last_name | character | The official's family name. |
| referee_controller_person_gender | character | MALE or FEMALE. |
| referee_controller_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| gender | character | MALE or FEMALE. |
| live_stats | logical | True when the match has live stats (box score and play-by-play). |
| without_stats | logical | True when the match keeps no statistics. |
| delegated | logical | True once officials are assigned to the match. |
| home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
| guest_jersey_color | character | Away jersey colour, hex. |
| bests | character | Each team's top player per stat. |
| match_evaluation_id | integer | Id of the officials' evaluation record (internal; no public route). |

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
  try(kzs_match(match_id = 101839))
#> ── KZS Match Header from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:16:04 UTC
#> # A tibble: 1 × 98
#>   match_id competition_id competition_name competition_type competition_phase_id
#>      <int>          <int> <chr>            <chr>                           <int>
#> 1   101839            579 Liga OTP banka   LEAGUE                           5811
#> # ℹ 93 more variables: competition_phase_name <chr>, transferred <lgl>,
#> #   season_id <int>, season <int>, genius_match_id <int>,
#> #   organiser_team_id <int>, round <int>, fiba_live_stats_url <chr>,
#> #   game_index <int>, date_time <chr>, attendance <int>, first_team_id <int>,
#> #   first_team_team_id <int>, first_team_name <chr>,
#> #   first_team_home_jersey_color <chr>, first_team_guest_jersey_color <chr>,
#> #   first_team_logo_uuid <chr>, first_team_code <chr>, …
# }
```
