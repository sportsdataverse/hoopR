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
#> ✖ 2026-09-30 02:07:28.455008: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:29.931208: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:30.837846: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:31.007617: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:31.195831: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:31.521011: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:31.790737: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:31.967426: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:32.127021: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:32.307938: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:32.521544: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:32.947892: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:33.323073: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:33.946194: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:34.123114: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:34.322396: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:34.519536: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:34.70028: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:34.873259: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:35.051774: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:35.241495: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:35.403357: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:35.747649: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:35.923311: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:36.109145: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:36.271002: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:36.436614: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 02:07:36.616039: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-30 02:07:36 UTC
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
