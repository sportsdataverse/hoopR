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
#> ✖ 2026-06-12 14:40:39.150727: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:41.402209: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:41.91494: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:42.119189: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:42.490348: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:42.747714: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:43.175745: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:43.372374: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:43.727137: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:44.105967: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:44.321617: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:44.686287: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:44.852393: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:45.171233: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:45.339733: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:45.506655: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:45.656447: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:45.837285: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:46.003217: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:46.403009: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:46.741579: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:46.893545: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:47.22169: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:47.570235: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:47.762795: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:48.110056: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:48.280969: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:48.633973: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 14:40:48.978124: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 14:40:48 UTC
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
