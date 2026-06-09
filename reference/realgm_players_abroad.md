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
# \donttest{
  try(realgm_players_abroad())
#> ── NBA players abroad from basketball.realgm.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:09 UTC
#> # A tibble: 43 × 11
#>    player      pos   ht       wt nba_status team_s    gp   mpg   ppg   rpg   apg
#>    <chr>       <chr> <chr> <dbl> <chr>      <chr>  <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 Taran Arms… G     6-5     190 Restricte… Dubai…    18  11.2  1.94  1.28  1.5 
#>  2 Damion Bau… SG    6-4     194 Unrestric… Valle…     7  31.4 11.7   3.43  8.86
#>  3 Malik Beas… SG    6-4     187 Unrestric… Cangr…    17  28.1 18.4   4.18  1.76
#>  4 Bol Bol     C     7-3     220 Unrestric… Talk …    16  38   35.9  13.8   1.75
#>  5 B.J. Bosto… SG    6-6     188 Unrestric… Fener…    50  13.6  5.94  2     0.48
#>  6 Jared Butl… PG    6-3     193 Unrestric… KK Cr…    60  19.7 12.8   2     3.73
#>  7 Vlatko Can… SF    6-8     236 Unrestric… AX Ar…     2   7.7  0     0     0   
#>  8 Josh Chris… G     6-4     215 Unrestric… Sioux…     8  16.8 13.8   4.75  2.25
#>  9 Torrey Cra… GF    6-5     221 Unrestric… Mets …    26  29   14.3   6.77  2.65
#> 10 Jae Crowder SF    6-6     235 Unrestric… Vaque…    21  26.6 15.0   5.81  2.71
#> # ℹ 33 more rows
# }
```
