# **Get KZS Matches**

Matches of a competition (optionally inside a from/to window) with the
Genius LiveStats id.

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/`

## Usage

``` r
kzs_matches(competition_id, date_from = NULL, date_to = NULL)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

- date_from:

  Earliest tip-off, an ISO instant such as 2025-10-01T00:00:00.000Z (a
  bare date is a 400). Omitted = the whole competition.

- date_to:

  Latest tip-off, an ISO instant such as 2025-10-31T23:59:59.000Z.
  Omitted = the whole competition.

## Value

A `hoopR_data` tibble: Matches of a competition (optionally inside a
from/to window) with the Genius LiveStats id. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_matches`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| competition_name | character | Competition name (Slovenian; the sponsor name changes: Liga Telemach 2007-15, NovaKBM 2015-24, OTP banka 2024-). |
| competition_type | character | Competition type (code table). |
| competition_phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
| competition_phase_name | character | Phase name, Slovenian ('Redni del' = regular season, '1. del' = first stage). |
| transferred | logical | True when the match was carried over from an earlier phase (results transferred). |
| season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
| season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
| genius_match_id | integer | Genius LiveStats match id parsed from fiba_live_stats_url (org KZS); null before 2015/16. |
| organiser_team_id | integer | Team id of the organiser (home) side; null in older headers, which send an empty organiser. |
| round | integer | Round (matchday) number within the phase. |
| fiba_live_stats_url | character | Genius Sports LiveStats URL `'https://fibalivestats.dcd.shared.geniussports.com/u/KZS/{geniusMatchId}/'`; the number is the Genius match id that keys genius-livestats/ data.json. Absent before 2015-16 (no live stats). |
| game_index | integer | Game number within the round (fixture order). |
| date_time | character | Tip-off, UTC (ISO 8601 'Z'). |
| attendance | integer | Spectators (0 when not recorded). |
| sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
| sport_hall_address | character | Venue address, one line. |
| sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
| first_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. First (home) side. |
| first_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. First (home) team. |
| is_first_team_placeholder | logical | True when the first (home) slot is a bracket placeholder, not yet a team. |
| second_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. Second (away) side. |
| second_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. Second (away) team. |
| is_second_team_placeholder | logical | True when the second (away) slot is a placeholder. |
| first_team_name | character | First (home) team name. |
| first_team_short_name | character | First team short name (” when none). |
| second_team_name | character | Second (away) team name. |
| second_team_short_name | character | Second team short name (” when none). |
| first_team_score | integer | First (home) team final score. |
| second_team_score | integer | Second (away) team final score. |
| score_inserted_manually | logical | True when the score was typed in by the federation rather than taken from the live-stats feed. |
| first_team_logo_uuid | character | First (home) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}` (PNG). |
| second_team_logo_uuid | character | Second (away) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}` (PNG). |
| first_team_code | character | First team 3-letter code (club code). |
| second_team_code | character | Second team 3-letter code. |
| status | character | Match status: FINISHED in every sample (POSTPONED filtered by the site on other lists). |
| delegated | logical | True once officials are assigned to the match. |
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
| match_evaluation_id | integer | Id of the officials' evaluation record (internal; no public route). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
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
  try(kzs_matches(
    competition_id = 579, date_from = "2025-10-01T00:00:00.000Z",
    date_to = "2025-10-31T23:59:59.000Z"
  ))
#> ── KZS Matches from api.kzs.si ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:27 UTC
#> # A tibble: 21 × 69
#>    match_id competition_id competition_name competition_type
#>       <int>          <int> <chr>            <chr>           
#>  1   101846            579 Liga OTP banka   LEAGUE          
#>  2   101842            579 Liga OTP banka   LEAGUE          
#>  3   101843            579 Liga OTP banka   LEAGUE          
#>  4   101844            579 Liga OTP banka   LEAGUE          
#>  5   101845            579 Liga OTP banka   LEAGUE          
#>  6   101848            579 Liga OTP banka   LEAGUE          
#>  7   101847            579 Liga OTP banka   LEAGUE          
#>  8   101849            579 Liga OTP banka   LEAGUE          
#>  9   101851            579 Liga OTP banka   LEAGUE          
#> 10   101850            579 Liga OTP banka   LEAGUE          
#> # ℹ 11 more rows
#> # ℹ 65 more variables: competition_phase_id <int>,
#> #   competition_phase_name <chr>, transferred <lgl>, season_id <int>,
#> #   season <int>, genius_match_id <int>, organiser_team_id <int>, round <int>,
#> #   fiba_live_stats_url <chr>, game_index <int>, date_time <chr>,
#> #   attendance <int>, sport_hall_name <chr>, sport_hall_address <chr>,
#> #   sport_hall_id <int>, first_team_id <int>, first_team_team_id <int>, …
# }
```
