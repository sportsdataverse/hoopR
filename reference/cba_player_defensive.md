# **Get CBA Player Defensive**

Season player defensive rates (one page).

Endpoint:
`POST https://data-server.cbaleague.com/api/player-defensive-list` (JSON
body)

## Usage

``` r
cba_player_defensive(
  season,
  match_type_id = 1,
  count_ranger = 1,
  player_ranger = 1,
  team_id = NULL,
  sort = 3,
  rank = 1,
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

- sort:

  (default `3`) Sort column code the site sends (3 is the default
  order); the API answers an empty body without it.

- rank:

  (default `1`) Sort direction code the site sends (1 default); the API
  answers an empty body without it.

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble: One row per player of the requested page. An
empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_player_defensive`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| age | integer | Age in years in that season. |
| blocked_rate | double | block rate (site definition, as blockedPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| blocked_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: block rate (site definition, as blockedPercentage). |
| blocked_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: block rate (site definition, as blockedPercentage). |
| first_position | character | Primary position label (Chinese; see position for the label set). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| fouls_rate | double | foul rate: defensive fouls per 100 possessions. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| fouls_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: foul rate: defensive fouls per 100 possessions. |
| fouls_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: foul rate: defensive fouls per 100 possessions. |
| is_color | integer | Highlight flag, 1 or 2 (unverified meaning; the site uses it to colour the row). |
| minutes | integer | Minutes played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
| nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
| number | character | Jersey number as a string. |
| play_times | integer | Games played (Chinese text), integer. |
| player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
| player_name | character | Player name (Chinese). |
| position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
| position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
| rank | character | Unobserved: null in every sample (a row-rank slot; the site numbers rows itself). |
| rebounds_defensive_rate | double | defensive-rebound rate (site definition, as reboundsDefensivePercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| rebounds_defensive_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: defensive-rebound rate (site definition, as reboundsDefensivePercentage). |
| rebounds_defensive_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: defensive-rebound rate (site definition, as reboundsDefensivePercentage). |
| rebounds_offensive_rate | double | offensive-rebound rate (site definition, as reboundsOffensivePercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| rebounds_offensive_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: offensive-rebound rate (site definition, as reboundsOffensivePercentage). |
| rebounds_offensive_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: offensive-rebound rate (site definition, as reboundsOffensivePercentage). |
| season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
| seconds | integer | Seconds played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
| steals_rate | double | steal rate (site definition, as stealsPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the \_sort column holds the same fraction). |
| steals_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: steal rate (site definition, as stealsPercentage). |
| steals_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: steal rate (site definition, as stealsPercentage). |
| team_cn_alias | character | Team short name (Chinese) in that season. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_player_defensive(season = 2026, team_id = 29128)

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
