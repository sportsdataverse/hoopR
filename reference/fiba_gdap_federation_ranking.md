# **FIBA GDAP: federation ranking**

FIBA world ranking of national teams.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapfederationsranking`

## Usage

``` r
fiba_gdap_federation_ranking(
  category = "men",
  zone_id = 1L,
  as_of_date = NULL,
  return_parsed = TRUE
)
```

## Arguments

- category:

  (character, default `"men"`) Ranking category: men or women (the site
  also knows boys/girls)

- zone_id:

  (integer, default `1L`) Ranking zone id from getgdaprankingzones (1 =
  World, 2 = Africa, 3 = Americas, 4 = Asia, 5 = Europe)

- as_of_date:

  (character, optional) Ranking as of this date, ISO 8601: the latest
  ranking published on or before it (2026-03-10 answers the 2026-03-03
  ranking). Omitted = the latest ranking

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| as_of_date | character | Date of the ranking returned: the latest ranking published on or before the requested date. |
| zone_ranking_code | character | Ranking zone code (WORLD, AFRICA...). |
| zone_ranking_official_name | character | Ranking zone official name. |
| world_rank | integer | Position in the FIBA world ranking (1 = best). |
| country_name | character | Country name in English. |
| zone_rank | integer | Rank within the zone. |
| ioc_code | character | IOC country code. |
| fiba_code | character | FIBA three-letter country code (GER, USA; historic URS, YUG). |
| current_points | double | Ranking points (one decimal). |
| world_rank_variation | integer | Change in world rank since the previous release (positive = up). |
| comments | character | Ranking note; null in every sample. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_federation_ranking(category = "men", zone_id = 1, as_of_date = "2025-09-15")

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
