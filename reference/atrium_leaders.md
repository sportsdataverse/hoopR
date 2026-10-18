# **Atrium Leaders**

**Season leaders per statistic (top 5 each), with their player and team
ids.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_leaders`

`rank` is the 1-based position within the statistic. `value` is numeric;
a duration statistic (`minutesPerGame`) lands in `value_text` as an ISO
string.

## Usage

``` r
atrium_leaders(
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

A `hoopR_data` tibble, one row per `(season_id, stat_key, rank)`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID of the leaders. |
| stat_key | character | Statistic the leader is ranked in (points, pointsPerGame, efficiency, doubleDouble, ...). |
| stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
| stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
| rank | integer | Position of the leader within the statistic, 1-based (the API lists the top 5). |
| entity_id | character | Team UUID of the leader's team. |
| entity_name | character | Name of the leader's team. |
| person_id | character | Player UUID of the leader. |
| person_name | character | Name of the leader. |
| value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
| value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |

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
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
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
  try(atrium_leaders(
    website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
  ))
#> ── Atrium leaders from embed-api.eui.connect.sportradar.com ────────────────────
#> ℹ Data updated: 2026-10-18 15:33:38 UTC
#> # A tibble: 45 × 12
#>    website_id season_id            stat_key stat_name stat_label  rank entity_id
#>         <int> <chr>                <chr>    <chr>     <chr>      <int> <chr>    
#>  1         12 df310a05-51ad-11f0-… points   PTS       Points         1 da0b634d…
#>  2         12 df310a05-51ad-11f0-… points   PTS       Points         2 f43b1b0f…
#>  3         12 df310a05-51ad-11f0-… points   PTS       Points         3 238ad480…
#>  4         12 df310a05-51ad-11f0-… points   PTS       Points         4 88bff512…
#>  5         12 df310a05-51ad-11f0-… points   PTS       Points         5 7e9f3d8d…
#>  6         12 df310a05-51ad-11f0-… pointsP… PTS       Points pa…     1 f43b1b0f…
#>  7         12 df310a05-51ad-11f0-… pointsP… PTS       Points pa…     2 da0b634d…
#>  8         12 df310a05-51ad-11f0-… pointsP… PTS       Points pa…     3 88bff512…
#>  9         12 df310a05-51ad-11f0-… pointsP… PTS       Points pa…     4 e796c4fa…
#> 10         12 df310a05-51ad-11f0-… pointsP… PTS       Points pa…     5 736b73ae…
#> # ℹ 35 more rows
#> # ℹ 5 more variables: entity_name <chr>, person_id <chr>, person_name <chr>,
#> #   value <dbl>, value_text <chr>
# }
```
