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
#> ℹ Data updated: 2026-11-09 19:54:15 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  76ers 9-2   .818  -     111.0 107.9 4-1  
#>  2 1       CONFERE… 2                  Celt… 8-2   .800  0.5   115.0 104.3 5-0  
#>  3 1       CONFERE… 3                  Pist… 6-3   .667  2.0   111.7 103.9 2-2  
#>  4 1       CONFERE… 4                  Hawks 7-4   .636  2.0   118.6 115.5 3-2  
#>  5 1       CONFERE… 5                  Knic… 5-4   .556  3.0   109.9 104.2 3-2  
#>  6 1       CONFERE… 6                  Rapt… 5-4   .556  3.0   118.2 112.8 2-1  
#>  7 1       CONFERE… 7                  Cava… 5-5   .500  3.5   117.0 114.1 4-2  
#>  8 1       CONFERE… 8                  Heat  4-6   .400  4.5   115.8 121.1 1-3  
#>  9 1       CONFERE… 9                  Wiza… 4-6   .400  4.5   107.8 112.5 2-2  
#> 10 1       CONFERE… 10                 Horn… 3-7   .300  5.5   96.3  110.2 2-4  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
