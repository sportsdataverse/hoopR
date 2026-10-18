# **Get Basketligaen Player Career**

Player career totals, one row per ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/athlete/playerProfile_gameLog`

## Usage

``` r
sportality_athlete_career(athlete_uuid, master_site_instance_id = NULL)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid.

- master_site_instance_id:

  (default `NULL`) Site instance (dbl1_dbl). No effect in the drop-one
  probe.

## Value

A `hoopR_data` tibble: Player career totals, one row per ssgt. An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sdv-py `sportality_athlete_career`), then any column the
API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| g | integer | Games played in the ssgt. |
| gps | integer | Games started (0 on every row seen). |
| mpg | numeric | Minutes per game, 'M.m' string. |
| ppg | numeric | Points per game (a number or. |
| drpg | numeric | Defensive rebounds per game. |
| orpg | numeric | Offensive rebounds per game. |
| rpg | numeric | Rebounds per game. |
| apg | numeric | Assists per game. |
| stpg | numeric | Steals per game. |
| blkpg | numeric | Blocks per game. |
| pfpg | numeric | Personal fouls per game. |
| 2_p_perc | numeric | Two-point percentage, 0-100. |
| 3_pm | integer | Three-pointers made (total). |
| 3_pa | numeric | Three-pointers attempted (total, or a percentage string in the checked rows; unverified). |
| 3_p_perc | numeric | Three-point percentage, 0-100. |
| ft_perc | numeric | Free-throw percentage, 0-100. |
| topg | numeric | Turnovers per game. |
| plus_minus_pg | numeric | Plus/minus per game. |
| info_uuid | character | Athlete uuid on player tables, team uuid on team tables (platform key space). |
| info_full_name | character | Full display name of the player. |
| info_first_name | character | Given (first) name(s) of the player. |
| info_last_name | character | Family name (surname) of the player. |
| info_nationality | character | ISO 3166-1 alpha-2 country code. |
| info_gender | character | Gender of the person as recorded by the site (male in every row seen). |
| info_age_value | integer | Age in whole years. |
| info_age_format | character | Unit of the value (years). Values: `years` = years. |
| info_weight_value | integer | Weight of the player in kilograms. |
| info_weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
| info_height_value | integer | Height of the player in centimetres. |
| info_height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
| info_jersey_number | character | Jersey number ('N/A' on career rows). |
| info_position | character | Position code (G, F, C, SG, SF ...). |
| info_position_code | character | Position code ('N/A' on career rows). Values: `N/A` = not applicable (career rows). |
| info_shoots | character | Shooting hand (null). |
| info_team_uuid | character | Team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| info_team_instance_id | character | Site instance id of the club (platform key space). |
| info_team_name | character | Name of the team. |
| info_team_code | character | Three-letter team code. |
| info_season_stats | character | Season totals (always empty here). |
| info_career_stats | character | Career totals (always empty here). |
| info_statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |
| info_is_in_squad | logical | Whether the player is in the team's current squad. |
| info_player_id | integer | Genius person id (Genius key space; an integer). |
| info_ssgt_uuid | character | ssgt uuid of the career row (platform key space). |
| info_team_id | integer | Genius team id (Genius key space; an integer here). |

## Details

- Unofficial: the JSON API behind www.basketligaen.dk, the Danish men's
  basketball league (Basketligaen, series code DBL). The site runs on
  the Sportality platform (the vendor behind the SHL and
  HockeyAllsvenskan wrappers). The terms page was not read; payloads are
  not redistributed as release assets.

- Stats provider: genius-basketball, a relay of Genius Sports LiveStats.
  The Genius match, team and person ids in play-by-play, box scores and
  stats tables (game_id, team_id, player_id, all Int64) join the genius
  family; the platform uuids (game, team, athlete, ssgt) are not Genius
  ids and exist only on this site. The Genius ORG code of Denmark is not
  exposed.

- Season = the END year (2026 = 2025/26) everywhere; the runtime maps
  it, with game_type ('regular' or 'finals', the playoffs), to the
  site's ssgt (season + series + game type) through layout-info.
  Schedules, standings and season tables start in 2002/03; game-level
  data (play-by-play with shot x/y, box scores, team stats) starts in
  2023/24.

- Source defects the runtime refuses (`hoopR_asset_fetch`): an
  unfinished game or a truncated play-by-play feed, a box score or feed
  that names another game, a cut stats table. The 2002/03 regular-season
  schedule lists 109 finished games where its own standings count 110: a
  source gap.

- Personal data is removed from every body: birth dates, e-mail
  addresses, phone numbers, addresses and contact blocks.

- No women's league: Dameligaen has its own domain (dameligaen.dk),
  which answers 401 to anonymous requests.

- Errors are classed conditions: `hoopR_no_data` (404, an empty gameday
  body, [`{}`](https://rdrr.io/r/base/Paren.html) / `[]`, a table with
  no rows, a season or game type layout-info does not list),
  `hoopR_bad_request` (a bad argument, a 400 / 422) and
  `hoopR_asset_fetch` (an error envelope or non-JSON 200, a body for
  another game / team / athlete / ssgt, an unfinished game or truncated
  play-by-play, a cut stats table, any other non-2xx; a 500 is the
  site's answer for an unknown uuid and is not retried), all inheriting
  `hoopR_error`. Wrappers raise; they never return an empty frame.

     sportality_athlete_career(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")

## See also

Other Basketligaen Functions:
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
