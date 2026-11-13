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

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "atrium_shots")`) and in the searchable
[return
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
#> ── Atrium shots from embed-api.eui.connect.sportradar.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:12:51 UTC
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
