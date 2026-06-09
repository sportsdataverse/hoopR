# **RealGM NBA Draft Results**

**Get the results of a past NBA draft from
[RealGM](https://basketball.realgm.com).**

One row per selection (rounds 1 and 2, labelled by `round`) plus the
listed undrafted players (`round = NA`), including pre-draft team /
international club, age, years of service and nationality.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft(year = most_recent_nba_season() - 1L)
```

## Arguments

- year:

  Draft year (the calendar year the draft was held). Defaults to the
  most recently completed draft (`most_recent_nba_season() - 1`).

## Value

A `hoopR_data` tibble carrying `draft_year` and `round` columns:

|                |           |                                            |
|----------------|-----------|--------------------------------------------|
| col_name       | types     | description                                |
| pick           | integer   | Overall pick number (`NA` for undrafted).  |
| player         | character | Player name.                               |
| team           | character | Drafting team abbreviation.                |
| draft_trades   | character | Draft-night trade note, if any.            |
| pos            | character | Position.                                  |
| ht             | character | Listed height.                             |
| wt             | integer   | Listed weight (lbs).                       |
| age            | numeric   | Age at draft.                              |
| yos            | integer   | Years of service since.                    |
| pre_draft_team | character | Pre-draft team / school / club.            |
| class          | character | College class / draft eligibility note.    |
| nationality    | character | Player nationality.                        |
| round          | integer   | Draft round (`1`, `2`, or `NA` undrafted). |
| draft_year     | numeric   | Draft year (echoes `year`).                |

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
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
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_draft(year = 2020))
} # }
```
