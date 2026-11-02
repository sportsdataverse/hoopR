# **Get EASL Schedule**

Every fixture of one season: status, tip-off, stage, pool, venue and
both teams with their scores.

Endpoint: `GET https://easl.joshricha.com/api/v1/matches`

## Usage

``` r
easl_schedule(season = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble: Every fixture of one season: status, tip-off,
stage, pool, venue and both teams with their scores. An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `easl_schedule`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when parsed bare. |
| season_id | character | DataCore season UUID v1 of the fixture (the row's own seasonId). |
| fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
| fixture_number | integer | Fixture number YYSSNNN: two-digit start year, two-digit end year, three-digit sequence (2627001 = first game of 2026-27, 2526003 = third of 2025-26). Null on every 2023-24 fixture. |
| fixture_type | character | REGULAR (group stage), PLAYOFF (quarter- and semifinals) or FINAL (championship and third-place games). Missing from the DRAFT placeholders. Absent on some rows. |
| status | character | CONFIRMED for a finished game, SCHEDULED for a future one, DRAFT for an unscheduled placeholder. |
| fixture_name | character | Fixture name for special games ('EASL Championship', 'Semifinals 2', 'EASL Tip-Off 2026 Cebu'); null for ordinary group games. |
| start_time_utc | character | Scheduled tip-off in UTC, 'YYYY-MM-DDTHH:MM:SS' with no zone marker. The /matches list holds null here on DRAFT fixtures; the single-fixture sample is a finished game. |
| start_time_local | character | Scheduled tip-off in the venue's local time, 'YYYY-MM-DDTHH:MM:SS' with no zone (19:10 local = 10:10 UTC in Tokyo). DRAFT fixtures carry a date at 00:00:00. |
| attendance | integer | Announced attendance of the game; null when not recorded. |
| live_data_available | logical | Whether live stats were collected for the game (present on a minority of fixtures; meaning unverified). Absent on some rows. |
| live_video_available | logical | Whether live video was available (false on all 146 fixtures of the four seasons). |
| pool_code | character | Pool (group) id: a 30-character hex string, equal to pool.id; null on playoff and DRAFT fixtures. |
| pool_id | character | Pool id: a 30-character hex string; null for playoff games ('Unknown Pool'). |
| pool_name | character | Pool name: 'Group A', 'Group B', 'Group C' or the placeholder 'Unknown Pool'. |
| pool_abb | character | Pool abbreviation (A, B, C). Playoff and DRAFT fixtures of the /matches list carry the placeholder pool, whose abb is empty or 'N/A'. Null on some rows. |
| stage_id | character | Stage reference `<season UUID>:<stage code>` on team-fixture rows only (its first half scopes the fixture to a season); null on the other fixture routes, which send the stage_code, stage_name and stage_order trio. |
| stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
| stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
| stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
| venue_name | character | Arena name. Absent on some rows. |
| venue_name_latin | character | Venue name in Latin script; null on most rows. Absent on some rows. |
| venue_abbreviation_latin | character | Venue abbreviation in the Latin field; null except the native-script name of Okinawa Arena on 12 fixtures. Absent on some rows. |
| venue_abbreviation_local | character | Venue abbreviation in the local field; null except 'F-PICO' on 2 fixtures. Absent on some rows. |
| venue_alternate_name_latin | character | Alternative venue name; null on most rows. Absent on some rows. |
| venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). Absent on some rows. |
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
  try(easl_schedule(season = 2026))
#> ── EASL Schedule from easl.joshricha.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:51:21 UTC
#> # A tibble: 42 × 44
#>    season season_id   fixture_id fixture_number fixture_type status fixture_name
#>     <int> <chr>       <chr>               <int> <chr>        <chr>  <chr>       
#>  1   2026 77441bb3-9… 10af8fd4-…        2526042 FINAL        CONFI… EASL Champi…
#>  2   2026 77441bb3-9… fed1d9e9-…        2526041 FINAL        CONFI… Third-Place…
#>  3   2026 77441bb3-9… c050a9ab-…        2526040 PLAYOFF      CONFI… Semifinals 2
#>  4   2026 77441bb3-9… 9b6a67ec-…        2526039 PLAYOFF      CONFI… Semifinals 1
#>  5   2026 77441bb3-9… b7b2d03c-…        2526038 PLAYOFF      CONFI… Quarterfina…
#>  6   2026 77441bb3-9… 919bd7cc-…        2526037 PLAYOFF      CONFI… Quarterfina…
#>  7   2026 77441bb3-9… 4841a0de-…        2526035 REGULAR      CONFI… NA          
#>  8   2026 77441bb3-9… 63129de2-…        2526036 REGULAR      CONFI… NA          
#>  9   2026 77441bb3-9… 25c39958-…        2526034 REGULAR      CONFI… NA          
#> 10   2026 77441bb3-9… be4c5140-…        2526031 REGULAR      CONFI… NA          
#> # ℹ 32 more rows
#> # ℹ 37 more variables: start_time_utc <chr>, start_time_local <chr>,
#> #   attendance <int>, live_data_available <lgl>, live_video_available <lgl>,
#> #   pool_code <chr>, pool_id <chr>, pool_name <chr>, pool_abb <chr>,
#> #   stage_id <chr>, stage_code <chr>, stage_name <chr>, stage_order <int>,
#> #   venue_name <chr>, venue_name_latin <chr>, venue_abbreviation_latin <chr>,
#> #   venue_abbreviation_local <chr>, venue_alternate_name_latin <chr>, …
# }
```
