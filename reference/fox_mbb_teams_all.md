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
#> ✖ 2026-08-24 19:11:25.37609: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:26.704597: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:27.423334: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:27.673878: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:28.041807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:28.347918: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:28.588188: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:28.775352: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:29.124809: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:29.450026: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:29.632555: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:29.972913: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:30.215312: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:30.429854: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:30.629234: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:30.819502: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:31.006306: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:31.187142: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:31.360887: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:31.575419: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:31.918201: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:32.108029: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:32.515404: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:32.700807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:32.95399: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:33.116607: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:33.315341: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 19:11:33.507207: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 19:11:33 UTC
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
