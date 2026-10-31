# **IBBA Coaches**

**The coaching staff of a team-season (birth dates are dropped).**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Coaches`

## Usage

``` r
ibba_coaches(team_id, team_uid, season)
```

## Arguments

- team_id:

  (*integer* required): Team-season id (new every season; Maccabi = 1109
  in 2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` /
  `away_team_id` or ibba_box_score.

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| coach_id | integer | Coach id in the IBBA coach table (per team-season registration as far as the samples show; stability across seasons is unverified). |
| coach_type | integer | Staff role code: 1 = head coach, 2 = assistant coach (inferred from the Maccabi Tel Aviv sample). |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| coach_name_he | character | Coach name in Hebrew, HTML-unescaped. |
| coach_name | character | Coach name in English. |
| is_replaced | logical | True when the person was replaced during the season (left the roster or staff). |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
| sort_order | integer | Display order of the coach within the staff list (mOrder). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_coaches(season = 2026, team_id = 1109, team_uid = 10)

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
[`ibba_leaders()`](https://hoopR.sportsdataverse.org/reference/ibba_leaders.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)
