# **Get KZS Player Profile**

Player profile: names, year of birth, nationality and positions.

Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}`

## Usage

``` r
kzs_player(player_id)
```

## Arguments

- player_id:

  (required) Player registry id (player_id in a box score or roster),
  e.g. 106285. Not the person id.

## Value

A `hoopR_data` tibble: Player profile: names, year of birth, nationality
and positions. An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sportsdataverse-py `kzs_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
| person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
| first_name | character | The player's given name. |
| last_name | character | The player's family name. |
| year_of_birth | integer | Year of birth (players: public bio). |
| nationality_id | integer | Country id (FMS internal; use the ISO codes). |
| nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
| nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
| nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
| nationality_eng_name | character | Country name in English. |
| homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
| photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_player(player_id = 106285)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
