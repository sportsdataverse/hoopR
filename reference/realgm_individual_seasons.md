# **RealGM NBA Best Individual Seasons**

**Get the all-time best individual NBA seasons leaderboard from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_individual_seasons()
```

## Value

A `hoopR_data` tibble with one row per player-season (`player`,
`season`, `team`, `gp`, `min`, `pts`, shooting splits, `reb`, `ast`,
etc.).

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md),
[`realgm_gms()`](https://hoopR.sportsdataverse.org/reference/realgm_gms.md),
[`realgm_individual_games()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_games.md),
[`realgm_player_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_player_stats.md),
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md),
[`realgm_players_abroad()`](https://hoopR.sportsdataverse.org/reference/realgm_players_abroad.md),
[`realgm_rookie_scale()`](https://hoopR.sportsdataverse.org/reference/realgm_rookie_scale.md),
[`realgm_salary_cap()`](https://hoopR.sportsdataverse.org/reference/realgm_salary_cap.md),
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_individual_seasons())
#> ── NBA best individual seasons from basketball.realgm.com ─────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 19:17:22 UTC
#> # A tibble: 100 × 24
#>    number player     season team     gp   min   pts   fgm   fga fg_percent x3pm 
#>     <dbl> <chr>       <dbl> <chr> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl> <chr>
#>  1      1 Wilt Cham…   1962 PHI      80  48.5  50.4  20    39.5      0.506 -    
#>  2      2 Wilt Cham…   1963 GOS      80  47.6  44.8  18.3  34.6      0.528 -    
#>  3      3 Wilt Cham…   1961 PHI      79  47.8  38.4  15.8  31.1      0.509 -    
#>  4      4 Elgin Bay…   1962 LAL      48  44.4  38.3  14.2  33.1      0.428 -    
#>  5      5 Wilt Cham…   1960 PHI      72  46.4  37.6  14.8  32.1      0.461 -    
#>  6      6 Michael J…   1987 CHI      82  40    37.1  13.4  27.8      0.482 0.1  
#>  7      7 Wilt Cham…   1964 GOS      80  46.1  36.9  15.1  28.7      0.524 -    
#>  8      8 James Har…   2019 HOU      78  36.8  36.1  10.8  24.5      0.442 4.8  
#>  9      9 Rick Barry   1967 GOS      78  40.7  35.6  13    28.7      0.451 -    
#> 10     10 Kobe Brya…   2006 LAL      80  41    35.4  12.2  27.2      0.45  2.3  
#> # ℹ 90 more rows
#> # ℹ 13 more variables: x3pa <chr>, x3p_percent <chr>, ftm <dbl>, fta <dbl>,
#> #   ft_percent <dbl>, orb <chr>, drb <chr>, reb <dbl>, ast <dbl>, stl <chr>,
#> #   blk <chr>, tov <chr>, pf <dbl>
# }
```
