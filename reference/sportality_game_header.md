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
documented columns come first, in this order (sdv-py
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

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
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

## Examples

``` r
# \donttest{
  try(sportality_game_header(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Header from basketligaen.dk ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:42:56 UTC
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
