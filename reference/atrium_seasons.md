# **Atrium Seasons**

**Every season (competition and year) a site lists, with the sdv END
year of each.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures`

A season is one competition in one year. `year` is the site's own key
(START year on site 12, calendar year elsewhere); `season_end_year` is
the sdv END year. Site 236 lists no seasons, so its frame is empty.

## Usage

``` r
atrium_seasons(website_id, locale = NULL)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row per `season_id`; `is_default_season`
marks the season the site serves by default:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| season_id | character | Season UUID; pass it as season_id to any season-scoped wrapper. |
| competition_id | character | Competition UUID; pass it as competition_id to pick one of several seasons of an END year. |
| competition_name | character | Competition name in the site's language; the same name can appear for several years. |
| season_name | character | Season name in the site's language, e.g. Betclic ELITE 2025. |
| abbreviation_local | character | Local abbreviation of the season; null in every body seen. |
| year | integer | The site's own year of the season: the START year on LNB (site 12), the calendar year elsewhere. |
| season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
| is_default_season | logical | True for the season the body is about (the site's default when none was asked). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

## See also

Other Atrium Functions:
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
  try(atrium_seasons(website_id = 12))
#> ── Atrium seasons from embed-api.eui.connect.sportradar.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:38:07 UTC
#> # A tibble: 19 × 9
#>    website_id season_id              competition_id competition_name season_name
#>         <int> <chr>                  <chr>          <chr>            <chr>      
#>  1         12 4a877e1f-51d1-11f0-a8… 2c58cdf2-51d1… All Star Game    All Star G…
#>  2         12 d72d56a8-51d3-11f0-94… b98931f7-51d3… Betclic ÉLITE -… Betclic ÉL…
#>  3         12 df310a05-51ad-11f0-bd… 3f4064bb-51ad… Betclic ÉLITE    Betclic ÉL…
#>  4         12 c8514e7e-51ae-11f0-94… a355be55-51ae… Espoirs ÉLITE    Espoirs EL…
#>  5         12 3bfda51f-51ad-11f0-84… 28940adf-51ad… Supercoupe       SuperCoupe…
#>  6         12 d9c62b61-51d1-11f0-88… c4021a1f-51d1… Young Star Game  Young Star…
#>  7         12 5e31a852-51ae-11f0-b5… 4c27df72-51ae… ÉLITE 2          ÉLITE 2 20…
#>  8         12 57b5b7b0-2fd7-11ef-93… 35901fb4-2fd7… All Star Game    All Star G…
#>  9         12 8d12d86f-6545-11ef-8c… 27a79741-597b… Betclic ÉLITE -… Betclic ÉL…
#> 10         12 d2dd2541-5978-11ef-81… b5c596e1-5978… Betclic ÉLITE -… Betclic ÉL…
#> 11         12 cab2f926-2fab-11ef-8b… a2262b45-2fab… Betclic ÉLITE    Betclic ÉL…
#> 12         12 c68a19df-2fb4-11ef-bf… ac2bc8df-2fb4… Espoirs ELITE    Espoirs EL…
#> 13         12 e1ffce27-6544-11ef-8b… 4e83de5b-597c… Espoirs PROB - … Espoirs PR…
#> 14         12 702b8520-2fb5-11ef-8f… 59512848-2fb5… Espoirs PROB     Espoirs PR…
#> 15         12 add3f98b-5977-11ef-91… 932b5919-5977… Leaders Cup      Leaders Cu…
#> 16         12 79e39e0e-5978-11ef-95… 405cf027-5978… Leaders Cup PROB Leaders Cu…
#> 17         12 91334b18-2fb3-11ef-be… 0847055c-2fb3… PROB             PROB 2024  
#> 18         12 418ecaae-19af-11ee-a5… 2cd1ec93-19af… Betclic ÉLITE    Betclic ÉL…
#> 19         12 7561dbee-19b5-11ee-af… 213e021f-19b5… PROB             PROB 2023  
#> # ℹ 4 more variables: abbreviation_local <chr>, year <int>,
#> #   season_end_year <int>, is_default_season <lgl>
# }
```
