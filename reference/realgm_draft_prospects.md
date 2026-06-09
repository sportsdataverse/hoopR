# **RealGM NBA Draft Prospect Stats**

**Get current NBA draft-prospect statistics from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft_prospects()
```

## Value

A `hoopR_data` tibble with one row per prospect (`player`, `team`
(school/club), `gp`, `mpg`, `ppg`, shooting splits, `rpg`, `apg`, `spg`,
`bpg`).

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md),
[`realgm_gms()`](https://hoopR.sportsdataverse.org/reference/realgm_gms.md),
[`realgm_individual_games()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_games.md),
[`realgm_individual_seasons()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_seasons.md),
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
  try(realgm_draft_prospects())
#> ── NBA draft prospect stats from basketball.realgm.com ────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:12 UTC
#> # A tibble: 115 × 20
#>    player team     gp   mpg   ppg   fgm   fga fg_percent  x3pm  x3pa x3p_percent
#>    <chr>  <chr> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl> <dbl> <dbl>       <dbl>
#>  1 A.J. … BYU      35  34.8  25.5   8.8  17.3      0.51    1.4   4.2       0.331
#>  2 Dariu… ARK      36  35.2  23.5   8    16.5      0.484   2.5   5.8       0.44 
#>  3 Ebuka… STAN     31  35.1  23.2   7.5  16.2      0.465   2     5.7       0.354
#>  4 Nick … NWU      33  35.5  23     8.1  15.9      0.51    1.4   3.3       0.417
#>  5 Camer… DUKE     38  33.5  22.5   7.6  13.7      0.556   1.4   3.6       0.391
#>  6 Labar… UA       33  30.9  22     7.4  14.7      0.501   2.5   6.2       0.399
#>  7 J.T. … TXTCH    25  34.9  21.8   9.4  17.1      0.548   0.6   2.3       0.281
#>  8 Juke … WF       35  35.3  21.4   6.7  15.1      0.444   2.5   7.5       0.332
#>  9 Darry… KU       24  29.1  20.2   6.5  14.8      0.438   2.6   6.9       0.382
#> 10 Bruce… OSU      34  36.6  19.9   7    12.6      0.554   1.8   4.6       0.4  
#> # ℹ 105 more rows
#> # ℹ 9 more variables: ftm <dbl>, fta <dbl>, ft_percent <dbl>, orb <dbl>,
#> #   drb <dbl>, rpg <dbl>, apg <dbl>, spg <dbl>, bpg <dbl>
# }
```
