# **IBBA Stats Types**

**The stat categories ibba_leaders accepts (the stat_type codes) with
their Hebrew names.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/StatsTypes`

## Usage

``` r
ibba_stats_types()
```

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| stat_type | character | Stat category code to pass to ibba_leaders as stat_type (bracketed codes such as '\[OR\]' are literal). |
| stat_name_he | character | Stat category name in Hebrew. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_stats_types()

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
