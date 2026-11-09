# **FIBA GDAP: ranking zones**

FIBA world-ranking zones.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdaprankingzones`

## Usage

``` r
fiba_gdap_ranking_zones(return_parsed = TRUE)
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
| zone_ranking_id | integer | Ranking zone id (getgdaprankingzones key space: 1 = World ... 5 = Europe). |
| code | character | Ranking zone code (W, AF, AM, AS, EU). |
| official_name | character | Official name of the ranking zone (World, FIBA Europe, FIBA Americas...). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_ranking_zones()

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
