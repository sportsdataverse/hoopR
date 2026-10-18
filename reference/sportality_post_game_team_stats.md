# **Get Basketligaen Post-Game Team Stats**

Post-game team comparison (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/post-game-data/team-stats/{game_uuid}`

## Usage

``` r
sportality_post_game_team_stats(
  game_uuid,
  ssgt_uuid,
  home_team_uuid,
  away_team_uuid
)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

- ssgt_uuid:

  (required) ssgt uuid. Without it the answer is an empty 200 body.

- home_team_uuid:

  (required) Home team uuid; without it the home side comes back blank.

- away_team_uuid:

  (required) Away team uuid; without it the away side comes back blank.

## Value

A `hoopR_data` tibble: Post-game team comparison (2023/24 on). An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sdv-py `sportality_post_game_team_stats`), then any
column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| home_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
| home_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
| home_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
| home_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
| home_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
| home_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
| home_team_center_value | integer | Centre value (percentage as an integer 0-100). |
| away_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
| away_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
| away_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
| away_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
| away_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
| away_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
| away_team_center_value | integer | Centre value (percentage as an integer 0-100). |

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
  try(sportality_post_game_team_stats(
    away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",
    ssgt_uuid = "xs07bd3fmp"
  ))
#> ── Basketligaen Post-Game Team Stats from basketligaen.dk ── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:02:37 UTC
#> # A tibble: 3 × 14
#>   home_team_side_translate_key home_team_left_type home_team_left_value
#>   <chr>                        <chr>                              <int>
#> 1 s_2P                         2PM                                   25
#> 2 s_3P                         3PM                                    5
#> 3 s_FT                         FTM                                   19
#> # ℹ 11 more variables: home_team_right_type <chr>, home_team_right_value <int>,
#> #   home_team_center_type <chr>, home_team_center_value <int>,
#> #   away_team_side_translate_key <chr>, away_team_left_type <chr>,
#> #   away_team_left_value <int>, away_team_right_type <chr>,
#> #   away_team_right_value <int>, away_team_center_type <chr>,
#> #   away_team_center_value <int>
# }
```
