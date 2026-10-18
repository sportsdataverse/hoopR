# **NBL Rosetta Player Stats**

A player's season totals and averages for every season, by period.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/statistics/for/player/{player_id}`

## Usage

``` r
nbl_rosetta_player_stats(player_id, org = "nbl")
```

## Arguments

- player_id:

  (*character* required): Player id: the DataCore person id (player_id
  of nbl_rosetta_players) or Rosetta's own id; either is accepted.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

## Value

A `hoopR_data` tibble (one row per season and period):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| assists_average | numeric | Assists per game. |
| blocks_average | numeric | Blocks per game. |
| field_goals_attempted | integer | Field goals attempted, season total. |
| field_goals_made | integer | Field goals made, season total. |
| field_goals_attempted_average | numeric | Field goals attempted per game. |
| field_goals_made_average | numeric | Field goals made per game. |
| field_goals_percentage | numeric | Field goals made / attempted, a 0-1 FRACTION. |
| fouls_average | numeric | Fouls committed (personal + technical + others) per game. |
| free_throws_attempted | integer | Free throws attempted, season total. |
| free_throws_made | integer | Free throws made, season total. |
| free_throws_attempted_average | numeric | Free throws attempted per game. |
| free_throws_made_average | numeric | Free throws made per game. |
| free_throws_percentage | numeric | Free throws made / attempted, a 0-1 FRACTION. |
| games | integer | Games played in the season (in the period rows, by the player or team). |
| games_started | integer | Games in the starting five. |
| offensive_rebounds | integer | Offensive rebounds, season total. |
| fouls | integer | Fouls committed (personal + technical + others), season total. |
| personal_fouls | integer | Personal fouls, season total. |
| technical_fouls | integer | Technical fouls, season total. |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| three_points_attempted | integer | Three-point field goals attempted, season total. |
| three_points_attempted_average | numeric | Three-point field goals attempted per game. |
| three_points_made | integer | Three-point field goals made, season total. |
| three_points_made_average | numeric | Three-point field goals made per game. |
| three_points_percentage | numeric | Three-point field goals made / attempted, a 0-1 FRACTION. |
| turnovers_average | numeric | Turnovers per game. |
| turnovers | integer | Turnovers, season total. |
| two_points_attempted | integer | Two-point field goals attempted, season total. |
| two_points_attempted_average | numeric | Two-point field goals attempted per game. |
| two_points_made | integer | Two-point field goals made, season total. |
| two_points_made_average | numeric | Two-point field goals made per game. |
| two_points_percentage | numeric | Two-point field goals made / attempted, a 0-1 FRACTION. |
| minutes | numeric | Minutes played, decimal minutes. |
| minutes_average | numeric | Minutes per game, decimal minutes. |
| points | integer | Points, season total. |
| rebounds | integer | Total rebounds, season total. |
| assists | integer | Assists, season total. |
| blocks | integer | Blocks, season total. |
| steals | integer | Steals, season total. |
| plus_minus | integer | Point differential while on court, season total. |
| plus_minus_average | numeric | Point differential while on court per game. |
| efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV), season total. |
| efficiency_average | numeric | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) per game. |
| points_average | numeric | Points per game. |
| rebounds_average | numeric | Total rebounds per game. |
| steals_average | numeric | Steals per game. |
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
| player_first_name | character | The player's given name, e.g. Elijah. |
| player_jersey_number | character | Jersey number, a STRING. |
| player_last_name | character | The player's family name, e.g. Pepper. |
| player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
| rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| sc_total_score | integer | SuperCoach score including double-double / triple-double bonuses. |
| sc_total_score_without_dd_and_td | integer | SuperCoach score without those bonuses. |
| sc_breakdown_points_value | integer | The stat's value for the game or season. |
| sc_breakdown_points_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_rebounds_value | integer | The stat's value for the game or season. |
| sc_breakdown_rebounds_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_assists_value | integer | The stat's value for the game or season. |
| sc_breakdown_assists_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_blocks_value | integer | The stat's value for the game or season. |
| sc_breakdown_blocks_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_steals_value | integer | The stat's value for the game or season. |
| sc_breakdown_steals_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_turnovers_value | integer | The stat's value for the game or season. |
| sc_breakdown_turnovers_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_breakdown_triple_double_value | integer | The stat's value for the game or season. |
| sc_breakdown_triple_double_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| sc_double_figure_count | integer | Stats in double figures (for the double-double / triple-double bonus) |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
| sc_breakdown_double_double_value | integer | The stat's value for the game or season. |
| sc_breakdown_double_double_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
| season_start_date | character | First day of the season, ISO date-time without offset. |
| player_full_name | character | Given and family name. |
| player_active | logical | Player record is active. |
| player_date_of_birth | character | Date of birth, ISO date. |
| player_nationality | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_height | numeric | Height in centimetres. |
| player_weight | numeric | Unobserved in samples (null in every capture); type and meaning unverified. |
| team_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
| synthetic_from_roster | logical | Row built from the roster because the player has no season statistics (all stats 0) |

Columns the body adds beyond these follow, in body order (sdv-py keeps
them too).

## Details

- Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL
  documents or supports). The terms of use were not reviewed; payloads
  are not redistributed as release assets.

- Gated by a referer, not a key: every request carries Origin / Referer
  set to nbl.com.au (the runtime sends them); without them the host
  answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.

- Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for
  the 2025-26 NBL season (the stats provider changed from Genius Sports
  to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full
  event log with shot x/y for 2025-26 and, in the same shape, back to
  2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.

- One host serves three organisations; pass org='nbl' (default), 'wnbl'
  or 'nbl1'. NBL1 is the second tier (men's and women's conferences,
  calendar-year seasons).

- Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year
  is the START year for the NBL and WNBL from 1998-99 and a calendar
  year for NBL1 and the 1979-1997 winter seasons; the runtime maps it.
  Year 1998 holds two seasons (calendar 1998 and 1998-99).

- Ids: `<entity>`*id columns are DataCore ids (UUID v1; join on them),
  rosetta*`<entity>`\_id Rosetta's own. match_id is the DataCore fixture
  id every match route is keyed on.

- Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`).
  Rosetta caches a body per path and serves it whatever the query
  string, so a page cut by someone else's limit is refused
  (`hoopR_asset_fetch`); retry after the cache entry expires.

Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown
match, team, player or season id, an org or season type with nothing, or
no season in progress); `hoopR_asset_fetch` for the 403 gate body, a
stub or error envelope, a page cut by Rosetta's path cache, a body for
another org, season or entity than the one asked for, or any other
failed fetch; `hoopR_bad_request` for an unknown `org` / `season_type`,
a malformed id, or HTTP 400 / 422.

## See also

Other NBL Rosetta:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_next_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_matches.md),
[`nbl_rosetta_outcomes()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_outcomes.md),
[`nbl_rosetta_player_game_log()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_game_log.md),
[`nbl_rosetta_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_players.md),
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md),
[`nbl_rosetta_seasons_current()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons_current.md),
[`nbl_rosetta_standings()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_standings.md),
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_player_stats(org = "nbl", player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f"))
#> ── NBL Rosetta player_stats from prod.rosetta.nbl.com.au ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:45:03 UTC
#> # A tibble: 3 × 91
#>   org   assists_average blocks_average field_goals_attempted field_goals_made
#>   <chr>           <dbl>          <dbl>                 <int>            <int>
#> 1 nbl              1.57         0.243                    338              134
#> 2 nbl              3            0                         93               43
#> 3 nbl              1.23         0.0645                   184               77
#> # ℹ 86 more variables: field_goals_attempted_average <dbl>,
#> #   field_goals_made_average <dbl>, field_goals_percentage <dbl>,
#> #   fouls_average <dbl>, free_throws_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted_average <dbl>, free_throws_made_average <dbl>,
#> #   free_throws_percentage <dbl>, games <int>, games_started <int>,
#> #   offensive_rebounds <int>, fouls <int>, personal_fouls <int>,
#> #   technical_fouls <int>, period <int>, three_points_attempted <int>, …
# }
```
