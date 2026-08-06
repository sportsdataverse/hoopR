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
#> ✖ 2026-08-06 04:00:22.619388: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:26.481088: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:28.02841: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:28.211728: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:28.407364: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:29.084598: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:29.621888: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:29.837699: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:30.021479: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:30.189492: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:30.585025: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:30.741839: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:30.903744: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:31.065245: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:31.223792: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:31.624476: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:31.809268: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.002636: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.17601: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.358651: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.542411: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.842486: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:32.995655: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:33.199191: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:33.368477: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:33.727133: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:34.189936: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-06 04:00:34.346608: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 04:00:34 UTC
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
