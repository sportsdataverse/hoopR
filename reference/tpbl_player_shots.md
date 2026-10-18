# **Get TPBL Player Shots**

Every field-goal attempt of one player in one division with its court
position.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/players/{player_id}/shooting-spots`

## Usage

``` r
tpbl_player_shots(division_id, player_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- player_id:

  Required. TPBL player id (one per person across seasons and teams);
  `player_id` in tpbl_roster. Not the GoHoops person id and not the
  roster id.

## Value

A `hoopR_data` tibble: Every field-goal attempt of one player in one
division with its court position. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`tpbl_player_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
| is_made | logical | True when the shot went in. |
| point_x | integer | Shot position in MILLIMETRES, 0-28000 along the court length (a 28 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. Same frame as the team list, where it was verified; here it is only checked to stay on the court. |
| point_y | integer | Shot position in MILLIMETRES, 0-15000 across the court (a 15 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. The direction of y is unverified. |
| offense_basket | integer | Basket the player's team attacked: 0 = the hoop at x = 1575, 1 = the hoop at x = 26425. |

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
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)

## Examples

``` r
# \donttest{
  try(tpbl_player_shots(division_id = 2, player_id = 75))
#> ── TPBL Player Shots from api.tpbl.basketball ────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:04:23 UTC
#> # A tibble: 366 × 6
#>    division_id player_id is_made point_x point_y offense_basket
#>          <int>     <int> <lgl>     <int>   <int>          <int>
#>  1           2        75 TRUE      18270    7200              1
#>  2           2        75 TRUE       5530   10230              0
#>  3           2        75 TRUE      24060    7310              1
#>  4           2        75 FALSE      4480    7140              0
#>  5           2        75 FALSE     24320   11800              1
#>  6           2        75 TRUE      25480     390              1
#>  7           2        75 TRUE      25860    8060              1
#>  8           2        75 FALSE     20690   10070              1
#>  9           2        75 FALSE     24700     510              1
#> 10           2        75 FALSE      4100    3830              0
#> # ℹ 356 more rows
# }
```
