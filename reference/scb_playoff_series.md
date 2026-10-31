# **Get BBL / DBBL Playoff Series**

Playoff bracket of a season: one row per series (quarter-finals,
semi-finals, finals).

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/playoff-tree`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_playoff_series(season, league = "bbl")
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

A `hoopR_data` tibble: Playoff bracket of a season: one row per series
(quarter-finals, semi-finals, finals). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_playoff_series`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| round | character | Round of the bracket: `quarter_finals`, `semi_finals` or `finals`. |
| series | integer | 1-based position of the series within its round, in the order the API lists them. |
| match_winner_id | character | Season-team id of the series winner, a string (the playoff tree sends an integer). |
| is_match_finished | logical | The series is decided. |
| team_a_id | character | Season-team id of series team A (the higher seed is A), a string (the playoff tree sends it as an integer); equals the club team id. |
| team_a_name | character | Name of series team A (the higher seed is A) as listed that season. |
| team_a_tlc | character | Three-letter club code of series team A (the higher seed is A). |
| team_a_rank | integer | Regular-season table position (the seed) of series team A (the higher seed is A). |
| team_a_victories | integer | Series wins of team A. |
| team_b_id | character | Season-team id of series team B (the higher seed is A), a string (the playoff tree sends it as an integer); equals the club team id. |
| team_b_name | character | Name of series team B (the higher seed is A) as listed that season. |
| team_b_tlc | character | Three-letter club code of series team B (the higher seed is A). |
| team_b_rank | integer | Regular-season table position (the seed) of series team B (the higher seed is A). |
| team_b_victories | integer | Series wins of team B. |
| games | integer | Games of the series. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_playoff_series(season = 2026)

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
