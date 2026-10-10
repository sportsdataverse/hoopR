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
#> ✖ 2026-10-10 23:07:53.909051: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:08.016855: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:13.720385: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:13.9764: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:14.2063: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:16.083264: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:17.956523: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:18.366343: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:18.556008: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:18.74003: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:19.15747: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:19.398428: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:19.698509: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:20.020566: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:20.378984: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:20.684327: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:21.014733: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:21.336866: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:21.647661: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:21.96568: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:22.408076: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:22.736009: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:23.037169: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:23.462687: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:23.779696: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:24.306076: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:24.959426: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-10 23:08:25.140615: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-10 23:08:25 UTC
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
