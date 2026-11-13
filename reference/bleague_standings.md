# **B.LEAGUE Standings**

**Standings of one B.LEAGUE season and division, one row per club per
table (conference, division or wild card).**

Endpoint: `GET https://www.bleague.jp/standings/`

One row per club per table. `section` is the table heading in Japanese
(East, Central and West divisions, wild card; B2 and B3 may have one
table with a different heading) and `section_en` its English name for
those four. A club can appear in a division table and in the wild-card
table. `win_pct` is a 0-1 fraction. The page shows the standings as of
the request, not a season end.

## Usage

``` r
bleague_standings(season, tab)
```

## Arguments

- season:

  (*integer* required): season END year (`2026` = 2025-26); the site's
  own year is the START year, so the request sends `season - 1`.

- tab:

  (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.

## Value

A `hoopR_data` tibble with one row per club per table. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_standings")`) and in the
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
  try(bleague_standings(season = 2026, tab = 1))
#> ── B.LEAGUE standings from www.bleague.jp ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:48:47 UTC
#> # A tibble: 48 × 22
#>    season   tab season_label section section_en  rank team_id team    team_short
#>     <int> <int> <chr>        <chr>   <chr>      <int> <chr>   <chr>   <chr>     
#>  1   2026     1 2025-26      東地区  East           1 703     宇都宮ブレッ… 宇都宮    
#>  2   2026     1 2025-26      東地区  East           2 704     千葉ジェッツ… 千葉J     
#>  3   2026     1 2025-26      東地区  East           3 713     群馬クレイン… 群馬      
#>  4   2026     1 2025-26      東地区  East           4 706     アルバルク東… A東京     
#>  5   2026     1 2025-26      東地区  East           5 702     レバンガ北海… 北海道    
#>  6   2026     1 2025-26      東地区  East           6 692     仙台89ER… 仙台      
#>  7   2026     1 2025-26      東地区  East           7 694     横浜ビー・コ… 横浜BC    
#>  8   2026     1 2025-26      東地区  East           8 726     サンロッカー… SR渋谷    
#>  9   2026     1 2025-26      東地区  East           9 745     越谷アルファ… 越谷      
#> 10   2026     1 2025-26      東地区  East          10 712     茨城ロボッツ… 茨城      
#> # ℹ 38 more rows
#> # ℹ 13 more variables: wins <int>, losses <int>, win_pct <dbl>,
#> #   games_behind <dbl>, points_for <int>, points_against <int>,
#> #   point_diff <int>, home_record <chr>, away_record <chr>, last_n <int>,
#> #   last_n_record <chr>, streak <chr>, division_title <chr>
# }
```
