# **Atrium Standings**

**Standings of a season, with the columns the site configures (LNB home
/ away splits, LNBP played and points).**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/standings`

`win_percentage` is a 0-1 fraction. `group` is the table's label (empty
for a single table).

## Usage

``` r
atrium_standings(
  website_id,
  season = NULL,
  season_id = NULL,
  competition_id = NULL,
  round_number = NULL,
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

- round_number:

  (*integer* optional): Round (journee) number to show; the pages that
  take it list their rounds.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble with one row per (`season_id`, `group`,
`entity_id`). Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "atrium_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
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
  try(atrium_standings(
    website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
  ))
#> ── Atrium standings from embed-api.eui.connect.sportradar.com ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:10:43 UTC
#> # A tibble: 16 × 28
#>    website_id season_id       season_end_year group position entity_id team_name
#>         <int> <chr>                     <int> <chr>    <int> <chr>     <chr>    
#>  1         12 df310a05-51ad-…            2026 NA           1 f43b1b0f… Paris    
#>  2         12 df310a05-51ad-…            2026 NA           2 e796c4fa… Nanterre 
#>  3         12 df310a05-51ad-…            2026 NA           3 25bcb29d… Lyon-Vil…
#>  4         12 df310a05-51ad-…            2026 NA           4 c281453b… Cholet   
#>  5         12 df310a05-51ad-…            2026 NA           5 7e9f3d8d… Le Mans  
#>  6         12 df310a05-51ad-…            2026 NA           6 703aa4cc… Bourg-en…
#>  7         12 df310a05-51ad-…            2026 NA           7 88bff512… Strasbou…
#>  8         12 df310a05-51ad-…            2026 NA           8 989c44aa… Chalon/S…
#>  9         12 df310a05-51ad-…            2026 NA           9 da0b634d… Nancy    
#> 10         12 df310a05-51ad-…            2026 NA          10 c3b5d870… Boulazac 
#> 11         12 df310a05-51ad-…            2026 NA          11 238ad480… Dijon    
#> 12         12 df310a05-51ad-…            2026 NA          12 ca771ea2… Limoges  
#> 13         12 df310a05-51ad-…            2026 NA          13 689d1a0a… Saint-Qu…
#> 14         12 df310a05-51ad-…            2026 NA          14 506c2d71… Gravelin…
#> 15         12 df310a05-51ad-…            2026 NA          15 736b73ae… Monaco   
#> 16         12 df310a05-51ad-…            2026 NA          16 9ebf8651… Le Portel
#> # ℹ 21 more variables: is_current_team <lgl>, logo_url <chr>, wins <int>,
#> #   losses <int>, played <int>, standing_points <int>, win_percentage <dbl>,
#> #   scored_for <int>, scored_against <int>, point_difference <int>,
#> #   result_string_home <chr>, scored_for_home <int>, scored_against_home <int>,
#> #   point_difference_home <int>, result_string_away <chr>,
#> #   scored_for_away <int>, scored_against_away <int>,
#> #   point_difference_away <int>, streak <int>, streak_home <int>, …
# }
```
