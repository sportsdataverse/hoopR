# **Get LBA Game Log**

A player's game log for one season, one row per game.

Endpoint: `GET https://www.legabasket.it/api/players/get-player-matches`
(`cs_id=1&id=<player_id>&s=<season>`)

## Usage

``` r
lba_game_log(player_id, season = NULL)
```

## Arguments

- player_id:

  (required) Player id (player_id in lba_players or a box score),
  e.g. 969. Global: one id for a whole career.

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

## Value

A `hoopR_data` tibble: A player's game log for one season, one row per
game. The columns are always these, in this order (sdv-py
`lba_game_log`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| stat_line_id | integer | Id of the player's stat line for the game (one per player and game). |
| championship_id | integer | Championship id of the game. |
| championships_match_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| player_id | integer | Player id (global, one per career). |
| team_id | integer | Team id (team-season) of the player. |
| number | integer | Jersey number the player wore in the game. |
| played_minutes | integer | Minutes played, in that game. |
| points | integer | Points, in that game. |
| suffered_fouls | integer | Fouls drawn, in that game. |
| done_fouls | integer | Fouls committed, in that game. |
| shots_2p_realized | integer | 2-point field goals made, in that game. |
| shots_2p_total | integer | 2-point field goals attempted, in that game. |
| shots_3p_realized | integer | 3-point field goals made, in that game. |
| shots_3p_total | integer | 3-point field goals attempted, in that game. |
| free_throws_realized | integer | Free throws made, in that game. |
| free_throws_total | integer | Free throws attempted, in that game. |
| restricted_area_p1 | character | Null in every sample (meaning unverified). |
| restricted_area_p2 | character | Null in every sample (meaning unverified). |
| restricted_area_p3 | character | Null in every sample (meaning unverified). |
| slam_dunk | integer | Dunks, in that game. |
| offensive_rebound | integer | Offensive rebounds, in that game. |
| defensive_rebound | integer | Defensive rebounds, in that game. |
| ball_stop_given | integer | Blocks, in that game. |
| ball_stop_received | integer | Own shots blocked, in that game. |
| lost_balls | integer | Turnovers, in that game. |
| regain_balls | integer | Steals, in that game. |
| assists | integer | Assists, in that game. |
| technical_fouls | character | Technical fouls (null in old seasons). |
| minute5_fouls | integer | Minute of the fifth foul (0 = did not foul out; inferred, unverified). |
| time5_fouls | integer | Game time of the fifth foul (0 = did not foul out; inferred, unverified). |
| rating_lega | integer | LBA efficiency rating (`valutazione`), in that game. |
| quintet | integer | Starts (in the starting five), in that game. |
| rating_oer | double | OER (points / (FGA + turnovers + FTA / 2)), in that game. |
| avg_points | integer | The player's plus-minus in the game (the site's name is misleading). |
| wp_id | integer | Null in every sample (meaning unverified). |
| deleted_at | character | Null in every sample (meaning unverified). |
| created_at | character | Timestamp, ISO-8601 with the Italian offset. |
| updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
| player_role_id | integer | Position id (position key space: the id behind `player_role`; joins the `r_id` filter). |
| order | integer | Row order in the box score. |
| captain | logical | Team captain in that game. |
| shots_2p_perc | integer | 2-point field-goal percentage, 0-100, in that game. |
| shots_3p_perc | integer | 3-point field-goal percentage, 0-100, in that game. |
| free_throws_perc | integer | Free-throw percentage, 0-100, in that game. |
| total_rebound | integer | Total rebounds, in that game. |
| ext_code | character | `<websocket_match_id>\|<team code>\|<player code>` (`1674778\|TVU\|CAP-ALE-95`). |
| fouls_first_category | integer | Category-1 technical fouls (null in old seasons; reading inferred). |
| fouls_flagrant | integer | Unsportsmanlike / flagrant fouls. |
| championship_day_name | character | Round code, number sent as a string. |
| home_score | integer | Home points after the action, parsed from the score text (2021-22 on; else null). |
| visitor_score | integer | Visitor points after the action, parsed from the score text (2021-22 on; else null). |
| match_date | character | Tip-off in UTC, ISO-8601 `Z` (local time in `match_hh` / `match_mm`). |
| match_hh | integer | Tip-off hour, local time. |
| match_mm | integer | Tip-off minute, local time. |
| championship_match_id | integer | Game id (repeated). |
| player_team_id | integer | Team id (team-season) of the player (repeated). |
| player_team_name | character | Short name of the player's team in the game (without the season sponsor). |
| player_team_code | character | `<season>\|<team code>` (`1995\|BOF`). |
| visitor_team_id | integer | Visitor team-season id of the game (the play-by-play vt_id). |
| visitor_team_name | character | Away team short name. |
| visitor_team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| home_team_id | integer | Home team-season id of the game (the play-by-play ht_id). |
| home_team_name | character | Home team short name. |
| home_team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| phase_description | character | Phase code: `And` (Andata, 1st half of the season) / `Rit` (Ritorno). |
| match_adp | integer | The player's plus-minus in the game (the site's name is misleading). |
| home_match_result | character | `w` / `l` for the home team when the player was on it, else null. |
| visitor_match_result | character | `w` / `l` for the away team when the player was on it, else null. |

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

     lba_game_log(player_id = 969, season = 2027)

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
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
