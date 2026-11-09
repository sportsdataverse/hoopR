# **Get CBA Game Team Shots**

Shot-zone profile of the two teams of a game. NOT game data: the teams'
current season table.

Endpoint:
`POST https://data-server.cbaleague.com/api/team-match-datas/schedule-shoot-list`
(JSON body)

## Usage

``` r
cba_game_team_shots(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble: One row per team (and averages); a team-season
table, not game data. An empty valid answer is a zero-row tibble with
these columns, in this order (sportsdataverse-py `cba_game_team_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points allowed per 100 possessions). Typed Float64 like the family's other routes. |
| bout_point_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points per 100 possessions). Typed Float64 like the family's other routes. |
| bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) net points per 100 possessions). Typed Float64 like the family's other routes. |
| guard_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_hit_at_rim_made_rate | double | at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_hit_middle_rate | double | mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| guard_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
| guard_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
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
| offensive_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). |
| offensive_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). |
| offensive_hit_at_rim_made_rate | double | at-rim shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_hit_middle_rate | double | mid-range shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). |
| offensive_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| offensive_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). |
| offensive_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). |
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
| team_name | character | Team name (Chinese) in that season; changes with the sponsor. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_game_team_shots(schedule_id = 100105799))
#> ── CBA Game Team Shots from data-server.cbaleague.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:03:18 UTC
#> # A tibble: 2 × 50
#>   bout_no_points_sort bout_point_sort bout_subtract_points_sort
#>                 <dbl>           <dbl>                     <dbl>
#> 1                  NA              NA                        NA
#> 2                  NA              NA                        NA
#> # ℹ 47 more variables: guard_field_goals_at_rim <dbl>,
#> #   guard_field_goals_at_rim_rank <dbl>, guard_field_goals_at_rim_sort <dbl>,
#> #   guard_hit_at_rim_made_rate <dbl>, guard_hit_at_rim_made_rate_rank <dbl>,
#> #   guard_hit_at_rim_made_rate_sort <dbl>, guard_hit_middle_rate <dbl>,
#> #   guard_hit_middle_rate_rank <dbl>, guard_hit_middle_rate_sort <dbl>,
#> #   guard_middle_rate <dbl>, guard_middle_rate_rank <dbl>,
#> #   guard_middle_rate_sort <dbl>, guard_real_point <dbl>, …
# }
```
