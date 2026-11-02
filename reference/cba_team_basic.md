# **Get CBA Team Basic**

A team's per-game averages or totals, one row per season of the team.

Endpoint: `POST https://data-server.cbaleague.com/api/teams/basic-data`
(JSON body)

## Usage

``` r
cba_team_basic(
  team_id,
  match_type_id = 1,
  statistical_dimension = 1,
  self_or_other = 1
)
```

## Arguments

- team_id:

  (required) Required. CBA team id (clubs, stable across seasons and
  renames).

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- statistical_dimension:

  (default `1`) How counting columns are formatted: 1 per game
  (default), 2 season total, 3 and 4 per 100 possessions.

- self_or_other:

  (default `1`) Whose statistics: 1 the team's own (default), 2 its
  opponents'.

## Value

A `hoopR_data` tibble: One row per season of the team. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `cba_team_basic`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| assists | double | Assists, formatted by statisticalDimension. A number (the API sends it as display text). |
| blocked | double | Blocks, formatted by statisticalDimension. A number (the API sends it as display text). |
| cba_rank | character | Unobserved: null in every sample (a league-rank slot). |
| field_goals | double | Field goals made, formatted by statisticalDimension. A number (the API sends it as display text). |
| field_goals_attempted | double | Field goals attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
| field_goals_percentage_rate | double | Field-goal percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
| fouls | double | Personal fouls, formatted by statisticalDimension. A number (the API sends it as display text). |
| free_throws | double | Free throws made, formatted by statisticalDimension. A number (the API sends it as display text). |
| free_throws_attempted | double | Free throws attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
| free_throws_percentage_rate | double | Free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
| losses_number | integer | Losses (Chinese text). (as the API names it) |
| points | double | Points, formatted by statisticalDimension (1 per-game average, 2 season total, 3 and 4 per 100 possessions: both give the same values, 120.1 = boutPoints). A number (the API sends it as display text). |
| real_player_times | integer | Games counted for the averages ((Chinese text) by its name); equals scheduleNumber in the sample except in short seasons (unverified). |
| rebounds | double | Total rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
| rebounds_defensive | double | Defensive rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
| rebounds_offensive | double | Offensive rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
| round | double | Possessions in the season (Chinese text) as a float (4074.09); identical for statisticalDimension 1-4. |
| schedule_number | integer | Games played in that season and match type (Chinese text). |
| schedule_season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
| season | character | Season label 'YYYY-YYYY' as a string ('2024-2025' = start year - end year; the sdv END year is the second one); scheduleSeason is the numeric START year. |
| steals | double | Steals, formatted by statisticalDimension. A number (the API sends it as display text). |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| team_name | character | Team name (Chinese) in that season; changes with the sponsor (the sampled team 29128 has 9 different names across 20 seasons). Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| three_point_attempted | double | Three-pointers attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
| three_point_goals | double | Three-pointers made, formatted by statisticalDimension. A number (the API sends it as display text). |
| three_point_percentage_rate | double | Three-point percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
| time | double | Team minutes per game (statisticalDimension 1) or in total (2). A number (the API sends it as display text). |
| turnovers | double | Turnovers, formatted by statisticalDimension. A number (the API sends it as display text). |
| win_number | integer | Wins (Chinese text). (as the API names it) |
| win_rate | double | Win rate (Chinese text). A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |

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
[`cba_player_base()`](https://hoopR.sportsdataverse.org/reference/cba_player_base.md),
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
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)

## Examples

``` r
# \donttest{
  try(cba_team_basic(team_id = 29128))
#> ── CBA Team Basic from data-server.cbaleague.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:50:53 UTC
#> # A tibble: 21 × 30
#>    assists blocked cba_rank field_goals field_goals_attempted
#>      <dbl>   <dbl> <chr>          <dbl>                 <dbl>
#>  1    22.6     4.4 NA              37.3                  81.1
#>  2    23.7     3.9 NA              37.7                  78.7
#>  3    19.9     3.2 NA              32.1                  68  
#>  4    21.1     2.2 NA              43.7                  87.4
#>  5    24.3     3.7 NA              40.4                  85.1
#>  6    26.1     4.4 NA              39                    76.7
#>  7    17.3     3.8 NA              41.3                  86.8
#>  8    20.3     4   NA              39.3                  83  
#>  9    25.8     3.7 NA              38.6                  79.4
#> 10    13.7     2.7 NA              41                    76.1
#> # ℹ 11 more rows
#> # ℹ 25 more variables: field_goals_percentage_rate <dbl>, fouls <dbl>,
#> #   free_throws <dbl>, free_throws_attempted <dbl>,
#> #   free_throws_percentage_rate <dbl>, losses_number <int>, points <dbl>,
#> #   real_player_times <int>, rebounds <dbl>, rebounds_defensive <dbl>,
#> #   rebounds_offensive <dbl>, round <dbl>, schedule_number <int>,
#> #   schedule_season <int>, season <chr>, steals <dbl>, team_id <int>, …
# }
```
