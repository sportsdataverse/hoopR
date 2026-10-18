# **Get P. LEAGUE+ Player Season Stats**

Player season averages and totals of one season and stage: shooting,
rebounds, assists and fouls.

Endpoint:
`GET https://pleagueofficial.com/stat-player/{season slug}/{stage_sn}`

## Usage

``` r
pleague_stat_player(season, stage_sn)
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

- stage_sn:

  Required. Stage select value of the player table: 2 = regular season,
  3 = playoffs, 4 = finals.

## Value

A `hoopR_data` tibble: Player season averages and totals of one season
and stage: shooting, rebounds, assists and fouls. An empty valid answer
is a zero-row tibble with these columns, in this order (sdv-py
`pleague_stat_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
| season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
| stage_sn | integer | Stage select value: 2 = regular season, 3 = playoffs, 4 = finals (echo of the request, checked against the page's selected option). |
| stage | character | Stage slug: pre-season ((Chinese text), exhibition games before the season), regular-season ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese text), the championship series). |
| player_page_id | character | The 8-character page id of /player/{id} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
| name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
| jersey | character | Shirt number as a string (the player's number in the latest game). |
| team_zh | character | Team name in Traditional Chinese as the page prints it (a traded player shows the current team). |
| games | integer | Games played ((Chinese text)). |
| minutes_avg | character | Minutes per game 'mm:ss' ((Chinese text)). |
| minutes_total | character | Total minutes 'mmm:ss' ((Chinese text)). |
| fg2_made_avg | double | Per-game average of 2-point makes ((Chinese text)). |
| fg2_made_total | integer | Season total of 2-point makes ((Chinese text)). |
| fg2_att_avg | double | Per-game average of 2-point attempts ((Chinese text)). |
| fg2_att_total | integer | Season total of 2-point attempts ((Chinese text)). |
| fg3_made_avg | double | Per-game average of 3-point makes ((Chinese text)). |
| fg3_made_total | integer | Season total of 3-point makes ((Chinese text)). |
| fg3_att_avg | double | Per-game average of 3-point attempts ((Chinese text)). |
| fg3_att_total | integer | Season total of 3-point attempts ((Chinese text)). |
| ft_made_avg | double | Per-game average of free-throw makes ((Chinese text)). |
| ft_made_total | integer | Season total of free-throw makes ((Chinese text)). |
| ft_att_avg | double | Per-game average of free-throw attempts ((Chinese text)). |
| ft_att_total | integer | Season total of free-throw attempts ((Chinese text)). |
| points_avg | double | Per-game average of points ((Chinese text)). |
| points_total | integer | Season total of points ((Chinese text)). |
| reb_off_avg | double | Per-game average of offensive rebounds ((Chinese text)). |
| reb_off_total | integer | Season total of offensive rebounds ((Chinese text)). |
| reb_def_avg | double | Per-game average of defensive rebounds ((Chinese text)). |
| reb_def_total | integer | Season total of defensive rebounds ((Chinese text)). |
| reb_avg | double | Per-game average of total rebounds ((Chinese text)). |
| reb_total | integer | Season total of total rebounds ((Chinese text)). |
| ast_avg | double | Per-game average of assists ((Chinese text)). |
| ast_total | integer | Season total of assists ((Chinese text)). |
| stl_avg | double | Per-game average of steals ((Chinese text)). |
| stl_total | integer | Season total of steals ((Chinese text)). |
| blk_avg | double | Per-game average of blocks ((Chinese text)). |
| blk_total | integer | Season total of blocks ((Chinese text)). |
| tov_avg | double | Per-game average of turnovers ((Chinese text)). |
| tov_total | integer | Season total of turnovers ((Chinese text)). |
| pf_avg | double | Per-game average of personal fouls ((Chinese text)). |
| pf_total | integer | Season total of personal fouls ((Chinese text)). |
| fg2_pct | double | 2-point percentage 0-100 ((Chinese text); the cell holds the same value as average and total). |
| fg3_pct | double | 3-point percentage 0-100 ((Chinese text); same value as average and total). |
| ft_pct | double | Free-throw percentage 0-100 ((Chinese text); same value as average and total). |

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
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_stat_player(season = 2025, stage_sn = 2))
#> Error in pleague_stat_player(season = 2025, stage_sn = 2) : 
#>   pleagueofficial.com/stat-player/2024-25/2 answered HTTP 403, not 200
# }
```
