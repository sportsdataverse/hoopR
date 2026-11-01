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
#> ✖ 2026-11-01 23:41:15.828197: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:19.785524: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:21.598834: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:21.688689: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:21.755548: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.133785: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.40324: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.50082: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.581326: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.679981: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.762995: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:22.83537: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.10444: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.190253: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.276194: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.386945: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.463226: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.542334: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.637532: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.714933: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.839861: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:23.923156: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.034743: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.196242: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.276613: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.377754: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.458647: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 23:41:24.536044: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:41:24 UTC
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
