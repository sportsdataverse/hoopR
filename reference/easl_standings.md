# **Get EASL Standings**

Group-stage standings of one season: rank within the pool, record,
splits, points and the last five results.

Endpoint: `GET https://easl.joshricha.com/api/v1/standings`

## Usage

``` r
easl_standings(season = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble: Group-stage standings of one season: rank within
the pool, record, splits, points and the last five results. An empty
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `easl_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26), from the request. |
| season_id | character | DataCore season UUID v1, from the request (the standings rows carry none). |
| standing_id | character | Standings row id: a DataCore UUID v1 for the (season, pool, team) row (joins nothing else). |
| position | integer | Rank within the pool, 1-4. |
| team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
| team_code | character | Three-letter club code; null for some clubs. |
| pool_id | character | Pool id: a 30-character hex string (equals a fixture's poolCode). |
| pool_name | character | Pool name: 'Group A', 'Group B' or 'Group C'. |
| pool_abb | character | Pool abbreviation: A, B or C. Null on some rows. |
| live | logical | True while the standing is recomputed live during games (false on all six snapshots checked). |
| latest | logical | True on the newest standings snapshot (false on all six snapshots checked, including the active season's). |
| game_played | integer | Games played (group stage only: playoff games are not counted, although lastFiveMatches includes them). |
| game_played_home | integer | Games played at home. |
| game_played_away | integer | Games played away. |
| wins | integer | Wins: all group-stage games on the standings route, all games on the season statistics routes. |
| wins_home | integer | Wins in the team's home games. |
| wins_away | integer | Wins in the team's away games. |
| losses | integer | Losses: all group-stage games on the standings route, all games on the season statistics routes. |
| losses_home | integer | Losses in the team's home games. |
| losses_away | integer | Losses in the team's away games. |
| draws | integer | Draws (0: basketball has none). |
| draws_home | integer | Home draws (0). |
| draws_away | integer | Away draws (0). |
| win_percentage | double | Winning share as a 0-1 ratio rounded to 2 decimals (0.83 = 5-1), NOT a percentage. |
| win_percentage_home | double | Home winning share, 0-1 ratio. |
| win_percentage_away | double | Away winning share, 0-1 ratio. |
| points_for | integer | Points the team scored over its group-stage games (points_against is the points it conceded). |
| points_against | integer | Points allowed. |
| point_difference | integer | Points for minus points against. |
| point_difference_home | integer | Point difference in home games. |
| point_difference_away | integer | Point difference in away games. |
| steak | integer | Current winning streak in games (the key is misspelled 'steak'); 0 after a loss. Never negative: losing streaks are not tracked. |
| streak_home | integer | Current winning streak in home games; 0 after a loss. |
| streak_away | integer | Current winning streak in away games; 0 after a loss. |
| last_five | character | Results of the team's last five games as a comma-separated string, most recent first (W win, L loss). |

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
  try(easl_standings(season = 2026))
#> ── EASL Standings from easl.joshricha.com ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:13:23 UTC
#> # A tibble: 12 × 36
#>    season season_id     standing_id position team_id team_name team_code pool_id
#>     <int> <chr>         <chr>          <int> <chr>   <chr>     <chr>     <chr>  
#>  1   2026 77441bb3-975… e9e5c9db-3…        1 865489… Utsunomi… "BRE"     284a47…
#>  2   2026 77441bb3-975… e9e721a6-3…        2 864e19… Seoul SK… "SK"      284a47…
#>  3   2026 77441bb3-975… e9e88480-3…        3 865159… Taipei F… "TFB"     284a47…
#>  4   2026 77441bb3-975… e9ea3acb-3…        4 27492b… Hong Kon… "HKE"     284a47…
#>  5   2026 77441bb3-975… e9f2cec7-3…        1 865db3… Ryukyu G… ""        47dffb…
#>  6   2026 77441bb3-975… e9f42fd7-3…        2 f17004… Taoyuan … ""        47dffb…
#>  7   2026 77441bb3-975… e9f58794-3…        3 c6b127… Meralco … "MRB"     47dffb…
#>  8   2026 77441bb3-975… e9f6d87f-3…        4 4458de… Macau Bl… ""        47dffb…
#>  9   2026 77441bb3-975… e9ff758c-3…        1 0548e9… Alvark T…  NA       963b9a…
#> 10   2026 77441bb3-975… ea019506-3…        2 b18c0d… New Taip… "NTK"     963b9a…
#> 11   2026 77441bb3-975… ea03473d-3…        3 cbf7cf… South Go… "BRO"     963b9a…
#> 12   2026 77441bb3-975… ea04aedf-3…        4 d311c0… Changwon…  NA       963b9a…
#> # ℹ 28 more variables: pool_name <chr>, pool_abb <chr>, live <lgl>,
#> #   latest <lgl>, game_played <int>, game_played_home <int>,
#> #   game_played_away <int>, wins <int>, wins_home <int>, wins_away <int>,
#> #   losses <int>, losses_home <int>, losses_away <int>, draws <int>,
#> #   draws_home <int>, draws_away <int>, win_percentage <dbl>,
#> #   win_percentage_home <dbl>, win_percentage_away <dbl>, points_for <int>,
#> #   points_against <int>, point_difference <int>, …
# }
```
