# **RealGM NBA Standings**

**Get the current NBA standings (both conferences) from
[RealGM](https://basketball.realgm.com).**

One row per team with record, win pct, games back, streak, last-ten,
scoring margin and home/away/division/conference splits. The Eastern and
Western conference tables are stacked and labelled by a `conference`
column.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_standings()
```

## Value

A `hoopR_data` tibble with one row per team:

|            |           |                           |
|------------|-----------|---------------------------|
| col_name   | types     | description               |
| number     | integer   | Conference rank.          |
| team       | character | Team name.                |
| w          | integer   | Wins.                     |
| l          | integer   | Losses.                   |
| pct        | numeric   | Win percentage.           |
| gb         | numeric   | Games back.               |
| l10        | character | Last-ten record.          |
| strk       | character | Current streak.           |
| ppg        | numeric   | Points per game.          |
| oppg       | numeric   | Opponent points per game. |
| diff       | numeric   | Scoring margin.           |
| home       | character | Home record.              |
| away       | character | Away record.              |
| conference | character | `Eastern` or `Western`.   |

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
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_standings())
} # }
```
