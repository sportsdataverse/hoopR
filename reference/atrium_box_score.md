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

A `hoopR_data` tibble with one row per (`fixture_id`, `person_id`). Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "atrium_box_score")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

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
#> ℹ Data updated: 2026-11-10 01:58:15 UTC
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
