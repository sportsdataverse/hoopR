# **Get EASL Player Box Score**

Player box score of a finished game, one row per rostered player
(non-players have null counting stats).

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/boxscore`

## Usage

``` r
easl_player_box(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Player box score of a finished game, one row per
rostered player (non-players have null counting stats). An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `easl_player_box`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| fixture_id | character | DataCore fixture (game) UUID v1 of the box row. |
| team_id | character | The player's team: DataCore team (entity) UUID v1 (the wire's entityId). |
| team_name | character | The player's team display name, joined from the body's teams array. |
| team_name_native | character | The player's team name in native script, joined from the body's teams array; blank for most clubs. |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. Absent on some rows. |
| player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. Absent on some rows. |
| bib | character | Jersey number as a string ('00' and '0' are distinct). |
| position | character | Playing position: G, F, C, PG, SG, SF, PF or GF; null on some rows. |
| starter | logical | True for a starter (five per team). |
| is_player | logical | True on every row (team officials are never listed). |
| is_team_official | logical | False on every row. |
| played | logical | True when the player has playing time (minutes present); False for the rostered players who did not play (their counting stats are null). |
| minutes_played | double | Playing time in minutes (decimal), parsed from the ISO 8601 minutes statistic (PT35M11S = 35.1833). |
| assists | integer | Assists: passes that directly lead to a made field goal. Null on some rows. |
| assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Null on some rows. |
| assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Null on some rows. |
| blocks | integer | Shots blocked (made by this player or team). Null on some rows. |
| blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Null on some rows. |
| double_double | integer | Double-double flag: 1 when exactly two of points, rebounds, assists, steals, blocks reached 10 in the game, else 0 (a triple-double is counted in tripleDouble instead). In a season line it is a count of such games. |
| dunks | integer | Dunks made. Null on some rows. |
| efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). |
| efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Null on some rows. |
| field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Null on some rows. |
| field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Null on some rows. |
| field_goals_made | integer | Field goals made (2- and 3-point shots). Null on some rows. |
| field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Null on some rows. |
| fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Null on some rows. |
| fouls_coach_technical | integer | Technical fouls on the coach. Null on some rows. |
| fouls_disqualifying | integer | Disqualifying fouls. Null on some rows. |
| fouls_disruptive | integer | Disruptive fouls (DataCore column; filled from 2026-27). Null on some rows. |
| fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Null on some rows. |
| fouls_flagrant | integer | Flagrant fouls (DataCore column; filled from 2026-27). Null on some rows. |
| fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Null on some rows. |
| fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Null on some rows. |
| fouls_technical | integer | Technical fouls committed by the player or team. Null on some rows. |
| fouls_technical_cat1 | integer | Technical fouls of category 1 (DataCore column; filled from 2026-27). Null on some rows. |
| fouls_technical_cat2 | integer | Technical fouls of category 2 (DataCore column; filled from 2026-27). Null on some rows. |
| fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). |
| fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Null on some rows. |
| free_throws_attempted | integer | Free throws attempted. Null on some rows. |
| free_throws_made | integer | Free throws made: a game count on the box-score and team-total routes, a season total on the season statistics routes. |
| free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Null on some rows. |
| index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. |
| max_assists | integer | Highest assists in a single game: in a game row it equals assists; in a season line it is the best game. Null on some rows. |
| max_free_throws_made | integer | Highest free throws made in a single game (equals freeThrowsMade in a game row). |
| max_points | integer | Highest points in a single game (equals points in a game row). |
| max_points_four_made | integer | Highest 4-point shots made in a game (DataCore column; EASL has no 4-point line; filled from 2026-27). Null on some rows. |
| max_points_three_made | integer | Highest 3-pointers made in a single game. Null on some rows. |
| max_points_two_made | integer | Highest 2-pointers made in a single game. Null on some rows. |
| max_rebounds | integer | Highest rebounds in a single game. Null on some rows. |
| max_rebounds_defensive | integer | Highest defensive rebounds in a single game. Null on some rows. |
| max_rebounds_offensive | integer | Highest offensive rebounds in a single game. Null on some rows. |
| max_steals | integer | Highest steals in a single game. Null on some rows. |
| minus | integer | Points the opponents scored while the player was on the court. Null on some rows. |
| minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Null on some rows. |
| pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). |
| plus | integer | Points the player's team scored while he was on the court. Null on some rows. |
| plus_minus | integer | plus - minus: the team's point margin while the player was on the court. Null on some rows. |
| points | integer | Points scored: a game count on the box-score and team-total routes, a season total on the season statistics routes. |
| points_fast_break | integer | Points scored on fast breaks. Null on some rows. |
| points_fast_break_attempted | integer | Fast-break field goals attempted. Null on some rows. |
| points_fast_break_made | integer | Fast-break field goals made. Null on some rows. |
| points_four_attempted | integer | 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Null on some rows. |
| points_four_made | integer | 4-point shots made (see pointsFourAttempted). Null on some rows. |
| points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| points_from_turnover | integer | Points scored off opponent turnovers. Null on some rows. |
| points_in_the_paint | integer | Points scored in the paint. Null on some rows. |
| points_in_the_paint_attempted | integer | Field goals attempted in the paint. Null on some rows. |
| points_in_the_paint_made | integer | Field goals made in the paint. Null on some rows. |
| points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Null on some rows. |
| points_second_chance_attempted | integer | Second-chance field goals attempted. Null on some rows. |
| points_second_chance_made | integer | Second-chance field goals made. Null on some rows. |
| points_three_attempted | integer | 3-point field goals attempted. Null on some rows. |
| points_three_made | integer | 3-point field goals made. Null on some rows. |
| points_three_percentage | double | 3-point percentage on a 0-100 scale. Null on some rows. |
| points_two_attempted | integer | 2-point field goals attempted. Null on some rows. |
| points_two_made | integer | 2-point field goals made. Null on some rows. |
| points_two_percentage | double | 2-point percentage on a 0-100 scale. Null on some rows. |
| power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Null on some rows. |
| power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Null on some rows. |
| rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Null on some rows. |
| rebounds_defensive | integer | Defensive rebounds. Null on some rows. |
| rebounds_defensive_percentage | double | Share of available defensive rebounds taken while on the court, on a 0-100 scale; values above 100 (up to 108.9) occur, so the definition is unverified. Null on some rows. |
| rebounds_offensive | integer | Offensive rebounds. Null on some rows. |
| rebounds_offensive_percentage | double | Share of available offensive rebounds taken while on the court, 0-100 scale (up to 91.4 observed); definition unverified. Null on some rows. |
| rebounds_percentage | double | Share of all available rebounds taken while on the court, 0-100 scale; definition unverified. Null on some rows. |
| steals | integer | Steals. Null on some rows. |
| triple_double | integer | Triple-double flag: 1 when three or more of points, rebounds, assists, steals, blocks reached 10, else 0. |
| true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| turnovers | integer | Turnovers committed by players. Null on some rows. |
| turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
| usage_rate | double | Usage rate on a 0-100 scale: share of the team's possessions used while on the court (up to 136 observed); definition unverified. Null on some rows. |

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
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_player_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Player Box Score from easl.joshricha.com ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:36:12 UTC
#> # A tibble: 24 × 94
#>    fixture_id           team_id team_name team_name_native player_id player_name
#>    <chr>                <chr>   <chr>     <chr>            <chr>     <chr>      
#>  1 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 26d8f5c8… LU Chun-Hs…
#>  2 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 5d009383… William AR…
#>  3 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 689dc46e… Alec BROWN 
#>  4 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 85c99dab… D.J. NEWBI…
#>  5 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 897d9aab… TABUSE Yuta
#>  6 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8983317f… HIEJIMA Ma…
#>  7 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8984fe11… OGAWA Atsu…
#>  8 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8986bf47… ENDO Yusuke
#>  9 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 89889819… TAKEUCHI K…
#> 10 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8a4180f3… TAKASHIMA …
#> # ℹ 14 more rows
#> # ℹ 88 more variables: player_name_latin <chr>, bib <chr>, position <chr>,
#> #   starter <lgl>, is_player <lgl>, is_team_official <lgl>, played <lgl>,
#> #   minutes_played <dbl>, assists <int>, assists_defensive <int>,
#> #   assists_turnover_ratio <dbl>, blocks <int>, blocks_received <int>,
#> #   double_double <int>, dunks <int>, efficiency <int>,
#> #   efficiency_custom <int>, field_goals_attempted <int>, …
# }
```
