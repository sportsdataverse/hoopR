# **Get TPBL Referees**

The officiating crew of one finished game, chief referee first (names
only).

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}`

## Usage

``` r
tpbl_referees(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble: The officiating crew of one finished game, chief
referee first (names only). An empty answer raises `hoopR_no_data`; the
columns are always these, in this order (sdv-py `tpbl_referees`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| sequence | integer | Position in the crew as the API lists it: 1 = the chief referee. |
| referee_id | integer | TPBL referee id (key space: TPBL referees on api.tpbl.basketball). Not the GoHoops referee id. |
| gohoops_referee_id | integer | GoHoops referee id (key space: GoHoops referees). Not the TPBL referee id. |
| name | character | Referee name in Traditional Chinese. Names only: no contact or birth data is published. |
| role | character | Crew role enum: BASKETBALL_CHIEF_REFEREE = crew chief, BASKETBALL_FIRST_ASSISTANT_REFEREE = first assistant (umpire 1), BASKETBALL_SECOND_ASSISTANT_REFEREE = second assistant (umpire 2). |

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

     tpbl_referees(game_id = 6)

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)
