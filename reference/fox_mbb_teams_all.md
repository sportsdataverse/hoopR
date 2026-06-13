# **Get the full Fox Sports men's college basketball team directory**

**Enumerate every MBB team in the Fox Sports (Bifrost) directory.** A
single
[`fox_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md)
call only returns the seed team's conference, so this walks unseen team
ids (one seed per conference) and unions the results.

## Usage

``` r
fox_mbb_teams_all(max_id = 500, max_calls = 60)
```

## Arguments

- max_id:

  Highest Fox team id to probe as a seed (default `500`).

- max_calls:

  Safety cap on the number of standings calls (default `60`).

## Value

A `hoopR_data` tibble, one row per team: `fox_team_id`, `fox_team_name`,
`fox_section`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md)

## Examples

``` r
# \donttest{
  try(fox_mbb_teams_all())
#> ✖ 2026-06-13 03:06:43.322144: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:44.190006: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:44.568778: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:44.719663: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:44.952767: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:45.295185: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:46.070558: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:46.279563: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:47.136806: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:47.378418: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:47.541999: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:47.732918: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:48.029091: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:48.230479: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:48.421996: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:49.364028: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:49.524679: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:49.713698: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:49.866933: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:50.021303: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:50.207308: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:50.391879: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:50.564465: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:50.807869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:51.692003: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:51.878784: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:52.338471: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:53.239945: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 03:06:53.420987: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:06:53 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 236         Navy Midshipmen            Patriot League
#>  2 232         Colgate Raiders            Patriot League
#>  3 235         Lehigh Mountain Hawks      Patriot League
#>  4 1           Boston University Terriers Patriot League
#>  5 104         American Eagles            Patriot League
#>  6 150         Loyola Maryland Greyhounds Patriot League
#>  7 234         Lafayette Leopards         Patriot League
#>  8 231         Bucknell Bison             Patriot League
#>  9 230         Army Black Knights         Patriot League
#> 10 233         Holy Cross Crusaders       Patriot League
#> # ℹ 355 more rows
# }
```
