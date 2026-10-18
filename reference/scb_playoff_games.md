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
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`scb_playoff_games`):

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
  try(scb_playoff_games(season = 2026))
#> ── BBL/DBBL Playoff Games from the SCB API ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:01:47 UTC
#> # A tibble: 29 × 15
#>    league season season_id round         series game_id scheduled_time timestamp
#>    <chr>   <int>     <int> <chr>          <int> <chr>   <chr>              <int>
#>  1 bbl      2026      2025 quarter_fina…      1 2005742 2026-05-17T14…    1.78e9
#>  2 bbl      2026      2025 quarter_fina…      1 2005743 2026-05-19T18…    1.78e9
#>  3 bbl      2026      2025 quarter_fina…      1 2005744 2026-05-23T12…    1.78e9
#>  4 bbl      2026      2025 quarter_fina…      2 2005747 2026-05-16T18…    1.78e9
#>  5 bbl      2026      2025 quarter_fina…      2 2005748 2026-05-18T16…    1.78e9
#>  6 bbl      2026      2025 quarter_fina…      2 2005749 2026-05-22T18…    1.78e9
#>  7 bbl      2026      2025 quarter_fina…      2 2005750 2026-05-24T14…    1.78e9
#>  8 bbl      2026      2025 quarter_fina…      2 2005751 2026-05-27T18…    1.78e9
#>  9 bbl      2026      2025 quarter_fina…      3 2005757 2026-05-17T16…    1.78e9
#> 10 bbl      2026      2025 quarter_fina…      3 2005758 2026-05-19T16…    1.78e9
#> # ℹ 19 more rows
#> # ℹ 7 more variables: game_winner_id <chr>, home_team_id <chr>,
#> #   guest_team_id <chr>, team_a_id <chr>, team_b_id <chr>, points_team_a <int>,
#> #   points_team_b <int>
# }
```
