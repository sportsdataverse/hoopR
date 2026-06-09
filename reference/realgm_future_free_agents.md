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
# \donttest{
  try(realgm_future_free_agents())
#> ── Future NBA free agents from basketball.realgm.com ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 19:17:12 UTC
#> # A tibble: 784 × 13
#>    player     pos   team  season   age   yos veteran_fa_status    gp   pts   reb
#>    <chr>      <chr> <chr> <chr>  <dbl> <dbl> <chr>             <dbl> <dbl> <dbl>
#>  1 Precious … SF    SAC   2026-…    26     6 Non-Bird             73 10.1   6.74
#>  2 Steven Ad… C     HOU   2028-…    34    15 Bird                 32  5.84  8.62
#>  3 Bam Adeba… C     MIA   2028-…    30    11 Bird                 73 20.1  10.0 
#>  4 Bam Adeba… C     MIA   2029-…    31    12 Bird                 73 20.1  10.0 
#>  5 Ochai Agb… SF    BRK   2026-…    26     4 Bird                 62  5.06  2.27
#>  6 Santi Ald… C     MEM   2028-…    27     7 Bird                 43 14     6.67
#>  7 Santi Ald… C     MEM   2027-…    26     6 Bird                 43 14     6.67
#>  8 Trey Alex… SG    NOP   2026-…    23     2 Non-Bird              9  5.22  1.22
#>  9 Nickeil A… SG    ATL   2028-…    29     9 Bird                 78 20.8   3.44
#> 10 Nickeil A… SG    ATL   2029-…    30    10 Bird                 78 20.8   3.44
#> # ℹ 774 more rows
#> # ℹ 3 more variables: ast <dbl>, per <dbl>, agent <chr>
# }
```
