# **Get ESPN MBB Season-Week Detail**

Returns metadata for one week (number, start / end dates, text label,
and `$ref` to the per-week rankings endpoint).

Returns metadata for one week (number, start / end dates, text label,
and `$ref` to the per-week rankings endpoint).

## Usage

``` r
espn_mbb_season_week(
  week,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_nba_season_week(
  week,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- week:

  Week number.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per week.

|              |           |                                           |
|--------------|-----------|-------------------------------------------|
| col_name     | types     | description                               |
| league       | character | League slug.                              |
| season       | integer   | Season year.                              |
| season_type  | integer   | Season-type id.                           |
| week         | integer   | Week number.                              |
| text         | character | Display label (e.g. "Week 5").            |
| start_date   | character | ISO 8601 week start.                      |
| end_date     | character | ISO 8601 week end.                        |
| rankings_ref | character | `$ref` to the per-week rankings endpoint. |

A `hoopR_data` tibble with one row per week.

|              |           |                                           |
|--------------|-----------|-------------------------------------------|
| col_name     | types     | description                               |
| league       | character | League slug.                              |
| season       | integer   | Season year.                              |
| season_type  | integer   | Season-type id.                           |
| week         | integer   | Week number.                              |
| text         | character | Display label (e.g. "Week 5").            |
| start_date   | character | ISO 8601 week start.                      |
| end_date     | character | ISO 8601 week end.                        |
| rankings_ref | character | `$ref` to the per-week rankings endpoint. |

## Details

**Get ESPN MBB Season-Week Detail**

**Get ESPN NBA Season-Week Detail**

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_season_week(week = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Week Detail ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:40 UTC
#> # A tibble: 1 × 8
#>   league         season season_type  week text  start_date end_date rankings_ref
#>   <chr>           <int>       <int> <int> <chr> <chr>      <chr>    <chr>       
#> 1 mens-college-…   2025           2     5 Week… 2024-12-0… 2024-12… http://spor…
# }
# \donttest{
  espn_nba_season_week(week = 5, season = 2025)
#> ── ESPN NBA Season Week Detail ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:40 UTC
#> # A tibble: 1 × 8
#>   league season season_type  week text   start_date        end_date rankings_ref
#>   <chr>   <int>       <int> <int> <chr>  <chr>             <chr>    <chr>       
#> 1 nba      2025           2     5 Week 5 2024-11-19T08:00Z 2024-11… http://spor…
# }
```
