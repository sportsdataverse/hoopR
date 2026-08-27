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
#> ✖ 2026-08-27 17:47:52.203847: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:53.314685: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:53.956787: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:54.159266: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:54.315819: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:54.693681: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:54.919866: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:55.138044: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:55.32928: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:55.532326: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:55.853895: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:56.183388: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:56.3837: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:56.765168: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:57.079835: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:57.302235: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:57.468107: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:57.628766: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:57.86217: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:58.053154: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:58.3059: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:58.558659: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:58.901106: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:59.221211: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:59.496324: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:59.741976: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:47:59.93802: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-27 17:48:00.14577: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:48:00 UTC
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
