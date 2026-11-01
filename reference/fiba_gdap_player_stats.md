# **FIBA GDAP: player stats**

A player's per-game averages, totals and highs at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapplayercompetitionstatisticsbyplayerid`

## Usage

``` r
fiba_gdap_player_stats(player_id, comp, return_parsed = TRUE)
```

## Arguments

- player_id:

  (integer, required) Required. FIBA person id (global): personId of a
  roster row, pId in play-by-play, P\_`<id>` in the game-page box

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| points_per_game | double | The player's average points per game played. |
| rebounds_per_game | double | The player's average rebounds per game played. |
| rebounds_offensive_per_game | double | The player's average offensive rebounds per game played. |
| rebounds_defensive_per_game | double | The player's average defensive rebounds per game played. |
| assists_per_game | double | The player's average assists per game played. |
| blocks_per_game | double | The player's average blocked shots per game played. |
| turnovers_per_game | double | The player's average turnovers per game played. |
| fouls_per_game | double | The player's average personal fouls per game played. |
| plus_minus_per_game | double | The player's average plus/minus (point differential while on court) per game played. |
| efficiency_per_game | double | The player's average efficiency (FIBA EFF) per game played. |
| play_time_in_seconds_per_game | double | The player's average playing time in seconds per game played. |
| field_goals_made_per_game | double | The player's average field goals made per game played. |
| field_goals_attempted_per_game | double | The player's average field goals attempted per game played. |
| two_points_made_per_game | double | The player's average two-point field goals made per game played. |
| two_points_attempted_per_game | double | The player's average two-point field goals attempted per game played. |
| three_points_made_per_game | double | The player's average three-point field goals made per game played. |
| three_points_attempted_per_game | double | The player's average three-point field goals attempted per game played. |
| free_throws_made_per_game | double | The player's average free throws made per game played. |
| free_throws_attempted_per_game | double | The player's average free throws attempted per game played. |
| points_from_turnovers_per_game | double | The player's average points from turnovers per game played. |
| fast_break_points_per_game | double | The player's average fast-break points per game played. |
| second_chance_points_per_game | double | The player's average second-chance points per game played. |
| points_in_the_paint_per_game | double | The player's average points in the paint per game played. |
| steals_per_game | double | The player's average steals per game played. |
| total_games_played | integer | The player's total games played over the games played. |
| total_games_won | integer | The player's total games won over the games played. |
| total_games_lost | integer | The player's total games lost over the games played. |
| total_rebounds | integer | The player's total rebounds over the games played. |
| total_rebounds_offensive | integer | The player's total offensive rebounds over the games played. |
| total_rebounds_defensive | integer | The player's total defensive rebounds over the games played. |
| total_blocks | integer | The player's total blocked shots over the games played. |
| total_turnovers | integer | The player's total turnovers over the games played. |
| total_fouls | integer | The player's total personal fouls over the games played. |
| total_assists | integer | The player's total assists over the games played. |
| total_plus_minus | integer | The player's total plus/minus (point differential while on court) over the games played. |
| total_efficiency | integer | The player's total efficiency (FIBA EFF) over the games played. |
| total_play_time_in_seconds | integer | The player's total playing time in seconds over the games played. |
| total_points | integer | The player's total points over the games played. |
| total_field_goals_made | integer | The player's total field goals made over the games played. |
| total_field_goals_attempted | integer | The player's total field goals attempted over the games played. |
| field_goals_percentage | double | Field-goal percentage, 0-100 (over the competition; full float precision in averages). |
| total_two_points_made | integer | The player's total two-point field goals made over the games played. |
| total_two_points_attempted | integer | The player's total two-point field goals attempted over the games played. |
| two_points_percentage | double | Two-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
| total_three_points_made | integer | The player's total three-point field goals made over the games played. |
| total_three_points_attempted | integer | The player's total three-point field goals attempted over the games played. |
| three_points_percentage | double | Three-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
| total_free_throws_made | integer | The player's total free throws made over the games played. |
| total_free_throws_attempted | integer | The player's total free throws attempted over the games played. |
| free_throws_percentage | double | Free-throw percentage, 0-100 (over the competition; full float precision in averages). |
| total_double_doubles | integer | The player's total double-doubles over the games played. |
| total_triple_doubles | integer | The player's total triple-doubles over the games played. |
| total_quadruple_doubles | integer | The player's total quadruple-doubles over the games played. |
| total_quintuple_doubles | integer | The player's total quintuple-doubles over the games played. |
| total_points_from_turnovers | integer | The player's total points from turnovers over the games played. |
| total_fast_break_points | integer | The player's total fast-break points over the games played. |
| total_second_chance_points | integer | The player's total second-chance points over the games played. |
| total_points_in_the_paint | integer | The player's total points in the paint over the games played. |
| total_steals | integer | The player's total steals over the games played. |
| rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
| rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
| rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md),
[`fiba_gamepage_period_scores()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_period_scores.md),
[`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md),
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md),
[`fiba_gdap_competition()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_competition.md),
[`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md),
[`fiba_gdap_federation_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_games.md),
[`fiba_gdap_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_ranking.md),
[`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md),
[`fiba_gdap_game()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game.md),
[`fiba_gdap_game_officials()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_officials.md),
[`fiba_gdap_game_periods()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_periods.md),
[`fiba_gdap_games_between()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_games_between.md),
[`fiba_gdap_gateway_competition_ids()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_competition_ids.md),
[`fiba_gdap_gateway_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_federation_ranking.md),
[`fiba_gdap_medal_count()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_medal_count.md),
[`fiba_gdap_national_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_national_teams.md),
[`fiba_gdap_nominations()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_nominations.md),
[`fiba_gdap_player_game_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_game_stats.md),
[`fiba_gdap_player_info()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_info.md),
[`fiba_gdap_ranking_zones()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_ranking_zones.md),
[`fiba_gdap_roster()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster.md),
[`fiba_gdap_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_coaches.md),
[`fiba_gdap_roster_latest()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_latest.md),
[`fiba_gdap_round_gamedays()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_gamedays.md),
[`fiba_gdap_round_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_standings.md),
[`fiba_gdap_rounds()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_rounds.md),
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md),
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)

## Examples

``` r
# \donttest{
  try(fiba_gdap_player_stats(player_id = 211501, comp = 208182))
#> ── FIBA gdap_player_stats from fiba.basketball ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:47:47 UTC
#> # A tibble: 1 × 64
#>   player_id competition_id points_per_game rebounds_per_game
#>       <int>          <int>           <dbl>             <dbl>
#> 1    211501         208182             7.8               2.3
#> # ℹ 60 more variables: rebounds_offensive_per_game <dbl>,
#> #   rebounds_defensive_per_game <dbl>, assists_per_game <dbl>,
#> #   blocks_per_game <dbl>, turnovers_per_game <dbl>, fouls_per_game <dbl>,
#> #   plus_minus_per_game <dbl>, efficiency_per_game <dbl>,
#> #   play_time_in_seconds_per_game <dbl>, field_goals_made_per_game <dbl>,
#> #   field_goals_attempted_per_game <dbl>, two_points_made_per_game <dbl>,
#> #   two_points_attempted_per_game <dbl>, three_points_made_per_game <dbl>, …
# }
```
