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
# \donttest{
  try(realgm_players())
#> ── NBA player index from basketball.realgm.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:32 UTC
#> # A tibble: 530 × 11
#>    number player       pos   ht       wt   age current_team   yos pre_draft_team
#>     <dbl> <chr>        <chr> <chr> <dbl> <dbl> <chr>        <dbl> <chr>         
#>  1      9 Precious Ac… SF    6-8     243    26 Sacramento …     5 Memphis       
#>  2     12 Steven Adams C     6-11    265    32 Houston Roc…    12 Pittsburgh    
#>  3     13 Bam Adebayo  C     6-9     255    28 Miami Heat       8 Kentucky      
#>  4     30 Ochai Agbaji SF    6-5     215    26 Brooklyn Ne…     3 Kansas        
#>  5      7 Santi Aldama C     7-0     215    25 Memphis Gri…     4 Loyola (MD)   
#>  6     23 Trey Alexan… SG    6-5     185    23 New Orleans…     1 Creighton     
#>  7      7 Nickeil Ale… SG    6-5     205    27 Atlanta Haw…     6 Virginia Tech 
#>  8      8 Grayson All… SG    6-3     198    30 Phoenix Suns     7 Duke          
#>  9     31 Jarrett All… C     6-9     243    28 Cleveland C…     8 Texas         
#> 10      5 Jose Alvara… G     6-0     179    28 New York Kn…     4 Georgia Tech  
#> # ℹ 520 more rows
#> # ℹ 2 more variables: draft_status <chr>, nationality <chr>
# }
```
