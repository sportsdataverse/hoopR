# **Get EASL Seasons**

Every configured EASL season (the four editions 2023-24 to 2026-27) with
its DataCore season id and END year.

Endpoint: `GET https://easl.joshricha.com/api/v1/metadata/seasons`

## Usage

``` r
easl_seasons()
```

## Value

A `hoopR_data` tibble: Every configured EASL season (the four editions
2023-24 to 2026-27) with its DataCore season id and END year. An empty
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `easl_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26), derived as year + 1. |
| season_id | character | seasonId: DataCore season UUID v1 (key space: EASL seasons; one per edition: 57cefc32... is 2024-25). Joins the `seasonId` query parameter of /matches, /standings, /leaders, /players and the `/teams/{teamId}` routes, the `seasonId` of every fixture and leader row, and the season half of a team-fixture `stage.id`. |
| season_row_id | integer | The sync server's own integer row id (1 = 2024-25, 2 = 2025-26, 3 = 2023-24, 4 = 2026-27: insertion order, not chronological). Not a DataCore id. |
| year | integer | START year of the season (2024 = EASL 24-25, which runs 2024-10 to 2025-03). sdv season (END year) = year + 1. |
| name | character | Season label ('EASL 24-25' = 2024-25). |
| name_latin | character | Season label in Latin script; null on some seasons. |
| status | character | COMPLETE for a finished season, ACTIVE for the current one (the default of every season route). |
| start_date | Date | First day of the season, local date YYYY-MM-DD. |
| end_date | Date | Last scheduled day of the season, local date YYYY-MM-DD. |
| competition_id | character | DataCore competition UUID v1 (key space: competitions); the same 77a790d8-ad01-11ed-8355-01b87a3904c0 on all four seasons: EASL is one competition with one season per edition. |
| profile_id | character | DataCore profile UUID v1 of the competition (joins nothing in this API). |
| organization_id | character | DataCore organisation id of the league: b1e0z (EASL) on every row. |
| age_group | character | Age group of the competition: SENIOR. |
| event_type | character | DataCore event type: FIXTURE (a game schedule). |
| gender | character | MALE (EASL is a men's competition). |
| representation | character | CLUB (club teams, not national teams). |
| season_type | character | DataCore season type: SEASON. |
| standard | character | Competition standard: ELITE. |
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
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
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
  try(easl_seasons())
#> ── EASL Seasons from easl.joshricha.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:14:00 UTC
#> # A tibble: 4 × 20
#>   season season_id        season_row_id  year name  name_latin status start_date
#>    <int> <chr>                    <int> <int> <chr> <chr>      <chr>  <date>    
#> 1   2025 57cefc32-5ace-1…             1  2024 EASL… EASL 24-25 COMPL… 2024-10-02
#> 2   2026 77441bb3-9759-1…             2  2025 EASL… NA         COMPL… 2025-10-08
#> 3   2024 c24ce68a-6420-1…             3  2023 EASL… NA         COMPL… 2023-10-11
#> 4   2027 1409787d-a683-1…             4  2026 EASL… NA         ACTIVE 2026-10-03
#> # ℹ 12 more variables: end_date <date>, competition_id <chr>, profile_id <chr>,
#> #   organization_id <chr>, age_group <chr>, event_type <chr>, gender <chr>,
#> #   representation <chr>, season_type <chr>, standard <chr>, created_at <chr>,
#> #   updated_at <chr>
# }
```
