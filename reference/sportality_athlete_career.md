# **Get Basketligaen Player Career**

Player career totals, one row per ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/athlete/playerProfile_gameLog`

## Usage

``` r
sportality_athlete_career(athlete_uuid, master_site_instance_id = NULL)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid.

- master_site_instance_id:

  (default `NULL`) Site instance (dbl1_dbl). No effect in the drop-one
  probe.

## Value

A `hoopR_data` tibble with one row per ssgt. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_athlete_career")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_athlete_career(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
