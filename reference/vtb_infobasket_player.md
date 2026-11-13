# **Get VTB Infobasket Player**

Player profile: names, birth date, height, weight, position.

Endpoint: `GET https://org.infobasket.su/Widget/PlayerPage/{person_id}`

## Usage

``` r
vtb_infobasket_player(person_id, tag = "vtb")
```

## Arguments

- person_id:

  Infobasket PersonID (person_id in a box score or roster): one person
  across clubs and seasons, e.g. 423011.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_player")`) and in the
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
  try(vtb_infobasket_player(person_id = 423011))
#> ── VTB Infobasket Player from org.infobasket.su ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:56 UTC
#> # A tibble: 1 × 16
#>   person_id person_last_name_ru person_first_name_ru person_last_name_en
#>       <int> <chr>               <chr>                <chr>              
#> 1    423011 Миллер              Патрик               Miller             
#> # ℹ 12 more variables: person_first_name_en <chr>, person_gender <int>,
#> #   birth_date <chr>, person_height <int>, person_weight <int>,
#> #   person_status <int>, player_position <int>, player_hand <chr>,
#> #   is_naturalized <lgl>, position_id <int>, position_name_ru <chr>,
#> #   position_name_en <chr>
# }
```
