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
#> ✖ 2026-08-25 00:23:56.568: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:12.059226: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:15.649718: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:16.104521: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:16.331007: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:18.04814: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:19.052272: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:19.417661: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:19.818541: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:20.177979: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:20.616626: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:20.985073: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:21.262324: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:21.723995: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:21.974231: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:22.466543: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:22.725783: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:23.120395: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:23.5094: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:23.887244: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:24.40147: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:24.600291: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:25.00369: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:25.533902: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:25.841282: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:27.021398: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:27.211954: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 00:24:28.017572: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:24:28 UTC
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
