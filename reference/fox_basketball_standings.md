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
#> ℹ Data updated: 2026-11-25 05:15:10 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  76ers 14-4  .778  -     115.3 113.4 7-3  
#>  2 1       CONFERE… 2                  Hawks 11-6  .647  2.5   116.7 113.6 5-3  
#>  3 1       CONFERE… 3                  Celt… 12-6  .667  2.0   112.3 102.9 6-1  
#>  4 1       CONFERE… 4                  Knic… 11-6  .647  2.5   108.9 103.2 6-3  
#>  5 1       CONFERE… 5                  Pist… 11-6  .647  2.5   112.8 107.2 3-3  
#>  6 1       CONFERE… 6                  Heat  10-6  .625  3.0   120.7 119.4 6-3  
#>  7 1       CONFERE… 7                  Cava… 9-9   .500  5.0   118.2 116.8 7-3  
#>  8 1       CONFERE… 8                  Magic 7-10  .412  6.5   107.4 112.3 1-6  
#>  9 1       CONFERE… 9                  Wiza… 7-12  .368  7.5   110.6 116.2 3-6  
#> 10 1       CONFERE… 10                 Rapt… 6-11  .353  7.5   111.5 111.7 2-7  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
