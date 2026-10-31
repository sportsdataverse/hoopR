# **Get Basketligaen Last Game Day**

Games of the last played match day of an ssgt.

Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/last-game-day`

## Usage

``` r
sportality_last_game_day(season = NULL, game_type = "regular")
```

## Arguments

- season:

  (default `NULL`) Season END year (2026 = 2025/26), mapped to its ssgt
  through layout-info. NULL = the active ssgt (these match-day views
  follow the current season).

- game_type:

  (default `"regular"`) Game type: regular (the league season) or finals
  (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble: Games of the last played match day of an ssgt. An
empty valid answer raises `hoopR_no_data`; the documented columns come
first, in this order (sportsdataverse-py `sportality_last_game_day`),
then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
| start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
| state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `post-game` = played (schedule, day views). |
| overtime | logical | Whether the game went to overtime. |
| shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
| ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
| home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
| home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
| home_team_code | character | Three-letter code of the home team. |
| home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
| home_team_names_short | character | Short name of the team. |
| home_team_names_long | character | Long name of the team. |
| home_team_names_full | character | Full name of the team. |
| home_team_names_code_site | character | Team code as the club's own site shows it. |
| home_team_names_short_site | character | Short team name as the club's own site shows it. |
| home_team_names_full_site | character | Full team name as the club's own site shows it. |
| home_team_names_long_site | character | Long team name as the club's own site shows it. |
| home_team_score | integer | Home points; null before the game is played. |
| home_team_icon | character | Home team logo URL. |
| away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
| away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
| away_team_code | character | Three-letter code of the away team. |
| away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
| away_team_names_short | character | Short name of the team. |
| away_team_names_long | character | Long name of the team. |
| away_team_names_full | character | Full name of the team. |
| away_team_names_code_site | character | Team code as the club's own site shows it. |
| away_team_names_short_site | character | Short team name as the club's own site shows it. |
| away_team_names_full_site | character | Full team name as the club's own site shows it. |
| away_team_names_long_site | character | Long team name as the club's own site shows it. |
| away_team_score | integer | Away points; null before the game is played. |
| away_team_icon | character | Away team logo URL. |
| venue_uuid | character | Venue uuid (platform key space). |
| venue_name | character | Venue name; absent when unknown. |
| series_uuid | character | Series uuid (platform key space). |
| series_code | character | Series display name (Basketligaen; NOT the DBL code). |
| series_display_name | character | Series display name (Basketligaen). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_last_game_day())
#> Error in sportality_last_game_day() : 
#>   www.basketligaen.dk/api/statistics-v2/layout-info: 0 ssgts in the body,
#> expected the 40+ of 25 seasons.
# }
```
