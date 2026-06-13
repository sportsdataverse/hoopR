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
#> ✖ 2026-06-13 04:20:34.483273: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:37.149963: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:38.223274: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:38.396889: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:39.044268: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:39.393801: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:40.041467: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:40.438403: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:40.853459: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:41.251674: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:41.621227: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:42.16381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:42.654638: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:43.111045: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:43.563268: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:44.036583: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:44.397452: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:44.803629: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:45.181916: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:45.573382: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:45.909999: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:46.221994: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:46.559845: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:46.862227: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:47.213107: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:47.631292: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:48.010436: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:48.326978: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 04:20:48.66428: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:20:48 UTC
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
