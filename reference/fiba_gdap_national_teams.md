# **FIBA GDAP: national teams**

Every national federation FIBA lists.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapnationalteams`

## Usage

``` r
fiba_gdap_national_teams(return_parsed = TRUE)
```

## Arguments

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| national_federation_id | integer | Federation organisation id (organisationId key space: 64 = Germany). |
| display_name | character | English display name of the federation (the country), as the FIBA site shows it. |
| official_name | character | Federation's official name. |
| country_id | integer | FIBA country id (country table key space; not an organisationId). |
| country_name | character | Country name in English. |
| country_fiba_code | character | FIBA code of the federation's country. |
| zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
| zone_name | character | FIBA zone (Europe, Africa...). |
| organisation_status_code | character | Organisation status: ACT active. |
| membership_status_code | character | FIBA membership status: ACT active. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_national_teams()

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
