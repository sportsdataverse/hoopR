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
#> ✖ 2026-09-30 05:42:27.843539: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:28.990088: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:29.58265: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:29.767665: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:29.984061: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:30.297676: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:30.530534: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:30.720934: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:30.950387: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:31.290766: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:31.496934: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:31.855164: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:32.037491: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:32.324214: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:32.525961: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:32.746514: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:32.938615: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:33.151218: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:33.468127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:33.724628: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:33.926387: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:34.268729: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:34.603235: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:34.79331: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:34.989191: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:35.197369: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:35.408942: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-30 05:42:35.662913: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-30 05:42:35 UTC
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
