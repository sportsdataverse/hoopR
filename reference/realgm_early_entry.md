# **RealGM NBA Draft Early Entrants**

**Get the current NBA draft early-entrant and withdrawal list from
[RealGM](https://basketball.realgm.com).**

Stacks RealGM's early-entry candidate tables (college and international
entrants and withdrawals) into one tibble.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_early_entry()
```

## Value

A `hoopR_data` tibble with one row per candidate (`player`, `pos`, `ht`,
`wt`, `birth_date`, `college` / `pre_draft_team`, `class`,
`draft_status`, `yos`, `nationality`).

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
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
  try(realgm_early_entry())
#> ── NBA draft early entrants from basketball.realgm.com ────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:15 UTC
#> # A tibble: 79 × 11
#>    player          pos   ht       wt birth_date college class draft_status   yos
#>    <chr>           <chr> <chr> <dbl> <chr>      <chr>   <chr> <chr>        <dbl>
#>  1 Matthew Able    SG    6-5     190 Jul 12, 2… NC Sta… Fr    N/A              0
#>  2 Amari Allen     PF    6-8     180 Jan 26, 2… Alabama Fr    N/A              0
#>  3 Alijah Arenas   SF    6-6     195 Mar 16, 2… USC     Fr    N/A              0
#>  4 Flory Bidunga   PF    6-10    235 May 20, 2… Louisv… So    N/A              0
#>  5 Finley Bizjack  SG    6-4     190 N/A        West V… Jr    N/A              0
#>  6 John Blackwell  SG    6-4     203 Dec 25, 2… Wiscon… Jr    N/A              0
#>  7 Shane Blakeney  SG    6-5     200 N/A        Drexel  Jr    N/A              0
#>  8 Anton Bonke     C     7-2     270 Aug 4, 20… Michig… Jr    N/A              0
#>  9 Rowan Brumbaugh SG    6-4     190 Mar 7, 20… Tulane  Jr    N/A              0
#> 10 Elliot Cadeau   PG    6-1     180 Sep 4, 20… Michig… Jr    N/A              0
#> # ℹ 69 more rows
#> # ℹ 2 more variables: nationality <chr>, pre_draft_team <chr>
# }
```
