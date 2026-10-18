# **Get EASL Team**

One team's directory entry; resolves the historical teams easl_teams
does not list.

Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}`

## Usage

``` r
easl_team(team_id)
```

## Arguments

- team_id:

  (required) DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list.

## Value

A `hoopR_data` tibble: One team's directory entry; resolves the
historical teams easl_teams does not list. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`easl_team`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_row_id | integer | The sync server's own integer row id of the team (not a DataCore id; inactive teams interleave, so ids of /teams rows have gaps). |
| team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
| name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. |
| code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
| code_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| standard | character | Competition standard: ELITE. |
| age_group | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| gender | character | Competition gender of the team: MALE (the EASL is a men's competition). |
| status | character | ACTIVE for teams in the current season (the only ones /teams lists), INACTIVE for historical teams (only via `/teams/{teamId}`). |
| primary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| secondary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| tertiary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| logo | character | Club logo URL on the Sportradar DataCore asset CDN (images.dc.connect.sportradar.com/b1e0z/...). |
| website | character | Club website URL; most clubs have none. |
| facebook_username | character | Club Facebook handle; most clubs have none. |
| twitter_username | character | Club X / Twitter handle; most clubs have none. |
| instagram_username | character | Club Instagram handle; some clubs have none. |
| wikipedia_url | character | Club Wikipedia URL (DataCore column); empty for every ACTIVE team. |
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
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_team(team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Team from easl.joshricha.com ─────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:36:19 UTC
#> # A tibble: 1 × 22
#>   team_row_id team_id name  name_native code_latin code_local standard age_group
#>         <int> <chr>   <chr> <chr>       <chr>      <chr>      <chr>    <chr>    
#> 1           8 865489… Utsu… 宇都宮ブレックス…… BRE        NA         ELITE    NA       
#> # ℹ 14 more variables: gender <chr>, status <chr>, primary_color <chr>,
#> #   secondary_color <chr>, tertiary_color <chr>, logo <chr>, website <chr>,
#> #   facebook_username <chr>, twitter_username <chr>, instagram_username <chr>,
#> #   wikipedia_url <chr>, organization_id <chr>, created_at <chr>,
#> #   updated_at <chr>
# }
```
