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
#> ℹ Data updated: 2026-10-22 02:37:53 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  Pist… 1-0   1.000 -     121.0 113.0 1-0  
#>  2 1       CONFERE… 2                  76ers 1-0   1.000 -     106.0 100.0 0-0  
#>  3 1       CONFERE… 3                  Knic… 0-1   .000  1.0   100.0 106.0 0-1  
#>  4 1       CONFERE… 4                  Celt… 0-1   .000  1.0   113.0 121.0 0-0  
#>  5 1       CONFERE… 5                  Hawks 1-0   1.000 -     132.0 125.0 0-0  
#>  6 1       CONFERE… 6                  Nets  0-0   -     0.5   0.0   0.0   0-0  
#>  7 1       CONFERE… 7                  Horn… 0-0   -     0.5   0.0   0.0   0-0  
#>  8 1       CONFERE… 8                  Bulls 0-0   -     0.5   0.0   0.0   0-0  
#>  9 1       CONFERE… 9                  Cava… 0-0   -     0.5   0.0   0.0   0-0  
#> 10 1       CONFERE… 10                 Pace… 0-0   -     0.5   0.0   0.0   0-0  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
