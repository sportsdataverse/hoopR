# **Get Basketligaen Team Stats**

Team totals per period (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/team-stats/{game_uuid}`

## Usage

``` r
sportality_team_stats(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Team totals per period (2023/24 on). An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sdv-py `sportality_team_stats`), then any column the API
added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_side | character | home or away: the side the row belongs to. |
| game_source_id | integer | Genius match id (Int64), the same number as game_id and sports-v2 game_info_ext_id. |
| game_id | integer | Genius match id (Int64), the join to the genius family; on play-by-play lines, an integer elsewhere. |
| team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
| team_name | character | Name of the team. |
| team_code | character | Platform team code (HOL, RAN). |
| team_number | integer | Team number; home is 1. |
| instance_id | character | Site instance that owns the feed (platform key space; dbl1_dbl). |
| source | character | Feed that produced the row (genius-basketball-stream-reader). |
| game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
| period | integer | Period: 0 = the whole game, 1-4 the quarters, 5 and up overtime. |
| period_type | character | REGULAR or OVERTIME; absent on the whole-game row of some eras. Values: `REGULAR` = regulation period. |
| tp | integer | Points scored by the team in the period (period 0 = the whole game). |
| fgm | integer | Field goals made (total). |
| a | integer | Assists (total). |
| reb | integer | Total rebounds. |
| stl | integer | Number of steals. |
| blk | integer | Number of blocked shots made. |
| pf | integer | Personal fouls. |

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
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_team_stats(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Team Stats from basketligaen.dk ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:38:21 UTC
#> # A tibble: 10 × 19
#>    team_side game_source_id game_id team_id team_name      team_code team_number
#>    <chr>              <int>   <int>   <int> <chr>          <chr>           <int>
#>  1 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  2 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  3 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  4 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  5 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  6 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  7 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  8 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  9 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#> 10 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#> # ℹ 12 more variables: instance_id <chr>, source <chr>, game_uuid <chr>,
#> #   period <int>, period_type <chr>, tp <int>, fgm <int>, a <int>, reb <int>,
#> #   stl <int>, blk <int>, pf <int>
# }
```
