# **RealGM NBA Standings**

**Get the current NBA standings (both conferences) from
[RealGM](https://basketball.realgm.com).**

One row per team with record, win pct, games back, streak, last-ten,
scoring margin and home/away/division/conference splits. The Eastern and
Western conference tables are stacked and labelled by a `conference`
column.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_standings()
```

## Value

A `hoopR_data` tibble with one row per team:

|            |           |                           |
|------------|-----------|---------------------------|
| col_name   | types     | description               |
| number     | integer   | Conference rank.          |
| team       | character | Team name.                |
| w          | integer   | Wins.                     |
| l          | integer   | Losses.                   |
| pct        | numeric   | Win percentage.           |
| gb         | numeric   | Games back.               |
| l10        | character | Last-ten record.          |
| strk       | character | Current streak.           |
| ppg        | numeric   | Points per game.          |
| oppg       | numeric   | Opponent points per game. |
| diff       | numeric   | Scoring margin.           |
| home       | character | Home record.              |
| away       | character | Away record.              |
| conference | character | `Eastern` or `Western`.   |

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
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_standings())
#> ── NBA standings from basketball.realgm.com ───────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:18 UTC
#> # A tibble: 30 × 18
#>    number team           w     l   pct    gb l10   strk    ppg  oppg  diff home 
#>     <dbl> <chr>      <dbl> <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <dbl> <chr>
#>  1      1 Detroit P…    60    22 0.732     0 8-2   W 3    118.  110.   8.2 32-9 
#>  2      2 Boston Ce…    56    26 0.683     4 8-2   W 2    115.  107.   7.7 30-11
#>  3      3 New York …    53    29 0.646     7 6-4   L 1    116.  110.   6.4 30-10
#>  4      4 Cleveland…    52    30 0.634     8 7-3   W 1    120.  115.   4.1 27-14
#>  5      5 Atlanta H…    46    36 0.561    14 6-4   L 1    118.  116    2.5 24-17
#>  6      6 Toronto R…    46    36 0.561    14 6-4   W 1    115.  112.   2.8 24-17
#>  7      7 Philadelp…    45    37 0.549    15 6-4   W 2    116.  116.  -0.2 23-18
#>  8      8 Orlando M…    45    37 0.549    15 7-3   L 1    116.  115.   0.6 26-16
#>  9      9 Charlotte…    44    38 0.537    16 6-4   W 1    116   111.   4.8 21-20
#> 10     10 Miami Heat    43    39 0.524    17 5-5   W 2    121.  118.   2.4 26-15
#> # ℹ 20 more rows
#> # ℹ 6 more variables: away <chr>, div <chr>, conf <chr>, rem <dbl>, rowp <dbl>,
#> #   conference <chr>
# }
```
