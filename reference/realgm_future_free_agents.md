# **RealGM Future NBA Free Agents**

**Get RealGM's projected future NBA free-agent class from
[RealGM](https://basketball.realgm.com).**

One row per upcoming free agent, including the free-agency season, the
player's Bird/veteran free-agent status, recent production and –
distinctively – the player's listed agent.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_future_free_agents()
```

## Value

A `hoopR_data` tibble with one row per future free agent:

|                   |           |                                        |
|-------------------|-----------|----------------------------------------|
| col_name          | types     | description                            |
| player            | character | Player name.                           |
| pos               | character | Position.                              |
| team              | character | Current team abbreviation.             |
| season            | character | Free-agency season (e.g. `2026-2027`). |
| age               | integer   | Age.                                   |
| yos               | integer   | Years of service.                      |
| veteran_fa_status | character | Bird / Non-Bird / veteran FA status.   |
| gp                | integer   | Games played.                          |
| pts               | numeric   | Points per game.                       |
| reb               | numeric   | Rebounds per game.                     |
| ast               | numeric   | Assists per game.                      |
| per               | numeric   | Player Efficiency Rating.              |
| agent             | character | Listed player agent.                   |

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
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
if (FALSE) { # \dontrun{
  try(realgm_future_free_agents())
} # }
```
