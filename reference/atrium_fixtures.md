# **Atrium Fixtures (schedule and results)**

**Fixtures (schedule and results) of a season, home and away side by
side.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures`

Scores are integers (the API sends strings); `start_time_utc` is a UTC
`POSIXct`; `start_time_local` is the venue's wall-clock time as the API
sends it (character: its zone, `timezone`, varies per row, so no single
`POSIXct` zone fits). sdv-py keeps both naive.

## Usage

``` r
atrium_fixtures(
  website_id,
  season = NULL,
  season_id = NULL,
  competition_id = NULL,
  entity_id = NULL,
  round_number = NULL,
  sub = NULL,
  locale = NULL
)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- season:

  (*integer* optional): Season END year (2026 = 2025-26 on LNB, site 12,
  whose own year is the START year; the calendar year on the other
  sites). Needs `competition_id` when several competitions share that
  year (see
  [`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md)).
  Omit `season` and `season_id` for the site's default season.

- season_id:

  (*character* optional): Season UUID (`season_id` in
  [`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md));
  sent as is, skipping the END-year lookup of `season`.

- competition_id:

  (*character* optional): Competition UUID (`competition_id` in
  [`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md)).
  Picks the season together with `season`, and is then not sent; with
  neither `season` nor `season_id` the API filters by it.

- entity_id:

  (*character* optional): Team UUID (`entity_id` in
  [`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md)
  or any fixture row).

- round_number:

  (*integer* optional): Round (journee) number to show; the pages that
  take it list their rounds.

- sub:

  (*character* optional): Tab: `"FIXTURES"` (upcoming) or `"RESULTS"`
  (played). Omitted = the site's default tab.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row per `fixture_id`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID the page is about (the site's default season when none was asked). |
| competition_id | character | Competition UUID of the season. |
| competition_name | character | Competition name in the site's language, e.g. Betclic ELITE or LIGA CALIENTE.MX LNBP. |
| season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| fixture_type | character | Kind of game as sent: REGULAR, PLAYOFF, ... (the set is open). |
| name | character | Fixture name as the site prints it (e.g. Paris - Lyon-Villeurbanne); null on LNBP. |
| round | character | Round of the game as the site words it, e.g. Journee: 30. |
| round_code | character | Round code; null in every body seen. |
| pool | character | Pool the game belongs to; null when the competition has none. |
| series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
| stage_code | character | Opaque 30-hex stage code of the game; null in every body seen. |
| status | character | Status code of the game, e.g. CONFIRMED (final), as sent. |
| status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
| start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
| start_time_local | character | Scheduled start in the venue's local time, as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; timezone gives the zone, which varies per row). |
| timezone | character | IANA time zone of the venue (e.g. Europe/Paris, Mexico/General) that start_time_local is in. |
| times_unconfirmed | logical | True while the start time is not final. |
| venue | character | Name of the arena where the game is played. |
| venue_id | character | Venue UUID; joins no other route. |
| attendance | integer | Spectators at the game; null when not reported. |
| home_entity_id | character | Team UUID of the home team. |
| home_code | character | Short code of the home team (e.g. PAB). |
| home_name | character | Name of the home team. |
| home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
| home_result_place | integer | Result place of the home team: 1 for the winner, 2 for the loser. |
| home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
| home_draw | logical | True when the game ended level for the home team. |
| home_shootout_attempts | character | Shootout attempts of the home team as sent (an empty string becomes null). |
| home_secondary_score | character | Secondary score of the home team (unused in the samples; shown as text). |
| away_entity_id | character | Team UUID of the away team. |
| away_code | character | Short code of the away team (e.g. PAB). |
| away_name | character | Name of the away team. |
| away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
| away_result_place | integer | Result place of the away team: 1 for the winner, 2 for the loser. |
| away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
| away_draw | logical | True when the game ended level for the away team. |
| away_shootout_attempts | character | Shootout attempts of the away team as sent (an empty string becomes null). |
| away_secondary_score | character | Secondary score of the away team (unused in the samples; shown as text). |

## Details

**Unofficial.** This is the public endpoint the Sportradar Atrium /
Synergy "Connect" widget calls from every visitor's browser (keyless;
the host has no robots.txt). The data is Sportradar's and the leagues'.
The wrappers read it on the caller's behalf, one request at least 1 s
after the last to the host, and it is not republished as release assets.
Keep crawls small and incremental.

**Sites and seasons.** `website_id` picks the league site; one site
carries many competitions. Seasons are END years (`season = 2026`): the
site's own year is the START year on LNB and the calendar year
elsewhere, and a year can hold several competitions, so pair `season`
with `competition_id` (see
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md))
or pass `season_id`.
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md)
maps a site's own year to that END year, and
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md)
finds the season UUID.

**Columns** are configured per site: a statistic one site omits is `NA`.
A key the documented columns do not list is appended with an inferred
type. Player and team ids (UUIDs, character) are shared across sites;
the player stat tables carry names only, so `person_id` there is decoded
from the widget link beside each name.

**Errors** (classed conditions, all inheriting `hoopR_error`):
`hoopR_no_data` when the site has nothing for the request (HTTP 404, no
such season, an empty fixture list, a game with no play-by-play yet, or
a fixture id the site does not serve: an unknown id or a game of another
site, which the API answers alike with an empty fixture);
`hoopR_bad_request` for HTTP 400 / 422 or an argument that cannot be
mapped (an ambiguous END year, `season` with `season_id`);
`hoopR_asset_fetch` for any other failed fetch, an error / stub body, or
a body that belongs to another site, type, season, game, player or team
than the one asked for.

## See also

Other Atrium:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md),
[`atrium_standings_summary()`](https://hoopR.sportsdataverse.org/reference/atrium_standings_summary.md),
[`atrium_team()`](https://hoopR.sportsdataverse.org/reference/atrium_team.md),
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md),
[`nbl1_competition`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md)

## Examples

``` r
# \donttest{
  try(atrium_fixtures(website_id = 14))
#> ── Atrium fixtures from embed-api.eui.connect.sportradar.com ───────────────────
#> ℹ Data updated: 2026-10-18 15:33:32 UTC
#> # A tibble: 8 × 40
#>   website_id season_id           competition_id competition_name season_end_year
#>        <int> <chr>               <chr>          <chr>                      <int>
#> 1         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 2         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 3         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 4         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 5         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 6         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 7         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 8         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> # ℹ 35 more variables: fixture_id <chr>, fixture_type <chr>, name <chr>,
#> #   round <chr>, round_code <chr>, pool <chr>, series <chr>, stage_code <chr>,
#> #   status <chr>, status_label <chr>, start_time_utc <dttm>,
#> #   start_time_local <chr>, timezone <chr>, times_unconfirmed <lgl>,
#> #   venue <chr>, venue_id <chr>, attendance <int>, home_entity_id <chr>,
#> #   home_code <chr>, home_name <chr>, home_score <int>,
#> #   home_result_place <int>, home_result_status <chr>, home_draw <lgl>, …
# }
```
