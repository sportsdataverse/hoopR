# **Get EASL Team Schedule**

A team's fixtures in one season, shaped like easl_schedule.

Endpoint:
`GET https://easl.joshricha.com/api/v1/teams/{team_id}/matches`

## Usage

``` r
easl_team_schedule(team_id, season = NULL)
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

A `hoopR_data` tibble: A team's fixtures in one season, shaped like
easl_schedule. An empty answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py `easl_team_schedule`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request. |
| season_id | character | Season UUID: the rows carry no seasonId (the season sits in the first half of stage_id), so this is the request's. |
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
| stage_id | character | Stage reference on `/teams/{teamId}/matches` rows only: `<seasonId UUID>:<stage code>` (the season and stage the game belongs to; replaces the nameLocal / stageCode / stageOrder trio of /matches rows). |
| stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
| stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
| stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
| venue_name | character | Arena name. Absent on some rows. |
| venue_name_latin | character | Venue name in Latin script; null on most rows. |
| venue_abbreviation_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_abbreviation_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_alternate_name_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). |
| venue_city | character | City of the arena. Absent on some rows. |
| venue_state | character | State or province of the arena (Philippine games, for example Cebu). Absent on some rows. |
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

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_team_schedule(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")

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
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
