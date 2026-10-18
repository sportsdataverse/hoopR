# **Get EASL Player**

One player's biography: names, nationality, birth date, height, weight.

Endpoint: `GET https://easl.joshricha.com/api/v1/players/{player_id}`

## Usage

``` r
easl_player(player_id)
```

## Arguments

- player_id:

  (required) DataCore person UUID v1, e.g.
  '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of easl_players,
  the box scores, leaders and play-by-play. A malformed id is
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: One player's biography: names, nationality, birth
date, height, weight. An empty answer raises `hoopR_no_data`; the
columns are always these, in this order (sdv-py `easl_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| name_abbreviated | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
| gender | character | MALE on all 552 rows. |
| dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. |
| height_cm | integer | Height in centimetres; 43 of 552 players have none. |
| height_feet | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| weight_kg | integer | Weight in kilograms; many players have none. |
| weight_lbs | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
| jersey_number | character | Jersey number as a string. Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| position | character | Playing position (G, F, C, PG, SG, SF, PF, GF). Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| organization_id | character | DataCore organisation id: b1e0z (EASL). |
| created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
| updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |

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
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_player(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5"))
#> ── EASL Player from easl.joshricha.com ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:36:10 UTC
#> # A tibble: 1 × 18
#>   player_row_id player_id   name  name_latin name_abbreviated nationality gender
#>           <int> <chr>       <chr> <chr>      <chr>            <chr>       <chr> 
#> 1           164 85c99dab-9… D.J.… D.J. NEWB… NA               USA         MALE  
#> # ℹ 11 more variables: dob <date>, height_cm <int>, height_feet <chr>,
#> #   weight_kg <int>, weight_lbs <int>, status <chr>, jersey_number <chr>,
#> #   position <chr>, organization_id <chr>, created_at <chr>, updated_at <chr>
# }
```
