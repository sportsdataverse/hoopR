# **Get LBA Roster Coach**

Head coach of one team-season.

Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster`
(`id=<team_id>`)

## Usage

``` r
lba_roster_coach(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

## Value

A `hoopR_data` tibble: Head coach of one team-season. The columns are
always these, in this order (sportsdataverse-py `lba_roster_coach`); a
column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| coach_id | integer | Coach id (global coach key space; joins the game header `home_coach_id` / `visitor_coach_id`). |
| name | character | Coach's given name. |
| surname | character | Coach's family name. |
| birth_date | character | Birth date, Date `YYYY-MM-DD`. |
| place_of_birth | character | Birthplace (Italian spelling, e.g. `Londra`). |
| coach_type_id | integer | Coach role id (1 = head coach). |
| coach_type_description | character | Coach role, Italian: `Allenatore` = head coach. |
| coach_type_code | character | Coach role code, number sent as a string. |
| team_name | character | Team, short name. |
| coach_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_roster_coach(team_id = 1764)

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
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)
