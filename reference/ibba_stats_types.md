# **IBBA Stats Types**

**The stat categories ibba_leaders accepts (the stat_type codes) with
their Hebrew names.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/StatsTypes`

## Usage

``` r
ibba_stats_types()
```

## Value

A `hoopR_data` tibble with one row per statistic type. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_stats_types")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_stats_types()

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
