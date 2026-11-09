# **RealGM NBA Player Stats**

**Get season player statistics leaders from RealGM
(basketball.realgm.com).**

Returns the qualified-player leaderboard for a season, statistic family
and season segment. RealGM exposes basic box-score averages as well as
advanced and miscellaneous splits not all available from first-party
feeds.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_player_stats(
  season = most_recent_nba_season(),
  stat_type = "Averages",
  season_type = "Regular_Season"
)
```

## Arguments

- season:

  Season (the year the season ends, e.g. `2026` for 2025-26). Defaults
  to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- stat_type:

  Statistic family. One of `"Averages"` (default), `"Totals"`,
  `"Per_48"`, `"Per_40"`, `"Per_36"`, `"Per_Minute"`, `"Advanced_Stats"`
  or `"Misc_Stats"`.

- season_type:

  Season segment. One of `"Regular_Season"` (default), `"Playoffs"`,
  `"Preseason"` or `"Summer_League"`.

## Value

A `hoopR_data` tibble (one row per qualified player) carrying the
requested `season`, `stat_type` and `season_type` as columns. Columns
vary by `stat_type`; for `"Averages"`:

|          |           |                    |
|----------|-----------|--------------------|
| col_name | types     | description        |
| player   | character | Player name.       |
| team     | character | Team abbreviation. |
| gp       | integer   | Games played.      |
| mpg      | numeric   | Minutes per game.  |
| ppg      | numeric   | Points per game.   |
| rpg      | numeric   | Rebounds per game. |
| apg      | numeric   | Assists per game.  |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_player_stats(season = 2025, stat_type = "Averages"))
} # }
```
