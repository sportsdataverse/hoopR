# **RealGM NBA Players Abroad**

**Get the list of NBA-affiliated players currently playing overseas from
[RealGM](https://basketball.realgm.com).**

RealGM tracks NBA draft picks, two-way and free-agent players who are on
international rosters – a view no first-party NBA/ESPN endpoint
provides.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_players_abroad()
```

## Value

A `hoopR_data` tibble with one row per player:

|            |           |                                               |
|------------|-----------|-----------------------------------------------|
| col_name   | types     | description                                   |
| player     | character | Player name.                                  |
| pos        | character | Position.                                     |
| ht         | character | Listed height.                                |
| wt         | integer   | Listed weight (lbs).                          |
| nba_status | character | NBA contract / rights status.                 |
| team_s     | character | Current overseas team(s) and NBA affiliation. |
| gp         | integer   | Games played.                                 |
| mpg        | numeric   | Minutes per game.                             |
| ppg        | numeric   | Points per game.                              |
| rpg        | numeric   | Rebounds per game.                            |
| apg        | numeric   | Assists per game.                             |

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
[`realgm_rookie_scale()`](https://hoopR.sportsdataverse.org/reference/realgm_rookie_scale.md),
[`realgm_salary_cap()`](https://hoopR.sportsdataverse.org/reference/realgm_salary_cap.md),
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_players_abroad())
} # }
```
