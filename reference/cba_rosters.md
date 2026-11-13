# **Get CBA Rosters**

Registered rosters of both sides with player bio fields (the season
registration, not the game box).

Endpoint:
`GET https://data-server.cbaleague.com/api/schedules/getPlayersByScheduleId/{schedule_id}`

## Usage

``` r
cba_rosters(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per registered player. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_rosters")`) and in the searchable
[return
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
  try(cba_rosters(schedule_id = 100105799))
#> ── CBA Rosters from data-server.cbaleague.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:49:00 UTC
#> # A tibble: 32 × 38
#>    schedule_id side    age birth_date body_data   cn_alias cn_alias_show cn_name
#>          <int> <chr> <int> <chr>      <chr>       <chr>    <chr>         <chr>  
#>  1   100105799 home      0 2006-01-24 "{\"cNName… 蔡束林森 蔡束林森      蔡束林森……
#>  2   100105799 home      0 2006-02-07 "{\"cNName… 崔新泉   ---           崔新泉 
#>  3   100105799 home      0 2006-12-23 "{\"cNName… 侯孟泽   侯孟泽        侯孟泽 
#>  4   100105799 home      0 1997-09-24 "{\"cNName… 胡金秋   胡金秋        胡金秋 
#>  5   100105799 home      0 1997-04-16 "{\"cNName… 李金效   李金效        李金效 
#>  6   100105799 home      0 2006-03-21 "{\"cNName… 连宇     --            连宇   
#>  7   100105799 home      0 1996-04-26 "{\"cNName… 孙铭徽   孙铭徽        孙铭徽 
#>  8   100105799 home      0 2003-06-06 "{\"cNName… 王欣瑞   王欣瑞        王欣瑞 
#>  9   100105799 home      0 1999-06-02 "{\"cNName… 吴骁     吴骁          吴骁   
#> 10   100105799 home      0 2004-03-19 "{\"cNName… 续峻玮   续峻玮        续峻玮 
#> # ℹ 22 more rows
#> # ℹ 30 more variables: created_date <chr>, first_name <chr>, height <int>,
#> #   id <chr>, is_captain <lgl>, is_delete <lgl>, is_injury <lgl>,
#> #   is_three <int>, last_modified_date <chr>, last_name <chr>,
#> #   match_type_id <int>, nationality <chr>, number <chr>, player_cba_id <int>,
#> #   player_id <int>, player_pic <chr>, position <chr>,
#> #   position_description <chr>, position_string <chr>, season <int>, …
# }
```
