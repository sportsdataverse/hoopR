# **Get BBL / DBBL Season Player Statistics**

Season player stat table: totals and per-game values, one row per player
and stat block.

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/player-statistics`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_player_statistics(season, league = "bbl", display_type = "MAIN_ROUND")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26, the sdv key). Sent to the
  API as its START-year seasonId (season - 1).

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- display_type:

  (default `"MAIN_ROUND"`) Which games the table covers: MAIN_ROUND
  (regular season), PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS
  or CUP.

## Value

A `hoopR_data` tibble: Season player stat table: totals and per-game
values, one row per player and stat block. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`scb_player_statistics`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| display_type | character | Which games the table covers, echoed from the request (MAIN_ROUND, PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP). |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| shirt_number | character | Jersey number of the player, kept as text so a `00` jersey survives. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| team_tlc | character | Three-letter club code. |
| season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
| round_code | integer | Provider round code; 1 for MAIN_ROUND in every sample (mapping unverified). |
| competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
| seconds_played | integer | The player's season total playing time in SECONDS over displayType. |
| points | integer | The player's season total points over displayType. |
| two_point_shots_made | integer | The player's season total 2-point field goals made over displayType. |
| two_point_shots_attempted | integer | The player's season total 2-point field goals attempted over displayType. |
| two_point_shot_success_percent | numeric | The player's season total 2-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| three_point_shots_made | integer | The player's season total 3-point field goals made over displayType. |
| three_point_shots_attempted | integer | The player's season total 3-point field goals attempted over displayType. |
| three_point_shot_success_percent | numeric | The player's season total 3-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| field_goals_made | integer | The player's season total field goals made over displayType. |
| field_goals_attempted | integer | The player's season total field goals attempted over displayType. |
| field_goals_success_percent | numeric | The player's season total field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| free_throws_made | integer | The player's season total free throws made over displayType. |
| free_throws_attempted | integer | The player's season total free throws attempted over displayType. |
| free_throws_success_percent | numeric | The player's season total free-throw percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| offensive_rebounds | integer | The player's season total offensive rebounds over displayType. |
| defensive_rebounds | integer | The player's season total defensive rebounds over displayType. |
| total_rebounds | integer | The player's season total rebounds (offensive + defensive) over displayType. |
| assists | integer | The player's season total assists over displayType. |
| steals | integer | The player's season total steals over displayType. |
| turnovers | integer | The player's season total turnovers over displayType. |
| blocks | integer | The player's season total blocked shots over displayType. |
| fouls_committed | integer | The player's season total fouls committed over displayType. |
| efficiency | integer | The player's season total efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) over displayType. |
| plus_minus | integer | The player's season total plus-minus over displaytype. |
| games_played | integer | The player's season total games played over displayType. |
| seconds_per_game | numeric | Per-game average of seconds, seconds. |
| points_per_game | numeric | Per-game average of points. |
| two_point_shots_made_per_game | numeric | Per-game average of 2-point field goals made. |
| two_point_shots_attempted_per_game | numeric | Per-game average of 2-point field goals attempted. |
| three_point_shots_made_per_game | numeric | Per-game average of 3-point field goals made. |
| three_point_shots_attempted_per_game | numeric | Per-game average of 3-point field goals attempted. |
| field_goals_made_per_game | numeric | Per-game average of field goals made. |
| field_goals_attempted_per_game | numeric | Per-game average of field goals attempted. |
| field_goals_success_percent_per_game | numeric | Per-game average of field-goal percentage (0 in every sample: unusable). |
| free_throws_made_per_game | numeric | Per-game average of free throws made. |
| free_throws_attempted_per_game | numeric | Per-game average of free throws attempted. |
| defensive_rebounds_per_game | numeric | Per-game average of defensive rebounds. |
| offensive_rebounds_per_game | numeric | Per-game average of offensive rebounds. |
| total_rebounds_per_game | numeric | Per-game average of rebounds (offensive + defensive). |
| assists_per_game | numeric | Per-game average of assists. |
| steals_per_game | numeric | Per-game average of steals. |
| turnovers_per_game | numeric | Per-game average of turnovers. |
| blocks_per_game | numeric | Per-game average of blocked shots. |
| fouls_committed_per_game | numeric | Per-game average of fouls committed. |
| efficiency_per_game | numeric | Per-game average of efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score). |
| plus_minus_per_game | numeric | Per-game average of plus-minus (point margin while on court). |
| double_double | integer | The player's season total double-doubles over displayType. |
| double_double_per_game | numeric | Per-game average of double-doubles. |
| games_started | integer | The player's season total games started over displayType. |
| triple_double | integer | The player's season total triple-doubles over displayType. |
| triple_double_per_game | numeric | Per-game average of triple-doubles. |
| fouls_received | integer | The player's season total fouls drawn over displayType. |
| fouls_received_per_game | numeric | Per-game average of fouls drawn. |
| overall | logical | False in every sample (meaning unverified). |
| stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
| aggregation | character | Aggregation label as sent: STAGE in player tables, MAIN_ROUND in team tables. |

## Details

- Unofficial use of a public source: these wrappers read the front-end
  API of the German Bundesliga sites (easycredit-bbl.de,
  toyota-dbbl.de), run by SCB; payloads are not redistributed as release
  assets.

- Legal notice: the BBL Impressum forbids storing BBL content
  (`Inhalte`) in an information system without BBL's written permission.
  That is a copyright term, not a robots rule (the API host has no
  robots.txt). The owner reviewed it and accepted the intake (2026-10-12
  ruling); keep requests slow (the runtime waits at least 1 s per host)
  and raise any published data release with the owner. The DBBL host is
  the same operator and API; its site notice was not separately
  reviewed.

- Both hosts need two headers: a constant `x-api-key` and an
  `x-api-secret` that rotates. The runtime derives the secret on first
  use from the key embedded in an easycredit-bbl.de page (reversed, `:`
  turned into `-`) and never logs or returns it. The derivation was
  reverse-engineered from observed requests and responses and has not
  been checked against the site's own front-end code; if the site
  changes how it signs requests, every call fails with
  `hoopR_asset_fetch`.

- Id key spaces: seasonId is the START year (2025 = 2025-26), so a
  wrapper's END-year `season` is sent as `season - 1`. Teams are keyed
  by teamId (seasonTeamId equals it in every sample). seasonPlayerId is
  per player per season and per club (a player traded mid-season has
  two); realPlayerId is the person. playerId is ambiguous (the
  seasonPlayerId in box scores, records and /season-players; the person
  in /transfers). Game ids are strings.

- Errors are classed conditions: `hoopR_no_data` (404, 204, a 400 "not a
  valid" id, no rows, a box score of a game not yet started),
  `hoopR_bad_request` (a bad argument, another 400 / 422) and
  `hoopR_asset_fetch` (a refused secret after one re-derive, any other
  non-2xx, an HTML / non-JSON / error-shaped body, a truncated page, a
  body for another game, season, club or league, a box score still in
  play), all inheriting `hoopR_error`. Wrappers raise; they never return
  an empty frame.

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_playoff_games()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_games.md),
[`scb_playoff_series()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_series.md),
[`scb_records_per_game()`](https://hoopR.sportsdataverse.org/reference/scb_records_per_game.md),
[`scb_records_season_averages()`](https://hoopR.sportsdataverse.org/reference/scb_records_season_averages.md),
[`scb_referees()`](https://hoopR.sportsdataverse.org/reference/scb_referees.md),
[`scb_season_player()`](https://hoopR.sportsdataverse.org/reference/scb_season_player.md),
[`scb_season_players()`](https://hoopR.sportsdataverse.org/reference/scb_season_players.md),
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_player_statistics(season = 2026))
#> ── BBL/DBBL Season Player Statistics from the SCB API ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:45:34 UTC
#> # A tibble: 316 × 72
#>    league season display_type season_player_id real_player_id first_name 
#>    <chr>   <int> <chr>        <chr>                     <int> <chr>      
#>  1 bbl      2026 MAIN_ROUND   2002018               140181613 Christopher
#>  2 bbl      2026 MAIN_ROUND   2001330                   52879 Jordan     
#>  3 bbl      2026 MAIN_ROUND   2001642               140181412 Alonzo     
#>  4 bbl      2026 MAIN_ROUND   2001591               140181388 Marcus     
#>  5 bbl      2026 MAIN_ROUND   2001861               140181529 Isaiah     
#>  6 bbl      2026 MAIN_ROUND   2001900               140181547 Joe        
#>  7 bbl      2026 MAIN_ROUND   2000735                   59862 Ibi        
#>  8 bbl      2026 MAIN_ROUND   2001687               140181424 Tevin      
#>  9 bbl      2026 MAIN_ROUND   2001520                   56766 TJ         
#> 10 bbl      2026 MAIN_ROUND   2001477               140181343 Davion     
#> # ℹ 306 more rows
#> # ℹ 66 more variables: last_name <chr>, shirt_number <chr>, position <chr>,
#> #   team_id <chr>, season_team_id <chr>, team_name <chr>, team_tlc <chr>,
#> #   season_id <int>, round_code <int>, competition <chr>, seconds_played <int>,
#> #   points <int>, two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, …
# }
```
