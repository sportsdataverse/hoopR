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
# \donttest{
  try(realgm_salary_cap())
#> ── NBA salary cap history from basketball.realgm.com ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:14 UTC
#> # A tibble: 52 × 9
#>    season    salary_cap  luxury_tax x1st_apron x2nd_apron bae   non_taxpayer_mle
#>    <chr>     <chr>       <chr>      <chr>      <chr>      <chr> <chr>           
#>  1 2034-2035 $243,781,0… $296,194,… $308,833,… $327,558,… $8,0… $22,233,000     
#>  2 2033-2034 $232,172,0… $282,089,… $294,126,… $311,959,… $7,7… $21,174,000     
#>  3 2032-2033 $221,116,0… $268,656,… $280,120,… $297,104,… $7,3… $20,166,000     
#>  4 2031-2032 $210,587,0… $255,863,… $266,781,… $282,956,… $6,9… $19,206,000     
#>  5 2030-2031 $200,559,0… $243,679,… $254,077,… $269,482,… $6,6… $18,291,000     
#>  6 2029-2030 $191,009,0… $232,076,… $241,979,… $256,651,… $6,3… $17,420,000     
#>  7 2028-2029 $181,913,0… $221,024,… $230,455,… $244,428,… $6,0… $16,590,000     
#>  8 2027-2028 $173,250,0… $210,499,… $219,481,… $232,789,… $5,7… $15,800,000     
#>  9 2026-2027 $165,000,0… $201,000,… $209,000,… $222,000,… $5,4… $15,048,000     
#> 10 2025-2026 $154,647,0… $187,895,… $195,945,… $207,824,… $5,1… $14,104,000     
#> # ℹ 42 more rows
#> # ℹ 2 more variables: taxpayer_mle <chr>, team_room_mle <chr>
# }
```
