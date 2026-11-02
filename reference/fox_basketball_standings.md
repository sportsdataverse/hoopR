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
#> ℹ Data updated: 2026-11-02 01:53:17 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  76ers 6-1   .857  -     108.7 104.9 3-1  
#>  2 1       CONFERE… 2                  Pist… 5-1   .833  0.5   109.8 101.8 2-0  
#>  3 1       CONFERE… 3                  Celt… 5-1   .833  0.5   118.7 109.2 4-0  
#>  4 1       CONFERE… 4                  Cava… 4-2   .667  1.5   121.0 116.0 3-0  
#>  5 1       CONFERE… 5                  Rapt… 3-2   .600  2.0   116.8 106.2 2-1  
#>  6 1       CONFERE… 6                  Wiza… 3-3   .500  2.5   110.5 109.7 2-1  
#>  7 1       CONFERE… 7                  Hawks 3-4   .429  3.0   116.3 115.4 1-2  
#>  8 1       CONFERE… 8                  Horn… 3-4   .429  3.0   98.3  106.4 2-2  
#>  9 1       CONFERE… 9                  Magic 2-4   .333  3.5   107.7 116.7 0-3  
#> 10 1       CONFERE… 10                 Heat  2-4   .333  3.5   118.3 121.5 1-3  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
