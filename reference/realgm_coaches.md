# **RealGM NBA Head Coaches**

**Get the current NBA head coaches from
[RealGM](https://basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_coaches()
```

## Value

A `hoopR_data` tibble with one row per coach:

|               |           |                                         |
|---------------|-----------|-----------------------------------------|
| col_name      | types     | description                             |
| staff         | character | Coach name.                             |
| team          | character | Team name.                              |
| start_season  | character | Season the coach started with the team. |
| years_in_role | integer   | Seasons in the role.                    |
| birth_date    | character | Birth date (when listed).               |
| nationality   | character | Nationality.                            |

## See also

Other RealGM Functions:
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
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_coaches())
#> ── NBA head coaches from basketball.realgm.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:20:44 UTC
#> # A tibble: 29 × 6
#>    staff            team       start_season years_in_role birth_date nationality
#>    <chr>            <chr>      <chr>                <dbl> <chr>      <chr>      
#>  1 David Adelman    Denver Nu… 2024-2025                2 -          United Sta…
#>  2 Kenny Atkinson   Cleveland… 2024-2025                2 Jun 2, 19… United Sta…
#>  3 J.B. Bickerstaff Detroit P… 2024-2025                2 -          United Sta…
#>  4 Chauncey Billups Portland … 2021-2022                5 Sep 25, 1… United Sta…
#>  5 Mike Brown       New York … 2025-2026                1 -          United Sta…
#>  6 Rick Carlisle    Indiana P… 2021-2022                5 Oct 27, 1… United Sta…
#>  7 Doug Christie    Sacrament… 2024-2025                2 May 9, 19… United Sta…
#>  8 Mark Daigneault  Oklahoma … 2020-2021                6 -          United Sta…
#>  9 Jordi Fernandez  Brooklyn … 2024-2025                2 -          United Sta…
#> 10 Chris Finch      Minnesota… 2020-2021                6 -          United Sta…
#> # ℹ 19 more rows
# }
```
