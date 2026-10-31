# **Get CBA Team Shots**

A team's shot-zone profile, one row per season of the team (zone splits
from 2017-18).

Endpoint:
`POST https://data-server.cbaleague.com/api/team-match-datas/team-shoot-list`
(JSON body)

## Usage

``` r
cba_team_shots(team_id, match_type_id = 1, page_number = 1, page_size = 100)
```

## Arguments

- team_id:

  (required) Required. CBA team id (clubs, stable across seasons and
  renames).

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble: One row per season of the team. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `cba_team_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points allowed per 100 possessions). Typed Float64 like the family's other routes. |
| bout_point_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points per 100 possessions). Typed Float64 like the family's other routes. |
| bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) net points per 100 possessions). Typed Float64 like the family's other routes. |
| guard_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_hit_at_rim_made_rate | double | at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_hit_middle_rate | double | mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| guard_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_three_goals_rate | double | three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| is_avg | integer | Row kind: 2 on every sampled row = a team's own row; 1 is presumed to mark a league-average row but is unobserved. |
| num | double | Games the profile covers (the site's 'games'), e.g. 42.0; a number typed as float. |
| offensive_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_hit_at_rim_made_rate | double | at-rim shooting percentage, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_hit_middle_rate | double | mid-range shooting percentage, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
| offensive_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
| offensive_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
| offensive_three_goals_rate | double | three-point shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
| offensive_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_team_shots(team_id = 29128)

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
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)
