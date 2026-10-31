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
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_team`):

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

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_team(team_id = 17551)

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
