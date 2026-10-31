# **Get BBL / DBBL Standings**

League table of a season: record, home / away split, streaks and
tie-break detail (2005-06 on).

Endpoint: `GET https://api.basketball-bundesliga.de/standings` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_standings(league = "bbl", season = NULL, competition = NULL)
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- season:

  (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent
  to the API as its START-year seasonId (season - 1). Omitted = the
  season in progress. Seasons before about 2000 answer an empty table.

- competition:

  (default `NULL`) Competition: BBL, BBL_CUP, ALLSTAR, CHAMPIONS_CUP
  (BBL host) or DBBL, DBBL_CUP (DBBL host). BBL_CUP answers an empty
  table.

## Value

A `hoopR_data` tibble: League table of a season: record, home / away
split, streaks and tie-break detail (2005-06 on). An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `scb_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| standing_id | character | Opaque id of the standings row, a string. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). An integer here. |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| team_name | character | Team name; null on some rows. |
| team_tlc | character | Three-letter club code. |
| team_name_short | character | Short team name (null on DBBL). |
| has_reached_playoffs | logical | Clinched a playoff place. |
| has_reached_playins | logical | Clinched at least the play-ins. |
| is_relegation_certain | logical | Relegated for certain. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
| stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
| rank | integer | Table position. |
| streak | character | Current streak: W or L; empty when none. |
| streak_count | integer | Length of the current streak. |
| point_corrections | character | Table-point deductions; \[\] in every sample. |
| home_victories | integer | Home games: wins. |
| home_losses | integer | Home games: number of losses in the table. |
| home_victory_percentage | double | Home games: win percentage, 0-100. |
| away_victories | integer | Away games: wins. |
| away_losses | integer | Away games: number of losses in the table. |
| away_victory_percentage | double | Away games: win percentage, 0-100. |
| table_points | integer | Table points scored (2 per win), from the API's `totalPointsMade`; the provider's notes call its 'Points' fields table points. |
| table_points_against | integer | Table points conceded (2 per loss), from the API's `totalPointsAgainst`; per the provider's notes, table points. |
| total_victory_percentage | double | All games: win percentage, 0-100. |
| total_games | integer | Games played in the table (home and away together). |
| total_victories | integer | All games: wins. |
| total_losses | integer | Losses in the table over all games. |
| last10_victories | integer | Wins in the last 10 games. |
| last10_losses | integer | Losses in the last 10 games. |
| last10_percentage | double | Win percentage over the last 10 games, 0-100. |
| last10_outcomes | character | Results of the last games, newest first: W or L. |
| home_last10_victories | integer | Home games: last 10 games, wins. |
| home_last10_losses | integer | Home games: last 10 games, losses. |
| home_last10_victory_percentage | double | Home games: last 10 games, win percentage, 0-100. |
| home_streak | character | Home games: current streak, W or L. |
| home_streak_count | integer | Home games: length of the current streak. |
| away_last10_victories | integer | Away games: last 10 games, wins. |
| away_last10_losses | integer | Away games: last 10 games, losses. |
| away_last10_victory_percentage | double | Away games: last 10 games, win percentage, 0-100. |
| away_streak | character | Away games: current streak, W or L. |
| away_streak_count | integer | Away games: length of the current streak. |
| updated_date | character | Last update of the row, ISO 8601 UTC. |
| ranking_comparison_info | character | Tie-break detail among teams level on record. |
| home_points_for | integer | Home games: basketball points scored (the API's football-style `GoalsMade`). |
| away_points_for | integer | Away games: basketball points scored (the API's football-style `GoalsMade`). |
| total_points_for | integer | All games: basketball points scored (the API's football-style `GoalsMade`). |
| home_points_against | integer | Home games: basketball points allowed (the API's football-style `GoalsAgainst`). |
| away_points_against | integer | Away games: basketball points allowed (the API's football-style `GoalsAgainst`). |
| total_points_against | integer | All games: basketball points allowed (the API's football-style `GoalsAgainst`). |
| home_point_difference | integer | Home games: point differential, scored minus allowed (the API's `GoalDifference`). |
| away_point_difference | integer | Away games: point differential, scored minus allowed (the API's `GoalDifference`). |
| total_point_difference | integer | All games: point differential, scored minus allowed (the API's `GoalDifference`). |

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
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_standings())
#> ── BBL/DBBL Standings from the SCB API ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:36:07 UTC
#> # A tibble: 18 × 55
#>    league season standing_id season_team_id team_id team_name           team_tlc
#>    <chr>   <int> <chr>       <chr>          <chr>   <chr>               <chr>   
#>  1 bbl      2027 74719       486            486     FC Bayern München … FCB     
#>  2 bbl      2027 74708       414            414     VET-CONCEPT Gladia… TRI     
#>  3 bbl      2027 74713       426            426     SKYLINERS           FRS     
#>  4 bbl      2027 74714       428            428     SYNTAINICS MBC      MBC     
#>  5 bbl      2027 74720       540            540     Fitness First Würz… WUE     
#>  6 bbl      2027 74716       433            433     MHP RIESEN Ludwigs… LUD     
#>  7 bbl      2027 74711       420            420     BMA365 Bamberg Bas… BAM     
#>  8 bbl      2027 74712       422            422     Basketball Löwen B… BRA     
#>  9 bbl      2027 74709       415            415     Telekom Baskets Bo… BON     
#> 10 bbl      2027 74722       551            551     ROSTOCK SEAWOLVES   HRO     
#> 11 bbl      2027 74707       413            413     ALBA BERLIN         BER     
#> 12 bbl      2027 74710       418            418     ratiopharm ulm      ULM     
#> 13 bbl      2027 74715       430            430     EWE Baskets Oldenb… OLD     
#> 14 bbl      2027 74717       483            483     Science City Jena   JEN     
#> 15 bbl      2027 74721       541            541     RASTA Vechta        VEC     
#> 16 bbl      2027 74785       473            473     Phoenix Hagen       HAG     
#> 17 bbl      2027 74723       554            554     Veolia Towers Hamb… HAM     
#> 18 bbl      2027 74718       485            485     NINERS Chemnitz     CHE     
#> # ℹ 48 more variables: team_name_short <chr>, has_reached_playoffs <lgl>,
#> #   has_reached_playins <lgl>, is_relegation_certain <lgl>, season_id <int>,
#> #   competition <chr>, stage <chr>, rank <int>, streak <chr>,
#> #   streak_count <int>, point_corrections <chr>, home_victories <int>,
#> #   home_losses <int>, home_victory_percentage <dbl>, away_victories <int>,
#> #   away_losses <int>, away_victory_percentage <dbl>, table_points <int>,
#> #   table_points_against <int>, total_victory_percentage <dbl>, …
# }
```
