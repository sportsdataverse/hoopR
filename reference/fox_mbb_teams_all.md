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
#> ✖ 2026-10-31 21:30:25.730131: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:29.967303: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:31.598911: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:31.720094: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:31.872895: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:32.458962: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:32.85717: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:32.998652: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.10922: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.192682: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.329109: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.479414: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.562275: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.649074: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.790605: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:33.925359: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.054451: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.190999: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.266344: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.340875: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.414307: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.504711: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.787506: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:34.924343: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:35.015471: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:35.101645: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:35.18557: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-10-31 21:30:35.257647: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:35 UTC
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
