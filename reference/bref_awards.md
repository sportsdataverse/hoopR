# **Basketball-Reference Awards Voting**

**Get end-of-season award voting from
[Basketball-Reference](https://www.basketball-reference.com).**

Returns the voting results for the major end-of-season awards (MVP,
Rookie of the Year, Defensive Player of the Year, Sixth Man, Most
Improved, Clutch Player, Coach of the Year) in one tidy tibble, one row
per candidate per award. No API key is required. Basketball-Reference
rate-limits aggressive scraping (~20 requests/minute) – space repeated
calls with [`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_awards(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per award candidate:

|  |  |  |
|----|----|----|
| col_name | types | description |
| award | character | Award slug (`mvp`, `roy`, `dpoy`, `smoy`, `mip`, `clutch_poy`, `coy`). |
| rank | integer | Finish in the voting. |
| player | character | Player (or coach) name. |
| age | integer | Age. |
| team | character | Team abbreviation. |
| votes_first | numeric | First-place votes. |
| points_won | numeric | Voting points won. |
| points_max | numeric | Maximum possible voting points. |
| award_share | numeric | Share of the maximum voting points. |
| season | integer | Season (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_awards(season = 2024))
#> ── Award voting from basketball-reference.com ─────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 03:58:38 UTC
#> # A tibble: 80 × 10
#>    rank  player    age team  votes_first points_won points_max award_share award
#>    <chr> <chr>   <dbl> <chr>       <dbl>      <dbl>      <dbl>       <dbl> <chr>
#>  1 1     Nikola…    28 DEN            79        926        990       0.935 mvp  
#>  2 2     Shai G…    25 OKC            15        640        990       0.646 mvp  
#>  3 3     Luka D…    24 DAL             4        566        990       0.572 mvp  
#>  4 4     Gianni…    29 MIL             1        192        990       0.194 mvp  
#>  5 5     Jalen …    27 NYK             0        142        990       0.143 mvp  
#>  6 6     Jayson…    25 BOS             0         86        990       0.087 mvp  
#>  7 7     Anthon…    22 MIN             0         18        990       0.018 mvp  
#>  8 8     Domant…    27 SAC             0          3        990       0.003 mvp  
#>  9 9     Kevin …    35 PHO             0          1        990       0.001 mvp  
#> 10 1     Victor…    20 SAS            99        495        495       1     roy  
#> # ℹ 70 more rows
#> # ℹ 1 more variable: season <int>
# }
```
