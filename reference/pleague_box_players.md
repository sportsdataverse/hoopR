# **Get P. LEAGUE+ Player Box Score**

Player box score of one finished game: minutes, points, shooting splits,
rebounds, assists, plus/minus, and the ratings from 2022-23;
did-not-play rows included.

Endpoint:
`GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`

## Usage

``` r
pleague_box_players(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble: Player box score of one finished game: minutes,
points, shooting splits, rebounds, assists, plus/minus, and the ratings
from 2022-23; did-not-play rows included. An empty valid answer is a
zero-row tibble with these columns, in this order (sdv-py
`pleague_box_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The {gid} of /game/{gid}. |
| side | character | Which team the row belongs to: home or away. The box lists home first, the play-by-play and the schedule list away first. |
| player_id | integer | P. LEAGUE+ player-team membership id on the site (key space: the member id the player page passes to trackPlayer(), e.g. 40 = Lai Ting-En), cast to an integer. NOT the 8-character page id. Join box rows on it, never on the printed name. |
| person_id | character | Preciser person uuid (key space: the analytics vendor's persons): the join between a box row and a pleague_preciser_shots row. Present on played rows from 2022-23; null on 2020-21 and 2021-22 rows and did-not-play rows (the refs notes report some 2025-26 finals boxes without it; gid 716 has it). |
| random_id | character | The 8-character page id of /player/{id} (same space as player_page_id). Reliable from 2022-23 only: on 2020-21 and 2021-22 rows it is wrong for most players (gid 13 gives Lai Ting-En the page of Kao Kuo-Hao), so never join across eras on it. |
| name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
| jersey | character | Shirt number as printed, a string ('0', '00' and '10' differ). |
| starter | logical | True for a starter (the site's '(Chinese text)' marker). Null on did-not-play rows. |
| played | logical | True when the player has court time; false on a 'DNP' (did not play) row, whose statistics are null. |
| minutes | character | Minutes played 'mm:ss'. Null on did-not-play rows. |
| seconds | integer | Playing time in whole seconds: the site's seconds column in 2020-21 and 2021-22, derived from minutes from 2022-23. Null on did-not-play rows. |
| points | integer | Points scored. Null on did-not-play rows. |
| reb_off | integer | Offensive rebounds. Null on did-not-play rows. |
| reb_def | integer | Defensive rebounds. Null on did-not-play rows. |
| reb | integer | Total rebounds (offensive plus defensive). Null on did-not-play rows. |
| ast | integer | Assists. Null on did-not-play rows. |
| stl | integer | Steals. Null on did-not-play rows. |
| blk | integer | Blocks made. Null on did-not-play rows. |
| tov | integer | Turnovers committed. Null on did-not-play rows. |
| pf | integer | Personal fouls committed. Null on did-not-play rows. |
| plus_minus | integer | Plus/minus: the team's points minus the opponent's while the player was on court (signed). Null on did-not-play rows. |
| eff | integer | Efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on every 2020-21 and 2021-22 row). Null on did-not-play rows. |
| fg2_made | integer | 2-point field goals made, from the site's 'made-attempted' string. Null on did-not-play rows. |
| fg2_att | integer | 2-point field goals attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
| fg2_pct | double | 2-point field-goal percentage, 0-100 (the site sends a number or a string). Null on did-not-play rows. |
| fg3_made | integer | 3-point field goals made, from the site's 'made-attempted' string. Null on did-not-play rows. |
| fg3_att | integer | 3-point field goals attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
| fg3_pct | double | 3-point field-goal percentage, 0-100. Null on did-not-play rows. |
| ft_made | integer | Free throws made, from the site's 'made-attempted' string. Null on did-not-play rows. |
| ft_att | integer | Free throws attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
| ft_pct | double | Free-throw percentage, 0-100. Null on did-not-play rows. |
| efg_pct | double | Effective field-goal percentage 0-100, (FGM + 0.5 x 3PM) / FGA x 100 (verified). 2020-21 and 2021-22 rows only; null from 2022-23. |
| ts_pct | double | True-shooting percentage 0-100, PTS / (2 x (FGA + 0.44 x FTA)) x 100 (verified). 2020-21 and 2021-22 rows only; null from 2022-23. |
| usage_pct | double | Usage percentage as the site prints it, 0-100; the standard usage formula reproduces it on only 685 of 3,932 rows, so the formula is unverified. 2020-21 and 2021-22 rows only. |
| position | character | Position code on some 2020-21 and 2021-22 rows ('G' guard, 'F' forward, 'C' centre); null on the rest and from 2022-23. |
| ortg | double | Offensive rating: the team's points scored per 100 offensive possessions while the player was on court (2022-23 on; null before). Null on did-not-play rows. |
| drtg | double | Defensive rating: the opponent's points per 100 of its possessions while the player was on court, lower is better (2022-23 on). Null on did-not-play rows. |
| netrtg | double | Net rating, ortg minus drtg (exact on every checked row; 2022-23 on). Null on did-not-play rows. |
| pace | double | Pace: 48 x the team's offensive possessions / minutes on court, the team's possessions per 48 minutes with this player on court (verified on 1,124 of 1,149 rows; 2022-23 on). Null on did-not-play rows. |
| ast_ratio | double | Assist ratio 0-100: assists per 100 of the player's own plays. The common formula AST / (FGA + 0.5 x FTA + AST + TOV) reproduces it on 919 of 1,174 rows, so the exact formula is unverified (2022-23 on). |
| to_ratio | double | Turnover ratio 0-100: turnovers per 100 of the player's own plays; same unverified formula family as ast_ratio (917 of 1,174 rows; 2022-23 on). |
| off_possessions | integer | The team's offensive possessions while the player was on court (the base of ortg; 2022-23 on). Null on did-not-play rows. |
| opp_off_possessions | integer | The opponent's offensive possessions while the player was on court (the base of drtg; 2022-23 on). Null on did-not-play rows. |
| opp_pts_second_chance | integer | Opponent second-chance points while the player was on court (2022-23 on). Null on did-not-play rows. |
| opp_pts_fast_break | integer | Opponent fast-break points while the player was on court (2022-23 on). Null on did-not-play rows. |
| opp_pts_off_turnover | integer | Opponent points off turnovers while the player was on court (2022-23 on). Null on did-not-play rows. |
| opp_pts_paint | integer | Opponent points in the paint while the player was on court (2022-23 on). Null on did-not-play rows. |

## Details

- Unofficial use of a public source: these wrappers read
  pleagueofficial.com (P. LEAGUE+, Taiwan's men's league), keyless. The
  site's /user-policy (members' terms, section 11) reserves all content
  on the site to the service and its rights holders and forbids use,
  copying, adaptation or distribution without authorisation (it says
  nothing about automated access); robots.txt holds only Cloudflare
  content-signal comment lines with no Allow, Disallow or Crawl-delay
  rule. Use for reference only; payloads are not redistributed as
  release assets, and a data release needs owner sign-off. Requests are
  spaced at least 1 s apart per host, retries included.

- Access: the site sits behind Cloudflare. sdv-py fetches it with
  curl_cffi (Chrome TLS); this R port sends a browser User-Agent through
  libcurl, which was served on a live check (2026-10-18); Cloudflare may
  still answer a request with an HTTP 403 challenge page
  (`hoopR_asset_fetch`). Redirects are not followed: the site answers an
  unknown `gid` or a season before 2020-21 with a 302 to the home page
  (`hoopR_no_data`).

- Coverage: schedules, standings and player tables from 2020-21
  (`season = 2021`); box scores for every finished game from 2020-21;
  play-by-play (with shot x / y) from 2022-23 (gid 191 on). 2020-21 and
  2021-22 pages embed an empty game uuid, so they have no play-by-play
  and no Preciser data (`hoopR_no_data`). A game is keyed by `gid`: ONE
  global integer sequence over every stage and season. Only finished
  games are served: an unplayed game, or a box or play-by-play that does
  not match its game page (the routes echo no id, so the game page is
  fetched first, cached for the session, and the body's scores, quarters
  and points are checked against it), raises `hoopR_asset_fetch`.

- Seasons are END years (2025 = the site's slug '2024-25'). Text is
  Traditional Chinese as printed (names, venues, play-by-play phrases);
  the column descriptions gloss it in English. Ids: `team_id` (1-8) is
  stable across renames; the box `player_id` is the player-team
  membership. The box `random_id` is UNRELIABLE before 2022-23 (gid 13
  gives one player another player's page id): join box rows on
  `player_id`, and box rows to Preciser shots on `person_id`, never on
  `random_id`. The date of birth is dropped from the player frame;
  officials appear by name only.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a redirect, a stage the season does not
  have, a game with no play-by-play, a season before 2020-21),
  `hoopR_bad_request` (an invalid argument, HTTP 400 / 422) and
  `hoopR_asset_fetch` (any other non-200, a dead connection, an empty or
  unreadable body, a page for another game, season, stage or player, an
  unfinished game, layout drift, a play-by-play phrase outside the
  observed vocabulary). HTTP 429 / 502 / 503 / 504 are retried, up to
  three attempts; HTTP 500 is NOT retried (the site answers 500 for an
  unknown id). Wrappers raise; they never warn and return empty.

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
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
  try(pleague_box_players(gid = 197))
#> ── P. LEAGUE+ Player Box from pleagueofficial.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:35:39 UTC
#> # A tibble: 26 × 47
#>      gid side  player_id person_id       random_id name_zh jersey starter played
#>    <int> <chr>     <int> <chr>           <chr>     <chr>   <chr>  <lgl>   <lgl> 
#>  1   197 home         40 26633c72-3d8d-… 1JbPozLB  賴廷恩  0      TRUE    TRUE  
#>  2   197 home         46 266973f4-3d8d-… 1imawJqL  周桂羽  8      FALSE   TRUE  
#>  3   197 home         49 266c1c4e-3d8d-… 1iclgBLT  林孟學  13     FALSE   TRUE  
#>  4   197 home         52 266e806e-3d8d-… 1hVSapP7  曾祥鈞  88     TRUE    TRUE  
#>  5   197 home         48 267bd121-3d8d-… 1iG5OYyZ  林志傑  12     FALSE   TRUE  
#>  6   197 home         50 267e9e03-3d8d-… 1I3hiwZr  蔡文誠  14     FALSE   TRUE  
#>  7   197 home         53 2681570d-3d8d-… 1HPVfP2B  石博恩  23     FALSE   TRUE  
#>  8   197 home        261 28be45ae-3d8d-… 0t1JFW9h  瓊斯    11     TRUE    TRUE  
#>  9   197 home        269 7ff29ae5-4554-… 0sjcEvTQ  強森    5      TRUE    TRUE  
#> 10   197 home        274 7ffade61-4554-… 0s67qUMZ  謝宗融  19     FALSE   TRUE  
#> # ℹ 16 more rows
#> # ℹ 38 more variables: minutes <chr>, seconds <int>, points <int>,
#> #   reb_off <int>, reb_def <int>, reb <int>, ast <int>, stl <int>, blk <int>,
#> #   tov <int>, pf <int>, plus_minus <int>, eff <int>, fg2_made <int>,
#> #   fg2_att <int>, fg2_pct <dbl>, fg3_made <int>, fg3_att <int>, fg3_pct <dbl>,
#> #   ft_made <int>, ft_att <int>, ft_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>,
#> #   usage_pct <dbl>, position <chr>, ortg <dbl>, drtg <dbl>, netrtg <dbl>, …
# }
```
