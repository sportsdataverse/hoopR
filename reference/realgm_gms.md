# **RealGM NBA General Managers**

**Get the current NBA general managers from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_gms()
```

## Value

A `hoopR_data` tibble with one row per general manager (`staff`, `team`,
`start_season`, `years_in_role`, `birth_date`, `nationality`).

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md),
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
  try(realgm_gms())
#> ── NBA general managers from basketball.realgm.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:20:55 UTC
#> # A tibble: 22 × 6
#>    staff           team        start_season years_in_role birth_date nationality
#>    <chr>           <chr>       <chr>                <dbl> <chr>      <chr>      
#>  1 Chad Buchanan   Indiana Pa… 2017-2018                9 -          United Sta…
#>  2 Joe Cronin      Portland T… 2021-2022                5 -          United Sta…
#>  3 Will Dawkins    Washington… 2023-2024                3 -          United Sta…
#>  4 Mike Dunleavy   Golden Sta… 2023-2024                3 Sep 15, 1… United Sta…
#>  5 Andy Elisburg   Miami Heat  2013-2014               13 -          United Sta…
#>  6 Michael Finley  Dallas Mav… 2025-2026                1 Mar 6, 19… United Sta…
#>  7 Brian Gregory   Phoenix Su… 2024-2025                2 Dec 15, 1… United Sta…
#>  8 Jon Horst       Milwaukee … 2016-2017               10 -          United Sta…
#>  9 Zachary Kleiman Memphis Gr… 2019-2020                7 -          United Sta…
#> 10 Matt Lloyd      Minnesota … 2024-2025                2 -          United Sta…
#> # ℹ 12 more rows
# }
```
