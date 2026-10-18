# **Get Basketligaen Athlete Details**

Player bio plus playerExtIds (the Genius person id).

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athlete-details/{athlete_uuid}`

## Usage

``` r
sportality_athlete_details(athlete_uuid)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid: roster `players[].uuid` or stats-info
  `stats[].info.uuid`. Key space: platform athlete uuids (not the Genius
  person id).

## Value

A `hoopR_data` tibble: Player bio plus playerExtIds (the Genius person
id). An empty valid answer raises `hoopR_no_data`; the documented
columns come first, in this order (sdv-py `sportality_athlete_details`),
then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| athlete_uuid | character | Platform athlete uuid (rosters and athlete routes key on it); not the Genius person id; null where the site has none. |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| created_at | character | Creation timestamp. |
| created_by | character | Creating site instance. |
| creator_site | character | Unobserved: null in every sample and every full body. When filled: Creating site (null). |
| height | integer | Height of the player in centimetres. |
| deleted | logical | Soft-delete flag. |
| first_name | character | Given (first) name(s) of the player. |
| gender | character | Gender of the person as recorded by the site (male in every row seen). |
| last_modified | character | Last-modified timestamp. |
| last_name | character | Family name (surname) of the player. |
| metadata | character | Free metadata (always empty). |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| shoots | character | Shooting hand (”). |
| weight | integer | Weight of the player in kilograms. |

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

## Examples

``` r
# \donttest{
  try(sportality_athlete_details(athlete_uuid = "dpu0901c0t"))
#> ── Basketligaen Athlete Details from basketligaen.dk ─────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:02:22 UTC
#> # A tibble: 1 × 15
#>   athlete_uuid player_id created_at       created_by creator_site height deleted
#>   <chr>            <int> <chr>            <chr>      <chr>         <int> <lgl>  
#> 1 dpu0901c0t     1917467 2026-06-17T12:1… dbl1_dbl   NA              197 FALSE  
#> # ℹ 8 more variables: first_name <chr>, gender <chr>, last_modified <chr>,
#> #   last_name <chr>, metadata <chr>, nationality <chr>, shoots <chr>,
#> #   weight <int>
# }
```
