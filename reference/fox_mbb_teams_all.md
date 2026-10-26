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
#> ✖ 2026-10-26 19:16:08.419535: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:10.029361: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:10.617202: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:10.720205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:10.812773: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.072441: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.280957: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.366904: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.456144: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.544306: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.651973: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.728549: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.814487: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.906288: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:11.986656: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.100947: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.190022: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.267196: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.396955: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.53856: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.618668: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.707816: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.814463: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:12.956553: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:13.063127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:13.20306: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:13.303711: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-26 19:16:13.393022: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:16:13 UTC
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
