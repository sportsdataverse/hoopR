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
#> ✖ 2026-11-03 09:54:59.098806: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:02.457841: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:03.500992: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:03.560289: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:03.61995: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:03.97559: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.17688: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.23702: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.298676: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.355482: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.397047: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.44836: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.507357: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.566605: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.633975: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.692539: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.752348: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.811749: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.887379: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:04.949267: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.022564: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.092793: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.14423: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.207211: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.267821: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.32537: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.398476: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-03 09:55:05.458139: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-03 09:55:05 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 233         Holy Cross Crusaders       Patriot League
#>  3 104         American Eagles            Patriot League
#>  4 230         Army Black Knights         Patriot League
#>  5 231         Bucknell Bison             Patriot League
#>  6 232         Colgate Raiders            Patriot League
#>  7 234         Lafayette Leopards         Patriot League
#>  8 235         Lehigh Mountain Hawks      Patriot League
#>  9 150         Loyola Maryland Greyhounds Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
