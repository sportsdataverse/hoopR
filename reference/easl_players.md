# **Get EASL Players**

Every EASL player of all seasons; with season and team_id a roster that
adds jersey number and position.

Endpoint: `GET https://easl.joshricha.com/api/v1/players`

## Usage

``` r
easl_players(season = NULL, team_id = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: no season filter.

- team_id:

  DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list. Needs season for a
  roster (jersey number and position). Default `NULL`: no team filter.

## Value

A `hoopR_data` tibble: Every EASL player of all seasons; with season and
team_id a roster that adds jersey number and position. An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `easl_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year of the filter, from the request; null when no season was passed. |
| season_id | character | DataCore season UUID v1 of the filter; null when no season was passed. |
| player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| name_abbreviated | character | Abbreviated name; null for 551 of 552 players (one empty string). |
| nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
| gender | character | MALE on all 552 rows. |
| dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. Null on some rows. |
| height_cm | integer | Height in centimetres; 43 of 552 players have none. Null on some rows. |
| height_feet | character | Height in feet and inches as a string (6'9); null for most players. |
| weight_kg | integer | Weight in kilograms; many players have none. Null on some rows. |
| weight_lbs | integer | Weight in pounds; null for many players. |
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
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
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
  try(easl_players(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Players from easl.joshricha.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:13:20 UTC
#> # A tibble: 17 × 20
#>    season season_id    player_row_id player_id name  name_latin name_abbreviated
#>     <int> <chr>                <int> <chr>     <chr> <chr>      <chr>           
#>  1   2026 77441bb3-97…            51 2c03440a… Just… Justin HA… NA              
#>  2   2026 77441bb3-97…            55 2e016dfa… ISHI… ISHIKAWA … NA              
#>  3   2026 77441bb3-97…           105 57598895… HOSH… HOSHIKAWA… NA              
#>  4   2026 77441bb3-97…           164 85c99dab… D.J.… D.J. NEWB… NA              
#>  5   2026 77441bb3-97…           216 897d9aab… TABU… TABUSE Yu… NA              
#>  6   2026 77441bb3-97…           217 8983317f… HIEJ… HIEJIMA M… NA              
#>  7   2026 77441bb3-97…           218 8984fe11… OGAW… OGAWA Ats… NA              
#>  8   2026 77441bb3-97…           219 8986bf47… ENDO… ENDO Yusu… NA              
#>  9   2026 77441bb3-97…           220 89889819… TAKE… TAKEUCHI … NA              
#> 10   2026 77441bb3-97…           221 8a4180f3… TAKA… TAKASHIMA… NA              
#> 11   2026 77441bb3-97…           222 8a44d984… WATA… WATANABE … NA              
#> 12   2026 77441bb3-97…           223 8a4b82f4… IKAR… IKARUGA S… NA              
#> 13   2026 77441bb3-97…           224 8a4f5e97… Gran… Grant JER… NA              
#> 14   2026 77441bb3-97…           225 8a530bfe… Isaa… Isaac FOTU NA              
#> 15   2026 77441bb3-97…           388 e670b5bc… Gavi… Gavin EDW… NA              
#> 16   2026 77441bb3-97…           409 f8a930cf… Blak… Blake AOKI NA              
#> 17   2026 77441bb3-97…           424 177cdc17… MATS… NA         NA              
#> # ℹ 13 more variables: nationality <chr>, gender <chr>, dob <date>,
#> #   height_cm <int>, height_feet <chr>, weight_kg <int>, weight_lbs <int>,
#> #   status <chr>, jersey_number <chr>, position <chr>, organization_id <chr>,
#> #   created_at <chr>, updated_at <chr>
# }
```
