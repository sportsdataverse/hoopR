# **Get P. LEAGUE+ Preciser Summary Teams**

Post-game team comparison of one finished game: totals, situational
points, lead tracker and top performer.

Endpoint:
`GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_summary_teams(uuid, gid = NULL)
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

A `hoopR_data` tibble: Post-game team comparison of one finished game:
totals, situational points, lead tracker and top performer. An empty
valid answer is a zero-row tibble with these columns, in this order
(sdv-py `pleague_preciser_summary_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| side | character | Which team the row belongs to: home or away. |
| team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
| team_name_zh | character | Team full name in Traditional Chinese ((Chinese text) = Taipei Fubon Braves, (Chinese text) = Taoyuan Pauian Pilots, (Chinese text) = Hsinchu Toplus Lioneers, (Chinese text) = Formosa Dreamers, (Chinese text) = Kaohsiung 17LIVE Steelers, (Chinese text) = New Taipei Kings, (Chinese text) = TSG Ghosthawks). |
| color | character | Team colour as a CSS hex string. |
| logo_url | character | Team logo url (photonew.preciser.io/plg/teams/{team uuid}.png). |
| points | integer | Team points (the comparison block). |
| rebounds | integer | Team total rebounds (the comparison block). |
| assists | integer | Team assists (the comparison block). |
| steals | integer | Team steals (the comparison block). |
| blocks | integer | Team blocks made (the comparison block). |
| turnovers | integer | Team turnovers. |
| fg_made | integer | Team field goals MADE: the vendor's key is field_goal_percentage but the value is a count of makes. |
| fg2_pct | double | Team 2-point percentage 0-100. |
| fg3_pct | double | Team 3-point percentage 0-100. |
| ft_pct | double | Team free-throw percentage 0-100. |
| fast_break_points | double | Team fast-break points. |
| paint_points | double | Team points in the paint. |
| second_chance_points | double | Team second-chance points. |
| biggest_lead | integer | The team's largest lead in points. |
| biggest_scoring_run | integer | The team's longest unanswered scoring run, in points. |
| time_leading_seconds | integer | Seconds the team led. |
| lead_changes | integer | Number of lead changes in the game (the same for both rows). |
| top_player_name | character | Name of the team's top performer (Traditional Chinese or a transliteration). |
| top_player_jersey | character | Shirt number of the top performer as a string. |
| top_player_points | integer | Points of the top performer in the game. |
| top_player_rebounds | integer | Total rebounds of the top performer in the game. |
| top_player_assists | integer | Assists of the top performer in the game. |

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

     pleague_preciser_summary_teams(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

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
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
