# **Get Basketligaen ssgt Stats Provider**

Stats provider of an ssgt, a bare word (genius-basketball).

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/ssgt/{ssgt_uuid}/provider`

## Usage

``` r
sportality_ssgt_provider(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble: Stats provider of an ssgt, a bare word
(genius-basketball). An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_ssgt_provider`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| provider | character | Stats provider of the ssgt (genius-basketball, a Genius Sports LiveStats relay). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_ssgt_provider(ssgt_uuid = "xs07bd3fmp")

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
