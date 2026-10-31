# **Get Basketligaen Box Score**

Player box score and team rows of both sides (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/boxscore/{game_uuid}`

## Usage

``` r
sportality_boxscore(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Player box score and team rows of both sides
(2023/24 on). An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sdv-py
`sportality_boxscore`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_side | character | home or away: the side the row belongs to. |
| row_type | character | Kind of row: player, team_coach (the bench row: team rebounds, turnovers and fouls charged to the team or coach) or team_totals. |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
| team_name | character | Name of the team. |
| period | integer | Period of the line: 0 = the whole game (the only value seen). |
| full_name | character | Full display name of the player. |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| nr | integer | Jersey number (null on the bench and totals rows). |
| pos | character | Position code of the line (G, F, C; null on the bench and totals rows). |
| mins | character | Minutes played as 'MM:SS' (null on the bench and totals rows). |
| pts | integer | Number of points scored. |
| fg | character | Field goals as 'made-attempted'. |
| fg_perc | double | Field-goal percentage, 0-100. |
| 2_p | character | Two-pointers as 'made-attempted'. |
| 2_p_perc | double | Two-point percentage, 0-100. |
| 3_p | character | Three-pointers as 'made-attempted'. |
| 3_p_perc | double | Three-point percentage, 0-100. |
| ft | character | Free throws as 'made-attempted'. |
| ft_perc | double | Free-throw percentage, 0-100. |
| off | integer | Offensive rebounds. |
| def | integer | Defensive rebounds. |
| reb | integer | Total rebounds. |
| ast | integer | Number of assists credited. |
| to | integer | Number of turnovers committed. |
| stl | integer | Number of steals. |
| blk | integer | Number of blocked shots made. |
| blkr | integer | Blocks received (shots of the player that were blocked). |
| pf | integer | Personal fouls. |
| f_on | integer | Fouls on (fouls drawn). |
| plus_minus | integer | Plus/minus while on court. |

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
  try(sportality_boxscore(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Box Score from basketligaen.dk ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:36:09 UTC
#> # A tibble: 28 × 32
#>    team_side row_type player_id team_id team_name    period full_name first_name
#>    <chr>     <chr>        <int>   <int> <chr>         <int> <chr>     <chr>     
#>  1 home      player     1887576  153747 Holbæk-Sten…      0 Oskar Fl… Oskar Flø…
#>  2 home      player     2777479  153747 Holbæk-Sten…      0 Bryceson… Bryceson  
#>  3 home      player     2404639  153747 Holbæk-Sten…      0 Anders J… Anders    
#>  4 home      player     2779432  153747 Holbæk-Sten…      0 Sebastia… Sebastian 
#>  5 home      player     2777481  153747 Holbæk-Sten…      0 Otto Jer… Otto      
#>  6 home      player     1951861  153747 Holbæk-Sten…      0 August H… August    
#>  7 home      player     2495922  153747 Holbæk-Sten…      0 Karl Hem… Karl      
#>  8 home      player     2380378  153747 Holbæk-Sten…      0 Julius A… Julius    
#>  9 home      player     2385172  153747 Holbæk-Sten…      0 Malthe A… Malthe    
#> 10 home      player     2778538  153747 Holbæk-Sten…      0 Caden Fry Caden     
#> # ℹ 18 more rows
#> # ℹ 24 more variables: last_name <chr>, nr <int>, pos <chr>, mins <chr>,
#> #   pts <int>, fg <chr>, fg_perc <dbl>, `2_p` <chr>, `2_p_perc` <dbl>,
#> #   `3_p` <chr>, `3_p_perc` <dbl>, ft <chr>, ft_perc <dbl>, off <int>,
#> #   def <int>, reb <int>, ast <int>, to <int>, stl <int>, blk <int>,
#> #   blkr <int>, pf <int>, f_on <int>, plus_minus <int>
# }
```
