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
#> ✖ 2026-11-04 10:14:32.80319: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:35.860181: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.072355: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.131604: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.202071: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.429942: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.694761: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.756226: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.820401: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.880882: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:37.944521: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.003889: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.06731: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.140846: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.175419: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.237259: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.300376: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.374668: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.443267: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.507131: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.571542: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.633673: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.690448: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.765545: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.878479: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:38.946992: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:39.00865: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 10:14:39.07285: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-04 10:14:39 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 104         American Eagles            Patriot League
#>  3 230         Army Black Knights         Patriot League
#>  4 231         Bucknell Bison             Patriot League
#>  5 232         Colgate Raiders            Patriot League
#>  6 234         Lafayette Leopards         Patriot League
#>  7 235         Lehigh Mountain Hawks      Patriot League
#>  8 150         Loyola Maryland Greyhounds Patriot League
#>  9 233         Holy Cross Crusaders       Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
