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
#> ✖ 2026-10-18 17:23:33.092: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:45.66011: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:50.528085: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:50.947502: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:51.48135: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:52.26891: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:53.217057: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:53.676215: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.037128: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.232331: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.475395: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.562579: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.845386: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:54.935016: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:55.159381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:55.548732: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:55.656321: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:55.842045: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:56.068424: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:56.274508: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:57.00134: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:57.230251: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:57.453529: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:57.7118: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:57.912923: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:58.736633: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:58.834609: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 17:23:58.925242: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:23:58 UTC
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
