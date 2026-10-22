# **Get LBA Game**

Game header: teams, venue, quarter scores, coaches, referees and
broadcasters.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-by-id`
(`sc=1&id=<game_id>`)

## Usage

``` r
lba_game(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: Game header: teams, venue, quarter scores,
coaches, referees and broadcasters. The columns are always these, in
this order (sdv-py `lba_game`); a column the site adds later is appended
after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| game_status | character | Game status, number sent as a string: `0` scheduled, `1` live, `2` final (per the OSS client; only `2` sampled). |
| championship_id | integer | Championship id (season + phase) of the game. |
| competition_name | character | Championship full name, e.g. `Regular Season 2026/27`. |
| championships_day_id | integer | Round id (`championships_day_id` key space: one round of one championship; joins `filters.days[].id` and standings `championships_day_id`; not the `d` param). |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| number | integer | Round number of the game, equal to `day_serial` (the `d` echo the capture checks). |
| match_datetime | character | Tip-off, ISO-8601 with the Italian offset (1995-96: midnight, no time kept). |
| match_hh | integer | Tip-off hour, local time. |
| match_mm | integer | Tip-off minute, local time. |
| target_score | character | Null in every sample (meaning unverified). |
| home_final_score | integer | Final points of the home team. |
| visitor_final_score | integer | Final points of the away team. |
| q1_hs | integer | Home points in the 1st quarter (null in the 1995-96 sample: no period scores then). |
| q1_vs | integer | Away points in the 1st quarter. |
| q2_hs | integer | Home points in the 2nd quarter. |
| q2_vs | integer | Away points in the 2nd quarter. |
| q3_hs | integer | Home points in the 3rd quarter (0 in the 1995-96 sample: a placeholder, not a score). |
| q3_vs | integer | Away points in the 3rd quarter (0 placeholder in 1995-96). |
| q4_hs | integer | Home points in the 4th quarter (0 placeholder in 1995-96). |
| q4_vs | integer | Away points in the 4th quarter (0 placeholder in 1995-96). |
| ot_hs | integer | Home overtime points (0 without overtime). |
| ot_vs | integer | Away overtime points. |
| home_coach_id | integer | Home head coach id. |
| home_coach_code | character | Home head coach code `SURNAME3-NAME3`. |
| home_coach_fullname | character | Home head coach, `Surname Name`. |
| visitor_coach_id | integer | Away head coach id. |
| visitor_coach_code | character | Away head coach code. |
| visitor_coach_fullname | character | Away head coach, `Surname Name`. |
| additional_time | integer | Overtime periods played (0 in every sample; reading inferred). |
| plant_id | integer | Arena id (arena key space; joins nothing specced). |
| websocket_match_id | integer | Live-feed game id, number sent as a string; separate from the game id. |
| has_streaming | integer | 1 when a stream exists, else 0. |
| live_match_data | character | Null in every sample (meaning unverified). |
| quarter | character | Last period played, number sent as a string (`4`; `5` = overtime). |
| ticketing_url | character | Ticket shop URL (null for old games). |
| match_serie | character | All-time head-to-head as `home wins-away wins` (`6-18`; inferred from `match_hw` / `match_vw`). |
| match_hw | integer | All-time head-to-head wins of the home club (inferred). |
| match_vw | integer | All-time head-to-head wins of the away club (inferred). |
| updated_at | character | Timestamp, ISO-8601 with the Italian offset. Last update of the game row. |
| h_team_id | integer | Home team id (team-season). |
| h_team_name | character | Home team name (sponsor name of that season). |
| h_team_enabled | logical | Home team page enabled on the site. |
| home_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| v_team_id | integer | Away team id (team-season). |
| v_team_name | character | Visitor team name (the sponsor name of that season). |
| v_team_enabled | logical | Away team page enabled on the site. |
| v_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| plant_name | character | Name of the arena where the game is played. |
| day_code | character | Round code (`1`, `2`, ...; string in game rows, integer in standings). |
| day_serial | integer | Round number (`event_serial`, the `d` param). |
| day_name | character | Round name, Italian: `1o Giornata` = matchday 1. |
| competition_type_id | integer | Phase type id: 4 = Regular Season, 2 = Play Off. |
| competition_type_code | character | Phase type code: `RS` / `PO`. |
| competition_type | character | Phase type name: `Regular Season` / `Play Off`. |
| competition_serie_id | integer | Series id, 1 = Serie A. |
| competition_serie | character | Series name, `Serie A`. |
| day_phase_id | integer | Phase id: 1 = `Andata` (first half of the season), 2 = `Ritorno` (second half). |
| spectators | integer | Attendance: spectators at the game. |
| referees | character | JSON list of the game's referees (id, name, surname); null when the site lists none. |
| broadcasters | character | JSON list of the game's broadcasters (name, logo key); null when the site lists none. |

## Details

- Unofficial and unsupported: these wrappers read the JSON API that the
  Next.js site www.legabasket.it itself calls. Legal notice: the site's
  terms say "Non e' consentito copiare ... dati e informazioni senza
  autorizzazione scritta" (copying data and information without written
  authorisation is not allowed), except for personal, non-commercial
  use. The owner accepted the restriction for this intake on 2026-10-12.
  Payloads are not redistributed as release assets, and any published
  data release of this source needs separate sign-off.

- robots.txt allows /api and sets Crawl-delay: 2. The runtime waits 2 s
  before every request, retries included. Crawl incrementally: fetch a
  final game once (keyed by game_id), find new games with one
  lba_calendar call per round, and do not backfill a history in a burst.

- Seasons are END years (2027 = 2026-27); the site sends START years and
  the runtime maps them (season - 1 on the wire). Game and player ids
  are global; team ids are re-issued every season (join lba_teams for
  the stable club_id); a championship id is one season AND one phase
  (Regular Season and Play Off differ).

- Play-by-play starts in 2017-18 and changes shape in 2019-20 (pixel
  frame to court percent) and 2021-22; see lba_pbp. Box scores reach
  back to 1995-96, where the period scores were not recorded (0 means
  missing).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or a body with no rows: an unknown season,
  a play-by-play before 2017-18, standings of a finished championship
  without a round), `hoopR_bad_request` (a season that is not an END
  year, a bad choice, HTTP 400 / 422) and `hoopR_asset_fetch` (any other
  non-2xx, a connection failure after retries, an empty / non-JSON /
  error-shaped 200, a game that is not final on the box score,
  play-by-play and shot routes, a truncated page, or a body for another
  season, championship, game, team, player, round or category than the
  one asked for). An unknown id is HTTP 500, which is not retried. A
  body the parser finds no rows in gives a zero-row tibble with these
  columns.

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_game(game_id = 25602))
#> ── LBA Game from legabasket.it ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:39:25 UTC
#> # A tibble: 1 × 62
#>   season game_id game_status championship_id competition_name      
#>    <int>   <int> <chr>                 <int> <chr>                 
#> 1   2027   25602 2                       602 Regular Season 2026/27
#> # ℹ 57 more variables: championships_day_id <int>, year <int>, number <int>,
#> #   match_datetime <chr>, match_hh <int>, match_mm <int>, target_score <chr>,
#> #   home_final_score <int>, visitor_final_score <int>, q1_hs <int>,
#> #   q1_vs <int>, q2_hs <int>, q2_vs <int>, q3_hs <int>, q3_vs <int>,
#> #   q4_hs <int>, q4_vs <int>, ot_hs <int>, ot_vs <int>, home_coach_id <int>,
#> #   home_coach_code <chr>, home_coach_fullname <chr>, visitor_coach_id <int>,
#> #   visitor_coach_code <chr>, visitor_coach_fullname <chr>, …
# }
```
