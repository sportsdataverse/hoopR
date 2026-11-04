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
#> ℹ Data updated: 2026-11-04 07:34:55 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  76ers 7-1   .875  -     110.9 105.1 4-1  
#>  2 1       CONFERE… 2                  Pist… 6-1   .857  0.5   111.9 100.3 2-0  
#>  3 1       CONFERE… 3                  Celt… 5-2   .714  1.5   115.0 109.1 4-0  
#>  4 1       CONFERE… 4                  Wiza… 4-3   .571  2.5   109.4 107.4 2-1  
#>  5 1       CONFERE… 5                  Rapt… 4-3   .571  2.5   119.1 111.4 2-1  
#>  6 1       CONFERE… 6                  Cava… 4-3   .571  2.5   119.7 116.1 3-1  
#>  7 1       CONFERE… 7                  Hawks 4-4   .500  3.0   115.2 114.0 1-2  
#>  8 1       CONFERE… 8                  Knic… 3-4   .429  3.5   106.4 105.1 2-2  
#>  9 1       CONFERE… 9                  Horn… 3-5   .375  4.0   97.4  108.6 2-3  
#> 10 1       CONFERE… 10                 Heat  2-5   .286  4.5   118.1 123.9 1-3  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
