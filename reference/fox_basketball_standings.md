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
#> ℹ Data updated: 2026-10-26 19:16:06 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  Pist… 3-0   1.000 -     118.3 105.7 1-0  
#>  2 1       CONFERE… 2                  76ers 3-1   .750  0.5   110.0 107.0 2-1  
#>  3 1       CONFERE… 3                  Hawks 2-1   .667  1.0   124.7 109.0 0-1  
#>  4 1       CONFERE… 4                  Rapt… 2-1   .667  1.0   113.7 103.7 1-0  
#>  5 1       CONFERE… 5                  Wiza… 2-1   .667  1.0   118.0 116.0 1-1  
#>  6 1       CONFERE… 6                  Pace… 2-1   .667  1.0   121.3 116.7 0-1  
#>  7 1       CONFERE… 7                  Horn… 2-1   .667  1.0   102.0 113.7 1-1  
#>  8 1       CONFERE… 8                  Celt… 1-1   .500  1.5   110.0 112.0 1-0  
#>  9 1       CONFERE… 9                  Cava… 1-1   .500  1.5   115.5 117.5 1-0  
#> 10 1       CONFERE… 10                 Magic 1-2   .333  2.0   109.7 116.3 0-2  
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
