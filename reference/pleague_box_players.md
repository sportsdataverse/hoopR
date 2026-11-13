# **Get P. LEAGUE+ Player Box Score**

Player box score of one finished game: minutes, points, shooting splits,
rebounds, assists, plus/minus, and the ratings from 2022-23;
did-not-play rows included.

Endpoint:
`GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`

## Usage

``` r
pleague_box_players(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_box_players")`) and in the
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
  try(pleague_box_players(gid = 197))
#> ── P. LEAGUE+ Player Box from pleagueofficial.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:01:37 UTC
#> # A tibble: 26 × 47
#>      gid side  player_id person_id       random_id name_zh jersey starter played
#>    <int> <chr>     <int> <chr>           <chr>     <chr>   <chr>  <lgl>   <lgl> 
#>  1   197 home         40 26633c72-3d8d-… 1JbPozLB  賴廷恩  0      TRUE    TRUE  
#>  2   197 home         46 266973f4-3d8d-… 1imawJqL  周桂羽  8      FALSE   TRUE  
#>  3   197 home         49 266c1c4e-3d8d-… 1iclgBLT  林孟學  13     FALSE   TRUE  
#>  4   197 home         52 266e806e-3d8d-… 1hVSapP7  曾祥鈞  88     TRUE    TRUE  
#>  5   197 home         48 267bd121-3d8d-… 1iG5OYyZ  林志傑  12     FALSE   TRUE  
#>  6   197 home         50 267e9e03-3d8d-… 1I3hiwZr  蔡文誠  14     FALSE   TRUE  
#>  7   197 home         53 2681570d-3d8d-… 1HPVfP2B  石博恩  23     FALSE   TRUE  
#>  8   197 home        261 28be45ae-3d8d-… 0t1JFW9h  瓊斯    11     TRUE    TRUE  
#>  9   197 home        269 7ff29ae5-4554-… 0sjcEvTQ  強森    5      TRUE    TRUE  
#> 10   197 home        274 7ffade61-4554-… 0s67qUMZ  謝宗融  19     FALSE   TRUE  
#> # ℹ 16 more rows
#> # ℹ 38 more variables: minutes <chr>, seconds <int>, points <int>,
#> #   reb_off <int>, reb_def <int>, reb <int>, ast <int>, stl <int>, blk <int>,
#> #   tov <int>, pf <int>, plus_minus <int>, eff <int>, fg2_made <int>,
#> #   fg2_att <int>, fg2_pct <dbl>, fg3_made <int>, fg3_att <int>, fg3_pct <dbl>,
#> #   ft_made <int>, ft_att <int>, ft_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>,
#> #   usage_pct <dbl>, position <chr>, ortg <dbl>, drtg <dbl>, netrtg <dbl>, …
# }
```
