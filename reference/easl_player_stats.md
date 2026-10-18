# **Get EASL Player Stats**

A player's cumulative statistics over ALL seasons (the server ignores a
season filter).

Endpoint:
`GET https://easl.joshricha.com/api/v1/players/{player_id}/stats`

## Usage

``` r
easl_player_stats(player_id)
```

## Arguments

- player_id:

  (required) DataCore person UUID v1, e.g.
  '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of easl_players,
  the box scores, leaders and play-by-play. A malformed id is
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: A player's cumulative statistics over ALL seasons
(the server ignores a season filter). An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`easl_player_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | character | DataCore person UUID v1, from the request (the body carries none). |
| assists | integer | Assists: passes that directly lead to a made field goal. Total over the player's games. |
| assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Total over the player's games. |
| assists_per_game | double | Assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
| assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Total over the player's games. |
| blocks | integer | Shots blocked (made by this player or team). Total over the player's games. |
| blocks_per_game | double | Shots blocked (made by this player or team). Per-game average: the total divided by `games`. |
| blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Total over the player's games. |
| blocks_received_per_game | double | The team's or player's own shots that were blocked by an opponent. Per-game average: the total divided by `games`. |
| double_double | integer | Double-double flag: 1 when exactly two of points, rebounds, assists, steals, blocks reached 10 in the game, else 0 (a triple-double is counted in tripleDouble instead). In a season line it is a count of such games. Total over the player's games. |
| draws | integer | Drawn games (basketball has none). Total over the player's games. |
| dunks | integer | Dunks made. Total over the player's games. |
| dunks_per_game | double | Dunks made. Per-game average: the total divided by `games`. |
| efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Total over the player's games. |
| efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Total over the player's games. |
| field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Total over the player's games. |
| field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Total over the player's games. |
| field_goals_made | integer | Field goals made (2- and 3-point shots). Total over the player's games. |
| field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Total over the player's games. |
| fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Total over the player's games. |
| fouls_coach_technical | integer | Technical fouls on the coach. Total over the player's games. |
| fouls_disqualifying | integer | Disqualifying fouls. Total over the player's games. |
| fouls_disruptive | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Total over the player's games. |
| fouls_drawn_per_game | double | Fouls drawn (committed against this player or team by an opponent). Per-game average: the total divided by `games`. |
| fouls_flagrant | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Total over the player's games. |
| fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Total over the player's games. |
| fouls_personal_per_game | double | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
| fouls_technical | integer | Technical fouls committed by the player or team. Total over the player's games. |
| fouls_technical_cat1 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_technical_cat2 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Total over the player's games. |
| fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Total over the player's games. |
| free_throws_attempted | integer | Free throws attempted. Total over the player's games. |
| free_throws_attempted_per_game | double | Free throws attempted. Per-game average: the total divided by `games`. |
| free_throws_made | integer | Free throws made. Total over the player's games. |
| free_throws_made_per_game | double | Free throws made. Per-game average: the total divided by `games`. |
| free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Total over the player's games. |
| games | integer | Finished games counted in this line. Total over the player's games. |
| games_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| games_started | integer | Games the player started. Total over the player's games. |
| index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Total over the player's games. |
| losses | integer | Games lost (for a player: by his team while he is in the line). Total over the player's games. |
| max_assists | integer | Highest assists in a single game: in a game row it equals assists; in a season line it is the best game. Total over the player's games. |
| max_free_throws_made | integer | Highest free throws made in a single game (equals freeThrowsMade in a game row). Total over the player's games. |
| max_points | integer | Highest points in a single game (equals points in a game row). Total over the player's games. |
| max_points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| max_points_three_made | integer | Highest 3-pointers made in a single game. Total over the player's games. |
| max_points_two_made | integer | Highest 2-pointers made in a single game. Total over the player's games. |
| max_rebounds | integer | Highest rebounds in a single game. Total over the player's games. |
| max_rebounds_defensive | integer | Highest defensive rebounds in a single game. Total over the player's games. |
| max_rebounds_offensive | integer | Highest offensive rebounds in a single game. Total over the player's games. |
| max_steals | integer | Highest steals in a single game. Total over the player's games. |
| minus | integer | Points the opponents scored while the player was on the court. Total over the player's games. |
| minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Total over the player's games. |
| minutes_per_game | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Per-game average: the total divided by `games`. |
| pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Total over the player's games. |
| plus | integer | Points the player's team scored while he was on the court. Total over the player's games. |
| plus_minus | integer | plus - minus: the team's point margin while the player was on the court. Total over the player's games. |
| points | integer | Points scored. Total over the player's games. |
| points_fast_break | integer | Points scored on fast breaks. Total over the player's games. |
| points_fast_break_attempted | integer | Fast-break field goals attempted. Total over the player's games. |
| points_fast_break_made | integer | Fast-break field goals made. Total over the player's games. |
| points_four_attempted | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_attempted_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_made_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_from_turnover | integer | Points scored off opponent turnovers. Total over the player's games. |
| points_in_the_paint | integer | Points scored in the paint. Total over the player's games. |
| points_in_the_paint_attempted | integer | Field goals attempted in the paint. Total over the player's games. |
| points_in_the_paint_made | integer | Field goals made in the paint. Total over the player's games. |
| points_per_game | double | Points scored. Per-game average: the total divided by `games`. |
| points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Total over the player's games. |
| points_second_chance_attempted | integer | Second-chance field goals attempted. Total over the player's games. |
| points_second_chance_made | integer | Second-chance field goals made. Total over the player's games. |
| points_three_attempted | integer | 3-point field goals attempted. Total over the player's games. |
| points_three_attempted_per_game | double | 3-point field goals attempted. Per-game average: the total divided by `games`. |
| points_three_made | integer | 3-point field goals made. Total over the player's games. |
| points_three_made_per_game | double | 3-point field goals made. Per-game average: the total divided by `games`. |
| points_three_percentage | double | 3-point percentage on a 0-100 scale. Total over the player's games. |
| points_two_attempted | integer | 2-point field goals attempted. Total over the player's games. |
| points_two_attempted_per_game | double | 2-point field goals attempted. Per-game average: the total divided by `games`. |
| points_two_made | integer | 2-point field goals made. Total over the player's games. |
| points_two_made_per_game | double | 2-point field goals made. Per-game average: the total divided by `games`. |
| points_two_percentage | double | 2-point percentage on a 0-100 scale. Total over the player's games. |
| power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Total over the player's games. |
| power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Total over the player's games. |
| rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Total over the player's games. |
| rebounds_defensive | integer | Defensive rebounds. Total over the player's games. |
| rebounds_defensive_per_game | double | Defensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_offensive | integer | Offensive rebounds. Total over the player's games. |
| rebounds_offensive_per_game | double | Offensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_per_game | double | Total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
| steals | integer | Steals. Total over the player's games. |
| steals_per_game | double | Steals. Per-game average: the total divided by `games`. |
| triple_double | integer | Triple-double flag: 1 when three or more of points, rebounds, assists, steals, blocks reached 10, else 0. Total over the player's games. |
| true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| turnovers | integer | Turnovers committed by players. Total over the player's games. |
| turnovers_per_game | double | Turnovers committed by players. Per-game average: the total divided by `games`. |
| turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| wins | integer | Games won (for a player: by his team while he is in the line). Total over the player's games. |

## Details

- WARNING: UNOFFICIAL THIRD-PARTY INTERMEDIARY. These wrappers read
  easl.joshricha.com/api/v1, an Express server run by an individual. It
  is not EASL's and not Sportradar's: it mirrors Sportradar DataCore
  (organisation b1e0z) into SQLite and serves it keyless, and it can
  change or vanish without notice. Its routes, field names (steak,
  facebook_username) and sync freshness are the proxy author's. A
  first-party DataCore feed needs credentials this package does not
  have. The host serves no robots.txt (404) and states no terms; the
  runtime waits at least 1 s before every request, retries included, and
  honours Retry-After. Payloads are not redistributed as release assets.

- Seasons are END years (2026 = EASL 25-26). The server's season key is
  the START year; the runtime reads the season list, maps the END year
  to the DataCore seasonId and defaults to the ACTIVE season. Four
  editions exist (2023-24 to 2026-27). The server defaults to the active
  season on /matches, /standings and /leaders; the runtime always sends
  the resolved seasonId. A season is two calendar years: group by
  season_id, not by the year of the tip-off.

- Finished games only: the game routes first read the fixture and refuse
  (`hoopR_asset_fetch`) one that is not CONFIRMED with two scores, a box
  score whose player points do not add up to the score (the server
  serves one-team, four-row boxes for some games), a play-by-play that
  does not end on the final score in its highest period (4 or more, and
  the last period of the period table), and team totals that disagree
  with the score. For the ACTIVE season's fixture lists the runtime
  reads /health: a server clock more than a day from yours, or a game
  still SCHEDULED more than a day after its tip-off, means the mirror
  has stalled (`hoopR_asset_fetch`). That proves the mirror kept up with
  the games played, not that a game is final upstream.

- Ids: every DataCore id is a UUID v1 string. team_id = entityId,
  player_id = personId; fixture_number (YYSSNNN) is null on every
  2023-24 fixture; `*_row_id` columns are the sync server's own
  integers, not DataCore ids. The fixture's competitors come in
  arbitrary order: read `home_*` / `away_*`, which the parsers take from
  isHome.

- No shot x/y, no game clock and no lineups exist on this server. The
  play-by-play text always says 'missed' for field goals and 'Free throw
  K of M made' for free throws, made or not: use points_scored (the
  change of the event team's running score), which lags on a minority of
  events. 301 of 2,444 sampled box rows are players who did not play
  (null minutes and counting stats; points are 0); player_box.played
  tells them apart. easl_player_stats ignores a season filter: it is the
  career line over every season. Names: nameFullLocal is the English
  display name and nameFullLatin the native-script name, so the columns
  are name and name_native.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, an empty list or leaders object, a team or
  player without games), `hoopR_bad_request` (a malformed id, or a
  season that is not one of the server's END years, raised before the
  request that would use it) and `hoopR_asset_fetch` (any other failure:
  any non-2xx, including the server's HTTP 400 / 422 and the HTTP 500 it
  answers for an unknown fixture, which is not retried; an error
  envelope; a game that is not finished or whose box score or
  play-by-play is incomplete; a stalled sync on the active season; a
  body for another game, season, team or player than the one asked for).
  Wrappers raise; they never warn and return an empty frame.

     easl_player_stats(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
