# **Atrium Fixture Periods**

**One game's periods with the points each team scored in each, overtime
periods included (ids 11+).**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`

`home_points` / `away_points` are the points scored IN that period, not
the running score. Overtime periods are `period_id` 11, 12, ... (not 5).

## Usage

``` r
atrium_fixture_periods(website_id, fixture_id, locale = NULL)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- fixture_id:

  (*character* required): Game UUID (`fixture_id` in
  [`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md)),
  e.g. `"0dc631bd-c34c-11f1-8d16-4d5a21afb79d"`.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row per `(fixture_id, period_id)`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
| label | character | Short period label in the site's language (Q1, P1), as sent. |
| is_overtime | logical | True for an overtime period. |
| is_shootout | logical | True for a shootout period. |
| started | logical | True once the period has started. |
| ended | logical | True once the period has ended. |
| duration_minutes | integer | Length of the period in minutes. |
| elapsed_minutes_before_period | integer | Minutes of game time played before the period starts (40 for the first overtime). |
| home_entity_id | character | Team UUID of the home team, from the fixture's isHome flag. |
| away_entity_id | character | Team UUID of the away team, from the fixture's isHome flag. |
| home_points | integer | Points the home team scored in this period (not the running score). |
| away_points | integer | Points the away team scored in this period (not the running score). |

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
  try(atrium_fixture_periods(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#> ── Atrium fixture periods from embed-api.eui.connect.sportradar.com ────────────
#> ℹ Data updated: 2026-10-18 15:33:31 UTC
#> # A tibble: 4 × 15
#>   website_id fixture_id        season_id period_id label is_overtime is_shootout
#>        <int> <chr>             <chr>         <int> <chr> <lgl>       <lgl>      
#> 1         14 0dc631bd-c34c-11… cc7d79f3…         1 P1    FALSE       FALSE      
#> 2         14 0dc631bd-c34c-11… cc7d79f3…         2 P2    FALSE       FALSE      
#> 3         14 0dc631bd-c34c-11… cc7d79f3…         3 P3    FALSE       FALSE      
#> 4         14 0dc631bd-c34c-11… cc7d79f3…         4 P4    FALSE       FALSE      
#> # ℹ 8 more variables: started <lgl>, ended <lgl>, duration_minutes <int>,
#> #   elapsed_minutes_before_period <int>, home_entity_id <chr>,
#> #   away_entity_id <chr>, home_points <int>, away_points <int>
# }
```
