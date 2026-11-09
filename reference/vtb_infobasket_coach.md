# **Get VTB Infobasket Coach**

Coach profile: names, height, weight (no birth data).

Endpoint: `GET https://org.infobasket.su/Widget/CoachPage/{person_id}`

## Usage

``` r
vtb_infobasket_coach(person_id)
```

## Arguments

- person_id:

  Infobasket PersonID (person_id in a box score or roster): one person
  across clubs and seasons, e.g. 423011.

## Value

A `hoopR_data` tibble with one row per coach. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_coach")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_coach(person_id = 131047)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
