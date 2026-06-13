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
#> ✖ 2026-06-13 05:50:53.827432: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:54.999516: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:55.655352: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:55.898971: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:56.206647: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:56.456295: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:56.690069: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:56.95122: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:57.201033: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:57.44169: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:57.778982: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:57.995139: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:58.166445: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:58.403556: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:58.598658: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:58.808465: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:59.025556: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:59.231491: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:59.399833: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:59.630958: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:50:59.848447: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:00.192275: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:00.421669: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:00.678921: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:00.882739: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:01.099086: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:01.325654: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:01.509775: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:51:01.687696: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 05:51:01 UTC
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
