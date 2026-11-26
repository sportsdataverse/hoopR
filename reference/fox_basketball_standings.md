# **Get Fox Sports Basketball Standings**

**Get Fox Sports Basketball Standings**

**Get Fox Sports Basketball Standings**

## Usage

``` r
fox_nba_standings(team_id)

fox_mbb_standings(team_id)
```

## Arguments

- team_id:

  Fox Bifrost team id (standings of that team's conference/division).

## Value

A `hoopR_data` tibble of standings rows (`team_id`, `section`, the
standings columns, `entity_id`).

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md),
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_standings("1"))
#> ── Fox Sports NBA standings ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-26 22:39:20 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  76ers 15-4  .789  -     115.1 112.9 8-3  
#>  2 1       CONFERE… 2                  Celt… 12-6  .667  2.5   112.3 102.9 6-1  
#>  3 1       CONFERE… 3                  Knic… 12-6  .667  2.5   109.6 103.2 7-3  
#>  4 1       CONFERE… 4                  Hawks 11-6  .647  3.0   116.7 113.6 5-3  
#>  5 1       CONFERE… 5                  Pist… 11-6  .647  3.0   112.8 107.2 3-3  
#>  6 1       CONFERE… 6                  Heat  10-7  .588  4.0   119.7 118.9 6-3  
#>  7 1       CONFERE… 7                  Cava… 9-10  .474  6.0   117.4 117.0 7-3  
#>  8 1       CONFERE… 8                  Magic 7-10  .412  7.0   107.4 112.3 1-6  
#>  9 1       CONFERE… 9                  Wiza… 7-12  .368  8.0   110.6 116.2 3-6  
#> 10 1       CONFERE… 10                 Rapt… 6-11  .353  8.0   111.5 111.7 2-7  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
