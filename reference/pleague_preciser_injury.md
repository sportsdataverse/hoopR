# **Get P. LEAGUE+ Preciser Injury Report**

Injury report of one finished game: one row per team.

Endpoint:
`GET https://api.preciser.io/game/injury/list/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_injury(uuid, gid = NULL)
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

A `hoopR_data` tibble: Injury report of one finished game: one row per
team. An empty valid answer is a zero-row tibble with these columns, in
this order (sdv-py `pleague_preciser_injury`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| side | character | Which team the row belongs to: home or away. |
| team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
| team_name_zh | character | Team short name in Traditional Chinese ('(Chinese text)' = Lioneers). |
| team_name_en | character | Team short English name ('Lioneers'). |
| color | character | Team colour as a CSS hex string. |
| logo_url | character | Team logo url (photonew.preciser.io/plg/teams/{team uuid}.png). |
| injury_report | character | The team's injury report as a JSON string; null when the vendor sent null. It was null on all 16 sampled games, so its shape is unverified. |

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
  try(pleague_preciser_injury(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#> ── P. LEAGUE+ Injury Report from api.preciser.io ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:01:19 UTC
#> # A tibble: 2 × 8
#>   game_uuid             side  team_uuid team_name_zh team_name_en color logo_url
#>   <chr>                 <chr> <chr>     <chr>        <chr>        <chr> <chr>   
#> 1 e6f98675-3e5b-11ed-9… home  e86394aa… 勇士         Braves       #3C8… https:/…
#> 2 e6f98675-3e5b-11ed-9… away  e8674343… 攻城獅       Lioneers     #4f1… https:/…
#> # ℹ 1 more variable: injury_report <chr>
# }
```
