# **Get EASL Game**

Header of one finished fixture: teams, final score, status, stage, pool,
venue and attendance.

Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}`

## Usage

``` r
easl_game(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Header of one finished fixture: teams, final
score, status, stage, pool, venue and attendance. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`easl_game`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Always null here: the game route carries no season; join season_id to easl_seasons. |
| season_id | character | Always null here: the game route carries no season. |
| fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
| fixture_number | integer | Fixture number YYSSNNN: two-digit start year, two-digit end year, three-digit sequence (2627001 = first game of 2026-27, 2526003 = third of 2025-26). Null on every 2023-24 fixture. |
| fixture_type | character | REGULAR (group stage), PLAYOFF (quarter- and semifinals) or FINAL (championship and third-place games). Missing from the DRAFT placeholders. |
| status | character | CONFIRMED = finished with a final box score; SCHEDULED = future; DRAFT = a placeholder with no teams or time. |
| fixture_name | character | Fixture name for special games ('EASL Championship', 'Semifinals 2', 'EASL Tip-Off 2026 Cebu'); null for ordinary group games. |
| start_time_utc | character | Scheduled tip-off in UTC, 'YYYY-MM-DDTHH:MM:SS' with no zone marker. The /matches list holds null here on DRAFT fixtures; the single-fixture sample is a finished game. |
| start_time_local | character | Scheduled tip-off in the venue's local time, 'YYYY-MM-DDTHH:MM:SS' with no zone (19:10 local = 10:10 UTC in Tokyo). DRAFT fixtures carry a date at 00:00:00. |
| attendance | integer | Announced attendance of the game; null when not recorded. |
| live_data_available | logical | Whether live stats were collected for the game (present on a minority of fixtures; meaning unverified). Absent on some rows. |
| live_video_available | logical | Whether live video was available (false on all 146 fixtures of the four seasons). |
| pool_code | character | Pool (group) id: a 30-character hex string, equal to pool.id; null on playoff and DRAFT fixtures. |
| pool_id | character | Pool id: a 30-character hex string; null for playoff games ('Unknown Pool'). |
| pool_name | character | Pool name: 'Group A', 'Group B', 'Group C' or the placeholder 'Unknown Pool'. |
| pool_abb | character | Pool abbreviation (A, B, C). Playoff and DRAFT fixtures of the /matches list carry the placeholder pool, whose abb is empty or 'N/A'. |
| stage_id | character | Stage reference `<season UUID>:<stage code>` on team-fixture rows only (its first half scopes the fixture to a season); null on the other fixture routes, which send the stage_code, stage_name and stage_order trio. |
| stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
| stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
| stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
| venue_name | character | Arena name. Absent on some rows. |
| venue_name_latin | character | Venue name in Latin script; null on most rows. |
| venue_abbreviation_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_abbreviation_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_alternate_name_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). |
| venue_city | character | City of the arena. |
| venue_state | character | State or province of the arena (Philippine games, for example Cebu). |
| home_team_id | character | Home team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| home_name | character | Home team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
| home_name_native | character | Home team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
| home_code_latin | character | Home team: three-letter club code (for example BRE); null or empty for some clubs. |
| home_code_local | character | Home team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
| home_score | integer | Home team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
| home_result_place | integer | Home team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
| home_draw | logical | Home team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
| away_team_id | character | Away team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| away_name | character | Away team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
| away_name_native | character | Away team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
| away_code_latin | character | Away team: three-letter club code (for example BRE); null or empty for some clubs. |
| away_code_local | character | Away team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
| away_score | integer | Away team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
| away_result_place | integer | Away team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
| away_draw | logical | Away team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |

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
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_game(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Game from easl.joshricha.com ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:28:00 UTC
#> # A tibble: 1 × 44
#>   season season_id fixture_id    fixture_number fixture_type status fixture_name
#>    <int> <chr>     <chr>                  <int> <chr>        <chr>  <chr>       
#> 1     NA NA        10af8fd4-106…        2526042 FINAL        CONFI… EASL Champi…
#> # ℹ 37 more variables: start_time_utc <chr>, start_time_local <chr>,
#> #   attendance <int>, live_data_available <lgl>, live_video_available <lgl>,
#> #   pool_code <chr>, pool_id <chr>, pool_name <chr>, pool_abb <chr>,
#> #   stage_id <chr>, stage_code <chr>, stage_name <chr>, stage_order <int>,
#> #   venue_name <chr>, venue_name_latin <chr>, venue_abbreviation_latin <chr>,
#> #   venue_abbreviation_local <chr>, venue_alternate_name_latin <chr>,
#> #   venue_country_code <chr>, venue_city <chr>, venue_state <chr>, …
# }
```
