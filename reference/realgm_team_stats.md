# **RealGM NBA Team Stats**

**Get season team statistics from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_team_stats(
  season = most_recent_nba_season(),
  stat_type = "Averages",
  season_type = "Regular_Season"
)
```

## Arguments

- season:

  Season (the year the season ends, e.g. `2026`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- stat_type:

  Statistic family. One of `"Averages"` (default), `"Totals"`,
  `"Advanced_Stats"` or `"Misc_Stats"`.

- season_type:

  Season segment. One of `"Regular_Season"` (default), `"Playoffs"`,
  `"Preseason"` or `"Summer_League"`.

## Value

A `hoopR_data` tibble (one row per team) carrying the requested
`season`, `stat_type` and `season_type` as columns. Columns vary by
`stat_type`; for `"Averages"`: `team`, `gp`, `mpg`, `ppg`, `rpg`, `apg`,
etc.

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
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
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_team_stats(season = 2025, stat_type = "Averages"))
#> ── NBA team stats from basketball.realgm.com ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:45 UTC
#> # A tibble: 30 × 25
#>    number team     gp   mpg   ppg   fgm   fga fg_percent  x3pm  x3pa x3p_percent
#>     <dbl> <chr> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl> <dbl> <dbl>       <dbl>
#>  1      1 Clev…    82  48.2  122.  44.5  90.8      0.491  15.9  41.5       0.383
#>  2      2 Memp…    82  48    122.  44.8  93.3      0.479  13.9  37.9       0.367
#>  3      3 Denv…    82  48.4  121.  45.4  89.8      0.506  12    31.9       0.376
#>  4      4 Okla…    82  48    120.  44.6  92.7      0.482  14.5  38.8       0.374
#>  5      5 Atla…    82  48.2  118.  43.4  91.8      0.472  13.5  37.7       0.358
#>  6      6 Chic…    82  48.2  118.  43.2  92        0.47   15.4  42         0.367
#>  7      7 Indi…    82  48.4  117.  43.6  89.3      0.488  13.2  35.8       0.368
#>  8      8 Bost…    82  48.3  116.  41.6  90        0.462  17.8  48.2       0.368
#>  9      9 New …    82  48.5  116.  43.3  89.2      0.486  12.6  34.1       0.369
#> 10     10 Sacr…    82  48.5  116.  43    90.1      0.478  12.6  35.2       0.357
#> # ℹ 20 more rows
#> # ℹ 14 more variables: ftm <dbl>, fta <dbl>, ft_percent <dbl>, orb <dbl>,
#> #   drb <dbl>, rpg <dbl>, apg <dbl>, spg <dbl>, bpg <dbl>, tov <dbl>, pf <dbl>,
#> #   season <dbl>, stat_type <chr>, season_type <chr>
# }
```
