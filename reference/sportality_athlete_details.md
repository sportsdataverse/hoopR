# **Get Basketligaen Athlete Details**

Player bio plus playerExtIds (the Genius person id).

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athlete-details/{athlete_uuid}`

## Usage

``` r
sportality_athlete_details(athlete_uuid)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid: roster `players[].uuid` or stats-info
  `stats[].info.uuid`. Key space: platform athlete uuids (not the Genius
  person id).

## Value

A `hoopR_data` tibble with one row per athlete. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_athlete_details")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_athlete_details(athlete_uuid = "dpu0901c0t")

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
