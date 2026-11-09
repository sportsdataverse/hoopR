# **Get ESPN MBB Coach Career Record (Long Format)**

Returns a coach's career record by type in long format (one row per stat
in the record's `stats[]` array). `record_type` codes commonly
populated: 0 = Total, 1 = Pre Season, 2 = Regular Season, 3 = Post
Season. Use
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md)
to discover coach_ids for a season.

Returns a coach's career record by type in long format (one row per stat
in the record's `stats[]` array). `record_type` codes commonly
populated: 0 = Total, 1 = Pre Season, 2 = Regular Season, 3 = Post
Season. Use
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md)
to discover coach_ids for a season.

## Usage

``` r
espn_mbb_coach_record(coach_id, record_type = 0L, ...)

espn_nba_coach_record(coach_id, record_type = 0L, ...)
```

## Arguments

- coach_id:

  ESPN coach identifier (use
  [`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md)
  to find).

- record_type:

  Integer record type: 0 = Total (default), 1 = Pre Season, 2 = Regular
  Season, 3 = Post Season.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble.

A long tibble.

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
  espn_mbb_coach_record(coach_id = 32116, record_type = 2)
#> ── ESPN MENS-COLLEGE-BASKETBALL Coach Record ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:08 UTC
#> # A tibble: 5 × 12
#>   league          coach_id record_type_id record_name record_type record_summary
#>   <chr>           <chr>             <int> <chr>       <chr>       <chr>         
#> 1 mens-college-b… 32116                 2 Regular Se… Regular Se… 16-15-0       
#> 2 mens-college-b… 32116                 2 Regular Se… Regular Se… 16-15-0       
#> 3 mens-college-b… 32116                 2 Regular Se… Regular Se… 16-15-0       
#> 4 mens-college-b… 32116                 2 Regular Se… Regular Se… 16-15-0       
#> 5 mens-college-b… 32116                 2 Regular Se… Regular Se… 16-15-0       
#> # ℹ 6 more variables: record_display <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, value <dbl>, stat_display_value <chr>
# }
# \donttest{
  espn_nba_coach_record(coach_id = 52120, record_type = 2)
#> ── ESPN NBA Coach Record ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:08 UTC
#> # A tibble: 5 × 12
#>   league coach_id record_type_id record_name    record_type    record_summary
#>   <chr>  <chr>             <int> <chr>          <chr>          <chr>         
#> 1 nba    52120                 2 Regular Season Regular Season 284-220-0     
#> 2 nba    52120                 2 Regular Season Regular Season 284-220-0     
#> 3 nba    52120                 2 Regular Season Regular Season 284-220-0     
#> 4 nba    52120                 2 Regular Season Regular Season 284-220-0     
#> 5 nba    52120                 2 Regular Season Regular Season 284-220-0     
#> # ℹ 6 more variables: record_display <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, value <dbl>, stat_display_value <chr>
# }
```
