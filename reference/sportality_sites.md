# **Get Basketligaen Sites (Clubs) of an ssgt**

Clubs (sites) taking part in an ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/all-sites/{ssgt_uuid}`

## Usage

``` r
sportality_sites(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble: Clubs (sites) taking part in an ssgt. An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sdv-py `sportality_sites`), then any column the API added
later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| id | character | Site instance id of the club (platform key space; the same as instanceId). |
| instance_id | character | Site instance id of the club or league (platform key space, `<code><n>_<code>` such as hol2_hol; the league itself is dbl1_dbl). |
| public_url | character | The club's own website. |
| name | character | Display name of the club. |
| icon | character | Team logo URL (SVG on sportality.cdn.s8y.se). |

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
  try(sportality_sites(ssgt_uuid = "xs07bd3fmp"))
#> ── Basketligaen Sites (Clubs) of an ssgt from basketligaen.dk ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:49:29 UTC
#> # A tibble: 12 × 5
#>    id       instance_id public_url                                name     icon 
#>    <chr>    <chr>       <chr>                                     <chr>    <chr>
#>  1 bac1_bac bac1_bac    http://www.bakkenbears.com/bears-academy/ Bears A… http…
#>  2 bak1_bak bak1_bak    http://www.bakkenbears.com                Bakken … http…
#>  3 bcc1_bcc bcc1_bcc    http://bccopenhagen.com                   BC Cope… http…
#>  4 bkv1_bkv bkv1_bkv    http://vejenbasket.dk                     BK Vejen http…
#>  5 bms1_bms bms1_bms    http://bmsherlev.dk                       BMS Her… http…
#>  6 glx1_glx glx1_glx    http://www.gladsaxebasket.dk              Gladsax… http…
#>  7 hic1_hic hic1_hic    http://horsensic.dk                       Horsens… http…
#>  8 hol2_hol hol2_hol    http://holbaekbasket.dk                   Holbæk-… http…
#>  9 ran1_ran ran1_ran    http://www.randerscimbria.dk              Randers… http…
#> 10 sve1_sve sve1_sve    http://www.rabbits.dk                     Svendbo… http…
#> 11 tfn1_tfn tfn1_tfn    http://teamfog.dk/forside/                Team FO… http…
#> 12 vbh1_vbh vbh1_vbh    http://www.vbbk.dk                        Værløse… http…
# }
```
