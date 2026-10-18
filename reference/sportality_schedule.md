# **Get Basketligaen Schedule**

Schedule and results of one season + series + game type.

Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/game-schedule`

## Usage

``` r
sportality_schedule(season, game_type = "regular")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025/26). Mapped to the provider's
  ssgt through /statistics-v2/layout- info (Basketligaen 2002/03 on); a
  season it does not list raises `hoopR_no_data`.

- game_type:

  (default `"regular"`) Game type: regular (the league season) or finals
  (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble: Schedule and results of one season + series +
game type. An empty valid answer raises `hoopR_no_data`; the documented
columns come first, in this order (sdv-py `sportality_schedule`), then
any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
| raw_start_date_time | character | Scheduled start, ISO 8601 UTC. |
| start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
| state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `post-game` = played (schedule, day views); `pre-game` = not yet played (schedule, day views). |
| overtime | logical | Whether the game went to overtime. |
| shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
| ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
| home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `N/A` = no result yet / not applicable; `WIN` = the team won. |
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
| away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `N/A` = no result yet / not applicable; `WIN` = the team won. |
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
| round_number | integer | Round number (0 for every game seen; the league has no rounds). |
| round_label | character | Round label (” for every game seen). |

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
  try(sportality_schedule(season = 2026))
#> ── Basketligaen Schedule from basketligaen.dk ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:45:51 UTC
#> # A tibble: 192 × 42
#>    game_uuid  raw_start_date_time      start_date_time   state overtime shootout
#>    <chr>      <chr>                    <chr>             <chr> <lgl>    <chr>   
#>  1 tzos88ce7j 2025-09-18T17:00:00.000Z 2025-09-18 19:00… post… FALSE    NA      
#>  2 e6c9q8kxrz 2025-09-23T17:00:00.000Z 2025-09-23 19:00… post… FALSE    NA      
#>  3 ncfteyungm 2025-09-23T17:00:00.000Z 2025-09-23 19:00… post… FALSE    NA      
#>  4 ok9xf6gpvq 2025-09-24T17:00:00.000Z 2025-09-24 19:00… post… FALSE    NA      
#>  5 fi5lbggu0d 2025-09-25T16:30:00.000Z 2025-09-25 18:30… post… FALSE    NA      
#>  6 e2nbu189d7 2025-09-25T17:15:00.000Z 2025-09-25 19:15… post… FALSE    NA      
#>  7 wnpaoqq9fv 2025-09-27T13:30:00.000Z 2025-09-27 15:30… post… FALSE    NA      
#>  8 uobq25luqy 2025-09-27T15:00:00.000Z 2025-09-27 17:00… post… FALSE    NA      
#>  9 gmsti5d0tg 2025-09-28T13:00:00.000Z 2025-09-28 15:00… post… FALSE    NA      
#> 10 ia97u0jb4u 2025-09-28T14:00:00.000Z 2025-09-28 16:00… post… FALSE    NA      
#> # ℹ 182 more rows
#> # ℹ 36 more variables: ssgt_uuid <chr>, home_team_status <chr>,
#> #   home_team_uuid <chr>, home_team_owner_instance_id <chr>,
#> #   home_team_code <chr>, home_team_names_code <chr>,
#> #   home_team_names_short <chr>, home_team_names_long <chr>,
#> #   home_team_names_full <chr>, home_team_names_code_site <chr>,
#> #   home_team_names_short_site <chr>, home_team_names_full_site <chr>, …
# }
```
