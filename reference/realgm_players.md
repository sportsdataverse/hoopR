# **RealGM NBA Player Index**

**Get the active NBA player index from
[RealGM](https://basketball.realgm.com).**

Returns RealGM's roster of active NBA players, including position,
listed height/weight, age, current team, years of service and pre-draft
team – the pre-draft / international detail RealGM is known for.

**Requires a headless browser.** RealGM is behind a Cloudflare
JavaScript challenge, so the `realgm_*()` functions drive headless
Chrome via the optional chromote package (install it and Google Chrome).
A plain HTTP client receives an HTTP 403 challenge page.

## Usage

``` r
realgm_players()
```

## Value

A `hoopR_data` tibble with one row per active player:

|                |           |                                |
|----------------|-----------|--------------------------------|
| col_name       | types     | description                    |
| number         | integer   | Row number.                    |
| player         | character | Player name.                   |
| pos            | character | Position.                      |
| ht             | character | Listed height.                 |
| wt             | integer   | Listed weight (lbs).           |
| age            | numeric   | Age.                           |
| current_team   | character | Current NBA team.              |
| yos            | integer   | Years of service.              |
| pre_draft_team | character | Pre-draft team / school.       |
| draft_status   | character | Draft pick / undrafted status. |
| nationality    | character | Player nationality.            |

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
  try(realgm_players())
} # }
```
