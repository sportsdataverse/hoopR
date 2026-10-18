# **Get P. LEAGUE+ Schedule**

Schedule and results of one season and stage (pre-season, regular
season, playoffs or finals): one row per game, away team first.

Endpoint:
`GET https://pleagueofficial.com/schedule-{stage}/{season slug}`

## Usage

``` r
pleague_schedule(season, stage = "regular-season")
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

- stage:

  Stage: pre-season ((Chinese text), exhibition games), regular-season
  ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese
  text)). A stage a season does not have (2025-26 pre-season) answers
  hoopR_no_data.

## Value

A `hoopR_data` tibble: Schedule and results of one season and stage
(pre-season, regular season, playoffs or finals): one row per game, away
team first. An empty valid answer is a zero-row tibble with these
columns, in this order (sdv-py `pleague_schedule`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
| season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
| stage | character | Stage slug: pre-season ((Chinese text), exhibition games before the season), regular-season ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese text), the championship series). |
| gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The {gid} of /game/{gid}. Cross-checked with the page's trackGame() call. |
| date | Date | Game date, Asia/Taipei (UTC+8) local time. |
| weekday_zh | character | Weekday as one Chinese character: (Chinese text) Sun, (Chinese text) Mon, (Chinese text) Tue, (Chinese text) Wed, (Chinese text) Thu, (Chinese text) Fri, (Chinese text) Sat. |
| time | character | Scheduled tip-off 'HH:MM', Asia/Taipei (UTC+8) local time. |
| starred | logical | True when the date cell carries the site's star icon (a highlighted game). |
| game_label | character | Game label as printed: 'G01' = game 1 of the stage, 'PLAYOFFS Game1' / 'PLAYOFFS A G1' = playoff game (series A / B), 'FINALS G1' / 'Final Game1' = finals game, '(Chinese text)G1' = game 1 of the first 'stop' ((Chinese text), a round-robin hub weekend; 2020-21). |
| venue_zh | character | Venue (arena) name in Traditional Chinese. |
| attendance | integer | Spectators: the first number of the page's 'N / M' seat cell; 0 on future games. |
| capacity | integer | Seats: the second number of the 'N / M' seat cell (the venue capacity as the site records it); 0 on future games. |
| phase | character | Row state from the page's CSS class: before_today = the date is past (the score is the result), is_future = not yet played (both scores 0), is_today. A past game printing 0-0 may be a series game that was never played: check the game page's status. |
| away_team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
| away_name_zh | character | Away team's name on that date in Traditional Chinese (short or long form; (Chinese text) = Braves, (Chinese text) = Pilots, (Chinese text) = Lioneers, (Chinese text) = Dreamers, (Chinese text) = Steelers, (Chinese text) = Kings, (Chinese text) = Ghosthawks, (Chinese text) = Yankey Ark). Printed names change by season (short and long forms, renames): key on the id, not the name. |
| away_name_en | character | Away team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
| away_logo | character | Away team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo\_{team}\_{epoch}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
| away_score | integer | Away team's final points (0 on a future game). |
| home_team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
| home_name_zh | character | Home team's name on that date in Traditional Chinese (short or long form). Printed names change by season (short and long forms, renames): key on the id, not the name. |
| home_name_en | character | Home team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
| home_logo | character | Home team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo\_{team}\_{epoch}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
| home_score | integer | Home team's final points (0 on a future game). |

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
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
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
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_schedule(season = 2025))
#> Error in pleague_schedule(season = 2025) : 
#>   pleagueofficial.com/schedule-regular-season/2024-25 answered HTTP 403,
#> not 200
# }
```
