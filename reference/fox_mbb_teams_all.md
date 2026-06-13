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
#> ✖ 2026-06-13 02:23:59.466684: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:01.171052: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:01.868727: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:02.055028: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:02.405718: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:02.735623: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:03.052016: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:03.295695: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:03.571127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:03.786843: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:04.039195: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:04.211583: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:04.40494: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:04.613741: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:04.827894: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.020768: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.21141: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.453483: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.620902: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.675785: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.726323: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.776244: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.942416: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:05.992763: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:06.043558: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:06.219643: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:06.273325: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:06.468169: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 02:24:06.638909: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 02:24:06 UTC
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
