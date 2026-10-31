# **Get BBL / DBBL Team Profile**

Club profile: names, code, home page, ticket shop, year joined and
honours.

Endpoint: `GET https://api.basketball-bundesliga.de/teams/{team_id}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_team(team_id, league = "bbl")
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

A `hoopR_data` tibble: Club profile: names, code, home page, ticket
shop, year joined and honours. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_team`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
| tlc | character | Three-letter club code. |
| name_full | character | Full club name as the API lists it today. |
| name_short | character | Short name (often the city); null on DBBL. |
| mascot | character | Club mascot name (null when none). |
| homepage_url | character | Club website address as sent (it can lack the scheme). |
| ticket_url | character | Ticket shop URL. |
| year_joined_bbl | integer | Year the club joined the league. |
| order_id | integer | Display order of the club on the site; null on some clubs. |
| best_achievements | character | Honours, German free text (Deutscher Meister = German champion, Pokalsieger = cup winner, Vizepokalsieger = cup runner-up). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_team(team_id = "413")

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
[`scb_records_per_game()`](https://hoopR.sportsdataverse.org/reference/scb_records_per_game.md),
[`scb_records_season_averages()`](https://hoopR.sportsdataverse.org/reference/scb_records_season_averages.md),
[`scb_referees()`](https://hoopR.sportsdataverse.org/reference/scb_referees.md),
[`scb_season_player()`](https://hoopR.sportsdataverse.org/reference/scb_season_player.md),
[`scb_season_players()`](https://hoopR.sportsdataverse.org/reference/scb_season_players.md),
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)
