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
#> ✖ 2026-11-01 20:45:38.91567: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:41.747772: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:42.801402: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:42.873695: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:42.911706: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.276702: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.482946: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.564708: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.642127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.728247: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.798028: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.860841: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.931788: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:43.999054: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.070577: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.144553: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.214504: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.286581: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.377628: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.444607: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.523357: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.591234: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.654256: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.723054: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.794331: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.867064: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:44.9432: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 20:45:45.013048: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:45:45 UTC
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
