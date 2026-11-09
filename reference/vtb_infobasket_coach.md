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

A `hoopR_data` tibble: Coach profile: names, height, weight (no birth
data). The columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_coach`); an empty valid answer raises `hoopR_no_data`, a
valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| person_id | integer | Infobasket person id (PersonID): one person (player, coach or official) across clubs and seasons. Joins to /Widget/PlayerPage/{personId} (players) and /Widget/CoachPage/{personId} (coaches). The scope check compares it with the request. |
| person_last_name_ru | character | Last name, Russian. |
| person_first_name_ru | character | First name, Russian. |
| person_last_name_en | character | Last name, English. |
| person_first_name_en | character | First name, English. |
| person_gender | integer | Person gender: 1 on every sampled (male) person. |
| person_height | integer | Height in centimetres. |
| person_weight | integer | Weight in kilograms. |
| person_status | integer | Person record status (1 active, 0 otherwise); meaning unverified. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_coach(person_id = 131047)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
