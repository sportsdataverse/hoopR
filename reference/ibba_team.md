# **IBBA Team**

**One team-season: standings line and club profile (colours, sponsors,
social links, arena id).**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/TeamById`

## Usage

``` r
ibba_team(team_id, team_uid, season)
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
| team_uid | integer | IBBA CLUB id, stable across seasons (Maccabi Tel Aviv = 10): the team_uid parameter of the roster routes. Not the per-season team_id. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_name_he | character | Team name in Hebrew, HTML-unescaped. |
| team_short_name_he | character | Short team name in Hebrew, HTML-unescaped. |
| team_name | character | Team name in English as registered for the season. |
| team_short_name | character | Short team name in English. |
| wins | integer | Games won in the season so far (standings line). |
| losses | integer | Games lost in the season so far (standings line). |
| points_for | integer | Points scored over the games played. |
| points_against | integer | Points conceded over the games played. |
| table_points | integer | Standings points (2 per win, 1 per loss in the league table). |
| place | integer | Rank in the standings of the board (1 = first). |
| website_url | character | Club website URL. |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
| icon_path | character | Site-relative path of the small team icon. |
| logo_url | character | Absolute URL of the team logo. |
| icon3_path | character | Site-relative path of the third team icon variant. |
| arena_id | integer | Home arena id in the IBBA site's own arena table (no arena route is modelled). |
| address_he | character | Club address in Hebrew, HTML-unescaped. |
| address | character | Club address in English, HTML-unescaped. |
| colors_he | character | Team colours in Hebrew. |
| colors | character | Team colours in English. |
| sponsors_he | character | Club sponsors in Hebrew, comma-separated. |
| sponsors | character | Club sponsors in English, comma-separated. |
| about_he | character | Club profile in Hebrew as HTML markup (honours, history); not stripped. |
| about | character | Club profile in English as HTML markup; null when the club has none. |
| facebook_url | character | Club Facebook page URL; null when none. |
| twitter_url | character | Club Twitter / X profile URL; null when none. |
| instagram_url | character | Club Instagram profile URL; null when none. |
| youtube_url | character | Club YouTube channel URL; null when none. |
| subscribe_url | character | Season-ticket subscription URL; null when none. |
| diary_url | character | Calendar-subscription (add-to-diary) URL of the club's fixtures. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_team(season = 2026, team_id = 1109, team_uid = 10)

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
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
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)
