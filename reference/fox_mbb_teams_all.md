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
#> ✖ 2026-09-27 03:37:47.929523: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:49.307117: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:49.920933: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:49.980169: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.03769: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.218274: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.477645: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.538125: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.59653: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.656532: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.843664: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.903509: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:50.961691: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.144975: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.209703: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.26986: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.327091: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.506756: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.564783: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.621763: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.678875: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.736645: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.798168: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:51.975163: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:52.033609: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:52.091381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:52.14915: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 03:37:52.209765: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-27 03:37:52 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 232         Colgate Raiders            Patriot League
#>  2 236         Navy Midshipmen            Patriot League
#>  3 150         Loyola Maryland Greyhounds Patriot League
#>  4 1           Boston University Terriers Patriot League
#>  5 104         American Eagles            Patriot League
#>  6 234         Lafayette Leopards         Patriot League
#>  7 235         Lehigh Mountain Hawks      Patriot League
#>  8 230         Army Black Knights         Patriot League
#>  9 233         Holy Cross Crusaders       Patriot League
#> 10 231         Bucknell Bison             Patriot League
#> # ℹ 355 more rows
# }
```
