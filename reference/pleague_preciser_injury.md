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
this order (sportsdataverse-py `pleague_preciser_injury`):

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

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md).

     pleague_preciser_injury(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

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
