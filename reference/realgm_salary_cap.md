# **RealGM NBA Salary Cap History**

**Get the NBA salary-cap history (and projections) from
[RealGM](https://basketball.realgm.com).**

One row per season with the cap, luxury-tax line, both aprons, bi-annual
exception and the mid-level exception tiers. Dollar figures are returned
as the formatted strings RealGM publishes (e.g. `"$140,588,000"`).

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_salary_cap()
```

## Value

A `hoopR_data` tibble with one row per season:

|                  |           |                                   |
|------------------|-----------|-----------------------------------|
| col_name         | types     | description                       |
| season           | character | Season (e.g. `2025-2026`).        |
| salary_cap       | character | Salary cap.                       |
| luxury_tax       | character | Luxury-tax threshold.             |
| x1st_apron       | character | First apron.                      |
| x2nd_apron       | character | Second apron.                     |
| bae              | character | Bi-annual exception.              |
| non_taxpayer_mle | character | Non-taxpayer mid-level exception. |
| taxpayer_mle     | character | Taxpayer mid-level exception.     |
| team_room_mle    | character | Room mid-level exception.         |

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
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_salary_cap())
} # }
```
