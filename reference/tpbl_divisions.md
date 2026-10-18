# **Get TPBL Divisions**

The divisions (preseason, regular season, play-in, playoffs, finals) of
one season.

Endpoint:
`GET https://api.tpbl.basketball/api/events/{season}/divisions`

## Usage

``` r
tpbl_divisions(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season; 2025 is the
  first). The API keys a season by its own small integer (1, 2, 3 =
  2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the
  same number): the runtime reads /seasons once and sends that id, so
  the example URL shows the year. A year the list lacks raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble: The divisions (preseason, regular season,
play-in, playoffs, finals) of one season. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`tpbl_divisions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
| season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
| gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. |
| name | character | Division name (Traditional Chinese: preseason (warm-up games), regular season, postseason challenge (play-in round), playoffs, finals). |
| status | character | Division status: COMPLETED or IN_PROGRESS. |

## Details

- Unofficial and unsupported: these are the routes the tpbl.basketball
  site's own front end calls on api.tpbl.basketball (read from its
  JavaScript bundle). The API is keyless and needs no headers;
  tpbl.basketball/robots.txt answers 200 with an empty body. The runtime
  waits at least 1 s before every request, retries included. Payloads
  are not redistributed as release assets.

- Coverage: three seasons so far (2024-25 = season 2025 to 2026-27 =
  season 2027). There is NO play-by-play route; the two shot lists carry
  court coordinates only, with no shooter, game, quarter or time. Names
  (teams with their sponsor, venues, players, referees) are Traditional
  Chinese; the column descriptions translate the codes.

- Seasons are END years (2026 = 2025-26). The API keys a season by its
  own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27); the runtime
  reads tpbl_seasons once per session and sends that id. A year the list
  lacks is `hoopR_no_data`.

- Ids: every route takes TPBL's own ids (season, division, team, game,
  player); the `gohoops_*` ids belong to GoHoops, the stats platform
  behind the league, and are echoed beside them. The box score keys its
  players by gohoops_roster_id (a person registered with one squad in
  one season), not by the TPBL player id: join tpbl_box_players to
  tpbl_roster on gohoops_roster_id. Every id is an integer. tipoff is a
  POSIXct in Asia/Taipei (the API sends naive Taiwan-local times).

- Finished games only: the game wrappers first read the game detail
  (cached per session) and refuse (`hoopR_asset_fetch`) a game that is
  not COMPLETED or still live; the box-score wrappers also refuse a
  stats body whose teams (in home / away order), final scores, quarter
  count or player points disagree with it. The season game list, the
  roster and the player game log are checked against the object asked
  for; the two shot lists name no team, player or division in the body,
  so only their shape and court bounds are checked. tpbl_games(verify =
  TRUE) also checks every division's completed games against its
  standings (falling back to the team-filtered lists for a division
  whose standings answer empty, as the 2024-25 playoffs do).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a season the API does not list, an empty
  list such as the standings of a playoff division), `hoopR_bad_request`
  (a non-integer id or season, HTTP 400 / 422, an invalid verify or
  rounds, raised before the request where it can be) and
  `hoopR_asset_fetch` (any other failure: a non-2xx after retries, a
  non-JSON body, an error envelope, an unfinished game, a body that
  disagrees with the object asked for). HTTP 500 is retried on every
  route except the player game log, where an unknown division_id answers
  500 deterministically: it fails after one request. Wrappers raise;
  they never warn and return an empty frame.

     tpbl_divisions(season = 2026)

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)
