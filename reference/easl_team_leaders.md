# **Get EASL Team Leaders**

A team's top-5 player leaders per category in one season, shaped like
easl_leaders.

Endpoint:
`GET https://easl.joshricha.com/api/v1/teams/{team_id}/leaders`

## Usage

``` r
easl_team_leaders(team_id, season = NULL)
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

A `hoopR_data` tibble: A team's top-5 player leaders per category in one
season, shaped like easl_leaders. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`easl_team_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when the body is parsed bare. |
| season_id | character | DataCore season UUID v1 of the leader row. |
| category | character | Leader category, the wire key of the group: pointsPerGame, reboundsPerGame, assistsPerGame, stealsPerGame, blocksPerGame, pointsThreeMade, pointsThreePercentage, fieldGoalsPercentage or freeThrowsPercentage. |
| rank | integer | Rank inside the category, 1 = best, in the delivered order (the server lists the top 5). |
| value | double | The leader's value in the category: a per-game average, a count (pointsThreeMade) or a percentage (0-100). Float64. |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| jersey_number | character | Jersey number as a string ('00', '0' and '75' are distinct). |
| position | character | Playing position: G, F, C, PG, SG, SF, PF or GF (guard-forward). |
| player_status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
| team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
| team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. |
| team_code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
| team_code_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |

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
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_team_leaders(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Team Leaders from easl.joshricha.com ─────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:36:24 UTC
#> # A tibble: 45 × 16
#>    season season_id category  rank value player_id player_name player_name_latin
#>     <int> <chr>     <chr>    <int> <dbl> <chr>     <chr>       <chr>            
#>  1   2026 77441bb3… assists…     1 7.11  85c99dab… D.J. NEWBI… D.J. NEWBILL     
#>  2   2026 77441bb3… assists…     2 4.44  8983317f… HIEJIMA Ma… HIEJIMA Makoto   
#>  3   2026 77441bb3… assists…     3 4.33  8a530bfe… Isaac FOTU  Isaac FOTU       
#>  4   2026 77441bb3… assists…     4 3.67  8a4f5e97… Grant JERR… Grant JERRETT    
#>  5   2026 77441bb3… assists…     5 2.14  8984fe11… OGAWA Atsu… OGAWA Atsuya     
#>  6   2026 77441bb3… blocksP…     1 0.833 8a4f5e97… Grant JERR… Grant JERRETT    
#>  7   2026 77441bb3… blocksP…     2 0.667 e670b5bc… Gavin EDWA… Gavin EDWARDS    
#>  8   2026 77441bb3… blocksP…     3 0.333 8983317f… HIEJIMA Ma… HIEJIMA Makoto   
#>  9   2026 77441bb3… blocksP…     4 0.333 8a530bfe… Isaac FOTU  Isaac FOTU       
#> 10   2026 77441bb3… blocksP…     5 0.286 8984fe11… OGAWA Atsu… OGAWA Atsuya     
#> # ℹ 35 more rows
#> # ℹ 8 more variables: jersey_number <chr>, position <chr>, player_status <chr>,
#> #   team_id <chr>, team_name <chr>, team_name_native <chr>,
#> #   team_code_latin <chr>, team_code_local <chr>
# }
```
