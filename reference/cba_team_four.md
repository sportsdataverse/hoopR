# **Get CBA Team Four**

A team's four-factors table, one row per season of the team.

Endpoint:
`POST https://data-server.cbaleague.com/api/teams/four-elements` (JSON
body)

## Usage

``` r
cba_team_four(team_id, match_type_id = 1)
```

## Arguments

- team_id:

  (required) Required. CBA team id (clubs, stable across seasons and
  renames).

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

## Value

A `hoopR_data` tibble: One row per season of the team. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `cba_team_four`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| effective_hit_rate | double | effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| effective_hit_sort | double | Unformatted fraction 0-1 behind effectiveHitRate. |
| field_goals | integer | Field goals made in the season (sum). |
| field_goals_attempted | integer | Field goals attempted in the season (sum). |
| free_throw_rate | double | free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| free_throw_sort | double | Unformatted fraction 0-1 behind freeThrowRate. |
| free_throws | integer | Free throws made in the season (sum). |
| loss_average | double | League-average losses; 0.0 in every sample. |
| loss_num | integer | Losses in that season. |
| offensive_rebound_rate | double | offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| offensive_rebound_sort | double | Unformatted fraction 0-1 behind offensiveReboundRate. |
| other_effective_hit_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| other_effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| other_effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
| other_effective_hit_sort | double | Unformatted fraction 0-1 behind otherEffectiveHitRate. |
| other_field_goals | integer | Field goals made by the team's opponents (sum). |
| other_field_goals_attempted | integer | Field goals attempted by the opponents (sum). |
| other_free_throw_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| other_free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| other_free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
| other_free_throw_sort | double | Unformatted fraction 0-1 behind otherFreeThrowRate. |
| other_free_throws | integer | Free throws made by the opponents (sum). |
| other_offensive_rebound_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| other_offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| other_offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
| other_offensive_rebound_sort | double | Unformatted fraction 0-1 behind otherOffensiveReboundRate. |
| other_points_hundred_round | double | points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
| other_points_hundred_round_average | double | League average of the metric. Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
| other_points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
| other_rebounds_defensive | integer | Defensive rebounds by the opponents (sum). |
| other_rebounds_offensive | integer | Offensive rebounds by the opponents (sum). |
| other_three_point_goals | integer | Three-pointers made by the opponents (sum). |
| other_turnovers | integer | Turnovers by the opponents (sum). |
| other_turnovers_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| other_turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| other_turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| other_turnovers_sort | double | Unformatted fraction 0-1 behind otherTurnoversRate. |
| other_win_points_hundred_round | double | Net points per 100 possessions as seen from the opponents' side (the site's 'other' block). |
| points_hundred_round | double | points scored per 100 possessions (offensive rating). |
| points_hundred_round_average | double | League average of the metric. Metric: points scored per 100 possessions (offensive rating). |
| points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points scored per 100 possessions (offensive rating). |
| rhythm | double | pace: possessions per 48 minutes. A number (the API sends it as display text). |
| rhythm_num | double | Unobserved: null in every sample (a numeric form of the pace; the schedule-four-elements route fills it). Typed Float64 like the family's other routes. |
| rhythm_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: pace: possessions per 48 minutes. |
| round | double | Possessions in the season (Chinese text), a float such as 2606.36. |
| round_jingque | double | Possessions in the season computed 'precisely' ((Chinese text) by its name); equals round in the sample (unverified difference). |
| schedule_season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
| season | integer | Season of the row ('2025' = the START year of 2025-26; sdv END year = value + 1); equals scheduleSeason. An integer (the API sends it as digit text). |
| self_rebounds_defensive | integer | Defensive rebounds by the team in the season (sum). |
| self_rebounds_offensive | integer | Offensive rebounds by the team in the season (sum). |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| three_point_goals | integer | Three-pointers made in the season (sum). |
| total_minute | integer | Team minutes played in the season (sum, 1440 = 30 games x 48). |
| total_other_points | integer | Points the team's opponents scored in the season (sum). |
| total_points | integer | Points the team scored in the season (sum). |
| turnovers | integer | Turnovers in the season (sum). |
| turnovers_rate | double | turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
| turnovers_sort | double | Unformatted fraction 0-1 behind turnoversRate. |
| win_num | integer | Wins in that season (regular season for matchTypeId 1). |
| win_points_hundred_round | double | net points per 100 possessions. |
| win_points_hundred_round_average | double | League average of the metric. Metric: net points per 100 possessions. |
| win_points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: net points per 100 possessions. |
| wine_average | double | League-average wins (field name sic); 0.0 in every sample. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_team_four(team_id = 29128)

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
[`cba_team_basic()`](https://hoopR.sportsdataverse.org/reference/cba_team_basic.md),
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)
