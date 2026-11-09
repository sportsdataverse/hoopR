# **FIBA GDAP: gateway competition ids**

Ids of the competitions that run in a date window.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getcustomgateway`

## Usage

``` r
fiba_gdap_gateway_competition_ids(start_date, end_date, return_parsed = TRUE)
```

## Arguments

- start_date:

  (character, required) Required. Window start as YYYY-MM-DD.

- end_date:

  (character, required) Required. Window end as YYYY-MM-DD.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | FIBA competition id (Int64, GDAP key space) of a competition that runs in the window. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_gateway_competition_ids(start_date = "2025-01-14", end_date = "2025-01-16")

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
