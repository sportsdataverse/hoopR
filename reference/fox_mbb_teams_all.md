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
#> ✖ 2026-08-25 04:53:16.646819: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:20.629807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:22.41923: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:22.507323: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:22.808661: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:23.468192: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:23.92769: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:24.230376: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:24.606644: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:24.868871: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:25.089492: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:25.193849: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:25.414238: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:25.69523: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:25.95059: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:26.289212: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:26.578342: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:26.620477: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:26.848185: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.028965: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.246255: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.429192: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.607829: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.787544: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:27.96926: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:28.184736: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:28.381606: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:53:28.605845: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 04:53:28 UTC
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
