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
are always these, in this order (sportsdataverse-py `kzs_player`):

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

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_player(player_id = 106285)

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
