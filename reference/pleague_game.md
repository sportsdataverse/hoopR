# **Get P. LEAGUE+ Game**

Header of one finished game: date, venue, both clubs with their score
and the Preciser game uuid.

Endpoint: `GET https://pleagueofficial.com/game/{gid}`

## Usage

``` r
pleague_game(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble: Header of one finished game: date, venue, both
clubs with their score and the Preciser game uuid. An empty valid answer
is a zero-row tibble with these columns, in this order
(sportsdataverse-py `pleague_game`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The {gid} of /game/{gid}. |
| uuid | character | Preciser game uuid (key space: the analytics vendor's games, a version-1 uuid), embedded in the game page as getPlayByPlay('uuid'); keys the play-by-play and every pleague_preciser wrapper. Null before 2022-23 (the page embeds an empty string: no play-by-play or vendor data). |
| status_zh | character | Status badge: (Chinese text) = finished. The only value the wrappers serve (anything else raises hoopR_asset_fetch). |
| finished | logical | True when the status badge is (Chinese text) (finished); always true for a served game. |
| date | Date | Game date from the header, Asia/Taipei (UTC+8) local time. |
| time | character | Tip-off 'HH:MM' from the header, Asia/Taipei (UTC+8) local time. |
| venue_zh | character | Venue (arena) name in Traditional Chinese. |
| game_label_zh | character | Stage and game number as printed in the header: '(Chinese text)G1' = regular season game 1 ('(Chinese text)G01' on 2020-21 pages); (Chinese text) = playoffs, (Chinese text) = finals. |
| away_name_zh | character | Away team's name on that date in Traditional Chinese (short or long form; (Chinese text) = Braves, (Chinese text) = Pilots, (Chinese text) = Lioneers, (Chinese text) = Dreamers, (Chinese text) = Steelers, (Chinese text) = Kings, (Chinese text) = Ghosthawks, (Chinese text) = Yankey Ark). Printed names change by season (short and long forms, renames): key on the id, not the name. |
| away_name_en | character | Away team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
| away_logo | character | Away team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo\_{team}\_{epoch}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
| away_score | integer | Away team's final points (0 on a future game). |
| home_name_zh | character | Home team's name on that date in Traditional Chinese (short or long form). Printed names change by season (short and long forms, renames): key on the id, not the name. |
| home_name_en | character | Home team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
| home_logo | character | Home team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo\_{team}\_{epoch}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
| home_score | integer | Home team's final points (0 on a future game). |
| overtimes | integer | Number of overtime periods played (overtime cells with points on the page). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
[`pleague_player()`](https://hoopR.sportsdataverse.org/reference/pleague_player.md),
[`pleague_player_seasons()`](https://hoopR.sportsdataverse.org/reference/pleague_player_seasons.md),
[`pleague_preciser_injury()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_injury.md),
[`pleague_preciser_lead_flow()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_lead_flow.md),
[`pleague_preciser_rotation()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_rotation.md),
[`pleague_preciser_score_log()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_score_log.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_game(gid = 197))
#> ── P. LEAGUE+ Game from pleagueofficial.com ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:55:59 UTC
#> # A tibble: 1 × 17
#>     gid uuid          status_zh finished date       time  venue_zh game_label_zh
#>   <int> <chr>         <chr>     <lgl>    <date>     <chr> <chr>    <chr>        
#> 1   197 e6f98675-3e5… 已完賽    TRUE     2022-11-05 17:00 臺北和平籃球館… 例行賽G1     
#> # ℹ 9 more variables: away_name_zh <chr>, away_name_en <chr>, away_logo <chr>,
#> #   away_score <int>, home_name_zh <chr>, home_name_en <chr>, home_logo <chr>,
#> #   home_score <int>, overtimes <int>
# }
```
