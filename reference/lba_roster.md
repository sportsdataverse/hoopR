# **Get LBA Roster**

Players of one team-season with bio, number and role.

Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster`
(`id=<team_id>`)

## Usage

``` r
lba_roster(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

## Value

A `hoopR_data` tibble: Players of one team-season with bio, number and
role. The columns are always these, in this order (sportsdataverse-py
`lba_roster`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| player_id | integer | Player id (global). |
| name | character | Player's given name. |
| surname | character | Player's family name. |
| code | character | Player code `SURNAME3-NAME3-YY`. |
| place_of_birth | character | Birthplace (Italian spelling). |
| birth_date | character | Birth date, Date `YYYY-MM-DD`. |
| player_number | character | Jersey number, number sent as a string. |
| country | character | Nationality, ISO alpha-3. |
| uefa_ratio | character | Eligibility class for the foreign-player quota: `I`, `E` or `C` (7 / 6 / 1 on the Treviso roster; reading as Italian / EU / non-EU is inferred). |
| height | integer | Player's height in centimetres. |
| weight | integer | Player's weight in kilograms. |
| year | integer | Season START year of the player entry (2026 = 2026-27). |
| start_date | character | Contract start with the team, Date `YYYY-MM-DD`. |
| end_date | character | Contract end with the team, Date `YYYY-MM-DD`. |
| player_role_id | integer | Position id (position key space: the id behind `player_role`; joins the `r_id` filter). |
| player_role | character | Position, Italian: `Playmaker` (point guard), `Guardia` (guard), `Ala` (forward), `Centro` (center), `-` unknown. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_roster(team_id = 1764)

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)
