# **RealGM NBA Rookie Scale**

**Get the current NBA rookie-scale salary table from
[RealGM](https://basketball.realgm.com).**

One row per first-round pick with the four contract-year amounts and the
qualifying-offer percentage. Dollar figures are the formatted strings
RealGM publishes.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_rookie_scale()
```

## Value

A `hoopR_data` tibble with one row per first-round pick (`pick`,
`x1st_year_salary`, `x2nd_year_salary`, `x3rd_year_option_salary`, the
4th-year option increase and qualifying-offer increase).

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
[`realgm_salary_cap()`](https://hoopR.sportsdataverse.org/reference/realgm_salary_cap.md),
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_rookie_scale())
#> ── NBA rookie scale from basketball.realgm.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:37 UTC
#> # A tibble: 30 × 6
#>     pick x1st_year_salary x2nd_year_salary x3rd_year_option_salary
#>    <dbl> <chr>            <chr>            <chr>                  
#>  1     1 $11,521,600      $12,097,900      $12,673,900            
#>  2     2 $10,308,600      $10,824,200      $11,339,800            
#>  3     3 $9,257,400       $9,719,900       $10,183,200            
#>  4     4 $8,346,400       $8,763,800       $9,181,300             
#>  5     5 $7,558,200       $7,935,900       $8,313,800             
#>  6     6 $6,864,700       $7,208,000       $7,551,400             
#>  7     7 $6,266,700       $6,580,200       $6,893,300             
#>  8     8 $5,741,000       $6,028,100       $6,315,200             
#>  9     9 $5,277,100       $5,541,300       $5,805,000             
#> 10    10 $5,013,400       $5,263,900       $5,514,300             
#> # ℹ 20 more rows
#> # ℹ 2 more variables:
#> #   x4th_year_option_percentage_increased_over_3rd_year_salary <chr>,
#> #   qualifying_offer_percentage_increase_over_4th_year_salary <chr>
# }
```
