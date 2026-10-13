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
#> ✖ 2026-10-13 01:17:15.991185: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:30.100637: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:37.833723: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:37.991161: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:38.480433: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:39.670856: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:40.753461: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:41.158605: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:41.502842: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:41.750582: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:41.912423: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:42.234054: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:42.655283: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:43.158578: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:43.418443: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:43.795821: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:44.226086: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:44.832566: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:45.119649: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:45.475918: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:45.683611: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:45.975406: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:46.379408: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:47.048736: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:47.539309: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:47.724406: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:48.134959: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-13 01:17:48.560018: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-13 01:17:48 UTC
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
