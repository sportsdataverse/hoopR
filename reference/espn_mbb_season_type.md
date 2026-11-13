# **Get ESPN MBB Season-Type Detail**

Returns metadata for one season-type within an MBB season: name,
abbreviation, start / end dates, and whether it carries groups,
standings, or playoff legs.

Returns metadata for one season-type within an NBA season: name,
abbreviation, start / end dates, and whether it carries groups,
standings, or playoff legs.

## Usage

``` r
espn_mbb_season_type(season_type = 2L, season = most_recent_mbb_season(), ...)

espn_nba_season_type(season_type = 2L, season = most_recent_nba_season(), ...)
```

## Arguments

- season_type:

  Season-type id (1 = preseason, 2 = regular (default), 3 = postseason,
  4 = off-season).

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per season type.

|               |           |                                       |
|---------------|-----------|---------------------------------------|
| col_name      | types     | description                           |
| league        | character | League slug.                          |
| season        | integer   | Season year.                          |
| season_type   | integer   | Season-type id.                       |
| type          | integer   | Numeric type code.                    |
| name          | character | Display name (e.g. "Regular Season"). |
| abbreviation  | character | Short code (e.g. "reg").              |
| year          | integer   | Year stamp.                           |
| start_date    | character | ISO 8601 start date.                  |
| end_date      | character | ISO 8601 end date.                    |
| has_groups    | logical   | Whether groups exist for this type.   |
| has_standings | logical   | Whether standings exist.              |
| has_legs      | logical   | Whether playoff legs exist.           |
| slug          | character | URL slug.                             |
| groups_ref    | character | `$ref` to the groups endpoint.        |
| weeks_ref     | character | `$ref` to the weeks endpoint.         |
| leaders_ref   | character | `$ref` to the leaders endpoint.       |

A `hoopR_data` tibble with one row per season type.

|               |           |                                       |
|---------------|-----------|---------------------------------------|
| col_name      | types     | description                           |
| league        | character | League slug.                          |
| season        | integer   | Season year.                          |
| season_type   | integer   | Season-type id.                       |
| type          | integer   | Numeric type code.                    |
| name          | character | Display name (e.g. "Regular Season"). |
| abbreviation  | character | Short code (e.g. "reg").              |
| year          | integer   | Year stamp.                           |
| start_date    | character | ISO 8601 start date.                  |
| end_date      | character | ISO 8601 end date.                    |
| has_groups    | logical   | Whether groups exist for this type.   |
| has_standings | logical   | Whether standings exist.              |
| has_legs      | logical   | Whether playoff legs exist.           |
| slug          | character | URL slug.                             |
| groups_ref    | character | `$ref` to the groups endpoint.        |
| weeks_ref     | character | `$ref` to the weeks endpoint.         |
| leaders_ref   | character | `$ref` to the leaders endpoint.       |

## Details

**Get ESPN MBB Season-Type Detail**

**Get ESPN NBA Season-Type Detail**

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
  espn_mbb_season_type(season_type = 2, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Type Detail ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:03 UTC
#> # A tibble: 1 × 16
#>   league   season season_type  type name  abbreviation  year start_date end_date
#>   <chr>     <int>       <int> <int> <chr> <chr>        <int> <chr>      <chr>   
#> 1 mens-co…   2025           2     2 Regu… reg           2025 2024-11-0… 2025-03…
#> # ℹ 7 more variables: has_groups <lgl>, has_standings <lgl>, has_legs <lgl>,
#> #   slug <chr>, groups_ref <chr>, weeks_ref <chr>, leaders_ref <chr>
# }
# \donttest{
  espn_nba_season_type(season_type = 2, season = 2025)
#> ── ESPN NBA Season Type Detail ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:03 UTC
#> # A tibble: 1 × 16
#>   league season season_type  type name    abbreviation  year start_date end_date
#>   <chr>   <int>       <int> <int> <chr>   <chr>        <int> <chr>      <chr>   
#> 1 nba      2025           2     2 Regula… reg           2025 2024-10-2… 2025-04…
#> # ℹ 7 more variables: has_groups <lgl>, has_standings <lgl>, has_legs <lgl>,
#> #   slug <chr>, groups_ref <chr>, weeks_ref <chr>, leaders_ref <chr>
# }
```
