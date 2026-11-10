# **Get VTB Infobasket Box Score**

Player box score of a finished game (one row per player of each team,
DNPs included).

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_box_score(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble with one row per player of each team. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_box_score")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_box_score(game_id = 921391))
#> ── VTB Infobasket Box Score from org.infobasket.su ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:06:11 UTC
#> # A tibble: 24 × 47
#>    game_id team_id is_home person_id team_number player_number display_number
#>      <int>   <int> <lgl>       <int>       <int>         <int> <chr>         
#>  1  921391    2650 TRUE       423011           1             2 2             
#>  2  921391    2650 TRUE       337028           1             0 0             
#>  3  921391    2650 TRUE       393326           1             5 5             
#>  4  921391    2650 TRUE       490452           1             3 3             
#>  5  921391    2650 TRUE       377837           1            17 17            
#>  6  921391    2650 TRUE        55701           1            99 99            
#>  7  921391    2650 TRUE        24712           1            27 27            
#>  8  921391    2650 TRUE        39197           1            16 16            
#>  9  921391    2650 TRUE        51909           1            37 37            
#> 10  921391    2650 TRUE        39489           1            38 38            
#> # ℹ 14 more rows
#> # ℹ 40 more variables: last_name_ru <chr>, last_name_en <chr>,
#> #   first_name_ru <chr>, first_name_en <chr>, person_name_ru <chr>,
#> #   person_name_en <chr>, is_captain <lgl>, birth_date <chr>, pos_id <int>,
#> #   country_code_ioc <chr>, country_name_ru <chr>, country_name_en <chr>,
#> #   rank_ru <chr>, rank_en <chr>, height <int>, weight <int>, points <int>,
#> #   shot1 <int>, goal1 <int>, shot1_percent <dbl>, shot2 <int>, goal2 <int>, …
# }
```
