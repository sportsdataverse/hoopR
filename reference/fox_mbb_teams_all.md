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
#> ✖ 2026-09-27 05:27:16.478696: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:30.135881: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:34.438194: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:34.615229: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:34.781579: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:36.006917: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:36.526873: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:36.696552: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:36.873816: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:37.047055: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:37.214859: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:37.382739: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:37.736052: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:37.91888: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:38.242692: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:38.418587: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:38.590319: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:38.763522: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:38.939899: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:39.315207: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:39.64504: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:39.713938: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:39.883333: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:40.212108: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:40.38195: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:40.574517: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:40.901207: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 05:27:41.06968: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-27 05:27:41 UTC
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
