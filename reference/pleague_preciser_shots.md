# **Get P. LEAGUE+ Preciser Shots**

Every field-goal attempt of one finished game with court x / y (vendor
frame), zone, style and result.

Endpoint: `GET https://api.preciser.io/v1/chart-data/id/{uuid}`

## Usage

``` r
pleague_preciser_shots(uuid, gid = NULL)
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

A `hoopR_data` tibble: Every field-goal attempt of one finished game
with court x / y (vendor frame), zone, style and result. An empty valid
answer is a zero-row tibble with these columns, in this order (sdv-py
`pleague_preciser_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| shot_no | integer | 1-based position in the order the vendor sent the shots, which is NOT guaranteed game order: sort on period and seconds_left. |
| period | integer | Period number: 1-4, 5 and up for overtime (OT1 = 5). |
| period_label | character | Period label: Q1-Q4, then OT1, OT2. |
| clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
| seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
| side | character | Which team took the shot: home or away, from the shooter's team uuid against home_id / away_id. |
| team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
| person_id | character | Preciser person uuid (key space: the vendor's persons): equal to the site box person_id of the same player, the join between this row and pleague_box_players (2022-23 on). |
| player_name | character | Shooter's name as printed (Traditional Chinese or a transliteration); equals the box name_zh. |
| type | character | Shot value: 2pt or 3pt. |
| subtype | character | Shot style: jumpShot, layup, drivingLayup, floatingJumpShot (floater), tipIn (putback), pullUpJumpShot, fadeAway, dunk, turnAroundJumpShot, hookShot, stepBackJumpShot, alleyOop; null on a few shots (7 of 2,566). |
| area | character | Shot zone, English label '{side} {distance band}': 'Center 8ft' (restricted-area band, within 8 ft), 'Center 8-16ft', 'Left 8-16ft', 'Right 8-16ft', 'Left 16-23ft', 'Center 16-23ft', 'Right 16-23ft', 'Left Center 16-23ft', ... and the three-point zones; null on some shots. |
| success | logical | True when the shot was made, false when missed. |
| x | double | Shot x: PERCENT (0-100) of the court LENGTH in the VENDOR frame, in which the HOME team always attacks the basket at x = 95 and the away team the basket at x = 5 (the frame does not flip at half-time). x_vendor = 100 - x_pbp in the halves where the home team attacks x \< 50 (pleague_pbp.x is the physical frame). Court 28.75 m long: distance = hypot((x - 5) x 0.2875, (y - 50) x 0.1525) m (mean error 0.010 m on 1,893 shots). |
| y | double | Shot y: PERCENT (0-100) of the court WIDTH in the vendor frame (baskets at y = 50); y_vendor = 100 - y_pbp in the halves where the home team attacks x \< 50 (held for 166 of the 168 shots of gid 197 matched to the play-by-play; one shot differs in y only). Which sideline is y = 0 is unverified. Court 15.25 m wide. |
| message_zh | character | Play text in Traditional Chinese, '{player}((Chinese text))(Chinese text)((Chinese text)){distance}(Chinese text){shot}' = '{player} made / missed a {distance} m {shot}'; the distance is in metres and matches x / y. |
| has_video | logical | True when the shot has a clip. The clip url is never kept: it carries a vendor access key. |
| home_team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
| away_team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |

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
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_preciser_shots(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#> ── P. LEAGUE+ Shots from api.preciser.io ─────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:42:34 UTC
#> # A tibble: 168 × 20
#>    game_uuid      shot_no period period_label clock seconds_left side  team_uuid
#>    <chr>            <int>  <int> <chr>        <chr>        <int> <chr> <chr>    
#>  1 e6f98675-3e5b…       1      4 Q4           02:37          157 home  e86394aa…
#>  2 e6f98675-3e5b…       2      1 Q1           02:28          148 away  e8674343…
#>  3 e6f98675-3e5b…       3      1 Q1           09:24          564 away  e8674343…
#>  4 e6f98675-3e5b…       4      4 Q4           02:19          139 away  e8674343…
#>  5 e6f98675-3e5b…       5      4 Q4           05:51          351 away  e8674343…
#>  6 e6f98675-3e5b…       6      3 Q3           00:23           23 away  e8674343…
#>  7 e6f98675-3e5b…       7      3 Q3           08:54          534 home  e86394aa…
#>  8 e6f98675-3e5b…       8      2 Q2           05:37          337 home  e86394aa…
#>  9 e6f98675-3e5b…       9      1 Q1           05:18          318 away  e8674343…
#> 10 e6f98675-3e5b…      10      2 Q2           02:42          162 home  e86394aa…
#> # ℹ 158 more rows
#> # ℹ 12 more variables: person_id <chr>, player_name <chr>, type <chr>,
#> #   subtype <chr>, area <chr>, success <lgl>, x <dbl>, y <dbl>,
#> #   message_zh <chr>, has_video <lgl>, home_team_uuid <chr>,
#> #   away_team_uuid <chr>
# }
```
