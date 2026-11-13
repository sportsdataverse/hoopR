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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Unofficial use of a public source: these wrappers read
  pleagueofficial.com (P. LEAGUE+, Taiwan's men's league), keyless. The
  site's /user-policy (members' terms, section 11) reserves all content
  on the site to the service and its rights holders and forbids use,
  copying, adaptation or distribution without authorisation (it says
  nothing about automated access); robots.txt holds only Cloudflare
  content-signal comment lines with no Allow, Disallow or Crawl-delay
  rule. Use for reference only, and check the terms before you republish
  the data. Requests are spaced at least 1 s apart per host, retries
  included.

- Access: the site sits behind Cloudflare. sportsdataverse-py fetches it
  with curl_cffi (Chrome TLS); this R port sends a browser User-Agent
  through libcurl, which was served on a live check (2026-10-18);
  Cloudflare may still answer a request with an HTTP 403 challenge page
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

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_schedule(season = 2025))
#> ── P. LEAGUE+ Schedule from pleagueofficial.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:38:53 UTC
#> # A tibble: 48 × 23
#>    season season_slug stage   gid date       weekday_zh time  starred game_label
#>     <int> <chr>       <chr> <int> <date>     <chr>      <chr> <lgl>   <chr>     
#>  1   2025 2024-25     regu…   598 2024-10-26 六         17:00 FALSE   G01       
#>  2   2025 2024-25     regu…   599 2024-10-27 日         17:00 FALSE   G02       
#>  3   2025 2024-25     regu…   600 2024-11-02 六         17:00 FALSE   G03       
#>  4   2025 2024-25     regu…   602 2024-11-09 六         17:00 FALSE   G05       
#>  5   2025 2024-25     regu…   603 2024-11-10 日         17:00 FALSE   G06       
#>  6   2025 2024-25     regu…   604 2024-11-12 二         19:00 FALSE   G07       
#>  7   2025 2024-25     regu…   605 2024-11-30 六         17:00 FALSE   G08       
#>  8   2025 2024-25     regu…   606 2024-12-01 日         17:00 FALSE   G09       
#>  9   2025 2024-25     regu…   607 2024-12-07 六         17:00 FALSE   G10       
#> 10   2025 2024-25     regu…   608 2024-12-08 日         17:00 FALSE   G11       
#> # ℹ 38 more rows
#> # ℹ 14 more variables: venue_zh <chr>, attendance <int>, capacity <int>,
#> #   phase <chr>, away_team_id <int>, away_name_zh <chr>, away_name_en <chr>,
#> #   away_logo <chr>, away_score <int>, home_team_id <int>, home_name_zh <chr>,
#> #   home_name_en <chr>, home_logo <chr>, home_score <int>
# }
```
