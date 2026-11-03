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
#> ✖ 2026-11-03 10:55:48.818501: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:51.594652: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:52.549748: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:52.585134: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:52.619896: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:52.954263: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.133066: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.189663: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.282771: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.350132: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.422859: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.50242: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.559193: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.62477: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.692299: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.765087: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.83336: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.901416: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:53.968641: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.042233: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.110106: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.150602: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.216752: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.307224: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.344732: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.416483: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.473474: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 10:55:54.541055: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-03 10:55:54 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 233         Holy Cross Crusaders       Patriot League
#>  3 104         American Eagles            Patriot League
#>  4 230         Army Black Knights         Patriot League
#>  5 231         Bucknell Bison             Patriot League
#>  6 232         Colgate Raiders            Patriot League
#>  7 234         Lafayette Leopards         Patriot League
#>  8 235         Lehigh Mountain Hawks      Patriot League
#>  9 150         Loyola Maryland Greyhounds Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
