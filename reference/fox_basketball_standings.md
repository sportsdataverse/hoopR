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
#> ── Fox Sports NBA standings ───────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 05:50:52 UTC
#> # A tibble: 90 × 23
#>    team_id section  eastern_conference v2    w_l   pct   gb    pf    pa    home 
#>    <chr>   <chr>    <chr>              <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1       CONFERE… 1                  Pist… 60-22 .732  -     117.8 109.6 31-9 
#>  2 1       CONFERE… 2                  Celt… 56-26 .683  4.0   114.8 107.2 30-11
#>  3 1       CONFERE… 3                  Knic… 53-29 .646  7.0   116.4 110.1 30-10
#>  4 1       CONFERE… 4                  Cava… 52-30 .634  8.0   119.5 115.4 27-14
#>  5 1       CONFERE… 5                  Rapt… 46-36 .561  14.0  114.6 111.8 24-17
#>  6 1       CONFERE… 6                  Hawks 46-36 .561  14.0  118.5 116.1 24-17
#>  7 1       CONFERE… 7                  76ers 45-37 .549  15.0  115.9 116.1 23-18
#>  8 1       CONFERE… 8                  Magic 45-37 .549  15.0  115.7 115.1 25-15
#>  9 1       CONFERE… 9                  Horn… 44-38 .537  16.0  116.0 111.2 21-20
#> 10 1       CONFERE… 10                 Heat  43-39 .524  17.0  120.9 118.5 26-15
#> # ℹ 80 more rows
#> # ℹ 13 more variables: away <chr>, conf <chr>, div <chr>, l10 <chr>,
#> #   strk <chr>, entity_id <chr>, western_conference <chr>, atlantic <chr>,
#> #   central <chr>, southeast <chr>, northwest <chr>, pacific <chr>,
#> #   southwest <chr>
# }
```
