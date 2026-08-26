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
#> ✖ 2026-08-26 19:55:35.464789: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:36.457637: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:36.916204: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:37.089347: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:37.416334: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:37.739626: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:38.049397: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:38.257888: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:38.893867: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:39.049941: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:39.206203: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:39.49439: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:39.701924: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:39.866577: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:40.24951: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:40.447598: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:40.623015: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:40.989976: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:41.246037: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:41.481612: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:41.660763: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:41.882481: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:42.057778: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:42.238511: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:42.527997: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:42.758074: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:42.926434: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-26 19:55:43.283614: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:55:43 UTC
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
