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
if (FALSE) { # interactive()
# \donttest{
  try(nba_tidy_boxscore(game_id = "0022300061"))
# }
}
```
