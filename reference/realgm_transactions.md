# **RealGM NBA Transactions Log**

**Get the NBA league transactions log from
[RealGM](https://basketball.realgm.com).**

One row per transaction (signings, waivers, two-way conversions,
G-League assignments/recalls, trades), each tagged with its date. RealGM
publishes the transactions as a dated narrative list rather than a
table, so this parses the page DOM directly.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_transactions()
```

## Value

A `hoopR_data` tibble with one row per transaction:

|             |           |                          |
|-------------|-----------|--------------------------|
| col_name    | types     | description              |
| date        | Date      | Transaction date.        |
| transaction | character | Transaction description. |

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
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md)

## Examples

``` r
# \donttest{
  try(realgm_transactions())
#> ── NBA transactions log from basketball.realgm.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:27 UTC
#> # A tibble: 2,798 × 2
#>    date       transaction                                                       
#>    <date>     <chr>                                                             
#>  1 2026-04-13 Adama-Alpha Bal, previously with the Memphis Grizzlies, became a …
#>  2 2026-04-13 Toby Okani, previously with the Memphis Grizzlies, became a free …
#>  3 2026-04-13 Tre Scott, previously with the Brooklyn Nets, became a free agent.
#>  4 2026-04-13 Dariq Whitehead, previously with the Memphis Grizzlies, became a …
#>  5 2026-04-13 Lucas Williamson, previously with the Memphis Grizzlies, became a…
#>  6 2026-04-12 Nick Smith, Jr. signed a multi-year contract with the Los Angeles…
#>  7 2026-04-12 The Los Angeles Lakers ended the two-way contract of Nick Smith, …
#>  8 2026-04-12 Kobe Bufkin, previously with the Los Angeles Lakers, became a fre…
#>  9 2026-04-12 Tyreke Key, previously with the Toronto Raptors, became a free ag…
#> 10 2026-04-12 Cameron Payne, previously with the Philadelphia Sixers, became a …
#> # ℹ 2,788 more rows
# }
```
