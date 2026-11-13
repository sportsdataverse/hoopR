# **Get P. LEAGUE+ Game**

Header of one finished game: date, venue, both clubs with their score
and the Preciser game uuid.

Endpoint: `GET https://pleagueofficial.com/game/{gid}`

## Usage

``` r
pleague_game(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_game")`) and in the searchable
[return
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
  try(pleague_game(gid = 197))
#> ── P. LEAGUE+ Game from pleagueofficial.com ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:58:21 UTC
#> # A tibble: 1 × 17
#>     gid uuid          status_zh finished date       time  venue_zh game_label_zh
#>   <int> <chr>         <chr>     <lgl>    <date>     <chr> <chr>    <chr>        
#> 1   197 e6f98675-3e5… 已完賽    TRUE     2022-11-05 17:00 臺北和平籃球館… 例行賽G1     
#> # ℹ 9 more variables: away_name_zh <chr>, away_name_en <chr>, away_logo <chr>,
#> #   away_score <int>, home_name_zh <chr>, home_name_en <chr>, home_logo <chr>,
#> #   home_score <int>, overtimes <int>
# }
```
