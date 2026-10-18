# **B.LEAGUE Team Summary**

**Team summary of one B.LEAGUE game per period category, in long form
(one row per team side).**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

The feed's `Summaries` rows hold both teams side by side; they are split
into two rows (`team_side` home / away). `period_category` is 1-4
(quarters), 15 / 16 (halves) or 18 (the whole game). `paint_points`,
`points_off_turnover`, `second_chance_points` and `fast_break_points`
are POINTS here (unlike the box score's counts of the same wire names).
`lead_changes` and `ties` belong to the whole row and repeat on both
sides.

## Usage

``` r
bleague_team_summary(schedule_key, season = NULL)
```

## Arguments

- schedule_key:

  (*integer* required): B.LEAGUE ScheduleKey, one global sequence across
  B1, B2, B3 and every season, e.g. `504734` (B1 2025-26 sec 1, Alvark
  Tokyo v Utsunomiya Brex); the `schedule_key` column of
  [`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md).

- season:

  (*integer* optional): a guard, the season END year the game must
  belong to; a context whose `Year` differs raises `hoopR_asset_fetch`.
  `NULL` (default) = no check (the key alone selects the game).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The {schedule_key} every game wrapper takes and the schedule page's list-item id. |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
| period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
| team_side | character | Side of the game the row belongs to: home or away. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| team_name_j | character | Team name in Japanese. |
| team_name_e | character | Team name in English, uppercase. |
| fg_made | integer | Field goals made (PTM). |
| fg_attempted | integer | Field goals attempted (PTA). |
| fg_pct | numeric | Field-goal percentage 0-100, one decimal. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | numeric | Two-point percentage 0-100. |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | numeric | Three-point percentage 0-100. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | numeric | Free-throw percentage 0-100. |
| reb_off | integer | Offensive rebounds. |
| reb_def | integer | Defensive rebounds. |
| reb | integer | Total rebounds. |
| assists | integer | Assists credited to the team in the period category. |
| turnovers | integer | Turnovers committed by the team in the period category. |
| steals | integer | Steals made by the team in the period category. |
| blocks | integer | Blocks made by the team in the period category. |
| blocks_received | integer | Shots blocked by the opponent. |
| fouls | integer | Fouls committed. |
| fouls_drawn | integer | Fouls drawn. |
| paint_points | integer | Points in the paint (inside-the-paint 2PT points; 2x the players' PT2IN count on v2). |
| points_off_turnover | integer | Points off turnovers. |
| second_chance_points | integer | Second-chance points. |
| fast_break_points | integer | Fast-break points. |
| max_lead | integer | Largest lead of the team in the period category (0 if it never led). |
| lead_last | integer | Lead statistic (LeadLast), integer; meaning unverified (7 for the home side on all checked games). |
| lead_last_home | integer | Home score-like value tied to lead_last; meaning unverified. A string on v2 quarter / game rows. |
| lead_last_away | integer | Away score-like value tied to lead_last; meaning unverified. |
| lead_changes | integer | Lead changes in the period category (LeadCount); the same on both side rows. |
| ties | integer | Times the score was tied in the period category (TieCount); the same on both side rows. |

## Details

The B.LEAGUE (Japan Professional Basketball League: B1, B2, B3) wrappers
mirror sdv-py's `sportsdataverse.basketball.bleague` wrappers of the
same names: same arguments, the same snake_case columns and types, one
row per sdv-py row.

**Unofficial and unsupported.** The game contexts are JSON objects in
B.LEAGUE's own public S3 bucket (`b-league.s3.amazonaws.com`, the store
its game pages read), and the schedule, standings and game_detail pages
of `www.bleague.jp` are parsed here. Neither host publishes terms for
this use (the site's /terms/ answers 404; robots.txt sets a Crawl-delay
only for msnbot and bingbot). Requests are spaced at least one second
apart per host; 429 and 5xx answers are retried (three attempts).
SportsDataverse has not ruled on the site's terms, so the data is not
redistributed as release assets.

**Seasons** are END years (`season = 2026` is 2025-26); the site's own
`Year` / `year=` is the START year, so the request sends
`year = season - 1`. Game wrappers take the global `schedule_key` (one
integer sequence across B1, B2, B3 and every season: 1 = the 2016-17
opener, 5856 in 2020-21, 500017 in 2022-23, 504734 / 505508 B1 / B2 and
10693 B3 in 2025-26); list a day's keys with
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md).

**Feeds.** A game is read from the v2 feed (B1/B2 from 2020-21), else
the v1 feed (B3 and B1/B2 2018-2020), else the game page's embedded copy
(the only source of 2016-17 and 2017-18), decided at run time. v2 ids
are strings, v1 ids integers: both become text here. v1 adds leaders and
the score track; the team-rebound codes 18 / 19 are swapped between the
feeds and a v1 substitution is one row where v2 has two. Player and team
names are Japanese (English names only on the box score and header).
Game wrappers serve FINISHED games only. Each game wrapper fetches the
context itself (two requests): fetch once per game per wrapper you need.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (no source holds the game, a schedule day without games,
HTTP 404), `hoopR_bad_request` (a non-integer or out-of-range argument,
HTTP 400 / 422) and `hoopR_asset_fetch` (any other failure: another
status, a transport error, a non-JSON or non-HTML body, an error or
changed body, an unfinished game, a context or page for another game,
season, tab or day, a truncated schedule list, or layout drift). All
inherit `hoopR_error`.

## See also

Other B.LEAGUE:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
[`bleague_leaders()`](https://hoopR.sportsdataverse.org/reference/bleague_leaders.md),
[`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md),
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_clubs()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_clubs.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_schedule_events()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_events.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md)

## Examples

``` r
# \donttest{
  try(bleague_team_summary(schedule_key = 504734))
#> ── B.LEAGUE team summary from b-league.s3.amazonaws.com ──── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:34:49 UTC
#> # A tibble: 14 × 40
#>    schedule_key season feed  period_category team_side team_id team_name_j     
#>           <int>  <int> <chr>           <int> <chr>     <chr>   <chr>           
#>  1       504734   2026 v2                  1 home      706     アルバルク東京  
#>  2       504734   2026 v2                  1 away      703     宇都宮ブレックス
#>  3       504734   2026 v2                  2 home      706     アルバルク東京  
#>  4       504734   2026 v2                  2 away      703     宇都宮ブレックス
#>  5       504734   2026 v2                  3 home      706     アルバルク東京  
#>  6       504734   2026 v2                  3 away      703     宇都宮ブレックス
#>  7       504734   2026 v2                  4 home      706     アルバルク東京  
#>  8       504734   2026 v2                  4 away      703     宇都宮ブレックス
#>  9       504734   2026 v2                 15 home      706     アルバルク東京  
#> 10       504734   2026 v2                 15 away      703     宇都宮ブレックス
#> 11       504734   2026 v2                 16 home      706     アルバルク東京  
#> 12       504734   2026 v2                 16 away      703     宇都宮ブレックス
#> 13       504734   2026 v2                 18 home      706     アルバルク東京  
#> 14       504734   2026 v2                 18 away      703     宇都宮ブレックス
#> # ℹ 33 more variables: team_name_e <chr>, fg_made <int>, fg_attempted <int>,
#> #   fg_pct <dbl>, fg2_made <int>, fg2_attempted <int>, fg2_pct <dbl>,
#> #   fg3_made <int>, fg3_attempted <int>, fg3_pct <dbl>, ft_made <int>,
#> #   ft_attempted <int>, ft_pct <dbl>, reb_off <int>, reb_def <int>, reb <int>,
#> #   assists <int>, turnovers <int>, steals <int>, blocks <int>,
#> #   blocks_received <int>, fouls <int>, fouls_drawn <int>, paint_points <int>,
#> #   points_off_turnover <int>, second_chance_points <int>, …
# }
```
