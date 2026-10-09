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
#> ✖ 2026-10-09 05:33:26.016272: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:38.994216: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:44.002416: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:44.170204: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:44.34791: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:45.594419: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:47.118999: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:47.287397: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:47.508878: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:47.690342: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:47.854549: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:48.147914: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:48.456209: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:48.874765: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:49.175095: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:49.477848: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:49.68709: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:50.193366: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:50.509929: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:50.805322: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:51.015549: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:51.311522: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:51.598876: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:51.915957: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:52.185152: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:52.530858: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:52.909586: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 05:33:53.10411: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 05:33:53 UTC
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
