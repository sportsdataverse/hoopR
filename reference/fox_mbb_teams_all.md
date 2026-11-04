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
#> ✖ 2026-11-04 07:34:57.551096: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:01.920706: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:04.732347: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:04.863987: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:04.978851: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:05.485367: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:05.902486: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.066736: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.181044: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.349253: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.433033: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.592053: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.772601: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:06.888209: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.077894: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.213127: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.337998: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.519092: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.679903: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.808659: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:07.933869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.086637: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.17059: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.284526: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.421461: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.535559: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.708863: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-11-04 07:35:08.792594: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── Fox Sports MBB full team directory ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-04 07:35:08 UTC
#> # A tibble: 365 × 3
#>    fox_team_id fox_team_name              fox_section   
#>    <chr>       <chr>                      <chr>         
#>  1 1           Boston University Terriers Patriot League
#>  2 104         American Eagles            Patriot League
#>  3 230         Army Black Knights         Patriot League
#>  4 231         Bucknell Bison             Patriot League
#>  5 232         Colgate Raiders            Patriot League
#>  6 234         Lafayette Leopards         Patriot League
#>  7 235         Lehigh Mountain Hawks      Patriot League
#>  8 150         Loyola Maryland Greyhounds Patriot League
#>  9 233         Holy Cross Crusaders       Patriot League
#> 10 236         Navy Midshipmen            Patriot League
#> # ℹ 355 more rows
# }
```
