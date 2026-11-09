# **Get Basketligaen Game Header**

Game header: Genius match id (extId), arena, state, teams, scores.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/game-info/{game_uuid}`

## Usage

``` r
sportality_game_header(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Game header: Genius match id (extId), arena,
state, teams, scores. An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_game_header`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| instance_context_site_team_is_in_game | logical | Whether the requesting site's own team plays in the game. |
| instance_context_site_team_is_home_team | logical | Whether the requesting site's own team is the home team. |
| instance_context_site_team_is_away_team | logical | Whether the requesting site's own team is the away team. |
| game_info_game_uuid | character | Game uuid (platform key space). |
| game_info_ext_id | integer | Genius match id (Int64; the same number as gameday game_source_id). |
| game_info_start_date_time | character | Scheduled start, ISO 8601 UTC with milliseconds. |
| game_info_arena_name | character | Name of the arena (venue). |
| game_info_state | character | Game state, underscore form: post_game once played. Values: `post_game` = played (sports-v2 game-info). |
| game_info_overtime | logical | Whether the game went to overtime. |
| game_info_shootout | character | Unobserved: null in every sample and every full body. When filled: Shootout flag (null on every game seen). |
| game_info_series_code | character | Series code (DBL). |
| game_info_series_name | character | Series name (Basketligaen). |
| game_info_round_number | integer | Round number (0). |
| game_info_round_label | character | Round label (”). |
| game_info_series_display_name | character | Series display name (Basketligaen). |
| home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
| home_team_names_short | character | Short name of the team. |
| home_team_names_long | character | Long name of the team. |
| home_team_names_full | character | Full name of the team. |
| home_team_names_code_site | character | Team code as the club's own site shows it. |
| home_team_names_short_site | character | Short team name as the club's own site shows it. |
| home_team_names_full_site | character | Full team name as the club's own site shows it. |
| home_team_names_long_site | character | Long team name as the club's own site shows it. |
| home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| home_team_instance_id | character | Site instance id of the home club (platform key space). |
| home_team_founded_on | character | Year the club was founded (” when unknown). |
| home_team_icon | character | Home team logo URL. |
| home_team_score | integer | Points scored by the home team. |
| away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
| away_team_names_short | character | Short name of the team. |
| away_team_names_long | character | Long name of the team. |
| away_team_names_full | character | Full name of the team. |
| away_team_names_code_site | character | Team code as the club's own site shows it. |
| away_team_names_short_site | character | Short team name as the club's own site shows it. |
| away_team_names_full_site | character | Full team name as the club's own site shows it. |
| away_team_names_long_site | character | Long team name as the club's own site shows it. |
| away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| away_team_instance_id | character | Site instance id of the away club (platform key space). |
| away_team_founded_on | character | Year the club was founded (” when unknown). |
| away_team_icon | character | Away team logo URL. |
| away_team_score | integer | Points scored by the away team. |
| ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
| series_uuid | character | Series uuid (platform key space; Basketligaen = m1ay3mpa4t, the only series on this host). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_game_header(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Header from basketligaen.dk ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:08:55 UTC
#> # A tibble: 1 × 43
#>   instance_context_site_team_is_…¹ instance_context_sit…² instance_context_sit…³
#>   <lgl>                            <lgl>                  <lgl>                 
#> 1 TRUE                             TRUE                   TRUE                  
#> # ℹ abbreviated names: ¹​instance_context_site_team_is_in_game,
#> #   ²​instance_context_site_team_is_home_team,
#> #   ³​instance_context_site_team_is_away_team
#> # ℹ 40 more variables: game_info_game_uuid <chr>, game_info_ext_id <int>,
#> #   game_info_start_date_time <chr>, game_info_arena_name <chr>,
#> #   game_info_state <chr>, game_info_overtime <lgl>, game_info_shootout <chr>,
#> #   game_info_series_code <chr>, game_info_series_name <chr>, …
# }
```
