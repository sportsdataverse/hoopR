# **Get Fox Sports Basketball Team Directory**

**Get Fox Sports Basketball Team Directory**

**Get Fox Sports Basketball Team Directory**

## Usage

``` r
fox_nba_teams(team_id = "1")

fox_mbb_teams(team_id = "1")
```

## Arguments

- team_id:

  Fox Bifrost seed team id used to fetch league standings (default
  `"1"`); the standings response enumerates every team in the seed's
  league sections.

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
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Examples

``` r
# \donttest{
  try(fox_nba_teams())
#> ── Fox Sports NBA teams ──────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 05:33:23 UTC
#> # A tibble: 30 × 3
#>    fox_team_id fox_team_name       fox_section   
#>    <chr>       <chr>               <chr>         
#>  1 3           Brooklyn Nets       Boston Celtics
#>  2 2           Miami Heat          Boston Celtics
#>  3 6           Philadelphia 76ers  Boston Celtics
#>  4 13          Indiana Pacers      Boston Celtics
#>  5 10          Chicago Bulls       Boston Celtics
#>  6 5           Orlando Magic       Boston Celtics
#>  7 12          Detroit Pistons     Boston Celtics
#>  8 14          Milwaukee Bucks     Boston Celtics
#>  9 1           Boston Celtics      Boston Celtics
#> 10 11          Cleveland Cavaliers Boston Celtics
#> # ℹ 20 more rows
# }
```
