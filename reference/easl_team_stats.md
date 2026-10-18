# **Get EASL Team Stats**

A team's cumulative season statistics: totals, per-game rates and the
opponent's totals (`*_against`).

Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}/stats`

## Usage

``` r
easl_team_stats(team_id, season = NULL)
```

## Arguments

- team_id:

  (required) DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list.

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble: A team's cumulative season statistics: totals,
per-game rates and the opponent's totals (`*_against`). An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `easl_team_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | character | DataCore team UUID v1, from the request (the body carries none). |
| season | integer | Season END year (2026 = EASL 25-26), from the request. |
| season_id | character | DataCore season UUID v1, from the request. |
| assists | integer | Assists: passes that directly lead to a made field goal. Season total of the team's finished games. |
| assists_against | integer | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Season total of the team's finished games. |
| assists_against_per_game | double | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
| assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Season total of the team's finished games. |
| assists_per_game | double | Assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
| assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Season total of the team's finished games. |
| biggest_lead | integer | Largest lead the team held during the game, in points. A season total sums the per-game maxima. Season total of the team's finished games. |
| biggest_scoring_run | integer | Longest unanswered scoring run of the team, in points. A season total sums the per-game maxima. Season total of the team's finished games. |
| blocks | integer | Shots blocked (made by this player or team). Season total of the team's finished games. |
| blocks_per_game | double | Shots blocked (made by this player or team). Per-game average: the total divided by `games`. |
| blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Season total of the team's finished games. |
| blocks_received_per_game | double | The team's or player's own shots that were blocked by an opponent. Per-game average: the total divided by `games`. |
| draws | integer | Drawn games (basketball has none). Season total of the team's finished games. |
| dunks | integer | Dunks made. Season total of the team's finished games. |
| dunks_per_game | double | Dunks made. Per-game average: the total divided by `games`. |
| efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Season total of the team's finished games. |
| efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Season total of the team's finished games. |
| field_goals_against_percentage | double | Field-goal percentage allowed to opponents over the season (0-100 scale). Season total of the team's finished games. |
| field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Season total of the team's finished games. |
| field_goals_attempted_against | integer | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Season total of the team's finished games. |
| field_goals_attempted_against_per_game | double | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Per-game average: the total divided by `games`. |
| field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Season total of the team's finished games. |
| field_goals_made | integer | Field goals made (2- and 3-point shots). Season total of the team's finished games. |
| field_goals_made_against | integer | Opponent's figure in the same games: field goals made (2- and 3-point shots). Season total of the team's finished games. |
| field_goals_made_against_per_game | double | Opponent's figure in the same games: field goals made (2- and 3-point shots). Per-game average: the total divided by `games`. |
| field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Season total of the team's finished games. |
| fouls_bench_technical | integer | Technical fouls called on the bench (not a player). Season total of the team's finished games. |
| fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Season total of the team's finished games. |
| fouls_coach_technical | integer | Technical fouls on the coach. Season total of the team's finished games. |
| fouls_disqualifying | integer | Disqualifying fouls. Season total of the team's finished games. |
| fouls_disruptive | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Season total of the team's finished games. |
| fouls_drawn_per_game | double | Fouls drawn (committed against this player or team by an opponent). Per-game average: the total divided by `games`. |
| fouls_flagrant | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Season total of the team's finished games. |
| fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Season total of the team's finished games. |
| fouls_personal_against | integer | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Season total of the team's finished games. |
| fouls_personal_against_per_game | double | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
| fouls_personal_per_game | double | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
| fouls_technical | integer | Technical fouls committed by the player or team. Season total of the team's finished games. |
| fouls_technical_against | integer | Opponent's figure in the same games: technical fouls committed by the player or team. Season total of the team's finished games. |
| fouls_technical_against_per_game | double | Opponent's figure in the same games: technical fouls committed by the player or team. Per-game average: the total divided by `games`. |
| fouls_technical_cat1 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_technical_cat2 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Season total of the team's finished games. |
| fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Season total of the team's finished games. |
| free_throws_against_percentage | double | Free-throw percentage allowed to opponents over the season (0-100 scale). Season total of the team's finished games. |
| free_throws_attempted | integer | Free throws attempted. Season total of the team's finished games. |
| free_throws_attempted_against | integer | Opponent's figure in the same games: free throws attempted. Season total of the team's finished games. |
| free_throws_attempted_against_per_game | double | Opponent's figure in the same games: free throws attempted. Per-game average: the total divided by `games`. |
| free_throws_attempted_per_game | double | Free throws attempted. Per-game average: the total divided by `games`. |
| free_throws_made | integer | Free throws made. Season total of the team's finished games. |
| free_throws_made_against | integer | Opponent's figure in the same games: free throws made. Season total of the team's finished games. |
| free_throws_made_against_per_game | double | Opponent's figure in the same games: free throws made. Per-game average: the total divided by `games`. |
| free_throws_made_per_game | double | Free throws made. Per-game average: the total divided by `games`. |
| free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Season total of the team's finished games. |
| games | integer | Finished games counted in this line. Season total of the team's finished games. |
| index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Season total of the team's finished games. |
| losses | integer | Games lost (for a player: by his team while he is in the line). Season total of the team's finished games. |
| minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Season total of the team's finished games. |
| offensive_rating | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Season total of the team's finished games. |
| points | integer | Points scored. Season total of the team's finished games. |
| points_against | integer | Opponent's figure in the same games: points scored. Season total of the team's finished games. |
| points_against_per_game | double | Opponent's figure in the same games: points scored. Per-game average: the total divided by `games`. |
| points_fast_break | integer | Points scored on fast breaks. Season total of the team's finished games. |
| points_fast_break_against | integer | Opponent's figure in the same games: points scored on fast breaks. Season total of the team's finished games. |
| points_fast_break_against_per_game | double | Opponent's figure in the same games: points scored on fast breaks. Per-game average: the total divided by `games`. |
| points_fast_break_attempted | integer | Fast-break field goals attempted. Season total of the team's finished games. |
| points_fast_break_made | integer | Fast-break field goals made. Season total of the team's finished games. |
| points_fast_break_per_game | double | Points scored on fast breaks. Per-game average: the total divided by `games`. |
| points_four_attempted | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_attempted_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_attempted_against_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_attempted_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_made_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_four_made_against_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_made_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_four_percentage_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| points_from_bench | integer | Points scored by players who did not start (a team figure). Season total of the team's finished games. |
| points_from_bench_against | integer | Opponent's figure in the same games: points scored by players who did not start (a team figure). Season total of the team's finished games. |
| points_from_bench_against_per_game | double | Opponent's figure in the same games: points scored by players who did not start (a team figure). Per-game average: the total divided by `games`. |
| points_from_bench_per_game | double | Points scored by players who did not start (a team figure). Per-game average: the total divided by `games`. |
| points_from_turnover | integer | Points scored off opponent turnovers. Season total of the team's finished games. |
| points_from_turnover_against | integer | Opponent's figure in the same games: points scored off opponent turnovers. Season total of the team's finished games. |
| points_from_turnover_against_per_game | double | Opponent's figure in the same games: points scored off opponent turnovers. Per-game average: the total divided by `games`. |
| points_in_the_paint | integer | Points scored in the paint. Season total of the team's finished games. |
| points_in_the_paint_against | integer | Opponent's figure in the same games: points scored in the paint. Season total of the team's finished games. |
| points_in_the_paint_against_per_game | double | Opponent's figure in the same games: points scored in the paint. Per-game average: the total divided by `games`. |
| points_in_the_paint_attempted | integer | Field goals attempted in the paint. Season total of the team's finished games. |
| points_in_the_paint_made | integer | Field goals made in the paint. Season total of the team's finished games. |
| points_in_the_paint_per_game | double | Points scored in the paint. Per-game average: the total divided by `games`. |
| points_per_game | double | Points scored. Per-game average: the total divided by `games`. |
| points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Season total of the team's finished games. |
| points_second_chance_against | integer | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Season total of the team's finished games. |
| points_second_chance_against_per_game | double | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Per-game average: the total divided by `games`. |
| points_second_chance_attempted | integer | Second-chance field goals attempted. Season total of the team's finished games. |
| points_second_chance_made | integer | Second-chance field goals made. Season total of the team's finished games. |
| points_second_chance_per_game | double | Points scored on second-chance possessions (after an offensive rebound). Per-game average: the total divided by `games`. |
| points_three_attempted | integer | 3-point field goals attempted. Season total of the team's finished games. |
| points_three_attempted_against | integer | Opponent's figure in the same games: 3-point field goals attempted. Season total of the team's finished games. |
| points_three_attempted_against_per_game | double | Opponent's figure in the same games: 3-point field goals attempted. Per-game average: the total divided by `games`. |
| points_three_attempted_per_game | double | 3-point field goals attempted. Per-game average: the total divided by `games`. |
| points_three_made | integer | 3-point field goals made. Season total of the team's finished games. |
| points_three_made_against | integer | Opponent's figure in the same games: 3-point field goals made. Season total of the team's finished games. |
| points_three_made_against_per_game | double | Opponent's figure in the same games: 3-point field goals made. Per-game average: the total divided by `games`. |
| points_three_made_per_game | double | 3-point field goals made. Per-game average: the total divided by `games`. |
| points_three_percentage | double | 3-point percentage on a 0-100 scale. Season total of the team's finished games. |
| points_three_percentage_against | double | Opponent's figure in the same games: 3-point percentage on a 0-100 scale. Season total of the team's finished games. |
| points_two_attempted | integer | 2-point field goals attempted. Season total of the team's finished games. |
| points_two_attempted_against | integer | Opponent's figure in the same games: 2-point field goals attempted. Season total of the team's finished games. |
| points_two_attempted_against_per_game | double | Opponent's figure in the same games: 2-point field goals attempted. Per-game average: the total divided by `games`. |
| points_two_attempted_per_game | double | 2-point field goals attempted. Per-game average: the total divided by `games`. |
| points_two_made | integer | 2-point field goals made. Season total of the team's finished games. |
| points_two_made_against | integer | Opponent's figure in the same games: 2-point field goals made. Season total of the team's finished games. |
| points_two_made_against_per_game | double | Opponent's figure in the same games: 2-point field goals made. Per-game average: the total divided by `games`. |
| points_two_made_per_game | double | 2-point field goals made. Per-game average: the total divided by `games`. |
| points_two_percentage | double | 2-point percentage on a 0-100 scale. Season total of the team's finished games. |
| points_two_percentage_against | double | Opponent's figure in the same games: 2-point percentage on a 0-100 scale. Season total of the team's finished games. |
| power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Season total of the team's finished games. |
| power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Season total of the team's finished games. |
| rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Season total of the team's finished games. |
| rebounds_against | integer | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Season total of the team's finished games. |
| rebounds_against_per_game | double | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
| rebounds_defensive | integer | Defensive rebounds. Season total of the team's finished games. |
| rebounds_defensive_against | integer | Opponent's figure in the same games: defensive rebounds. Season total of the team's finished games. |
| rebounds_defensive_against_per_game | double | Opponent's figure in the same games: defensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_defensive_per_game | double | Defensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_offensive | integer | Offensive rebounds. Season total of the team's finished games. |
| rebounds_offensive_against | integer | Opponent's figure in the same games: offensive rebounds. Season total of the team's finished games. |
| rebounds_offensive_against_per_game | double | Opponent's figure in the same games: offensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_offensive_per_game | double | Offensive rebounds. Per-game average: the total divided by `games`. |
| rebounds_per_game | double | Total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
| rebounds_team_defensive | integer | Defensive rebounds credited to the team as a whole (not to a player). Season total of the team's finished games. |
| rebounds_team_defensive_against | integer | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Season total of the team's finished games. |
| rebounds_team_defensive_against_per_game | double | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Per-game average: the total divided by `games`. |
| rebounds_team_offensive | integer | Offensive rebounds credited to the team as a whole. Season total of the team's finished games. |
| rebounds_team_offensive_against | integer | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Season total of the team's finished games. |
| rebounds_team_offensive_against_per_game | double | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Per-game average: the total divided by `games`. |
| rebounds_team_total | integer | Team rebounds credited to the team as a whole (offensive + defensive). Season total of the team's finished games. |
| rebounds_team_total_against | integer | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Season total of the team's finished games. |
| rebounds_team_total_against_per_game | double | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Per-game average: the total divided by `games`. |
| steals | integer | Steals. Season total of the team's finished games. |
| steals_against | integer | Opponent's figure in the same games: steals. Season total of the team's finished games. |
| steals_against_per_game | double | Opponent's figure in the same games: steals. Per-game average: the total divided by `games`. |
| steals_per_game | double | Steals. Per-game average: the total divided by `games`. |
| true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| turnovers | integer | Turnovers committed by players. Season total of the team's finished games. |
| turnovers_against | integer | Opponent's figure in the same games: turnovers committed by players. Season total of the team's finished games. |
| turnovers_against_per_game | double | Opponent's figure in the same games: turnovers committed by players. Per-game average: the total divided by `games`. |
| turnovers_per_game | double | Turnovers committed by players. Per-game average: the total divided by `games`. |
| turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| turnovers_team | integer | Team turnovers not charged to a player (shot-clock and similar violations). Season total of the team's finished games. |
| turnovers_team_against | integer | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Season total of the team's finished games. |
| turnovers_team_against_per_game | double | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Per-game average: the total divided by `games`. |
| wins | integer | Games won (for a player: by his team while he is in the line). Season total of the team's finished games. |

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

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_team_stats(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Team Stats from easl.joshricha.com ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:36:26 UTC
#> # A tibble: 1 × 162
#>   team_id        season season_id assists assists_against assists_against_per_…¹
#>   <chr>           <int> <chr>       <int>           <int>                  <dbl>
#> 1 865489e8-b0f5…   2026 77441bb3…     222             161                   17.9
#> # ℹ abbreviated name: ¹​assists_against_per_game
#> # ℹ 156 more variables: assists_defensive <int>, assists_per_game <dbl>,
#> #   assists_turnover_ratio <dbl>, biggest_lead <int>,
#> #   biggest_scoring_run <int>, blocks <int>, blocks_per_game <dbl>,
#> #   blocks_received <int>, blocks_received_per_game <dbl>, draws <int>,
#> #   dunks <int>, dunks_per_game <dbl>, efficiency <int>,
#> #   efficiency_custom <int>, field_goals_against_percentage <dbl>, …
# }
```
