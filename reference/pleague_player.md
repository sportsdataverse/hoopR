# **Get P. LEAGUE+ Player**

One player's profile: names, club, jersey, position, height, weight and
birthplace.

Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`

## Usage

``` r
pleague_player(player_page_id)
```

## Arguments

- player_page_id:

  Required. The 8-character page id of /player/{id} (e.g. '1JbPozLB' =
  Lai Ting-En); `player_page_id` in pleague_stat_player, `random_id` in
  pleague_box_players from 2022-23 (unreliable before).

## Value

A `hoopR_data` tibble: One player's profile: names, club, jersey,
position, height, weight and birthplace. An empty valid answer is a
zero-row tibble with these columns, in this order (sdv-py
`pleague_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_page_id | character | The 8-character page id of /player/{id} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
| player_id | integer | P. LEAGUE+ player-team membership id (the box player_id), read from the page's trackPlayer() call, e.g. 40 = Lai Ting-En. NOT the 8-character page id. |
| name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
| name_en | character | Player name in Latin letters. |
| team_zh | character | Current team's short name in Traditional Chinese. |
| team_en | character | Current team's English name. |
| jersey | character | Shirt number as printed, a string ('0', '00' and '10' differ). |
| position | character | Position letter: G guard, F forward, C centre. |
| nickname | character | Nickname ((Chinese text)); null when blank. |
| tenure | character | Years of service ((Chinese text)) as the page prints it, with a prime character ('0”). |
| height_cm | double | Height in centimetres ((Chinese text)). |
| weight_kg | double | Weight in kilograms ((Chinese text)). |
| birthplace_zh | character | Birthplace in Traditional Chinese ((Chinese text); a country for foreign players). The date of birth is dropped on purpose. |
| status_zh | character | Player status ((Chinese text)): (Chinese text) = import (foreign player), (Chinese text) = local (Taiwanese) player. |
| education | character | Education lines ((Chinese text)) as printed, joined with '; '. |

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

     pleague_player(player_page_id = "1JbPozLB")

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
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
