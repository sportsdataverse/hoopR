# **Get CBA Player Base**

Season player box (one page of the season player table).

Endpoint: `POST https://data-server.cbaleague.com/api/player-base-list`
(JSON body)

## Usage

``` r
cba_player_base(
  season,
  match_type_id = 1,
  count_ranger = 1,
  player_ranger = 1,
  team_id = NULL,
  page_number = 1,
  page_size = 100
)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- count_ranger:

  (default `1`) How counting statistics scale: 1 per game (default), 2
  season total, 3 per 36 minutes, 4 per 100 possessions.

- player_ranger:

  (default `1`) Which players: 1 all (default), 2 domestic (Chinese)
  only, 4 foreign only.

- team_id:

  (optional) Optional CBA team id (clubs, stable across seasons and
  renames) to list one team's players.

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble: One row per player of the requested page. An
empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_player_base`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| age | integer | Age in years in that season. |
| assists | double | Assists per game when countRanger is 1. A number (the API sends it as display text). |
| birth_date | character | Date of birth 'YYYY-MM-DD' (a public player bio field; midnight-suffixed 'YYYY-MM-DD 00:00:00' on player-base-list). |
| blocked | double | Blocks per game when countRanger is 1. A number (the API sends it as display text). |
| cn_alias | character | Player name (Chinese). Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| field_goals | double | Field goals made per game when countRanger is 1. A number (the API sends it as display text). |
| field_goals_at_rim_attempted | double | At-the-rim (inside the restricted area) field goals attempted in the season (total), a float. |
| field_goals_at_rim_made | double | At-the-rim field goals made in the season (total), a float. |
| field_goals_attempted | double | Field goals attempted per game when countRanger is 1. A number (the API sends it as display text). |
| field_goals_mid_range_attempted | double | Mid-range (two-point shots outside the restricted area) field goals attempted in the season (total), a float. |
| field_goals_mid_range_made | double | Mid-range field goals made in the season (total), a float. |
| field_goals_percentage | double | Field-goal percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| field_goals_percentage_sort | double | Field-goal percentage as a FRACTION 0-1 for sorting. |
| fouls | double | Personal fouls per game when countRanger is 1. A number (the API sends it as display text). |
| fouls_defensive | double | Defensive personal fouls in the season (total), a float. |
| free_throws | double | Free throws made per game when countRanger is 1. A number (the API sends it as display text). |
| free_throws_attempted | double | Free throws attempted per game when countRanger is 1. A number (the API sends it as display text). |
| free_throws_percentage | double | Free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| free_throws_percentage_sort | double | Free-throw percentage as a FRACTION 0-1 for sorting. |
| game_start_num | integer | Games started (Chinese text). |
| minutes | double | Minutes: per game; a whole-season total integer on the offensive/defensive/shot lists (827). A number (the API sends it as display text). |
| nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
| number | character | Jersey number as a string. |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
| player_times | double | Games played (Chinese text), a float (39.0). |
| player_times2 | character | Unobserved: null in every sample. |
| points | double | Points per game when countRanger is 1 (the request value); other countRanger values change the unit (2 total, 3 per 36 minutes, 4 per 100 possessions). A number (the API sends it as display text). |
| position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
| rank_sort | character | Unobserved: null in every sample. |
| rebounds | double | Total rebounds per game when countRanger is 1. A number (the API sends it as display text). |
| rebounds_defensive | double | Defensive rebounds per game when countRanger is 1. A number (the API sends it as display text). |
| rebounds_offensive | double | Offensive rebounds per game when countRanger is 1. A number (the API sends it as display text). |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| seconds | double | Seconds: per-game average; a whole-season total integer elsewhere. A number (the API sends it as display text). |
| steals | double | Steals per game when countRanger is 1. A number (the API sends it as display text). |
| team_cn_alias | character | Team short name (Chinese) in that season. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| three_point_attempted | double | Three-pointers attempted per game when countRanger is 1. A number (the API sends it as display text). |
| three_point_goals | double | Three-pointers made per game when countRanger is 1. A number (the API sends it as display text). |
| three_point_percentage | double | Three-point percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| three_point_percentage_sort | double | Three-point percentage as a FRACTION 0-1 for sorting. |
| turnovers | double | Turnovers per game when countRanger is 1. A number (the API sends it as display text). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

Other CBA Functions:
[`cba_best_player()`](https://hoopR.sportsdataverse.org/reference/cba_best_player.md),
[`cba_best_stats()`](https://hoopR.sportsdataverse.org/reference/cba_best_stats.md),
[`cba_game_info()`](https://hoopR.sportsdataverse.org/reference/cba_game_info.md),
[`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md),
[`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md),
[`cba_match_types()`](https://hoopR.sportsdataverse.org/reference/cba_match_types.md),
[`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md),
[`cba_period_scores()`](https://hoopR.sportsdataverse.org/reference/cba_period_scores.md),
[`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md),
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
[`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md),
[`cba_schedule_day()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_day.md),
[`cba_schedule_month()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_month.md),
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md),
[`cba_team_basic()`](https://hoopR.sportsdataverse.org/reference/cba_team_basic.md),
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)

## Examples

``` r
# \donttest{
  try(cba_player_base(season = 2026, team_id = 29128))
#> ── CBA Player Base from data-server.cbaleague.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:45:33 UTC
#> # A tibble: 20 × 44
#>      age assists birth_date  blocked cn_alias field_goals field_goals_at_rim_a…¹
#>    <int>   <dbl> <chr>         <dbl> <chr>          <dbl>                  <dbl>
#>  1    29     3.9 1996-12-21…     0.1 布朗             6.7                     77
#>  2    28     5.4 1997-09-24…     0.3 塔克             5                      162
#>  3    28     1.2 1997-09-24…     0.2 胡金秋           7.1                    215
#>  4    33     1.2 1993-03-20…     1   桑普森           4.5                    127
#>  5    30     6.1 1996-04-26…     0.3 孙铭徽           3.4                     57
#>  6    27     0.8 1999-02-26…     0.7 卡尔顿           2.6                    131
#>  7    26     2.1 1999-07-13…     0.4 朱俊龙           2.2                     66
#>  8    27     0.8 1999-01-06…     0.2 赵嘉仁           2.2                     45
#>  9    28     0.6 1997-10-25…     0.2 赵岩昊           2.1                     47
#> 10    29     1.9 1996-12-26…     0.1 林秉圣           1.8                     32
#> 11    27     1   1998-08-26…     0   威廉姆斯         1.5                      4
#> 12    34     0.2 1991-12-02…     0.1 苏若禹           0.7                      6
#> 13    19     1.1 2006-12-23…     0.1 侯孟泽           0.5                      6
#> 14    19     0   2006-06-28…     1   周可梵           0                        0
#> 15    26     0.7 1999-06-02…     0.1 吴骁             0.4                     24
#> 16    22     0.1 2003-06-06…     0.1 王欣瑞           0.3                      2
#> 17    20     0   2006-02-07…     0   崔新泉           0.1                      3
#> 18    22     0.1 2004-03-19…     0   续峻玮           0.2                      3
#> 19    26     3   2000-05-09…     0   许可             0                        0
#> 20    23     0   2002-08-25…     0   赵佳一           0                        0
#> # ℹ abbreviated name: ¹​field_goals_at_rim_attempted
#> # ℹ 37 more variables: field_goals_at_rim_made <dbl>,
#> #   field_goals_attempted <dbl>, field_goals_mid_range_attempted <dbl>,
#> #   field_goals_mid_range_made <dbl>, field_goals_percentage <dbl>,
#> #   field_goals_percentage_sort <dbl>, fouls <dbl>, fouls_defensive <dbl>,
#> #   free_throws <dbl>, free_throws_attempted <dbl>,
#> #   free_throws_percentage <dbl>, free_throws_percentage_sort <dbl>, …
# }
```
