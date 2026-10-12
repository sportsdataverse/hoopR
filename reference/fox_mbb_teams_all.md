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
#> ✖ 2026-10-12 03:08:54.144111: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:54.928514: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:55.449131: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:55.793624: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:55.959431: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:56.246866: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:56.591716: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:56.92491: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:57.094291: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:58.033179: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:58.277563: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:58.504825: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:58.948261: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:59.181468: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:59.38454: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:08:59.952784: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:00.152039: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:00.357883: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:00.5578: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:00.737697: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:00.903985: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:01.077991: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:01.424643: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:01.606713: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:01.781251: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:01.956413: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:02.12527: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-12 03:09:02.325521: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-12 03:09:02 UTC
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
