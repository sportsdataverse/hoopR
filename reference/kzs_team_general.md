# **Get KZS Team Summary**

A team's record, form and best players in one competition (the body
echoes neither id).

Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}/general`

## Usage

``` r
kzs_team_general(team_id, competition_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in kzs_teams): one club team in one
  season, e.g. 17551. Not the match-team id nor the club id.

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: A team's record, form and best players in one
competition (the body echoes neither id). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_team_general`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| won | integer | Wins in the competition (all phases). |
| lost | integer | Losses in the competition. |
| last_games | character | Recent results, 'W' or 'L' per game (order unverified). |
| best_points_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| best_points_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
| best_points_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| best_points_player_person_first_name | character | The player's given name. |
| best_points_player_person_last_name | character | The player's family name. |
| best_points_player_person_year_of_birth | integer | Year of birth (players: public bio). |
| best_points_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
| best_points_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
| best_points_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
| best_points_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
| best_points_player_nationality_eng_name | character | Country name in English. |
| best_points_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
| best_points_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| best_points_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| best_average_points | double | That player's points per game. |
| best_rebounds_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| best_rebounds_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
| best_rebounds_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| best_rebounds_player_person_first_name | character | The player's given name. |
| best_rebounds_player_person_last_name | character | The player's family name. |
| best_rebounds_player_person_year_of_birth | integer | Year of birth (players: public bio). |
| best_rebounds_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
| best_rebounds_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
| best_rebounds_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
| best_rebounds_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
| best_rebounds_player_nationality_eng_name | character | Country name in English. |
| best_rebounds_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
| best_rebounds_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| best_rebounds_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| best_average_rebounds | double | That player's rebounds per game. |
| best_assists_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| best_assists_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
| best_assists_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| best_assists_player_person_first_name | character | The player's given name. |
| best_assists_player_person_last_name | character | The player's family name. |
| best_assists_player_person_year_of_birth | integer | Year of birth (players: public bio). |
| best_assists_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
| best_assists_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
| best_assists_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
| best_assists_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
| best_assists_player_nationality_eng_name | character | Country name in English. |
| best_assists_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
| best_assists_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| best_assists_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
| best_average_assists | double | That player's assists per game. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_team_general(competition_id = 579, team_id = 17551)

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
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)
