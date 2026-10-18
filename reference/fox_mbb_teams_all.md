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
#> ✖ 2026-10-18 15:39:51.640548: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:07.340108: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:14.282581: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:14.592033: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:14.92166: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:17.615605: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:18.89626: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:19.19175: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:19.537894: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:19.762741: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:19.998645: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:20.311008: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:20.600534: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:20.875269: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:21.157019: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:21.592785: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:21.863934: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:22.183156: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:22.484716: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:22.982869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:23.268584: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:23.344577: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:23.654319: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:23.951658: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:24.215456: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:24.49205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:24.866474: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-18 15:40:25.219988: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:40:25 UTC
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
