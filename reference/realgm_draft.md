# **RealGM NBA Draft Results**

**Get the results of a past NBA draft from
[RealGM](https://basketball.realgm.com).**

One row per selection (rounds 1 and 2, labelled by `round`) plus the
listed undrafted players (`round = NA`), including pre-draft team /
international club, age, years of service and nationality.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft(year = most_recent_nba_season() - 1L)
```

## Arguments

- year:

  Draft year (the calendar year the draft was held). Defaults to the
  most recently completed draft (`most_recent_nba_season() - 1`).

## Value

A `hoopR_data` tibble carrying `draft_year` and `round` columns:

|                |           |                                            |
|----------------|-----------|--------------------------------------------|
| col_name       | types     | description                                |
| pick           | integer   | Overall pick number (`NA` for undrafted).  |
| player         | character | Player name.                               |
| team           | character | Drafting team abbreviation.                |
| draft_trades   | character | Draft-night trade note, if any.            |
| pos            | character | Position.                                  |
| ht             | character | Listed height.                             |
| wt             | integer   | Listed weight (lbs).                       |
| age            | numeric   | Age at draft.                              |
| yos            | integer   | Years of service since.                    |
| pre_draft_team | character | Pre-draft team / school / club.            |
| class          | character | College class / draft eligibility note.    |
| nationality    | character | Player nationality.                        |
| round          | integer   | Draft round (`1`, `2`, or `NA` undrafted). |
| draft_year     | numeric   | Draft year (echoes `year`).                |

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
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
  try(realgm_draft(year = 2020))
#> ── NBA past draft from basketball.realgm.com ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:20:46 UTC
#> # A tibble: 139 × 14
#>     pick player  team  draft_trades pos   ht       wt   age   yos pre_draft_team
#>    <dbl> <chr>   <chr> <chr>        <chr> <chr> <dbl> <dbl> <dbl> <chr>         
#>  1     1 Anthon… MIN   ""           SF    6-4     225    19     5 Georgia       
#>  2     2 James … GOS   ""           C     6-11    240    19     5 Memphis       
#>  3     3 LaMelo… CHA   ""           G     6-7     180    19     5 Illawarra (Au…
#>  4     4 Patric… CHI   ""           G     6-6     235    19     5 Florida State 
#>  5     5 Isaac … CLE   ""           SG    6-4     225    19     5 Auburn        
#>  6     6 Onyeka… ATL   ""           PF    6-10    240    19     5 USC           
#>  7     7 Killia… DET   ""           G     6-4     195    19     5 Ratiopharm Ul…
#>  8     8 Obi To… NYK   ""           F     6-9     220    22     5 Dayton        
#>  9     9 Deni A… WAS   ""           SG    6-8     228    19     5 Maccabi Tel A…
#> 10    10 Jalen … PHX   ""           C     6-8     244    20     5 Maryland      
#> # ℹ 129 more rows
#> # ℹ 4 more variables: class <chr>, nationality <chr>, round <dbl>,
#> #   draft_year <dbl>
# }
```
