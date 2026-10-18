# **Get BBL / DBBL Game Player Box Score**

Box score of a finished game: one row per player line of both teams
(2002-03 on).

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_players(game_id, league = "bbl")
```

## Arguments

- game_id:

  (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or
  10130 (DBBL). One sequence per league.

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: Box score of a finished game: one row per player
line of both teams (2002-03 on). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`scb_game_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| side | character | `home` or `guest` (the away side), for the team the row belongs to. |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| shirt_number | character | Jersey number. A number or a numeric string across rows. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| team_tlc | character | Three-letter club code. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| seconds_played | integer | The player's playing time in SECONDS in the game. |
| points | integer | The player's points in the game. |
| two_point_shots_made | integer | The player's 2-point field goals made in the game. |
| two_point_shots_attempted | integer | The player's 2-point field goals attempted in the game. |
| two_point_shot_success_percent | double | The player's 2-point field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
| three_point_shots_made | integer | The player's 3-point field goals made in the game. |
| three_point_shots_attempted | integer | The player's 3-point field goals attempted in the game. |
| three_point_shot_success_percent | double | The player's 3-point field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
| field_goals_made | integer | The player's field goals made in the game. |
| field_goals_attempted | integer | The player's field goals attempted in the game. |
| field_goals_success_percent | double | The player's field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
| free_throws_made | integer | The player's free throws made in the game. |
| free_throws_attempted | integer | The player's free throws attempted in the game. |
| free_throws_success_percent | double | The player's free-throw percentage in the game, 0-100 (one decimal); 0 when no attempts. |
| offensive_rebounds | integer | The player's offensive rebounds in the game. |
| defensive_rebounds | integer | The player's defensive rebounds in the game. |
| total_rebounds | integer | The player's rebounds (offensive + defensive) in the game. |
| assists | integer | The player's assists in the game. |
| steals | integer | The player's steals in the game. |
| turnovers | integer | The player's turnovers in the game. |
| blocks | integer | The player's blocked shots in the game. |
| fouls_committed | integer | The player's fouls committed in the game. |
| efficiency | integer | The player's efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) in the game. |
| plus_minus | integer | The player's plus-minus (point margin while on court); null when the API sends an empty string (2005-06). |
| is_starting_five | logical | Started the game. |
| double_double | integer | The player's double-doubles in the game. |
| triple_double | integer | The player's triple-doubles in the game. |
| fouls_received | integer | The player's fouls drawn in the game. |
| opponent_team_name | character | Opponent's name. |
| field_goals_recomputed | logical | True when the API's field-goal totals disagreed with its 2-point plus 3-point parts (2005-06 box scores) and were recomputed from the parts. |

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
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_player_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_player_statistics.md),
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
  try(scb_game_players(game_id = "2006920"))
#> ── BBL/DBBL Game Player Box Score from the SCB API ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:49:04 UTC
#> # A tibble: 23 × 45
#>    league game_id season side  team_id season_player_id real_player_id
#>    <chr>  <chr>    <int> <chr> <chr>   <chr>                     <int>
#>  1 bbl    2006920   2027 home  413     56414                     37539
#>  2 bbl    2006920   2027 home  413     2001679                   40635
#>  3 bbl    2006920   2027 home  413     56377                     42293
#>  4 bbl    2006920   2027 home  413     1000868                   42321
#>  5 bbl    2006920   2027 home  413     2004104                   45523
#>  6 bbl    2006920   2027 home  413     2004358                   51576
#>  7 bbl    2006920   2027 home  413     2001680                   56949
#>  8 bbl    2006920   2027 home  413     57252                     57252
#>  9 bbl    2006920   2027 home  413     2002150               140180627
#> 10 bbl    2006920   2027 home  413     2004102               140181547
#> # ℹ 13 more rows
#> # ℹ 38 more variables: first_name <chr>, last_name <chr>, shirt_number <chr>,
#> #   position <chr>, season_team_id <chr>, team_name <chr>, team_tlc <chr>,
#> #   season_id <int>, seconds_played <int>, points <int>,
#> #   two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, …
# }
```
