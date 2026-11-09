# **Get Basketligaen Layout Info (ssgt Directory)**

Directory of every ssgt (season + series + game type) with its teams,
and the stats modules.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/layout-info`

## Usage

``` r
sportality_layout_info()
```

## Value

A `hoopR_data` tibble with one row per season-series-game type (ssgt).
Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_layout_info")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_layout_info()

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
