# **Atrium Team Page**

**A team page (summary tab): the team and its last and next game.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/entity_detail`

`previous_*` is the last played game and `next_*` the next scheduled one
(`NA` when the page shows none). `entity_id` is decoded from the page's
tab links; `color` is a hex string with its `#`.

## Usage

``` r
atrium_team(
  website_id,
  entity_id,
  season = NULL,
  season_id = NULL,
  competition_id = NULL,
  locale = NULL
)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- entity_id:

  (*character* required): Team UUID (`entity_id` in
  [`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md)
  or any fixture row), e.g. `"f43b1b0f-55bc-11f0-84d9-01499d2f0a07"`.

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

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row for the team:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| entity_id | character | Team UUID, decoded from the page's tab links (the body does not echo it elsewhere). |
| name | character | Team name from the page banner. |
| color | character | Team colour from the banner, hex string with its \#. |
| logo_url | character | URL of the banner's team logo. |
| previous_fixture_id | character | Game UUID of the last played game shown on the team page. |
| previous_round | character | Round of the last played game as the site words it (e.g. 30). |
| previous_status | character | Status code of the last played game, e.g. CONFIRMED. |
| previous_start_time_utc | POSIXct | Start of the last played game, naive UTC datetime. |
| previous_start_time_local | character | Start of the last played game in venue-local time, as the API sends it (no offset). |
| previous_venue | character | Arena of the last played game. |
| previous_attendance | integer | Spectators at the last played game; null when not reported. |
| previous_home_entity_id | character | Team UUID of the last played game's home team. |
| previous_home_name | character | Name of the last played game's home team. |
| previous_home_score | integer | Home team's points in the last played game. |
| previous_away_entity_id | character | Team UUID of the last played game's away team. |
| previous_away_name | character | Name of the last played game's away team. |
| previous_away_score | integer | Away team's points in the last played game. |
| next_fixture_id | character | Game UUID of the next scheduled game shown on the team page. |
| next_round | character | Round of the next scheduled game as the site words it (e.g. 30). |
| next_status | character | Status code of the next scheduled game, e.g. CONFIRMED. |
| next_start_time_utc | POSIXct | Start of the next scheduled game, naive UTC datetime. |
| next_start_time_local | character | Start of the next scheduled game in venue-local time, as the API sends it (no offset). |
| next_venue | character | Arena of the next scheduled game. |
| next_attendance | integer | Spectators at the next scheduled game; null when not reported. |
| next_home_entity_id | character | Team UUID of the next scheduled game's home team. |
| next_home_name | character | Name of the next scheduled game's home team. |
| next_home_score | integer | Home team's points in the next scheduled game. |
| next_away_entity_id | character | Team UUID of the next scheduled game's away team. |
| next_away_name | character | Name of the next scheduled game's away team. |
| next_away_score | integer | Away team's points in the next scheduled game. |

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

     atrium_team(website_id = 12, entity_id = "f43b1b0f-55bc-11f0-84d9-01499d2f0a07")

## See also

Other Atrium:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
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
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md),
[`nbl1_competition`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md)
