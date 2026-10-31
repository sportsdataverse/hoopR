# **Atrium Fixtures Ribbon**

**The fixtures ribbon: recent and upcoming games across the site's
competitions (empty on LNB off-season).**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures_ribbon`

Its scores are integers; `start_time_local` is the ribbon's
`fixture.date` (a local time, no offset; unverified).

## Usage

``` r
atrium_fixtures_ribbon(
  website_id,
  season = NULL,
  season_id = NULL,
  competition_id = NULL,
  entity_id = NULL,
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
| season_id | character | Season UUID of the game. |
| season_name | character | Name of the season / competition the game belongs to. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
| stage_name | character | Name of the stage; null in every body seen. |
| status | character | Status code of the game, e.g. CONFIRMED. |
| status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
| is_final | logical | True when the game is over. |
| is_live | logical | True while the game is being played. |
| times_unconfirmed | logical | True while the start time is not final. |
| start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
| start_time_local | character | The ribbon's fixture date as the API sends it: a local wall-clock time (no offset; the zone is not given). |
| home_entity_id | character | Team UUID of the home team. |
| home_name | character | Name of the home team. |
| home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
| home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
| home_is_leading | logical | True while the home team leads (ribbon rows). |
| away_entity_id | character | Team UUID of the away team. |
| away_name | character | Name of the away team. |
| away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
| away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
| away_is_leading | logical | True while the away team leads (ribbon rows). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

     atrium_fixtures_ribbon(website_id = 14)

## See also

Other Atrium Functions:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
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
