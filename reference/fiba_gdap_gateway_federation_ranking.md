# **FIBA GDAP: gateway federation ranking**

FIBA world ranking from the server-side gateway (same items as
fiba_gdap_federation_ranking).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getcustomgateway`

## Usage

``` r
fiba_gdap_gateway_federation_ranking(
  gender = "men",
  zone_id = 1L,
  as_of_date = NULL,
  return_parsed = TRUE
)
```

## Arguments

- gender:

  (character, default `"men"`) federationRanking: men or women (=
  gdapCategory)

- zone_id:

  (integer, default `1L`) federationRanking: ranking zone id (=
  zoneRankingId)

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
| organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| organisation_status_code | character | Organisation status: ACT active. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_gateway_federation_ranking(gender = "men", zone_id = 1, as_of_date = "2025-09-15")

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
