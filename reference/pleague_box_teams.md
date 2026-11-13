# **Get P. LEAGUE+ Team Box Score**

Team totals of one finished game: the box score's total row, home then
away.

Endpoint:
`GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`

## Usage

``` r
pleague_box_teams(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_box_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_box_teams(gid = 197))
#> ── P. LEAGUE+ Team Box from pleagueofficial.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:16:40 UTC
#> # A tibble: 2 × 23
#>     gid side  minutes seconds points fg2_made fg2_att fg2_pct fg3_made fg3_att
#>   <int> <chr> <chr>     <int>  <int>    <int>   <int>   <dbl>    <int>   <int>
#> 1   197 home  240:00    14400    102       26      59    44.1       12      28
#> 2   197 away  240:00    14400     94       25      55    45.4       11      26
#> # ℹ 13 more variables: fg3_pct <dbl>, ft_made <int>, ft_att <int>,
#> #   ft_pct <dbl>, reb <int>, reb_off <int>, reb_def <int>, ast <int>,
#> #   stl <int>, blk <int>, tov <int>, pf <int>, plus_minus <int>
# }
```
