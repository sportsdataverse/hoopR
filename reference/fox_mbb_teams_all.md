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
#> ✖ 2026-09-10 00:50:02.840323: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:04.012924: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:04.712492: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:04.992954: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:05.232972: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:05.478218: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:05.667736: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:05.848205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:06.112125: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:06.258205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:06.497517: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:06.750942: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:06.94446: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:07.125079: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:07.280037: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:07.49112: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:07.695187: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:07.872365: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:08.150502: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:08.316487: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:08.488124: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:08.701677: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:09.012558: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:09.201012: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:09.556377: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:09.910216: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:10.064763: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-10 00:50:10.446116: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-09-10 00:50:10 UTC
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
