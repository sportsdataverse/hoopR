# **Get TPBL Standings**

League table of one division: rank, record, games behind and streak.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`

## Usage

``` r
tpbl_standings(division_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

## Value

A `hoopR_data` tibble: League table of one division: rank, record, games
behind and streak. An empty answer raises `hoopR_no_data`; the columns
are always these, in this order (sdv-py `tpbl_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| rank | integer | Rank in the division, 1-based. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| alt_name | character | Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
| won | integer | Games won in the division so far. |
| lost | integer | Games lost in the division so far. |
| drawn | integer | Games drawn (always 0 in basketball). |
| games_behind | double | Games behind the leader (0 for the leader); a whole number in every captured division, read as a float so half games cannot break the dtype. |
| streak | character | Current streak: 'W' + count for wins, 'L' + count for losses (W2 = two straight wins). |

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
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)

## Examples

``` r
# \donttest{
  try(tpbl_standings(division_id = 2))
#> ── TPBL Standings from api.tpbl.basketball ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:04:26 UTC
#> # A tibble: 7 × 12
#>   division_id  rank team_id gohoops_team_id gohoops_squad_id team       alt_name
#>         <int> <int>   <int>           <int>            <int> <chr>      <chr>   
#> 1           2     1       7             945             8214 新北國王   kings   
#> 2           2     2       3             941             8210 福爾摩沙夢想家…… dreamers
#> 3           2     3       2             940             8209 高雄全家海神…… aquas   
#> 4           2     4       8             946             8215 臺北台新戰神…… mars    
#> 5           2     5       5             943             8212 桃園台啤永豐雲豹…… leopards
#> 6           2     6       6             944             8213 新北中信特攻…… dea     
#> 7           2     7       4             942             8211 新竹御嵿攻城獅…… lioneers
#> # ℹ 5 more variables: won <int>, lost <int>, drawn <int>, games_behind <dbl>,
#> #   streak <chr>
# }
```
