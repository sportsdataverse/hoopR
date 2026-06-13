# **NBA Player Box Score with Team Context**

A traditional player box score with each player's team totals joined on
(tactic **C**).
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md)
returns player-grain `PlayerStats` and team-grain `TeamStats`
separately; this left-joins the team totals onto every player row by
`GAME_ID` + `TEAM_ID`, suffixing the team columns with `_team`.

## Usage

``` r
nba_tidy_boxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID (10-digit, zero-padded e.g. `"0022300061"`).

- ...:

  Additional arguments passed to
  [`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md).

## Value

A `hoopR_data` tibble, one row per player, with the player's stats and
their team's totals (team columns suffixed `_team`).

## See also

Other NBA Combined Datasets:
[`nba_tidy_franchise_history()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_franchise_history.md),
[`nba_tidy_player_profile()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_player_profile.md)

## Examples

``` r
# \donttest{
  try(nba_tidy_boxscore(game_id = "0022300061"))
#> ✖ 2026-06-13 03:43:34.560879: Invalid arguments or no traditional boxscore v2 data for 0022300061 available!
#> ✖ Args: game_id = "0022300061", start_period = 0, end_period = 14, start_range = 0, end_range = 0, range_type = 0
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-06-13 03:43:34.572917: No NBA box score for 0022300061!
#> ✖ Args: game_id = "0022300061"
#> ✖ Error: No player box score returned
#> data frame with 0 columns and 0 rows
# }
```
