# **Get VTB Infobasket Player Season Stats**

A player's season-by-season totals in the competition tag.

Endpoint:
`GET https://org.infobasket.su/Widget/PlayerSeasonStats/{person_id}`

## Usage

``` r
vtb_infobasket_player_season_stats(person_id, tag = "vtb")
```

## Arguments

- person_id:

  Infobasket PersonID (person_id in a box score or roster): one person
  across clubs and seasons, e.g. 423011.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_player_season_stats")`)
and in the searchable [return
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
  try(vtb_infobasket_player_season_stats(person_id = 423011))
#> ── VTB Infobasket Player Season Stats from org.infobasket.su ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:40:24 UTC
#> # A tibble: 4 × 48
#>   person_id season season_name_ru  season_name_en   team_short_name_ru
#>       <int>  <int> <chr>           <chr>            <chr>             
#> 1    423011   2027 Сезон 2026/2027 Season 2026/2027 Локомотив-Кубань  
#> 2    423011   2026 Сезон 2025/2026 Season 2025/2026 Локомотив-К       
#> 3    423011   2025 Сезон 2024/2025 Season 2024/2025 Локомотив-К       
#> 4    423011   2024 Сезон 2023/2024 Season 2023/2024 Локомотив-К       
#> # ℹ 43 more variables: team_short_name_en <chr>, team_name_ru <chr>,
#> #   team_name_en <chr>, team_region_name_ru <chr>, team_region_name_en <chr>,
#> #   team_id <int>, game_count <int>, in_game_count <int>, start_count <int>,
#> #   points <int>, shot1 <int>, goal1 <int>, shot2 <int>, goal2 <int>,
#> #   shot3 <int>, goal3 <int>, shot1_percent <dbl>, shot2_percent <dbl>,
#> #   shot3_percent <dbl>, assist <int>, blocks <int>, def_rebound <int>,
#> #   off_rebound <int>, rebound <int>, steal <int>, turnover <int>, …
# }
```
