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
#> ✖ 2026-11-02 06:29:58.840701: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.306154: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.51706: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.551578: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.581819: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.656235: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.720996: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.75155: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.792032: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.832793: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.874771: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.926158: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:29:59.975819: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.022047: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.065022: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.118778: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.161326: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.220642: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.260869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.2916: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.329376: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.677029: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.731441: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.774327: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.816137: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.848817: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.891791: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-02 06:30:00.942508: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 06:30:00 UTC
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
