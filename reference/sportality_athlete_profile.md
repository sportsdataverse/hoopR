# **Get Basketligaen Athlete Profile**

Player profile: age, height, position, season and career totals.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/athlete/profile-page`

## Usage

``` r
sportality_athlete_profile(athlete_uuid, master_site_instance_id = NULL)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid.

- master_site_instance_id:

  (default `NULL`) Site instance (dbl1_dbl). No effect in the drop-one
  probe.

## Value

A `hoopR_data` tibble: Player profile: age, height, position, season and
career totals. An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sdv-py
`sportality_athlete_profile`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| uuid | character | Platform uuid of this record (10-character lowercase key space of its record type; joins the route that serves it). |
| full_name | character | Full display name of the player. |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| gender | character | Gender of the team or player: male or female (every record on this host is male). |
| age_value | integer | Age in whole years. |
| age_format | character | Unit of the value (years). Values: `years` = years. |
| weight_value | integer | Weight of the player in kilograms. |
| weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
| height_value | integer | Height of the player in centimetres. |
| height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
| jersey_number | integer | Jersey (shirt) number of the player. |
| position | character | Playing position. |
| position_code | character | Position code (G, F, C, or a finer code such as SG on the profile route). Values: `G` = guard. |
| shoots | character | Shooting hand (empty or null for every player seen). |
| team_uuid | character | Platform team uuid. |
| team_instance_id | character | Site instance id of the club (platform key space). |
| team_name | character | Name of the team. |
| team_code | character | Platform team code (HOL, RAN). |
| team_media | character | URL of the team logo image. |
| season_stats | character | The player's current-season totals as field/value pairs (GP, PAvg, ...). |
| career_stats | character | The player's career totals as field/value pairs. |
| statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |
| is_in_squad | logical | Whether the player is in the team's current squad. |
| media_url | character | Portrait image URL (imgix CDN). |
| media_alt | character | Image alt text (”). |
| media_srcset | character | Responsive image set (imgix CDN URLs with widths). |
| media_url_img_original_proportion | character | Portrait URL at its original proportions. |
| media_url_placeholder_image | character | Placeholder image URL (”). |
| media_videourl | character | Video URL (”). |
| media_photographer | character | Photographer credit (”). |
| media_focal_point | character | Focal point record (empty). |

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
  try(sportality_athlete_profile(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl"))
#> ── Basketligaen Athlete Profile from basketligaen.dk ─────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:02:23 UTC
#> # A tibble: 1 × 33
#>   uuid    full_name first_name last_name nationality gender age_value age_format
#>   <chr>   <chr>     <chr>      <chr>     <chr>       <chr>      <int> <chr>     
#> 1 dpu090… Luka Chu… Luka       Churchill DK          male          19 years     
#> # ℹ 25 more variables: weight_value <int>, weight_format <chr>,
#> #   height_value <int>, height_format <chr>, jersey_number <int>,
#> #   position <chr>, position_code <chr>, shoots <chr>, team_uuid <chr>,
#> #   team_instance_id <chr>, team_name <chr>, team_code <chr>, team_media <chr>,
#> #   season_stats <chr>, career_stats <chr>, statistics_provider <chr>,
#> #   is_in_squad <lgl>, media_url <chr>, media_alt <chr>, media_srcset <chr>,
#> #   media_url_img_original_proportion <chr>, …
# }
```
