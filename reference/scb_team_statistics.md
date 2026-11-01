# **Get BBL / DBBL Season Team Statistics**

Season team stat table: totals and per-game values, one row per team and
stat block.

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/team-statistics`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_team_statistics(season, league = "bbl", display_type = "MAIN_ROUND")
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

- display_type:

  (default `"MAIN_ROUND"`) Which games the table covers: MAIN_ROUND
  (regular season), PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS
  or CUP.

## Value

A `hoopR_data` tibble: Season team stat table: totals and per-game
values, one row per team and stat block. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_team_statistics`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| display_type | character | Which games the table covers, echoed from the request (MAIN_ROUND, PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP). |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| team_tlc | character | Three-letter club code. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| round_code | integer | Provider round code; 1 for MAIN_ROUND in every sample (mapping unverified). |
| competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
| aggregation | character | Aggregation label as sent: STAGE in player tables, MAIN_ROUND in team tables. |
| seconds_played | integer | The team's season total playing time in SECONDS over displayType. |
| points | integer | The team's season total points over displayType. |
| two_point_shots_made | integer | The team's season total 2-point field goals made over displayType. |
| two_point_shots_attempted | integer | The team's season total 2-point field goals attempted over displayType. |
| two_point_shot_success_percent | double | The team's season total 2-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| three_point_shots_made | integer | The team's season total 3-point field goals made over displayType. |
| three_point_shots_attempted | integer | The team's season total 3-point field goals attempted over displayType. |
| three_point_shot_success_percent | double | The team's season total 3-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| field_goals_made | integer | The team's season total field goals made over displayType. |
| field_goals_attempted | integer | The team's season total field goals attempted over displayType. |
| field_goals_success_percent | double | The team's season total field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| free_throws_made | integer | The team's season total free throws made over displayType. |
| free_throws_attempted | integer | The team's season total free throws attempted over displayType. |
| free_throws_success_percent | double | The team's season total free-throw percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
| offensive_rebounds | integer | The team's season total offensive rebounds over displayType. |
| defensive_rebounds | integer | The team's season total defensive rebounds over displayType. |
| total_rebounds | integer | The team's season total rebounds (offensive + defensive) over displayType. |
| assists | integer | The team's season total assists over displayType. |
| steals | integer | The team's season total steals over displayType. |
| turnovers | integer | The team's season total turnovers over displayType. |
| blocks | integer | The team's season total blocked shots over displayType. |
| fouls_committed | integer | The team's season total fouls committed over displayType. |
| efficiency | integer | The team's season total efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) over displayType. |
| plus_minus | integer | The team's season total plus-minus over displaytype. |
| games_played | integer | The team's season total games played over displayType. |
| seconds_per_game | double | Per-game average of seconds, seconds. |
| points_per_game | double | Per-game average of points. |
| two_point_shots_made_per_game | double | Per-game average of 2-point field goals made. |
| two_point_shots_attempted_per_game | double | Per-game average of 2-point field goals attempted. |
| three_point_shots_made_per_game | double | Per-game average of 3-point field goals made. |
| three_point_shots_attempted_per_game | double | Per-game average of 3-point field goals attempted. |
| field_goals_made_per_game | double | Per-game average of field goals made. |
| field_goals_attempted_per_game | double | Per-game average of field goals attempted. |
| field_goals_success_percent_per_game | double | Per-game average of field-goal percentage (0 in every sample: unusable). |
| free_throws_made_per_game | double | Per-game average of free throws made. |
| free_throws_attempted_per_game | double | Per-game average of free throws attempted. |
| defensive_rebounds_per_game | double | Per-game average of defensive rebounds. |
| offensive_rebounds_per_game | double | Per-game average of offensive rebounds. |
| total_rebounds_per_game | double | Per-game average of rebounds (offensive + defensive). |
| assists_per_game | double | Per-game average of assists. |
| steals_per_game | double | Per-game average of steals. |
| turnovers_per_game | double | Per-game average of turnovers. |
| blocks_per_game | double | Per-game average of blocked shots. |
| fouls_committed_per_game | double | Per-game average of fouls committed. |
| efficiency_per_game | double | Per-game average of efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score). |
| plus_minus_per_game | double | Per-game average of plus-minus (point margin while on court). |
| double_double | integer | The team's season total double-doubles over displayType. |
| double_double_per_game | double | Per-game average of double-doubles. |

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
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_team_statistics(season = 2026))
#> ── BBL/DBBL Season Team Statistics from the SCB API ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:44:21 UTC
#> # A tibble: 18 × 59
#>    league season display_type team_id season_team_id team_name          team_tlc
#>    <chr>   <int> <chr>        <chr>   <chr>          <chr>              <chr>   
#>  1 bbl      2026 MAIN_ROUND   486     486            FC Bayern München… FCB     
#>  2 bbl      2026 MAIN_ROUND   483     483            Science City Jena  JEN     
#>  3 bbl      2026 MAIN_ROUND   422     422            Basketball Löwen … BRA     
#>  4 bbl      2026 MAIN_ROUND   420     420            BMA365 Bamberg Ba… BAM     
#>  5 bbl      2026 MAIN_ROUND   541     541            RASTA Vechta       VEC     
#>  6 bbl      2026 MAIN_ROUND   488     488            MLP Academics Hei… HDB     
#>  7 bbl      2026 MAIN_ROUND   415     415            Telekom Baskets B… BON     
#>  8 bbl      2026 MAIN_ROUND   540     540            Fitness First Wür… WUE     
#>  9 bbl      2026 MAIN_ROUND   554     554            Veolia Towers Ham… HAM     
#> 10 bbl      2026 MAIN_ROUND   428     428            SYNTAINICS MBC     MBC     
#> 11 bbl      2026 MAIN_ROUND   414     414            VET-CONCEPT Gladi… TRI     
#> 12 bbl      2026 MAIN_ROUND   551     551            ROSTOCK SEAWOLVES  HRO     
#> 13 bbl      2026 MAIN_ROUND   418     418            ratiopharm ulm     ULM     
#> 14 bbl      2026 MAIN_ROUND   485     485            NINERS Chemnitz    CHE     
#> 15 bbl      2026 MAIN_ROUND   430     430            EWE Baskets Olden… OLD     
#> 16 bbl      2026 MAIN_ROUND   426     426            SKYLINERS          FRS     
#> 17 bbl      2026 MAIN_ROUND   433     433            MHP RIESEN Ludwig… LUD     
#> 18 bbl      2026 MAIN_ROUND   413     413            ALBA BERLIN        BER     
#> # ℹ 52 more variables: season_id <int>, round_code <int>, competition <chr>,
#> #   aggregation <chr>, seconds_played <int>, points <int>,
#> #   two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, three_point_shot_success_percent <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_success_percent <dbl>, free_throws_made <int>, …
# }
```
