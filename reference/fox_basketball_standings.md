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
#> ℹ Data updated: 2026-11-13 12:51:30 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  Celt… 10-2  .833  -     114.2 103.1 5-0  
#>  2 1       CONFERE… 2                  76ers 10-3  .769  0.5   111.2 109.4 5-2  
#>  3 1       CONFERE… 3                  Pist… 8-3   .727  1.5   115.6 107.8 3-2  
#>  4 1       CONFERE… 4                  Hawks 7-5   .583  3.0   118.2 116.2 3-3  
#>  5 1       CONFERE… 5                  Knic… 6-5   .545  3.5   110.3 103.5 4-3  
#>  6 1       CONFERE… 6                  Cava… 6-6   .500  4.0   116.4 114.3 4-2  
#>  7 1       CONFERE… 7                  Heat  5-6   .455  4.5   115.7 120.0 1-3  
#>  8 1       CONFERE… 8                  Rapt… 5-7   .417  5.0   114.2 112.8 2-3  
#>  9 1       CONFERE… 9                  Magic 4-7   .364  5.5   108.5 114.0 0-4  
#> 10 1       CONFERE… 10                 Horn… 4-8   .333  6.0   98.6  109.6 3-4  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
