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
#> ✖ 2026-08-24 20:40:40.912591: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:42.080586: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:42.661383: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:42.870194: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:43.314414: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:43.815034: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:44.049604: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:44.401111: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:44.585885: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:44.799731: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:45.003898: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:45.174865: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:45.418449: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:45.630629: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:45.818064: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:46.009381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:46.37788: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:46.592162: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:46.819868: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:47.055872: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:47.32967: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:47.674125: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:47.852633: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:48.032: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:48.226093: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:48.437644: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:48.828217: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:40:49.003511: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:49 UTC
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
