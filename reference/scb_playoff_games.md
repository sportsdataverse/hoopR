# **Get BBL / DBBL Playoff Games**

Every playoff game of a season with its series and the points of each
series team.

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/playoff-tree`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_playoff_games(season, league = "bbl")
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

A `hoopR_data` tibble: Every playoff game of a season with its series
and the points of each series team. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_playoff_games`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
| round | character | Round of the bracket: `quarter_finals`, `semi_finals` or `finals`. |
| series | integer | 1-based position of the game's series within its round, in the order the API lists them. |
| game_id | character | Game id, a string (the playoff tree sends an integer); joins `scb_games.game_id`. |
| scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
| timestamp | integer | Tip-off, Unix seconds. |
| game_winner_id | character | Season-team id of the game winner, a string (the playoff tree sends an integer). |
| home_team_id | character | Season-team id of the home team, a string (the playoff tree sends an integer). |
| guest_team_id | character | Season-team id of the guest (away) team, a string (the playoff tree sends an integer). |
| team_a_id | character | Season-team id of the series' team A (the higher seed); `points_team_a` is its score, whichever side hosted. |
| team_b_id | character | Season-team id of the series' team B; `points_team_b` is its score, whichever side hosted. |
| points_team_a | integer | Team A's points in the game. |
| points_team_b | integer | Team B's points in the game. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_playoff_games(season = 2026)

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
