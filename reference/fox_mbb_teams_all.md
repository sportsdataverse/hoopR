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
#> ✖ 2026-11-04 03:43:56.108689: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.521989: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.690845: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.716518: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.743752: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.805432: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.883314: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:56.940698: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.000639: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.055538: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.113599: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.169841: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.229049: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.287552: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.319173: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.375303: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.461648: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.539141: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.596853: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.652137: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.709389: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.765407: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.816093: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.894363: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:57.954551: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:58.012743: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:58.102571: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 03:43:58.15973: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-04 03:43:58 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 104         American Eagles            Patriot League
#>  3 230         Army Black Knights         Patriot League
#>  4 231         Bucknell Bison             Patriot League
#>  5 232         Colgate Raiders            Patriot League
#>  6 234         Lafayette Leopards         Patriot League
#>  7 235         Lehigh Mountain Hawks      Patriot League
#>  8 150         Loyola Maryland Greyhounds Patriot League
#>  9 233         Holy Cross Crusaders       Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
