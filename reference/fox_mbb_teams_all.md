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
#> ✖ 2026-11-06 07:20:56.390599: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:47.305849: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:52.274963: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:52.45199: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:52.563106: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:53.099562: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:54.560214: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:54.703398: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:54.799572: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:54.938957: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.06473: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.222578: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.386383: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.48313: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.623246: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.730508: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:55.873314: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:56.016874: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:56.175722: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:56.284659: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:56.380931: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:56.9537: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.08681: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.185009: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.28149: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.419911: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.516787: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-06 07:21:57.716919: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-06 07:21:57 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 230         Army Black Knights         Patriot League
#>  3 234         Lafayette Leopards         Patriot League
#>  4 235         Lehigh Mountain Hawks      Patriot League
#>  5 236         Navy Midshipmen            Patriot League
#>  6 104         American Eagles            Patriot League
#>  7 231         Bucknell Bison             Patriot League
#>  8 232         Colgate Raiders            Patriot League
#>  9 233         Holy Cross Crusaders       Patriot League
#> 10 150         Loyola Maryland Greyhounds Patriot League
#> # ℹ 355 more rows
# }
```
