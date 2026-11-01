# **Get BBL / DBBL Game Play-by-Play**

Play-by-play of a finished game with shot x/y (BBL 2008-09 on, DBBL
2024-25 on).

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_actions(game_id, league = "bbl")
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

A `hoopR_data` tibble: Play-by-play of a finished game with shot x/y
(BBL 2008-09 on, DBBL 2024-25 on). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_game_actions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
| action_id | integer | Action id, an integer unique across games of a league. |
| order_id | integer | Chronological sequence of the action within the game. |
| action_identifier | character | Provider action key `<n>:<seq>` (opaque; the first part is not the period). |
| period | integer | Period: 1-4 quarters, 5+ overtimes. |
| game_time | character | Game clock as HH:MM:SS: in an action, the time LEFT in the period (00:10:00 at the start of a 10-minute quarter); in a game header, 00:00:00 in every sample. |
| seconds_left | integer | Seconds left in the period at the action: `game_time` as seconds. |
| real_time | character | Wall-clock time of the action, ISO 8601 UTC. Pre-2011 games carry a placeholder: local midnight of the game day (23:00 UTC the day before) on every row. |
| type | character | Action type; see the action-type table. Records and videos use their own `type` (see those routes). |
| qualifiers | character | Action qualifiers (shot kind, rebound side, foul kind, turnover kind); see the qualifier table. |
| is_successful | logical | Made / successful (shots, free throws); for other types see the action-type table. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| side | character | `home` or `guest` (the away side), for the team the row belongs to. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. Null on team and period rows. |
| assisting_season_player_id | character | Season-player id of the assisting player; only on assisted made shots. Joins to box-score `seasonPlayer.id` and action `seasonPlayerId`. |
| shot_x | integer | Shot x on the site's half-court chart (0-280 across, 140 through the rim); null without a location. Scale and orientation unverified. |
| shot_y | integer | Shot y along the court from behind the baseline (rim near 45, arc top near 147); null without a location. Scale and orientation unverified. |
| home_team_points | integer | Home score after this action; only on scoring actions. |
| guest_team_points | integer | Guest score after this action; only on scoring actions. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
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
  try(scb_game_actions(game_id = "2006920"))
#> ── BBL/DBBL Game Play-by-Play from the SCB API ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:48:53 UTC
#> # A tibble: 516 × 20
#>    league game_id action_id order_id action_identifier period game_time
#>    <chr>  <chr>       <int>    <int> <chr>              <int> <chr>    
#>  1 bbl    2006920  20224750        1 0:0002                 1 00:10:00 
#>  2 bbl    2006920  20224751        2 3:0012                 1 00:10:00 
#>  3 bbl    2006920  20224752        3 3:0013                 1 00:09:47 
#>  4 bbl    2006920  20224753        4 3:0014                 1 00:09:21 
#>  5 bbl    2006920  20224754        5 3:0015                 1 00:09:21 
#>  6 bbl    2006920  20224755        6 3:0016                 1 00:09:17 
#>  7 bbl    2006920  20224756        7 3:0018                 1 00:09:07 
#>  8 bbl    2006920  20224757        8 3:0020                 1 00:08:50 
#>  9 bbl    2006920  20224758        9 3:0021                 1 00:08:50 
#> 10 bbl    2006920  20224759       10 3:0022                 1 00:08:43 
#> # ℹ 506 more rows
#> # ℹ 13 more variables: seconds_left <int>, real_time <chr>, type <chr>,
#> #   qualifiers <chr>, is_successful <lgl>, season_team_id <chr>, side <chr>,
#> #   season_player_id <chr>, assisting_season_player_id <chr>, shot_x <int>,
#> #   shot_y <int>, home_team_points <int>, guest_team_points <int>
# }
```
