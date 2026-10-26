# **Get TPBL Game**

Header of one finished game: teams with scores, venue, status, quarters,
tip-off, attendance and links.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}`

## Usage

``` r
tpbl_game(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble: Header of one finished game: teams with scores,
venue, status, quarters, tip-off, attendance and links. the columns are
always these, in this order (sdv-py `tpbl_game`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
| season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| gohoops_game_id | integer | GoHoops game id (key space: GoHoops games; 1242 for TPBL game 6). Not the TPBL game id. |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
| gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. Read from the home team. |
| gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. Read from the home team. |
| code | character | Game code inside the division: the game number as text in the regular season ('1' ... '42'), a series label in the playoffs ('AG1' = series A game 1, 'G7' = finals game 7), ” for preseason games. |
| status | character | Game status. Observed: COMPLETED (finished) and NOT_STARTED (scheduled). A game in progress has is_live true. |
| is_live | logical | True while the game is being played; false for finished and scheduled games. |
| periods | integer | Number of quarters played: 4 for a regulation game, 5 for one overtime, 6 for two; 0 before tip-off. |
| game_date | Date | Game date (Taiwan local date). |
| game_day_of_week | character | Traditional Chinese weekday in parentheses: Mon, Tue, Wed, Thu, Fri, Sat, Sun. |
| game_time | character | Scheduled tip-off 'HH:MM:SS'. Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
| tipoff | POSIXct | Scheduled tip-off as a naive timestamp (no zone). Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
| venue | character | Venue name in Traditional Chinese (Xinzhuang Gymnasium, Heping Basketball Gymnasium, Taichung Intercontinental Mini Dome, Hsinchu County Gymnasium, Kaohsiung Arena, Taoyuan Arena). |
| attendance | integer | Attendance as an integer, parsed from the API's visitors string; null before the game, when the API sends none or on a postponed game. |
| home_team_id | integer | Home TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| home_gohoops_team_id | integer | Home GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
| home_gohoops_squad_id | integer | Home GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| home_team | character | Home team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| home_alt_name | character | Home team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
| home_score | integer | Home team final score (points scored); null before tip-off. |
| away_team_id | integer | Away TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| away_gohoops_team_id | integer | Away GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
| away_gohoops_squad_id | integer | Away GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| away_team | character | Away team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| away_alt_name | character | Away team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
| away_score | integer | Away team final score (points scored); null before tip-off. |
| recap_url | character | YouTube recap URL; null when the game has none (the list can omit it, the game detail carries it). |
| live_stream_url | character | YouTube live-stream URL of the game; null when the API omits it. |
| judgement_report_url | character | URL of the referees' judgement report (a Google Drive file); null when none. |
| ticket_url | character | URL of the ticket page; null on most rows. |

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
  try(tpbl_game(game_id = 6))
#> ── TPBL Game from api.tpbl.basketball ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:39:15 UTC
#> # A tibble: 1 × 34
#>   season season_id game_id gohoops_game_id division_id gohoops_division_id
#>    <int>     <int>   <int>           <int>       <int>               <int>
#> 1     NA        NA       6            1242           1                  64
#> # ℹ 28 more variables: gohoops_season_id <int>, gohoops_event_id <int>,
#> #   code <chr>, status <chr>, is_live <lgl>, periods <int>, game_date <date>,
#> #   game_day_of_week <chr>, game_time <chr>, tipoff <dttm>, venue <chr>,
#> #   attendance <int>, home_team_id <int>, home_gohoops_team_id <int>,
#> #   home_gohoops_squad_id <int>, home_team <chr>, home_alt_name <chr>,
#> #   home_score <int>, away_team_id <int>, away_gohoops_team_id <int>,
#> #   away_gohoops_squad_id <int>, away_team <chr>, away_alt_name <chr>, …
# }
```
