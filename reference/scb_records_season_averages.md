# **Get BBL / DBBL Season-Average Records**

All-time season-average records (points, rebounds, assists, ...), one
row per record.

Endpoint:
`GET https://api.basketball-bundesliga.de/records/season-averages`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_records_season_averages(league = "bbl")
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: All-time season-average records (points,
rebounds, assists, ...), one row per record. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `scb_records_season_averages`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| stat | character | The record's stat list: assist_average, block_average, efficiency_average, foul_average, free_throws_success_percentage, points_average, rebound_average, steal_average, three_point_shot_average or turnover_average. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| place | integer | Rank within the list (1 = best); 0 on some rows. |
| order_id | integer | Sort order within the list. |
| value | numeric | The record value. A STRING in /records/per-game ('52'); a number in /records/season-averages. |
| ratio | numeric | \[made, attempted\] as strings, on percentage records only; null otherwise. |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| team_name | character | Team name as listed that season (sponsor names included). |
| team_tlc | character | The player's team code. |

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
  try(scb_records_season_averages())
#> ── BBL/DBBL Season-Average Records from the SCB API ──────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:01:50 UTC
#> # A tibble: 200 × 14
#>    league stat      season season_id place order_id value ratio season_player_id
#>    <chr>  <chr>      <int>     <int> <int>    <int> <dbl> <dbl> <chr>           
#>  1 bbl    assist_a…   2022      2021     1        1  9.67    NA 50133           
#>  2 bbl    assist_a…   2020      2019     2        2  8.85    NA 44602           
#>  3 bbl    assist_a…   2016      2015     3        3  8.48    NA 35615           
#>  4 bbl    assist_a…   2017      2016     4        4  8.15    NA 36064           
#>  5 bbl    assist_a…   2012      2011     5        5  8.11    NA 21453           
#>  6 bbl    assist_a…   2019      2018     6        6  8.1     NA 42614           
#>  7 bbl    assist_a…   2019      2018     7        7  7.84    NA 41300           
#>  8 bbl    assist_a…   2017      2016     7        8  7.84    NA 36158           
#>  9 bbl    assist_a…   2013      2012     8        9  7.79    NA 24161           
#> 10 bbl    assist_a…   2014      2013     9       10  7.78    NA 28137           
#> # ℹ 190 more rows
#> # ℹ 5 more variables: real_player_id <int>, first_name <chr>, last_name <chr>,
#> #   team_name <chr>, team_tlc <chr>
# }
```
