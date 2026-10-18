# **Get Basketligaen Play-by-Play**

Play-by-play events with shot coordinates and the Genius ids (2023/24
on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/play-by-play/{game_uuid}`

## Usage

``` r
sportality_pbp(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Play-by-play events with shot coordinates and the
Genius ids (2023/24 on). An empty valid answer raises `hoopR_no_data`;
the documented columns come first, in this order (sdv-py
`sportality_pbp`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_source_id | integer | Genius match id (Int64), the same number as game_id and sports-v2 game_info_ext_id. |
| game_id | integer | Genius match id (Int64), the join to the genius family; on play-by-play lines, an integer elsewhere. |
| event_id | integer | Genius event number within the game (Int64), increasing through the game. |
| type | character | Event type: one line per action; shots are the shooter's line, assists, blocks, steals and fouls drawn are further lines. Values: `2pt` = two-point attempt (made when isSuccessful = 1); `3pt` = three-point attempt (made when isSuccessful = 1); `assist` = assist on the previous made shot; `block` = block; `clock` = clock start, stop or adjustment; `foul` = foul committed; `foulon` = foul drawn (fouled player); `freethrow` = free-throw attempt; `game` = game start / end line; `headcoachchallenge` = head coach challenge; `jumpball` = jump ball or held ball; `period` = period start / end line; `rebound` = rebound; `steal` = steal; `substitution` = substitution (in or out); `timeout` = timeout; `turnover` = turnover. |
| event_uuid | character | Event uuid (UUID v5 derived from the event; unique per event). |
| period | integer | Period: 0 = the whole game, 1-4 the quarters, 5 and up overtime. |
| period_type | character | REGULAR or OVERTIME; absent on the period marker lines. Values: `OVERTIME` = overtime period; `REGULAR` = regulation period. |
| time | character | Clock REMAINING in the period as mm:ss:cc (cc looks like hundredths of a second, only ever 00, 10, 30, 50 ... seen; unverified). Absent on the per-period marker lines. |
| real_world_time | character | Wall-clock time of the event, ISO 8601 UTC. |
| updated_time | character | When the feed last updated the event, ISO 8601 UTC. |
| home_team_id | integer | Genius team id of the home team (Genius key space; Int64). |
| home_team_code | character | Home team code as Genius spells it (mixed case, 'Hol'). |
| home_team_name | character | Name of the home team. |
| home_abbreviation | character | Home team abbreviation. |
| home_team_number | integer | Team number in the game; home is 1. |
| home_place | character | Side of the home block: always home. |
| home_score | integer | Points scored by the home team. |
| away_team_id | integer | Genius team id of the away team (Genius key space; Int64). |
| away_team_code | character | Away team code as Genius spells it. |
| away_team_name | character | Name of the away team. |
| away_abbreviation | character | Away team abbreviation. |
| away_team_number | integer | Team number in the game; away is 2. |
| away_place | character | Side of the away block: always away. |
| away_score | integer | Points scored by the away team. |
| revision | integer | Revision counter of the event. |
| game_state | character | Game state at the event: ongoing during play, GameEnded on the final line. Values: `GameEnded` = game over (the final line of a complete feed); `ongoing` = game in progress. |
| game_type | character | Game type of the game (” on every line seen). |
| round | integer | Round number (0). |
| start_date_and_time | character | Start of the game (” on every line seen). |
| sub_type | character | Refinement of `type` (the shot type, rebound kind, foul kind, ...); null on types that have none. Values: `1of1` = free throw 1 of 1; `1of2` = free throw 1 of 2; `1of3` = free throw 1 of 3; `24sec` = shot-clock violation; `2of2` = free throw 2 of 2; `2of3` = free throw 2 of 3; `3of3` = free throw 3 of 3; `3sec` = three-second violation; `5sec` = five-second violation; `8sec` = eight-second violation; `adjustment` = clock adjustment; `alleyoop` = alley-oop shot; `alleyoopdunk` = alley-oop dunk; `backcourt` = backcourt violation; `badpass` = bad pass; `ballhandling` = ball-handling error; `benchTechnical` = technical foul on the bench; `coachTechnical` = technical foul on the coach; `defensive` = defensive rebound; `disqualifying` = disqualifying foul; `disruptive` = disruptive foul (unverified); `doubledribble` = double dribble; `drivinglayup` = driving layup; `dunk` = dunk; `end` = end of the period or game; `eurostep` = euro-step layup; `fadeaway` = fadeaway jump shot; `flagrant` = flagrant foul; `floatingjumpshot` = floating jump shot; `full` = full timeout; `heldball` = held ball; `hookshot` = hook shot; `in` = player enters; `jumpshot` = jump shot; `layup` = layup; `lodgedball` = lodged ball; `lost` = lost the jump ball; `offensive` = offensive rebound or offensive foul; `offensivegoaltending` = offensive goaltending; `officials` = official timeout; `other` = other; `out` = player leaves; `outofbounds` = out of bounds; `outofboundsrebound` = rebound off an out-of-bounds ball (unverified); `personal` = personal foul; `pullupjumpshot` = pull-up jump shot; `reverselayup` = reverse layup; `start` = start of the period or game, or clock start; `startperiod` = start of a period (jump ball line); `stepbackjumpshot` = step-back jump shot; `stop` = clock stop; `technical` = technical foul; `throwIn` = throw-in violation (unverified); `tipindunk` = tip-in dunk; `tipinlayup` = tip-in layup; `travel` = traveling; `turnaroundjumpshot` = turnaround jump shot; `unsportsmanlike` = unsportsmanlike foul; `won` = won the jump ball. |
| qualifiers | character | Event qualifiers joined by ';' (a list in recent games, a ';'-joined string or null in older ones). |
| is_successful | integer | 1 when the action succeeded (a made shot or free throw, a recorded rebound ...). ABSENT, not 0, for a missed shot, so count misses as rows without it. |
| instance_id | character | Site instance id of the club or league (platform key space, `<code><n>_<code>` such as hol2_hol; the league itself is dbl1_dbl). |
| source | character | Feed that produced the line (genius-basketball-stream-reader). |
| game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
| event_team_id | integer | Genius team id (Genius key space; Int64). |
| event_team_code | character | Team code as Genius spells it. |
| event_team_name | character | Name of the team. |
| event_abbreviation | character | Team abbreviation. |
| event_team_number | integer | Team number in the game (1 home, 2 away). |
| event_place | character | Side of the team the event belongs to: home or away. |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| player_pno | integer | Genius shirt-table number of the player. |
| player_team_number | integer | Team number in the game (1 home, 2 away). |
| player_first_name | character | Given (first) name(s) of the player. |
| player_family_name | character | Family name (this route says familyName; the others lastName). |
| coordinates_x | double | Shot or event x coordinate in Genius court units (Float64); origin and scale unverified. |
| coordinates_y | double | Shot or event y coordinate in Genius court units (Float64); origin and orientation unverified. |
| period_time | integer | Marker lines only: 0 (an integer), the start of the period. |

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
  try(sportality_pbp(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Play-by-Play from basketligaen.dk ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:33:27 UTC
#> # A tibble: 804 × 49
#>    game_source_id game_id event_id type     event_uuid  period period_type time 
#>             <int>   <int>    <int> <chr>    <chr>        <int> <chr>       <chr>
#>  1        2868126 2868126      800 game     75a1c424-6…      4 REGULAR     00:0…
#>  2        2868126 2868126      799 period   c7995db4-5…      4 REGULAR     00:0…
#>  3        2868126 2868126      798 clock    e67997fb-e…      4 REGULAR     00:0…
#>  4        2868126 2868126      797 clock    0de6a3c7-0…      4 REGULAR     00:0…
#>  5        2868126 2868126      796 2pt      cc616d49-8…      4 REGULAR     00:0…
#>  6        2868126 2868126      795 clock    84f92014-b…      4 REGULAR     00:0…
#>  7        2868126 2868126      794 clock    cf232264-d…      4 REGULAR     00:0…
#>  8        2868126 2868126      793 clock    1b5da16a-4…      4 REGULAR     00:1…
#>  9        2868126 2868126      792 turnover 504e3200-3…      4 REGULAR     00:1…
#> 10        2868126 2868126      791 clock    8a7eacf6-f…      4 REGULAR     00:1…
#> # ℹ 794 more rows
#> # ℹ 41 more variables: real_world_time <chr>, updated_time <chr>,
#> #   home_team_id <int>, home_team_code <chr>, home_team_name <chr>,
#> #   home_abbreviation <chr>, home_team_number <int>, home_place <chr>,
#> #   home_score <int>, away_team_id <int>, away_team_code <chr>,
#> #   away_team_name <chr>, away_abbreviation <chr>, away_team_number <int>,
#> #   away_place <chr>, away_score <int>, revision <int>, game_state <chr>, …
# }
```
