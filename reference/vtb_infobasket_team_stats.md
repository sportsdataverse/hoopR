# **Get VTB Infobasket Team Stats**

Season totals of every team of a season (all stages).

Endpoint: `GET https://org.infobasket.su/Comp/GetTeamStats/{season}`

## Usage

``` r
vtb_infobasket_team_stats(season, tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: Season totals of every team of a season (all
stages). The columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_team_stats`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| team_id | integer | Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| game_count | integer | Games in the totals (the whole competition, all stages, for the season-level CompID). |
| points | integer | Points. The wire's null is 0 here (null counts are filled). |
| shot1 | integer | Free throws attempted. The wire's null is 0 here (null counts are filled). |
| goal1 | integer | Free throws made. The wire's null is 0 here (null counts are filled). |
| shot2 | integer | 2-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal2 | integer | 2-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot3 | integer | 3-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal3 | integer | 3-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot23 | integer | Field goals (2 + 3 points) attempted. The wire's null is 0 here (null counts are filled). |
| goal23 | integer | Field goals (2 + 3 points) made. The wire's null is 0 here (null counts are filled). |
| shot1_percent | double | Free-throw percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot2_percent | double | 2-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot3_percent | double | 3-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot23_percent | double | Field-goal percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| assist | integer | Assists. The wire's null is 0 here (null counts are filled). |
| blocks | integer | Blocked shots. The wire's null is 0 here (null counts are filled). |
| def_rebound | integer | Defensive rebounds. The wire's null is 0 here (null counts are filled). |
| off_rebound | integer | Offensive rebounds. The wire's null is 0 here (null counts are filled). |
| rebound | integer | Total rebounds. The wire's null is 0 here (null counts are filled). |
| steal | integer | Steals. The wire's null is 0 here (null counts are filled). |
| turnover | integer | Turnovers. The wire's null is 0 here (null counts are filled). |
| team_def_rebound | integer | Team defensive rebounds (not credited to a player). The wire's null is 0 here (null counts are filled). |
| team_off_rebound | integer | Team offensive rebounds (not credited to a player). The wire's null is 0 here (null counts are filled). |
| team_rebound | integer | Team rebounds (not credited to a player). The wire's null is 0 here (null counts are filled). |
| team_steal | integer | Team steals (not credited to a player). The wire's null is 0 here (null counts are filled). |
| team_turnover | integer | Team turnovers (not credited to a player, e.g. shot-clock violations). The wire's null is 0 here (null counts are filled). |
| kpi | integer | Efficiency index (KPI, the platform's 'KPI'); formula unverified. |
| avg_points | double | Per-game average of: points; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_assist | double | Per-game average of: assists; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_blocks | double | Per-game average of: blocked shots; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_def_rebound | double | Per-game average of: defensive rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_off_rebound | double | Per-game average of: offensive rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_rebound | double | Per-game average of: total rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_steal | double | Per-game average of: steals; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_turnover | double | Per-game average of: turnovers; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_foul | double | Per-game average of: personal fouls committed; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_opponent_foul | double | Per-game average of: fouls drawn; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_plus_minus | double | Per-game average of: plus-minus: point differential while on the court; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_team_def_rebound | double | Per-game average of: team defensive rebounds (not credited to a player); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_team_off_rebound | double | Per-game average of: team offensive rebounds (not credited to a player); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_team_rebound | double | Per-game average of: team rebounds (not credited to a player); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_team_steal | double | Per-game average of: team steals (not credited to a player); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_team_turnover | double | Per-game average of: team turnovers (not credited to a player, e.g. shot-clock violations); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| foul | integer | Personal fouls committed. The wire's null is 0 here (null counts are filled). |
| opponent_foul | integer | Fouls drawn. The wire's null is 0 here (null counts are filled). |
| seconds | integer | Playing time in seconds. |
| played_time | character | Playing time as 'minutes:seconds' (team rows sum the five players: '200:00' = 40 minutes x 5). |
| avg_played_time | character | Average playing time per game as 'minutes:seconds'. |
| plus_minus | integer | Plus-minus: point differential while on the court. Null where the host sends none. |
| team_short_name_ru | character | The the team's short name in Russian (as the competition names it). |
| team_short_name_en | character | The the team's short name in English (as the competition names it). |
| team_name_ru | character | The the team's name in Russian (as the competition names it). |
| team_name_en | character | The the team's name in English (as the competition names it). |
| team_region_name_ru | character | The the team's region or city in Russian (as the competition names it). |
| team_region_name_en | character | The the team's region or city in English (as the competition names it). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_comp_issue()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_comp_issue.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff.md),
[`vtb_infobasket_playoff_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff_games.md),
[`vtb_infobasket_roster()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster.md),
[`vtb_infobasket_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster_coaches.md),
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md),
[`vtb_infobasket_standings()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_standings.md),
[`vtb_infobasket_team()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team.md),
[`vtb_infobasket_team_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_box_score.md),
[`vtb_infobasket_team_coach_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_coach_stats.md),
[`vtb_infobasket_team_comps()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_comps.md),
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_infobasket_team_stats_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_players.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_infobasket_team_stats(season = 2026))
#> ── VTB Infobasket Team Stats from org.infobasket.su ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:50:46 UTC
#> # A tibble: 11 × 57
#>    season team_id game_count points shot1 goal1 shot2 goal2 shot3 goal3 shot23
#>     <int>   <int>      <int>  <int> <int> <int> <int> <int> <int> <int>  <int>
#>  1   2026     682         40   2860   669   501  1632   761   926   279   2558
#>  2   2026     688         43   3327   773   578  1767   881   995   329   2762
#>  3   2026    2994         56   4779  1144   889  2049  1123  1454   548   3503
#>  4   2026    2650         53   4521  1317   992  2407  1256  1032   339   3439
#>  5   2026    2747         43   3400   943   699  1649   791  1119   373   2768
#>  6   2026     468         40   3045   685   536  1419   728  1072   351   2491
#>  7   2026    3059         43   3522   699   538  1728   919  1084   382   2812
#>  8   2026    2792         40   2870   665   494  1416   693  1023   330   2439
#>  9   2026     697         54   4569  1036   808  1849  1015  1582   577   3431
#> 10   2026    1390         44   3463   871   677  1611   829  1060   376   2671
#> 11   2026      15         52   4847  1152   919  1887  1040  1530   616   3417
#> # ℹ 46 more variables: goal23 <int>, shot1_percent <dbl>, shot2_percent <dbl>,
#> #   shot3_percent <dbl>, shot23_percent <dbl>, assist <int>, blocks <int>,
#> #   def_rebound <int>, off_rebound <int>, rebound <int>, steal <int>,
#> #   turnover <int>, team_def_rebound <int>, team_off_rebound <int>,
#> #   team_rebound <int>, team_steal <int>, team_turnover <int>, kpi <int>,
#> #   avg_points <dbl>, avg_assist <dbl>, avg_blocks <dbl>,
#> #   avg_def_rebound <dbl>, avg_off_rebound <dbl>, avg_rebound <dbl>, …
# }
```
