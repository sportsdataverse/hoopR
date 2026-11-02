# **Get BBL / DBBL Season Teams**

Every team of a season: club id, season-team id, name and three-letter
code.

Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_season_teams(season, league = "bbl")
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

A `hoopR_data` tibble: Every team of a season: club id, season-team id,
name and three-letter code. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_season_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| team_name | character | Team name as listed that season (sponsor names included). |
| tlc | character | Three-letter club code. |
| logo_url | character | Logo image URL (per season). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

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
  try(scb_season_teams(season = 2026))
#> ── BBL/DBBL Season Teams from the SCB API ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:56:23 UTC
#> # A tibble: 18 × 8
#>    league season season_id team_id season_team_id team_name       tlc   logo_url
#>    <chr>   <int>     <int> <chr>   <chr>          <chr>           <chr> <chr>   
#>  1 bbl      2026      2025 488     488            MLP Academics … HDB   https:/…
#>  2 bbl      2026      2025 413     413            ALBA BERLIN     BER   https:/…
#>  3 bbl      2026      2025 486     486            FC Bayern Münc… FCB   https:/…
#>  4 bbl      2026      2025 420     420            BMA365 Bamberg… BAM   https:/…
#>  5 bbl      2026      2025 415     415            Telekom Basket… BON   https:/…
#>  6 bbl      2026      2025 540     540            Fitness First … WUE   https:/…
#>  7 bbl      2026      2025 418     418            ratiopharm ulm  ULM   https:/…
#>  8 bbl      2026      2025 541     541            RASTA Vechta    VEC   https:/…
#>  9 bbl      2026      2025 414     414            VET-CONCEPT Gl… TRI   https:/…
#> 10 bbl      2026      2025 551     551            ROSTOCK SEAWOL… HRO   https:/…
#> 11 bbl      2026      2025 433     433            MHP RIESEN Lud… LUD   https:/…
#> 12 bbl      2026      2025 430     430            EWE Baskets Ol… OLD   https:/…
#> 13 bbl      2026      2025 485     485            NINERS Chemnitz CHE   https:/…
#> 14 bbl      2026      2025 428     428            SYNTAINICS MBC  MBC   https:/…
#> 15 bbl      2026      2025 554     554            Veolia Towers … HAM   https:/…
#> 16 bbl      2026      2025 426     426            SKYLINERS       FRS   https:/…
#> 17 bbl      2026      2025 483     483            Science City J… JEN   https:/…
#> 18 bbl      2026      2025 422     422            Basketball Löw… BRA   https:/…
# }
```
