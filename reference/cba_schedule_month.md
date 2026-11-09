# **Get CBA Schedule Month**

Game count per day of one calendar month.

Endpoint: `GET https://data-server.cbaleague.com/api/schedules/month`

## Usage

``` r
cba_schedule_month(year, month)
```

## Arguments

- year:

  (required) Required. CALENDAR year (not the season).

- month:

  (required) Required. Calendar month, 1-12.

## Value

A `hoopR_data` tibble: One row per day with games: date and game count.
An empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_schedule_month`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_num | integer | Number of games scheduled on that day (0 = none). |
| schedule_time | character | The day as 'YYYY-MM-DD 00:00:00' (China local time, no zone); one row per calendar day of the month. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_schedule_month(month = 12, year = 2025))
#> ── CBA Schedule Month from data-server.cbaleague.com ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:02:54 UTC
#> # A tibble: 31 × 2
#>    schedule_num schedule_time      
#>           <int> <chr>              
#>  1            0 2025-12-01 00:00:00
#>  2            0 2025-12-02 00:00:00
#>  3            0 2025-12-03 00:00:00
#>  4            0 2025-12-04 00:00:00
#>  5            0 2025-12-05 00:00:00
#>  6            0 2025-12-06 00:00:00
#>  7            0 2025-12-07 00:00:00
#>  8            0 2025-12-08 00:00:00
#>  9            0 2025-12-09 00:00:00
#> 10            0 2025-12-10 00:00:00
#> # ℹ 21 more rows
# }
```
