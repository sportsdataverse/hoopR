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
#> ✖ 2026-11-03 23:38:03.942517: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:05.797323: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:06.548769: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:06.670869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:06.757133: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:07.317727: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:07.540799: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:07.627233: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:07.762205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:07.988598: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.090444: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.197974: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.312314: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.428234: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.516832: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.670545: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.843399: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:08.961033: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.080029: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.207533: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.324916: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.440293: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.605152: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.722659: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:09.944104: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:10.08848: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:10.173613: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 23:38:10.290886: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-03 23:38:10 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 233         Holy Cross Crusaders       Patriot League
#>  3 104         American Eagles            Patriot League
#>  4 230         Army Black Knights         Patriot League
#>  5 231         Bucknell Bison             Patriot League
#>  6 232         Colgate Raiders            Patriot League
#>  7 234         Lafayette Leopards         Patriot League
#>  8 235         Lehigh Mountain Hawks      Patriot League
#>  9 150         Loyola Maryland Greyhounds Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
