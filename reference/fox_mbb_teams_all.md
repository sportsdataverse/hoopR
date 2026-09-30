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
#> ✖ 2026-09-30 15:05:25.620188: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:40.516452: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:46.268368: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:46.502726: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:46.949054: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:48.926287: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:50.641908: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:50.974351: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:51.333143: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:51.658129: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:52.099075: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:52.377706: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:52.715758: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:53.036594: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:53.364581: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:53.883317: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:54.294371: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:54.865622: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:55.385471: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:55.740538: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:56.031551: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:56.395614: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:56.686057: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:57.123912: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:57.430879: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:57.765127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:58.084292: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 15:05:58.378313: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-30 15:05:58 UTC
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
