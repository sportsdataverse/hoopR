# **Atrium Shots**

**One game's 2pt / 3pt attempts with their court location (percent of
the court) and result.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=shot_chart`

The shot chart holds field-goal attempts only (no free throws);
`event_id` joins the same event in
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md).
`x` / `y` are percent of the court (0-100, origin at a corner, x along
the 28 m length). LNBP and NBL1 clamp rim attempts to x = 5 / 95.

## Usage

``` r
atrium_shots(website_id, fixture_id, locale = NULL)
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

A `hoopR_data` tibble, one row per shot (`event_id`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| sequence | integer | 1-based position of the shot among the shots of the game (not the pbp sequence). |
| event_id | character | Event UUID of the shot; the same event in atrium_pbp. |
| period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
| clock | character | Time REMAINING in the period as an ISO 8601 duration (PT10M0S at the start). |
| clock_seconds | integer | Seconds remaining in the period, parsed from clock. |
| entity_id | character | Team UUID the event is credited to. |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| person_id | character | Player UUID of the shooter. |
| person_name | character | Name of the shooter. |
| bib | character | Jersey number of the player, as text; null for team events. |
| event_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, ... (language-independent). |
| event_sub_type | character | Event detail: jumpShot, layup, offensive, defensive, in, out, 1Of2, personal, ...; null when none. |
| description | character | The event's text in the site's language (e.g. Entre-deux remporte). |
| success | logical | True when the shot was made, false when missed. |
| success_label | character | The made / missed label in the site's language; sent on shot events only. |
| x | double | Shot location along the 28 m court length as percent of the court (0-100, origin at a corner); the home team attacks the low-x basket all game; LNBP and NBL1 clamp rim attempts to 5 / 95. |
| y | double | Shot location across the 15 m width as percent of the court (0-100); which sideline is 0 is unverified. |
| home_score | integer | Home team's running score after the event. |
| away_score | integer | Away team's running score after the event. |

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
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
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
  try(atrium_shots(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#> ── Atrium shots from embed-api.eui.connect.sportradar.com ── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:33:55 UTC
#> # A tibble: 129 × 22
#>    website_id fixture_id             season_id sequence event_id period_id clock
#>         <int> <chr>                  <chr>        <int> <chr>        <int> <chr>
#>  1         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        1 e248021…         1 PT9M…
#>  2         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        2 f27a476…         1 PT9M…
#>  3         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        3 f7e2b57…         1 PT9M…
#>  4         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        4 01cc3ed…         1 PT8M…
#>  5         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        5 70c7801…         1 PT5M…
#>  6         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        6 7fc9d0e…         1 PT5M…
#>  7         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        7 9fc5126…         1 PT4M…
#>  8         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        8 b9fbbc1…         1 PT4M…
#>  9         14 0dc631bd-c34c-11f1-8d… cc7d79f3…        9 ccd2e2a…         1 PT4M…
#> 10         14 0dc631bd-c34c-11f1-8d… cc7d79f3…       10 d8f1747…         1 PT4M…
#> # ℹ 119 more rows
#> # ℹ 15 more variables: clock_seconds <int>, entity_id <chr>, side <chr>,
#> #   person_id <chr>, person_name <chr>, bib <chr>, event_type <chr>,
#> #   event_sub_type <chr>, description <chr>, success <lgl>,
#> #   success_label <chr>, x <dbl>, y <dbl>, home_score <int>, away_score <int>
# }
```
