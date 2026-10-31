# **Get BBL / DBBL Single-Game Records**

Single-game records: the season's and the all-time ones, one row per
record.

Endpoint:
`GET https://api.basketball-bundesliga.de/records/per-game/{season}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_records_per_game(season, league = "bbl")
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

## Value

A `hoopR_data` tibble: Single-game records: the season's and the
all-time ones, one row per record. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_records_per_game`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
| scope | character | `season` for the requested season's records, `all_time` for the all-time list. |
| stat | character | The record's stat: points, rebounds, assists, steals, blocks, turnovers, efficiency, free_throws_made, three_point_shots_made or free_throws_success_percentage. |
| place | integer | Rank within the list (1 = best); 0 on some rows. |
| all_time_place | integer | Rank on the all-time list; null when not on it. |
| order_id | integer | Sort order within the list. |
| all_time_order_id | integer | Sort order on the all-time list; null when not on it. |
| value | double | The record value. A STRING in /records/per-game ('52'); a number in /records/season-averages. |
| ratio | double | \[made, attempted\] as strings, on percentage records only; null otherwise. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| team_name | character | Team name as listed that season (sponsor names included). |
| team_tlc | character | The player's team code. |
| home_tlc | character | Three-letter code of the home team of the record game. |
| guest_tlc | character | Three-letter code of the guest team of the record game. |
| game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
| scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_records_per_game(season = 2026)

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_player_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_player_statistics.md),
[`scb_playoff_games()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_games.md),
[`scb_playoff_series()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_series.md),
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
