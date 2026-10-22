# **Atrium Player Box Score**

**One game's box score: one row per rostered player with the statistics
the site configures.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`

A player who did not play has `participated` `FALSE` and `NA`
statistics. LNB has `blocks_received` and `plus_minus` but no field-goal
totals; LNBP the reverse. `minutes` is the ISO duration as sent and
`seconds_played` its value. Percentages are 0-100. `side` is `home` or
`away`.

## Usage

``` r
atrium_box_score(website_id, fixture_id, locale = NULL)
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

A `hoopR_data` tibble, one row per `(fixture_id, person_id)`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| entity_id | character | Team UUID the player is rostered with for this game. |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| person_id | character | Player UUID (person), shared across seasons and sites. |
| person_name | character | Player name as the site prints it (upper case on LNBP and NBL1). |
| bib | character | Jersey number the player wears, as text. |
| position | character | Position code on the roster (LNB, e.g. PG); null on LNBP. |
| starter | logical | True when the player started the game. |
| active | logical | True when the player is on the court in a live game. |
| participated | logical | True when the player entered the game; false rows have null statistics. |
| did_not_play_reason | character | Reason the player did not play; null in every body seen. |
| minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (player, this game). |
| seconds_played | integer | Time played in whole seconds, parsed from minutes (player, this game). |
| points | integer | Points scored (player, this game). |
| rebounds | integer | Total rebounds (player, this game). |
| rebounds_offensive | integer | Offensive rebounds (player, this game). |
| rebounds_defensive | integer | Defensive rebounds (player, this game). |
| assists | integer | Assists (player, this game). |
| steals | integer | Steals (player, this game). |
| blocks | integer | Shots blocked (player, this game). |
| blocks_received | integer | Own shots blocked by an opponent (LNB only) (player, this game). |
| turnovers | integer | Turnovers (player, this game). |
| fouls_total | integer | Fouls committed (player, this game). |
| fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (player, this game). |
| plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (player, this game). |
| efficiency | integer | Efficiency rating, from the site's own formula (player, this game). |
| field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (player, this game). |
| field_goals_attempted | integer | Field goals attempted (LNBP only) (player, this game). |
| field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (player, this game). |
| points_two_made | integer | Two-point field goals made (player, this game). |
| points_two_attempted | integer | Two-point field goals attempted (player, this game). |
| points_two_percentage | double | Two-point percentage, 0-100 (player, this game). |
| points_three_made | integer | Three-point field goals made (player, this game). |
| points_three_attempted | integer | Three-point field goals attempted (player, this game). |
| points_three_percentage | double | Three-point percentage, 0-100 (player, this game). |
| free_throws_made | integer | Free throws made (player, this game). |
| free_throws_attempted | integer | Free throws attempted (player, this game). |
| free_throws_percentage | double | Free-throw percentage, 0-100 (player, this game). |
| points_fast_break | integer | Fast-break points (LNBP only) (player, this game). |

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

Other Atrium Functions:
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
  try(atrium_box_score(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#> ── Atrium box score from embed-api.eui.connect.sportradar.com ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:34:17 UTC
#> # A tibble: 24 × 41
#>    website_id fixture_id   season_id entity_id side  person_id person_name bib  
#>         <int> <chr>        <chr>     <chr>     <chr> <chr>     <chr>       <chr>
#>  1         14 0dc631bd-c3… cc7d79f3… 6667c530… home  14f9317e… JOSE REYES  5    
#>  2         14 0dc631bd-c3… cc7d79f3… 6667c530… home  2f2d54b0… KAYO GONCA… 33   
#>  3         14 0dc631bd-c3… cc7d79f3… 6667c530… home  6474fd80… DAISHON SM… 1    
#>  4         14 0dc631bd-c3… cc7d79f3… 6667c530… home  680091e4… LUCAS DORIA 7    
#>  5         14 0dc631bd-c3… cc7d79f3… 6667c530… home  7b4ac74b… MARCOS RAM… 99   
#>  6         14 0dc631bd-c3… cc7d79f3… 6667c530… home  8edbc4a7… TAVARIO  M… 0    
#>  7         14 0dc631bd-c3… cc7d79f3… 6667c530… home  9d8134a6… ROMEAO FER… 3    
#>  8         14 0dc631bd-c3… cc7d79f3… 6667c530… home  bff532e1… GABRIEL VA… 23   
#>  9         14 0dc631bd-c3… cc7d79f3… 6667c530… home  ca638b7f… BRYAN RIVE… 18   
#> 10         14 0dc631bd-c3… cc7d79f3… 6667c530… home  cc58457a… ANYELO CIS… 6    
#> # ℹ 14 more rows
#> # ℹ 33 more variables: position <chr>, starter <lgl>, active <lgl>,
#> #   participated <lgl>, did_not_play_reason <chr>, minutes <chr>,
#> #   seconds_played <int>, points <int>, rebounds <int>,
#> #   rebounds_offensive <int>, rebounds_defensive <int>, assists <int>,
#> #   steals <int>, blocks <int>, blocks_received <int>, turnovers <int>,
#> #   fouls_total <int>, fouls_drawn <int>, plus_minus <int>, efficiency <int>, …
# }
```
