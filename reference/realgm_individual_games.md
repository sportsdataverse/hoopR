# **RealGM NBA Best Individual Games**

**Get the all-time best individual NBA games leaderboard from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_individual_games()
```

## Value

A `hoopR_data` tibble with one row per player-game (`player`, `date`,
`team`, `min`, `pts`, `fgm`, `fga`, `reb`, `ast`, `stl`, `blk`, etc.).

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md),
[`realgm_gms()`](https://hoopR.sportsdataverse.org/reference/realgm_gms.md),
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
  try(realgm_individual_games())
#> ── NBA best individual games from basketball.realgm.com ───────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 19:17:18 UTC
#> # A tibble: 100 × 20
#>    number player     date  team  min     pts   fgm   fga  x3pm  x3pa   ftm   fta
#>     <dbl> <chr>      <chr> <chr> <chr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      1 Bam Adeba… Mar … MIA   41:54    83    20    43     7    22    36    43
#>  2      2 Luka Donc… Mar … LAL   37:36    60    18    30     9    17    15    19
#>  3      3 Nikola Jo… Dec … DEN   42:36    56    15    21     4     6    22    23
#>  4      4 Anthony E… Jan … MIN   40:06    55    19    33     9    16     8    10
#>  5      5 Kawhi Leo… Dec … LAC   38:38    55    17    26     5    10    16    17
#>  6      6 James Har… Nov … LAC   35:13    55    17    26    10    16    11    14
#>  7      7 Nikola Jo… Nov … DEN   33:34    55    18    23     5     6    14    16
#>  8      8 Shai Gilg… Oct … OKC   45:21    55    15    31     2     7    23    26
#>  9      9 Tyrese Ma… Nov … PHL   46:38    54    18    30     6    15    12    14
#> 10     10 Jamal Mur… Mar … DEN   41:16    53    19    28     9    14     6     6
#> # ℹ 90 more rows
#> # ℹ 8 more variables: orb <dbl>, drb <dbl>, reb <dbl>, ast <dbl>, stl <dbl>,
#> #   blk <dbl>, tov <dbl>, pf <dbl>
# }
```
