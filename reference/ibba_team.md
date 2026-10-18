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

The IBBA wrappers read the Israel Basketball Association's ASP.NET web
service at `basket.co.il/ws/ws.asmx` (the ops its own site calls):
seasons, boards, teams, rosters, coaches, schedules and results, box
scores from 2004-05, season stats and leaders of the Winner League
(Israeli Premier League). They mirror sdv-py's
`sportsdataverse.basketball.ibba` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per sdv-py
row. The live box score, play-by-play and shot coordinates of a game are
in the
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md)
family (Segev Stats).

**Unofficial and unsupported.** The web service is keyless, unofficial
and reverse engineered. Requests are spaced at least one second apart
per host (429 / 502 / 503 / 504 are retried three times; an HTTP 500 is
the host's deterministic error page, a stack trace, and is not retried);
keep crawls slow and incremental. Contact details (e-mail, phone, fax)
and coaches' dates of birth are dropped.

**Seasons and ids.** `season` is the END year and the host's own `cYear`
(2026 = 2025-26): it is sent unchanged. `team_id` and `player_id` are
per-SEASON registrations (Maccabi Tel Aviv = team 1109 in 2025-26, 2111
in 2026-27); the host has no cross-season person id (the stable player
key is the Segev player id of the `ibba_segev_*()` family). `team_uid`
is the stable club id (Maccabi = 10). A `0` means "all" where an
argument says so; every parameter of an op is always sent.

**Coverage.** League box scores from 2004-05 (`season = 2005`).
`external_id` and `segev_game_id` exist only from 2025-26 (earlier games
carry no Segev id, so `segev_game_id` is `NA`). The women's league and
Liga Leumit are NOT on this host. Every value on the wire is a string
and Hebrew text is HTML-entity encoded: ids, counts and dates are cast
and text is unescaped.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, an empty body, which is what an unknown id
answers, or an empty row list), `hoopR_bad_request` (HTTP 400 / 422, or
an argument that is not a non-negative integer, a boolean or a non-empty
string as the op needs) and `hoopR_asset_fetch` (any other failure:
another status, a transport error, a body that is not JSON, an error or
changed envelope, a row for another season, team, player, board or game,
or a box score of a game that is not final). All inherit `hoopR_error`.

     ibba_team(season = 2026, team_id = 1109, team_uid = 10)

## See also

Other IBBA:
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
