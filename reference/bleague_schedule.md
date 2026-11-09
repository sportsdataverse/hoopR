# **B.LEAGUE Schedule**

**Games of one day of one B.LEAGUE competition and division: schedule
keys, clubs, scores, venue, tip-off.**

Endpoint: `GET https://www.bleague.jp/schedule/`

One row per game of that day with its `schedule_key` (the key every game
wrapper takes), local date, round, both clubs (`team_id` is text; names
are the page's short Japanese names), final score, venue and tip-off
time (a bare Japan-time `HH:MM`). `tab` is the division (1 = B1, 2 = B2,
3 = B3) and `event` the competition type; `season` is the END year.

## Usage

``` r
bleague_schedule(season, tab, month, day, event = NULL)
```

## Arguments

- season:

  (*integer* required): season END year (`2026` = 2025-26); the site's
  own year is the START year, so the request sends `season - 1`.

- tab:

  (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.

- month:

  (*integer* required): calendar month 1-12 of the game day (seasons run
  September to June).

- day:

  (*integer* required): day of month of the game day.

- event:

  (*integer* optional): competition type: 2 B1 league, 3 B1
  Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2
  playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs.
  `NULL` (default) = the league competition of the tab (2 / 7 / 15).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

## See also

[family_b_league](https://hoopR.sportsdataverse.org/reference/family_b_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(bleague_schedule(season = 2026, tab = 1, month = 10, day = 4))
#> ── B.LEAGUE schedule from www.bleague.jp ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:09:24 UTC
#> # A tibble: 12 × 17
#>    season   tab event schedule_key date       round_label round home_team_id
#>     <int> <int> <int>        <int> <date>     <chr>       <int> <chr>       
#>  1   2026     1     2       504748 2025-10-04 第1節           1 700         
#>  2   2026     1     2       504750 2025-10-04 第1節           1 1638        
#>  3   2026     1     2       504730 2025-10-04 第1節           1 745         
#>  4   2026     1     2       504732 2025-10-04 第1節           1 2486        
#>  5   2026     1     2       504740 2025-10-04 第1節           1 728         
#>  6   2026     1     2       504746 2025-10-04 第1節           1 699         
#>  7   2026     1     2       504742 2025-10-04 第1節           1 717         
#>  8   2026     1     2       504744 2025-10-04 第1節           1 729         
#>  9   2026     1     2       504728 2025-10-04 第1節           1 692         
#> 10   2026     1     2       504736 2025-10-04 第1節           1 726         
#> 11   2026     1     2       504738 2025-10-04 第1節           1 727         
#> 12   2026     1     2       504752 2025-10-04 第1節           1 701         
#> # ℹ 9 more variables: home_team <chr>, home_score <int>, away_team_id <chr>,
#> #   away_team <chr>, away_score <int>, prefecture <chr>, venue <chr>,
#> #   tip_time <chr>, state <chr>
# }
```
