# **Get Basketligaen Box Score**

Player box score and team rows of both sides (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/boxscore/{game_uuid}`

## Usage

``` r
sportality_boxscore(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per player or team row, per side. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_boxscore")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_boxscore(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Box Score from basketligaen.dk ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:14:48 UTC
#> # A tibble: 28 × 32
#>    team_side row_type player_id team_id team_name    period full_name first_name
#>    <chr>     <chr>        <int>   <int> <chr>         <int> <chr>     <chr>     
#>  1 home      player     1887576  153747 Holbæk-Sten…      0 Oskar Fl… Oskar Flø…
#>  2 home      player     2777479  153747 Holbæk-Sten…      0 Bryceson… Bryceson  
#>  3 home      player     2404639  153747 Holbæk-Sten…      0 Anders J… Anders    
#>  4 home      player     2779432  153747 Holbæk-Sten…      0 Sebastia… Sebastian 
#>  5 home      player     2777481  153747 Holbæk-Sten…      0 Otto Jer… Otto      
#>  6 home      player     1951861  153747 Holbæk-Sten…      0 August H… August    
#>  7 home      player     2495922  153747 Holbæk-Sten…      0 Karl Hem… Karl      
#>  8 home      player     2380378  153747 Holbæk-Sten…      0 Julius A… Julius    
#>  9 home      player     2385172  153747 Holbæk-Sten…      0 Malthe A… Malthe    
#> 10 home      player     2778538  153747 Holbæk-Sten…      0 Caden Fry Caden     
#> # ℹ 18 more rows
#> # ℹ 24 more variables: last_name <chr>, nr <int>, pos <chr>, mins <chr>,
#> #   pts <int>, fg <chr>, fg_perc <dbl>, `2_p` <chr>, `2_p_perc` <dbl>,
#> #   `3_p` <chr>, `3_p_perc` <dbl>, ft <chr>, ft_perc <dbl>, off <int>,
#> #   def <int>, reb <int>, ast <int>, to <int>, stl <int>, blk <int>,
#> #   blkr <int>, pf <int>, f_on <int>, plus_minus <int>
# }
```
