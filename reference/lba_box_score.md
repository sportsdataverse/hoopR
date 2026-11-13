# **Get LBA Box Score**

Box score of a final game: one row per player of both teams
(Italian-named stat columns).

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id`
(`info=true&id=<game_id>`)

## Usage

``` r
lba_box_score(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per player of both teams. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_box_score")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_box_score(game_id = 25602))
#> ── LBA Box Score from legabasket.it ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:56:10 UTC
#> # A tibble: 24 × 39
#>    game_id season side  team_id player_id player_num player_surname player_name
#>      <int>  <int> <chr>   <int>     <int>      <int> <chr>          <chr>      
#>  1   25602   2027 home     1764       969          0 CAPPELLETTI    Alessandro 
#>  2   25602   2027 home     1764      9331          2 CARTER         Chico      
#>  3   25602   2027 home     1764      9041          3 CHAPMAN        Brekkott   
#>  4   25602   2027 home     1764      4879          4 RUSSELL        DeWayne    
#>  5   25602   2027 home     1764      7566          8 MANFREDOTTI    Alessandro 
#>  6   25602   2027 home     1764      3714         11 MIASCHI        Federico   
#>  7   25602   2027 home     1764      9042         13 ANIGBOGU       Ike        
#>  8   25602   2027 home     1764      9332         19 ALLINEI        Gregorio   
#>  9   25602   2027 home     1764      7607         24 IAQUINTA       Antonio    
#> 10   25602   2027 home     1764      1189         26 CHILLO         Matteo     
#> # ℹ 14 more rows
#> # ℹ 31 more variables: player_code <chr>, player_p_key <chr>, pun <int>,
#> #   min <int>, sec <int>, sf <chr>, falli_c <int>, falli_sf <int>,
#> #   falli_tc1 <int>, falli_fla <int>, t2_r <int>, t2_t <int>, t2_perc <dbl>,
#> #   sc <int>, t3_r <int>, t3_t <int>, t3_perc <dbl>, tl_r <int>, tl_t <int>,
#> #   tl_perc <dbl>, rimbalzi_o <int>, rimbalzi_d <int>, rimbalzi_t <int>,
#> #   stoppate_dat <int>, stoppate_sub <int>, palle_p <int>, palle_r <int>, …
# }
```
