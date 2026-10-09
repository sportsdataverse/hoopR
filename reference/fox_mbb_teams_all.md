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
#> ✖ 2026-10-09 04:32:45.620807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:46.905754: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:47.363319: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:48.178258: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:48.413865: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:48.637069: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:48.895833: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:49.028283: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:49.413361: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:49.910861: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:50.066859: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:50.360508: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:50.669504: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:50.9429: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:51.239388: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:51.955378: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:52.096323: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:52.374179: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:52.6759: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:53.016276: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:53.279803: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:53.586523: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:53.872959: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:54.042009: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:54.193515: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:54.574973: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:54.917245: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-09 04:32:55.274441: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 04:32:55 UTC
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
