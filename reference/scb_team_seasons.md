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
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`scb_team_seasons`):

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
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_team_seasons(team_id = "413"))
#> ── BBL/DBBL Team Seasons from the SCB API ────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:01:59 UTC
#> # A tibble: 52 × 8
#>    league team_id season season_id season_team_id team_name         
#>    <chr>  <chr>    <int>     <int> <chr>          <chr>             
#>  1 bbl    413       1976      1975 413            DTV Charlottenburg
#>  2 bbl    413       1977      1976 413            DTV Charlottenburg
#>  3 bbl    413       1978      1977 413            DTV Charlottenburg
#>  4 bbl    413       1979      1978 413            DTV Charlottenburg
#>  5 bbl    413       1980      1979 413            DTV Charlottenburg
#>  6 bbl    413       1981      1980 413            DTV Charlottenburg
#>  7 bbl    413       1982      1981 413            DTV Charlottenburg
#>  8 bbl    413       1983      1982 413            DTV Charlottenburg
#>  9 bbl    413       1984      1983 413            DTV Charlottenburg
#> 10 bbl    413       1985      1984 413            DTV Charlottenburg
#> # ℹ 42 more rows
#> # ℹ 2 more variables: is_championship_winner <lgl>, is_cup_winner <lgl>
# }
```
