# **RealGM NBA Team Stats**

**Get season team statistics from RealGM (basketball.realgm.com).**

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

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_team_stats(season = 2025, stat_type = "Averages"))
} # }
```
