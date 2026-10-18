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
#> ✖ 2026-10-18 19:27:29.230537: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:39.539246: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:43.474785: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:44.364599: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:45.014284: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:46.198155: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:47.473279: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:47.788013: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:48.464705: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:48.876413: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:49.075731: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:49.366688: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:50.588924: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:51.483637: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:52.241917: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:52.893115: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:53.126283: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:53.543447: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:54.005297: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:54.377622: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:54.832778: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:55.022259: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:55.475273: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:55.7282: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:55.93609: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:56.286237: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:56.499249: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 19:27:56.877808: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:27:56 UTC
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
