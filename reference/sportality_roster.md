# **Get Basketligaen Team Roster**

Current roster of a team, grouped by position.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athletes/by-team-uuid/{team_uuid}`

## Usage

``` r
sportality_roster(team_uuid)
```

## Arguments

- team_uuid:

  (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the
  schedule or `teamList[].uuid`. Key space: platform team uuids (not the
  numeric Genius team id).

## Value

A `hoopR_data` tibble: Current roster of a team, grouped by position. An
empty valid answer raises `hoopR_no_data`; the documented columns come
first, in this order (sdv-py `sportality_roster`), then any column the
API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| position | character | Playing position. |
| position_code | character | Position code (G, F, C, or a finer code such as SG on the profile route). Values: `C` = center; `F` = forward; `G` = guard. |
| player_type | character | Record type (athlete). Values: `athlete` = a player. |
| gender | character | Gender of the person as recorded by the site (male in every row seen). |
| uuid | character | Athlete uuid (platform key space). |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| full_name | character | Full display name of the player. |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| jersey_number | integer | Jersey (shirt) number of the player. |
| portrait_url | character | URL of the player's latest rendered portrait. |

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
  try(sportality_roster(team_uuid = "rfo82vr830"))
#> ── Basketligaen Team Roster from basketligaen.dk ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:43:03 UTC
#> # A tibble: 13 × 11
#>    position position_code player_type gender uuid       first_name    last_name 
#>    <chr>    <chr>         <chr>       <chr>  <chr>      <chr>         <chr>     
#>  1 Guards   G             athlete     male   cj81dc09w3 Malthe        Aabling   
#>  2 Guards   G             athlete     male   cjcrt5hlho Bryceson      Burns     
#>  3 Guards   G             athlete     male   dmon8irp4j Maxim         Shinkarev 
#>  4 Guards   G             athlete     male   hnrg2dqjcu Oskar Harring Østoft    
#>  5 Guards   G             athlete     male   k1nh3mnqzp Julius        Aabling   
#>  6 Guards   G             athlete     male   khm59ormd2 Sebastian     Reumert   
#>  7 Guards   G             athlete     male   wtpfbry97z Karl          Heming    
#>  8 Guards   G             athlete     male   zu0qp4mq65 Anders        Jellesmark
#>  9 Forwards F             athlete     male   fjn17iovmg August        Heming    
#> 10 Forwards F             athlete     male   m8ajfnag3m Caden         Fry       
#> 11 Centers  C             athlete     male   fyeh5w7iar Oskar Fløng   Vanner    
#> 12 Centers  C             athlete     male   mqers10jtj Daniel        Stubkjær  
#> 13 Centers  C             athlete     male   wz2bk7trd4 Visti         Thomsen   
#> # ℹ 4 more variables: full_name <chr>, nationality <chr>, jersey_number <int>,
#> #   portrait_url <chr>
# }
```
