# **Get TPBL Team Box Score**

Whole-game team totals of both teams: shooting, rebounds, fouls,
assists, turnovers and paint points.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_teams(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble: Whole-game team totals of both teams: shooting,
rebounds, fouls, assists, turnovers and paint points. An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `tpbl_box_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| opponent_team_id | integer | TPBL team id of the other side of the game (franchise, 2-8). Joins team_id. |
| field_goals_made | integer | Field goals made by the team over the whole game. |
| field_goals_missed | integer | Field goals missed by the team over the whole game. |
| field_goals_attempted | integer | Field goals attempted by the team over the whole game. |
| field_goals_percentage | double | Field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| two_pointers_made | integer | 2-point field goals made by the team over the whole game. |
| two_pointers_missed | integer | 2-point field goals missed by the team over the whole game. |
| two_pointers_attempted | integer | 2-point field goals attempted by the team over the whole game. |
| two_pointers_percentage | double | 2-point field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| three_pointers_made | integer | 3-point field goals made by the team over the whole game. |
| three_pointers_missed | integer | 3-point field goals missed by the team over the whole game. |
| three_pointers_attempted | integer | 3-point field goals attempted by the team over the whole game. |
| three_pointers_percentage | double | 3-point field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| free_throws_made | integer | Free throws made by the team over the whole game. |
| free_throws_missed | integer | Free throws missed by the team over the whole game. |
| free_throws_attempted | integer | Free throws attempted by the team over the whole game. |
| free_throws_percentage | double | Free throws percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| won_score | integer | Team-row field: points the team scored in the whole game (the final score). |
| total_won_score | integer | Team-row field: points the team scored in the whole game (the final score; equals won_score on this line). |
| lost_score | integer | Team-row field: points the team conceded in the whole game (the opponent's final score). |
| total_lost_score | integer | Team-row field: points the team conceded in the whole game (equals lost_score on this line). |
| rebounds | integer | Total rebounds by the team over the whole game (offensive + defensive). |
| defensive_rebounds | integer | Defensive rebounds by the team over the whole game. |
| offensive_rebounds | integer | Offensive rebounds by the team over the whole game. |
| defensive_fouls | integer | Fouls committed on defense by the team over the whole game. |
| offensive_fouls | integer | Fouls committed on offense by the team over the whole game. |
| personal_fouls | integer | Personal fouls by the team over the whole game (excludes technical, unsportsmanlike and disqualifying fouls). |
| fouls | integer | Fouls charged by the team over the whole game: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
| assists | integer | Assists by the team over the whole game. |
| steals | integer | Steals by the team over the whole game. |
| blocks | integer | Blocked shots by the team over the whole game. |
| turnovers | integer | Turnovers committed by the team over the whole game; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
| points_in_paint | integer | Points scored in the paint by the team over the whole game. |
| second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the team over the whole game. |
| fast_break_points | integer | Points scored on the fast break by the team over the whole game. |

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
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
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

## Examples

``` r
# \donttest{
  try(tpbl_box_teams(game_id = 6))
#> ── TPBL Team Box Score from api.tpbl.basketball ──────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:04:17 UTC
#> # A tibble: 2 × 40
#>   game_id side  team_id team  gohoops_squad_id opponent_team_id field_goals_made
#>     <int> <chr>   <int> <chr>            <int>            <int>            <int>
#> 1       6 home        4 新竹御嵿…             8211                8               47
#> 2       6 away        8 臺北台新…             8215                4               42
#> # ℹ 33 more variables: field_goals_missed <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, two_pointers_made <int>,
#> #   two_pointers_missed <int>, two_pointers_attempted <int>,
#> #   two_pointers_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_missed <int>, three_pointers_attempted <int>,
#> #   three_pointers_percentage <dbl>, free_throws_made <int>,
#> #   free_throws_missed <int>, free_throws_attempted <int>, …
# }
```
