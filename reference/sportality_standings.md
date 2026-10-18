# **Get Basketligaen Standings**

Standings of an ssgt (gameday widget).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/team-standings/{ssgt_uuid}`

## Usage

``` r
sportality_standings(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble: Standings of an ssgt (gameday widget). An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sdv-py `sportality_standings`), then any column the API
added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
| team_uuid | character | Platform team uuid. |
| team_code | character | Platform team code (HOL, RAN). |
| team_name | character | Name of the team. |
| rank | integer | Rank in the standings table, 1 = first. |
| gp | integer | Number of games played. |
| w | integer | Number of wins. |
| l | integer | Number of losses. |
| tp | integer | League table points (2 per win). |
| for | integer | Points scored by the team (points for). |
| ga | integer | Points conceded. |
| plus_minus | integer | Point difference. |
| strk | integer | Current streak as a signed integer: positive = wins in a row, negative = losses in a row. |

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
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_standings(ssgt_uuid = "xs07bd3fmp"))
#> ── Basketligaen Standings from basketligaen.dk ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:49:30 UTC
#> # A tibble: 12 × 13
#>    team_id team_uuid  team_code team_name     rank    gp     w     l    tp `for`
#>      <int> <chr>      <chr>     <chr>        <int> <int> <int> <int> <int> <int>
#>  1   22255 iutrlqp3ef TFN       Team FOG Næ…     1     5     5     0    10   511
#>  2   22248 ktcu9aaala BAK       Bakken Bears     2     5     5     0    10   529
#>  3   22249 hip2m60a45 HIC       Horsens IC       3     6     4     2     8   505
#>  4   22256 kgmhwo9l5d SVE       Svendborg R…     4     6     4     2     8   529
#>  5   22250 gvvuxe9ysw RAN       Randers Cim…     5     6     4     2     8   568
#>  6  156486 ka7lusvmtn BCC       BC Copenhag…     6     5     3     2     6   378
#>  7  199228 nuzzapynfd GLX       Gladsaxe Ba…     7     6     2     4     4   476
#>  8  187013 wv1lcxg0u2 BKV       BK Vejen         8     5     2     3     4   404
#>  9  153747 rfo82vr830 HOL       Holbæk-Sten…     9     6     2     4     4   466
#> 10  140898 kgejfzwwbd BMS       BMS Herlev      10     6     1     5     2   450
#> 11  130088 swr1d65lew BAC       Bears Acade…    11     6     1     5     2   457
#> 12  114932 ozojzoejir VBH       Værløse Blu…    12     6     1     5     2   488
#> # ℹ 3 more variables: ga <int>, plus_minus <int>, strk <int>
# }
```
