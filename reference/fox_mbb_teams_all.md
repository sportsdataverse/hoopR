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
#> ✖ 2026-06-24 02:50:07.85548: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:11.383567: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:12.677513: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:12.996413: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:13.659836: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:14.148748: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:14.448128: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:14.834812: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:15.159346: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:15.31189: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:15.466311: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:15.774004: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:15.93094: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:16.248276: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:16.688622: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:16.977894: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:17.632416: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:17.97262: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:18.275846: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:18.625433: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:18.921316: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:19.078041: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:19.424587: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:19.788441: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:20.12019: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:20.604831: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:20.909419: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:21.253421: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-24 02:50:21.605691: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-24 02:50:21 UTC
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
