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
#> ✖ 2026-11-03 19:53:05.323254: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:08.755296: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:10.189003: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:10.275389: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:10.36376: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:10.717544: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.465693: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.551569: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.673374: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.780777: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.8709: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:11.951128: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.058594: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.168227: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.275775: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.380772: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.467081: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.568841: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.880451: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:12.96524: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.06248: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.156074: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.238955: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.371182: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.483225: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.576624: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.685381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 19:53:13.771436: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-03 19:53:13 UTC
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
