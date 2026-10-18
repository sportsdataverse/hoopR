# **Atrium Player Game Log**

**A player's game log: one row per game with the opponent, result and
the statistics the site shows.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/person_detail?sub=log`

`score` is the site's text (`"88 - 91"`); which side is listed first is
unverified, so it is not split. `date` is the local start time (no
offset). The log carries no fixture id: join on date and opponent.

## Usage

``` r
atrium_player_game_log(
  website_id,
  person_id,
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

- person_id:

  (*character* required): Player UUID (`person_id` in
  [`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md)
  or a box score), e.g. `"4458f165-f865-11f0-8ebf-539c931c1654"`.

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

A `hoopR_data` tibble, one row per game:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| person_id | character | Player UUID (person), shared across seasons and sites. |
| season_id | character | Season UUID the log is for (the season asked, else the site's default). |
| date | character | Local start of the game as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; the zone is not given): the field the ribbon's start_time_local reads. |
| opponent_entity_id | character | Team UUID of the opponent. |
| opponent_name | character | Name of the opponent. |
| result | character | Result for the player's team: W or L. |
| result_label | character | Result label in the site's language (V, D). |
| score | character | Final score as the site's text (e.g. 88 - 91); which side is listed first is unverified, so it is not split. |
| minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (player, that game). |
| seconds_played | integer | Time played in whole seconds, parsed from minutes (player, that game). |
| points | integer | Points scored (player, that game). |
| rebounds | integer | Total rebounds (player, that game). |
| rebounds_offensive | integer | Offensive rebounds (player, that game). |
| rebounds_defensive | integer | Defensive rebounds (player, that game). |
| assists | integer | Assists (player, that game). |
| steals | integer | Steals (player, that game). |
| blocks | integer | Shots blocked (player, that game). |
| blocks_received | integer | Own shots blocked by an opponent (LNB only) (player, that game). |
| turnovers | integer | Turnovers (player, that game). |
| fouls_total | integer | Fouls committed (player, that game). |
| fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (player, that game). |
| plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (player, that game). |
| efficiency | integer | Efficiency rating, from the site's own formula (player, that game). |
| field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (player, that game). |
| field_goals_attempted | integer | Field goals attempted (LNBP only) (player, that game). |
| field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (player, that game). |
| points_two_made | integer | Two-point field goals made (player, that game). |
| points_two_attempted | integer | Two-point field goals attempted (player, that game). |
| points_two_percentage | double | Two-point percentage, 0-100 (player, that game). |
| points_three_made | integer | Three-point field goals made (player, that game). |
| points_three_attempted | integer | Three-point field goals attempted (player, that game). |
| points_three_percentage | double | Three-point percentage, 0-100 (player, that game). |
| free_throws_made | integer | Free throws made (player, that game). |
| free_throws_attempted | integer | Free throws attempted (player, that game). |
| free_throws_percentage | double | Free-throw percentage, 0-100 (player, that game). |
| points_fast_break | integer | Fast-break points (LNBP only) (player, that game). |
| dunks | integer | Dunks (player, that game). |
| fouls_personal | integer | Personal fouls (player, that game). |

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
  try(atrium_player_game_log(website_id = 12, person_id = "4458f165-f865-11f0-8ebf-539c931c1654"))
#> ── Atrium player game log from embed-api.eui.connect.sportradar.com ────────────
#> ℹ Data updated: 2026-10-18 15:33:43 UTC
#> # A tibble: 14 × 39
#>    website_id person_id  season_id date  opponent_entity_id opponent_name result
#>         <int> <chr>      <chr>     <chr> <chr>              <chr>         <chr> 
#>  1         12 4458f165-… df310a05… 2026… 7e9f3d8d-55bb-11f… Le Mans       W     
#>  2         12 4458f165-… df310a05… 2026… 238ad480-55b8-11f… Dijon         L     
#>  3         12 4458f165-… df310a05… 2026… e796c4fa-55bc-11f… Nanterre      L     
#>  4         12 4458f165-… df310a05… 2026… da0b634d-55bc-11f… Nancy         W     
#>  5         12 4458f165-… df310a05… 2026… 703aa4cc-55b7-11f… Bourg-en-Bre… W     
#>  6         12 4458f165-… df310a05… 2026… c3b5d870-55b5-11f… Boulazac      L     
#>  7         12 4458f165-… df310a05… 2026… ca771ea2-55bb-11f… Limoges       W     
#>  8         12 4458f165-… df310a05… 2026… c281453b-55b7-11f… Cholet        L     
#>  9         12 4458f165-… df310a05… 2026… 989c44aa-55b7-11f… Chalon/Saône  W     
#> 10         12 4458f165-… df310a05… 2026… 689d1a0a-55bd-11f… Saint-Quentin W     
#> 11         12 4458f165-… df310a05… 2026… 736b73ae-55bc-11f… Monaco        W     
#> 12         12 4458f165-… df310a05… 2026… 506c2d71-55bb-11f… Gravelines-D… W     
#> 13         12 4458f165-… df310a05… 2026… 88bff512-55bd-11f… Strasbourg    W     
#> 14         12 4458f165-… df310a05… 2026… f43b1b0f-55bc-11f… Paris         L     
#> # ℹ 32 more variables: result_label <chr>, score <chr>, minutes <chr>,
#> #   seconds_played <int>, points <int>, rebounds <int>,
#> #   rebounds_offensive <int>, rebounds_defensive <int>, assists <int>,
#> #   steals <int>, blocks <int>, blocks_received <int>, turnovers <int>,
#> #   fouls_total <int>, fouls_drawn <int>, plus_minus <int>, efficiency <int>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, points_two_made <int>, …
# }
```
