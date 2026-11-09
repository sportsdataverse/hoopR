# **FIBA GDAP: medal count**

All-time medal table of a competition family.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapmedalcount`

## Usage

``` r
fiba_gdap_medal_count(family_id, return_parsed = TRUE)
```

## Arguments

- family_id:

  (integer, required) Required. Competition family id
  (competitionMarketingName.competitionMarketingNameId): 201 = World
  Cup, 320 = men's Olympics, 306 = Women's World Cup, 112 = BCL tier 1,
  211 = EuroLeague Women.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_name | character | Team name (country or club). |
| organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| fiba_code | character | FIBA three-letter country code (GER, USA; historic URS, YUG). |
| team_zone_code | character | Zone code of the team (E Europe, NAM Americas north...). |
| rank | integer | Rank (1 = first). |
| total_first_rank | integer | Gold medals (first places). |
| total_second_rank | integer | Number of silver medals the federation has won in the competition family. |
| total_third_rank | integer | Number of bronze medals the federation has won in the competition family. |
| total_participations | integer | Editions played. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_medal_count(family_id = 201)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
