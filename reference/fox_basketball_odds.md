# **Get Fox Sports Basketball Game Odds**

**Get Fox Sports Basketball Game Odds**

**Get Fox Sports Basketball Game Odds**

## Usage

``` r
fox_nba_odds(game_id)

fox_mbb_odds(game_id)
```

## Arguments

- game_id:

  Fox Bifrost event id.

## Value

A `hoopR_data` tibble, one row per team: `game_id`, `team`, plus the
six-pack odds columns (spread / to-win / total). Empty when no market.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
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
  try(fox_nba_odds("106422"))
#> ── Fox Sports NBA odds ────────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 02:23:56 UTC
#> # A tibble: 0 × 0
# }
```
