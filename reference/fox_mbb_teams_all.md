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
#> ✖ 2026-06-12 23:28:51.447772: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:52.688184: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:53.336975: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:53.601195: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:53.987796: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:54.186622: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:54.535463: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:54.908319: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:55.228489: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:55.605582: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:56.092587: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:56.350308: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:56.883956: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:57.225865: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:57.674489: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:57.852481: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:58.19494: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:58.905119: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:59.273441: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:59.584372: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:28:59.968206: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:00.330276: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:00.807216: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:01.136233: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:01.56479: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:01.895955: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:02.286084: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:02.617813: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:29:02.794824: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 23:29:02 UTC
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
