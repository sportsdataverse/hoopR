# **Get CBA Team Overview**

A team's overview table (record, pace, per-100 ratings), one row per
season of the team.

Endpoint:
`POST https://data-server.cbaleague.com/api/team-match-datas/team-entirety-list`
(JSON body)

## Usage

``` r
cba_team_overview(team_id, match_type_id = 1, page_number = 1, page_size = 100)
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
(sportsdataverse-py `cba_team_overview`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| bout_no_points | double | points allowed per 100 possessions (defensive rating), a float. |
| bout_no_points_rank | double | Rank among the teams of that season for boutNoPoints (integer-valued float; direction undocumented). |
| bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind boutNoPoints). |
| bout_point_sort | double | Unobserved: null in every sample (numeric value behind boutPoints). |
| bout_points | double | points scored per 100 possessions (offensive rating), a float (120.1). |
| bout_points_rank | double | Rank among the teams of that season for boutPoints (integer-valued float; direction undocumented). |
| bout_subtract_points | double | net points per 100 possessions (boutPoints - boutNoPoints), a float. |
| bout_subtract_points_rank | double | Rank among the teams of that season for boutSubtractPoints (integer-valued float). |
| bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind boutSubtractPoints). |
| is_avg | integer | Row kind: 2 on every sampled row = a team's own row (1 presumed league average, unobserved). |
| loss_num | double | Losses in that season, a float. |
| player_times | double | Games played, a float (42.0). |
| rhythm | double | pace: possessions per 48 minutes ('75.7'; site definition: (Chinese text)48(Chinese text)). A number (the API sends it as display text). |
| rhythm_rank | double | Unobserved: null in every sample (a rank slot for pace). Typed Float64 like the family's other routes. |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| win_num | double | Wins in that season (match type of the request), a number typed as float (33.0). |
| win_rate | double | Win rate. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_team_overview(team_id = 29128)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
