# **RealGM NBA Teams Index**

**Get the NBA team index, with division and conference, from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_teams()
```

## Value

A `hoopR_data` tibble with one row per team:

|            |           |                             |
|------------|-----------|-----------------------------|
| col_name   | types     | description                 |
| team       | character | Team name.                  |
| division   | character | Division (e.g. `Atlantic`). |
| conference | character | `Eastern` or `Western`.     |

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
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_teams())
#> ── NBA teams index from basketball.realgm.com ─────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:22 UTC
#> # A tibble: 30 × 3
#>    team                division conference
#>    <chr>               <chr>    <chr>     
#>  1 Boston Celtics      Atlantic Eastern   
#>  2 Brooklyn Nets       Atlantic Eastern   
#>  3 New York Knicks     Atlantic Eastern   
#>  4 Philadelphia Sixers Atlantic Eastern   
#>  5 Toronto Raptors     Atlantic Eastern   
#>  6 Chicago Bulls       Central  Eastern   
#>  7 Cleveland Cavaliers Central  Eastern   
#>  8 Detroit Pistons     Central  Eastern   
#>  9 Indiana Pacers      Central  Eastern   
#> 10 Milwaukee Bucks     Central  Eastern   
#> # ℹ 20 more rows
# }
```
