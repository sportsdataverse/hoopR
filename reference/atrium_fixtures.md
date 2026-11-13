# **Atrium Fixtures (schedule and results)**

**Fixtures (schedule and results) of a season, home and away side by
side.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures`

Scores are integers (the API sends strings); `start_time_utc` is a UTC
`POSIXct`; `start_time_local` is the venue's wall-clock time as the API
sends it (character: its zone, `timezone`, varies per row, so no single
`POSIXct` zone fits). sportsdataverse-py keeps both naive.

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

A `hoopR_data` tibble with one row per fixture. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "atrium_fixtures")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

**Unofficial.** This is the public endpoint the Sportradar Atrium /
Synergy "Connect" widget calls from every visitor's browser (keyless;
the host has no robots.txt). The data is Sportradar's and the leagues'.
The wrappers read it on the caller's behalf, one request at least 1 s
after the last to the host. Keep crawls small and incremental.

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

Other Atrium Functions:
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
#> ── Atrium fixtures from embed-api.eui.connect.sportradar.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:48:22 UTC
#> # A tibble: 3 × 40
#>   website_id season_id           competition_id competition_name season_end_year
#>        <int> <chr>               <chr>          <chr>                      <int>
#> 1         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 2         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> 3         14 cc7d79f3-43ee-11f1… 16be8396-24fb… LIGA CALIENTE.M…            2026
#> # ℹ 35 more variables: fixture_id <chr>, fixture_type <chr>, name <chr>,
#> #   round <chr>, round_code <chr>, pool <chr>, series <chr>, stage_code <chr>,
#> #   status <chr>, status_label <chr>, start_time_utc <dttm>,
#> #   start_time_local <chr>, timezone <chr>, times_unconfirmed <lgl>,
#> #   venue <chr>, venue_id <chr>, attendance <int>, home_entity_id <chr>,
#> #   home_code <chr>, home_name <chr>, home_score <int>,
#> #   home_result_place <int>, home_result_status <chr>, home_draw <lgl>, …
# }
```
