# **Get BBL / DBBL Game Team Box Score**

Box score of a finished game: one row per team, with the head coach and
the team line.

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_teams(game_id, league = "bbl")
```

## Arguments

- game_id:

  (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or
  10130 (DBBL). One sequence per league.

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: Box score of a finished game: one row per team,
with the head coach and the team line. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_game_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| side | character | `home` or `guest` (the away side), for the team the row belongs to. |
| team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| head_coach_name | character | Name of the team's head coach. |
| status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official) or OFFICIAL (final). |
| scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| season_id | integer | Season, START year (2026 = 2026-27). |
| team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| team_tlc | character | Three-letter club code. |
| competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
| stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
| seconds_played | integer | The team's playing time in SECONDS in the game (players plus the team line) (12000 = 5 x 40 min). |
| points | integer | The team's points in the game (players plus the team line). |
| two_point_shots_made | integer | The team's 2-point field goals made in the game (players plus the team line). |
| two_point_shots_attempted | integer | The team's 2-point field goals attempted in the game (players plus the team line). |
| two_point_shot_success_percent | double | The team's 2-point field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
| three_point_shots_made | integer | The team's 3-point field goals made in the game (players plus the team line). |
| three_point_shots_attempted | integer | The team's 3-point field goals attempted in the game (players plus the team line). |
| three_point_shot_success_percent | double | The team's 3-point field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
| field_goals_made | integer | The team's field goals made in the game (players plus the team line). |
| field_goals_attempted | integer | The team's field goals attempted in the game (players plus the team line). |
| field_goals_success_percent | double | The team's field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
| free_throws_made | integer | The team's free throws made in the game (players plus the team line). |
| free_throws_attempted | integer | The team's free throws attempted in the game (players plus the team line). |
| free_throws_success_percent | double | The team's free-throw percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
| offensive_rebounds | integer | The team's offensive rebounds in the game (players plus the team line). |
| defensive_rebounds | integer | The team's defensive rebounds in the game (players plus the team line). |
| total_rebounds | integer | The team's rebounds (offensive + defensive) in the game (players plus the team line). |
| assists | integer | The team's assists in the game (players plus the team line). |
| steals | integer | The team's steals in the game (players plus the team line). |
| turnovers | integer | The team's turnovers in the game (players plus the team line). |
| blocks | integer | The team's blocked shots in the game (players plus the team line). |
| fouls_committed | integer | The team's fouls committed in the game (players plus the team line). |
| efficiency | integer | The team's efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) in the game (players plus the team line). |
| plus_minus | integer | The team's point margin in the game. |
| team_line_seconds_played | integer | Team-line playing time in SECONDS (not credited to a player). |
| team_line_points | integer | Team-line points (not credited to a player). |
| team_line_two_point_shots_made | integer | Team-line 2-point field goals made (not credited to a player). |
| team_line_two_point_shots_attempted | integer | Team-line 2-point field goals attempted (not credited to a player). |
| team_line_two_point_shot_success_percent | double | Team-line 2-point field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
| team_line_three_point_shots_made | integer | Team-line 3-point field goals made (not credited to a player). |
| team_line_three_point_shots_attempted | integer | Team-line 3-point field goals attempted (not credited to a player). |
| team_line_three_point_shot_success_percent | double | Team-line 3-point field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
| team_line_field_goals_made | integer | Team-line field goals made (not credited to a player). |
| team_line_field_goals_attempted | integer | Team-line field goals attempted (not credited to a player). |
| team_line_field_goals_success_percent | double | Team-line field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
| team_line_free_throws_made | integer | Team-line free throws made (not credited to a player). |
| team_line_free_throws_attempted | integer | Team-line free throws attempted (not credited to a player). |
| team_line_free_throws_success_percent | double | Team-line free-throw percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
| team_line_offensive_rebounds | integer | Team-line offensive rebounds (not credited to a player). |
| team_line_defensive_rebounds | integer | Team-line defensive rebounds (not credited to a player). |
| team_line_total_rebounds | integer | Team-line rebounds (offensive + defensive) (not credited to a player). |
| team_line_assists | integer | Team-line assists (not credited to a player). |
| team_line_steals | integer | Team-line steals (not credited to a player). |
| team_line_turnovers | integer | Team-line turnovers (not credited to a player). |
| team_line_blocks | integer | Team-line blocked shots (not credited to a player). |
| team_line_fouls_committed | integer | Team-line fouls committed (not credited to a player). |
| team_line_efficiency | integer | Team-line efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) (not credited to a player). |
| team_line_plus_minus | integer | Team-line plus-minus: the team line has no court time, so this is not a margin. |
| field_goals_recomputed | logical | True when the API's field-goal totals disagreed with its 2-point plus 3-point parts (2005-06 box scores) and were recomputed from the parts. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
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
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_game_teams(game_id = "2006920"))
#> ── BBL/DBBL Game Team Box Score from the SCB API ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:48:55 UTC
#> # A tibble: 2 × 63
#>   league game_id season side  team_id head_coach_name status   scheduled_time   
#>   <chr>  <chr>    <int> <chr> <chr>   <chr>           <chr>    <chr>            
#> 1 bbl    2006920   2027 home  413     Pedro Calles    OFFICIAL 2026-09-18T18:00…
#> 2 bbl    2006920   2027 guest 485     Rodrigo Pastore OFFICIAL 2026-09-18T18:00…
#> # ℹ 55 more variables: season_team_id <chr>, season_id <int>, team_name <chr>,
#> #   team_tlc <chr>, competition <chr>, stage <chr>, seconds_played <int>,
#> #   points <int>, two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, three_point_shot_success_percent <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_success_percent <dbl>, free_throws_made <int>, …
# }
```
