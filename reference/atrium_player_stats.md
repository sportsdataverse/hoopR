# **Atrium Player Stats (season, long form)**

**Player season statistics in long form (one row per player, table and
statistic); ids decoded from the widget links.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_persons`

Each body holds several tables (`averages`, `shootingstatistics`,
`totals`, ...) whose statistic set the site configures. `stat_key`
(`pointsPerGame`) carries its numeric `value` or, for ISO durations,
`value_text`; pivot on `stat_key` for a wide table. Percentages are
0-100.

## Usage

``` r
atrium_player_stats(
  website_id,
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

A `hoopR_data` tibble with one row per (`table_key`, `person_id`,
`stat_key`). Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "atrium_player_stats")`) and in the
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
  # Interactive only: several stat tables of a whole competition, 2-6 s.
  try(atrium_player_stats(
    website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
  ))
#> ── Atrium player stats from embed-api.eui.connect.sportradar.com ───────────────
#> ℹ Data updated: 2026-11-13 12:48:30 UTC
#> # A tibble: 10,212 × 13
#>    website_id season_id    table_key table_label person_id person_name entity_id
#>         <int> <chr>        <chr>     <chr>       <chr>     <chr>       <chr>    
#>  1         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  2         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  3         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  4         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  5         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  6         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  7         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  8         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#>  9         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#> 10         12 df310a05-51… averages  Moyennes    01173036… Ismael Bako NA       
#> # ℹ 10,202 more rows
#> # ℹ 6 more variables: entity_name <chr>, stat_key <chr>, stat_name <chr>,
#> #   stat_label <chr>, value <dbl>, value_text <chr>
# }
```
