# **Get BBL / DBBL Team Seasons**

Every season a club played: its name that season and its championship
and cup titles.

Endpoint: `GET https://api.basketball-bundesliga.de/teams/{team_id}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_team_seasons(team_id, league = "bbl")
```

## Arguments

- team_id:

  (required) Club id (`team_id` in `scb_season_teams`), e.g. 413 (ALBA
  BERLIN).

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: Every season a club played: its name that season
and its championship and cup titles. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_team_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| season_team_id | character | Season-team id, a string; equal to the club `team_id` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| team_name | character | Team name as listed that season (sponsor names included). |
| is_championship_winner | logical | Won the championship that season. |
| is_cup_winner | logical | Won the cup that season. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_team_seasons(team_id = "413")

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
