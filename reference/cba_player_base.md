# **Get CBA Player Base**

Season player box (one page of the season player table).

Endpoint: `POST https://data-server.cbaleague.com/api/player-base-list`
(JSON body)

## Usage

``` r
cba_player_base(
  season,
  match_type_id = 1,
  count_ranger = 1,
  player_ranger = 1,
  team_id = NULL,
  page_number = 1,
  page_size = 100
)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- count_ranger:

  (default `1`) How counting statistics scale: 1 per game (default), 2
  season total, 3 per 36 minutes, 4 per 100 possessions.

- player_ranger:

  (default `1`) Which players: 1 all (default), 2 domestic (Chinese)
  only, 4 foreign only.

- team_id:

  (optional) Optional CBA team id (clubs, stable across seasons and
  renames) to list one team's players.

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble with one row per player of the requested page. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_player_base")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_player_base(season = 2026, team_id = 29128))
#> ── CBA Player Base from data-server.cbaleague.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:58:59 UTC
#> # A tibble: 20 × 44
#>      age assists birth_date  blocked cn_alias field_goals field_goals_at_rim_a…¹
#>    <int>   <dbl> <chr>         <dbl> <chr>          <dbl>                  <dbl>
#>  1    29     3.9 1996-12-21…     0.1 布朗             6.7                     77
#>  2    28     5.4 1997-09-24…     0.3 塔克             5                      162
#>  3    28     1.2 1997-09-24…     0.2 胡金秋           7.1                    215
#>  4    33     1.2 1993-03-20…     1   桑普森           4.5                    127
#>  5    30     6.1 1996-04-26…     0.3 孙铭徽           3.4                     57
#>  6    27     0.8 1999-02-26…     0.7 卡尔顿           2.6                    131
#>  7    26     2.1 1999-07-13…     0.4 朱俊龙           2.2                     66
#>  8    27     0.8 1999-01-06…     0.2 赵嘉仁           2.2                     45
#>  9    28     0.6 1997-10-25…     0.2 赵岩昊           2.1                     47
#> 10    29     1.9 1996-12-26…     0.1 林秉圣           1.8                     32
#> 11    27     1   1998-08-26…     0   威廉姆斯         1.5                      4
#> 12    34     0.2 1991-12-02…     0.1 苏若禹           0.7                      6
#> 13    19     1.1 2006-12-23…     0.1 侯孟泽           0.5                      6
#> 14    19     0   2006-06-28…     1   周可梵           0                        0
#> 15    26     0.7 1999-06-02…     0.1 吴骁             0.4                     24
#> 16    22     0.1 2003-06-06…     0.1 王欣瑞           0.3                      2
#> 17    20     0   2006-02-07…     0   崔新泉           0.1                      3
#> 18    22     0.1 2004-03-19…     0   续峻玮           0.2                      3
#> 19    26     3   2000-05-09…     0   许可             0                        0
#> 20    23     0   2002-08-25…     0   赵佳一           0                        0
#> # ℹ abbreviated name: ¹​field_goals_at_rim_attempted
#> # ℹ 37 more variables: field_goals_at_rim_made <dbl>,
#> #   field_goals_attempted <dbl>, field_goals_mid_range_attempted <dbl>,
#> #   field_goals_mid_range_made <dbl>, field_goals_percentage <dbl>,
#> #   field_goals_percentage_sort <dbl>, fouls <dbl>, fouls_defensive <dbl>,
#> #   free_throws <dbl>, free_throws_attempted <dbl>,
#> #   free_throws_percentage <dbl>, free_throws_percentage_sort <dbl>, …
# }
```
