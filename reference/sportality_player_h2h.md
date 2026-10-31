# **Get Basketligaen Player Head-to-Head**

Player head-to-head of a matchup with per-game and season lines.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/player-h2h-v2/{ssgt_uuid}/{home_team_uuid}/{away_team_uuid}`

## Usage

``` r
sportality_player_h2h(
  ssgt_uuid,
  home_team_uuid,
  away_team_uuid,
  game_uuid = NULL
)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

- home_team_uuid:

  (required) Home team uuid of the game.

- away_team_uuid:

  (required) Away team uuid of the game.

- game_uuid:

  (default `NULL`) Game uuid; selects the game whose box-score lines the
  head-to-head carries.

## Value

A `hoopR_data` tibble: Player head-to-head of a matchup with per-game
and season lines. An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_player_h2h`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| uuid | character | Athlete uuid (platform key space). |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| full_name | character | Full display name of the player. |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| gender | character | Gender of the person as recorded by the site (male in every row seen). |
| jersey_number | integer | Jersey (shirt) number of the player. |
| position | character | Position name (Guard, Forward, Center ...). |
| position_code | character | Position code. Values: `C` = center; `G` = guard; `N/A` = not applicable (career rows); `PF` = power forward; `PG` = point guard; `SF` = small forward; `SG` = shooting guard. |
| age_value | integer | Age in whole years. |
| age_format | character | Unit of the value (years). Values: `years` = years. |
| height_value | integer | Height of the player in centimetres. |
| height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
| weight_value | integer | Weight of the player in kilograms. |
| weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
| team_uuid | character | Platform team uuid. |
| team_instance_id | character | Site instance id of the club (platform key space). |
| team_name | character | Name of the team. |
| team_code | character | Platform team code (HOL, RAN). |
| team_media | character | URL of the team logo image. |
| media_url | character | Portrait image URL (imgix CDN). |
| media_alt | character | Image alt text (”). |
| media_srcset | character | Responsive image set (imgix CDN URLs with widths). |
| season_stats | character | Season totals as field/value pairs (absent for some players). |
| career_stats | character | Career totals as field/value pairs (absent for some players). |
| match_stats_nr | integer | Jersey (shirt) number of the player. |
| match_stats_pos | character | Playing position code of the player (G, F, C, ...). |
| match_stats_team_number | integer | Team number in the game. |
| match_stats_pno | integer | Genius shirt-table number. |
| match_stats_mins | character | Minutes played 'MM:SS'. |
| match_stats_pts | integer | Number of points scored. |
| match_stats_fg | character | Field goals 'made-attempted'. |
| match_stats_fg_perc | double | Field-goal percentage, 0-100. |
| match_stats_2_p | character | Two-pointers 'made-attempted'. |
| match_stats_2_p_perc | double | Two-point percentage, 0-100. |
| match_stats_3_p | character | Three-pointers 'made-attempted'. |
| match_stats_3_p_perc | double | Three-point percentage, 0-100. |
| match_stats_ft | character | Free throws 'made-attempted'. |
| match_stats_ft_perc | double | Free-throw percentage, 0-100. |
| match_stats_off | integer | Offensive rebounds. |
| match_stats_def | integer | Defensive rebounds. |
| match_stats_reb | integer | Total rebounds. |
| match_stats_ast | integer | Number of assists credited. |
| match_stats_to | integer | Number of turnovers committed. |
| match_stats_stl | integer | Number of steals. |
| match_stats_blk | integer | Number of blocked shots made. |
| match_stats_blkr | integer | Blocks received. |
| match_stats_pf | integer | Personal fouls. |
| match_stats_f_on | integer | Fouls on (fouls drawn). |
| match_stats_plus_minus | integer | Plus/minus while on court. |
| season_avg_stats | character | The player's season averages (an object keyed by stat). |
| statistics_provider | character | Stats provider (genius-basketball). |
| is_in_squad | logical | Whether the player is in the squad. |
| effective_ssgt_uuid | character | The ssgt the head-to-head was computed for: the CURRENT season, whatever the path asked. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_player_h2h(
       away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",
       ssgt_uuid = "xs07bd3fmp"
     )

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
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
