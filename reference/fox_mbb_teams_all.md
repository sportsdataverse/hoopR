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
#> ✖ 2026-11-01 21:47:59.680518: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.273925: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.423818: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.460653: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.487525: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.58106: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.880384: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.943649: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:00.970454: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.168389: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.230093: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.304185: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.360051: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.388498: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.468021: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.528111: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.597589: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.658429: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.715284: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.781776: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.838152: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.899537: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:01.964145: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:02.021595: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:02.093615: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:02.248566: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:02.316025: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-01 21:48:02.394167: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:48:02 UTC
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
