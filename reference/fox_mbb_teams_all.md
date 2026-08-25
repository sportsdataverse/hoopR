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
#> ✖ 2026-08-25 02:48:13.204586: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:14.253652: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:14.843013: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:15.032065: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:15.210007: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:15.471497: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:15.724658: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:15.956121: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:16.433369: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:16.82064: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:17.007955: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:17.445663: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:17.880877: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:18.095667: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:18.404052: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:18.774264: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:19.109185: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:19.325712: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:19.540787: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:19.923589: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:20.258578: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:20.444724: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:20.834331: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:21.020235: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:21.221041: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:21.438682: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:21.840183: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 02:48:22.170014: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 02:48:22 UTC
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
