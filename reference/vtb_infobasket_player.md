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

A `hoopR_data` tibble: Player profile: names, birth date, height,
weight, position. The columns are always these, in this order
(sportsdataverse-py `vtb_infobasket_player`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| person_id | integer | Infobasket PersonID: one person across clubs and seasons; players, coaches and officials share the space. |
| person_last_name_ru | character | Last name, Russian. |
| person_first_name_ru | character | First name, Russian. |
| person_last_name_en | character | Last name, English. |
| person_first_name_en | character | First name, English. |
| person_gender | integer | Person gender: 1 on every sampled (male) person. |
| birth_date | character | Birth date (ISO 8601 date) of a player: public bio, kept; coaches' and officials' birth data is never output. |
| person_height | integer | Height in centimetres. |
| person_weight | integer | Weight in kilograms. |
| person_status | integer | Person record status (1 active, 0 otherwise); meaning unverified. |
| player_position | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| player_hand | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| is_naturalized | logical | True for naturalised players. |
| position_id | integer | Position id of the player (PosID), with its names in position_name_ru / position_name_en. |
| position_name_ru | character | Position name in Russian. |
| position_name_en | character | Position name in English. |

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
#> ℹ Data updated: 2026-11-09 17:10:07 UTC
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
