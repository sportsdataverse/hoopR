# **Get KZS Team Roster**

A team's roster in one competition (the rows carry no team or
competition id).

Endpoint: `GET https://api.kzs.si/api/v1/public/teamPlayers/`

## Usage

``` r
kzs_roster(team_id, competition_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in kzs_teams): one club team in one
  season, e.g. 17551. Not the match-team id nor the club id.

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: A team's roster in one competition (the rows
carry no team or competition id). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_roster`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| roster_entry_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
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
| jersey_number | character | Shirt number worn, sent as a string ('1', '55'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_roster(competition_id = 579, team_id = 17551)

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
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)
