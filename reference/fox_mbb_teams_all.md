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
#> ✖ 2026-09-27 21:22:42.692246: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:48.795638: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:50.60551: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:50.933349: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:51.149839: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:51.712608: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:52.372649: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:52.594431: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:52.965087: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:53.218855: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:53.573886: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:54.120625: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:54.315454: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:54.523157: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:54.865567: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:55.100866: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:55.443264: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:55.674522: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:56.151962: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:56.361483: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:56.636601: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:56.883784: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:57.217195: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:57.571807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:57.793293: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:58.16326: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:58.532628: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-09-27 21:22:58.741292: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-27 21:22:58 UTC
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
