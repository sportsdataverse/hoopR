# **Get P. LEAGUE+ Preciser Rotation**

On-court stints of every player of one finished game (the rotation
chart).

Endpoint:
`GET https://api.preciser.io/game/rotation/chart/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_rotation(uuid, gid = NULL)
```

## Arguments

- uuid:

  Required. The Preciser game uuid the site's game page embeds (`uuid`
  of pleague_game; empty before 2022-23, which have no vendor data),
  e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).

- gid:

  Optional. The site's game id for this uuid. When given the runtime
  also fetches the site's game page and box (cached) and checks the
  vendor body against them (uuid, final score, made shots, roster and
  minutes); the uuid must be the game page's. Without it only the checks
  the body allows by itself run.

## Value

A `hoopR_data` tibble: On-court stints of every player of one finished
game (the rotation chart). An empty valid answer is a zero-row tibble
with these columns, in this order (sdv-py `pleague_preciser_rotation`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| side | character | Which team the row belongs to: home or away. |
| name_zh | character | Player name (Traditional Chinese); equals the site box name_zh, which is how the runtime checks the roster. |
| jersey | integer | Shirt number (an integer here; the box prints it as a string). |
| started | logical | True when the player started the game. |
| stint_no | integer | 1-based position of the stint among the player's stints, in game order. |
| start_period | character | Period in which the stint starts (Q1-Q4, OT1, ...). |
| start_clock | character | Clock REMAINING in start_period when the stint starts, 'm:ss'. |
| start_seconds | integer | Seconds elapsed on the game clock when the stint starts (cumulative across periods). |
| end_period | character | Period in which the stint ends. |
| end_clock | character | Clock REMAINING in end_period when the stint ends, 'm:ss'. |
| end_seconds | integer | Seconds elapsed on the game clock when the stint ends (cumulative across periods). |

## Details

- Unofficial use of a THIRD-PARTY host: api.preciser.io is the analytics
  vendor behind the P. LEAGUE+ game page, not the league's own API. It
  is keyless, CORS-open, has no robots.txt (404) and no terms were
  found; it serves the data the league's own game page displays. The
  league's /user-policy reserves its content, so payloads are not
  redistributed as release assets and a data release needs owner
  sign-off. Requests are spaced at least 1 s apart per host, retries
  included.

- Wrappers take the Preciser game uuid (the `uuid` column of
  [`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md);
  empty before 2022-23, which have no vendor data). Pass the optional
  `gid` to verify the body against the site's game page and box: the
  shot list and the rotation echo nothing about the game, so only then
  are the uuid, the final score, the made-shot counts, the roster and
  the court time (rotation minutes within 30 s of the box) checked. An
  unknown uuid answers 200 `[]` (`hoopR_no_data`) or HTTP 500
  (`hoopR_asset_fetch`, not retried).

- Id key spaces: the vendor names teams by uuid (`team_uuid` /
  `home_team_uuid` / `away_team_uuid`) and persons by `person_id` (the
  same value as the site box row's `person_id`); the site's `team_id`
  (1-8) joins to a team uuid through
  [`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
  (the standings logo file name).

- Shot x / y are in the VENDOR frame (percent of the court, the home
  team always attacks x = 95) while the site's play-by-play x / y are in
  the physical court frame (teams swap ends at half-time): x_vendor =
  100 - x_pbp and y_vendor = 100 - y_pbp in the halves where the home
  team attacks x \< 50. The court is 28.75 x 15.25 m. Clip urls carry a
  vendor access key (?key=): it is scrubbed from every body, a body that
  still holds one is refused, and no frame keeps a url.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a body of `[]`, empty rotation lists),
  `hoopR_bad_request` (a uuid that is not a uuid, a `gid` that is not an
  integer, HTTP 400 / 422) and `hoopR_asset_fetch` (any other failed or
  wrong answer, including a `gid` whose game has another uuid and a
  redirect off the vendor host). HTTP 429 / 502 / 503 / 504 are retried,
  up to three attempts.

     pleague_preciser_rotation(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

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
[`pleague_preciser_score_log()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_score_log.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
