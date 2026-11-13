# **Get ESPN MBB Season Award Detail**

Returns the name, description, and winners of one MBB season award.

Returns the name, description, and winners of one NBA season award. Most
awards have a single winner; multi-recipient awards (e.g. All-NBA First
Team) return one row per winner.

## Usage

``` r
espn_mbb_award(award_id, season = most_recent_mbb_season(), ...)

espn_nba_award(award_id, season = most_recent_nba_season(), ...)
```

## Arguments

- award_id:

  ESPN award identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per winner.

|             |           |                                                 |
|-------------|-----------|-------------------------------------------------|
| col_name    | types     | description                                     |
| league      | character | League slug.                                    |
| season      | integer   | Season year.                                    |
| award_id    | character | ESPN award identifier.                          |
| name        | character | Award name.                                     |
| description | character | Award description.                              |
| athlete_id  | character | ESPN athlete id of winner.                      |
| team_id     | character | ESPN team id.                                   |
| athlete_ref | character | `$ref` to winner's per-season athlete resource. |
| team_ref    | character | `$ref` to winner's per-season team resource.    |

A `hoopR_data` tibble with one row per winner.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League slug (`"nba"`). |
| season | integer | Season year. |
| award_id | character | ESPN award identifier. |
| name | character | Award name (e.g. "MVP"). |
| description | character | Award description. |
| athlete_id | character | ESPN athlete id of winner (parsed from `athlete_ref`). |
| team_id | character | ESPN team id (parsed from `team_ref`). |
| athlete_ref | character | `$ref` to winner's per-season athlete resource. |
| team_ref | character | `$ref` to winner's per-season team resource. |

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
  espn_mbb_award(award_id = 344, season = 2024)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Award Detail from ESPN.com ──────────────
#> ℹ Data updated: 2026-11-13 17:34:21 UTC
#> # A tibble: 1 × 9
#>   league        season award_id name  description athlete_id team_id athlete_ref
#>   <chr>          <int> <chr>    <chr> <chr>       <chr>      <chr>   <chr>      
#> 1 mens-college…   2024 344      Karl… Best power… 4397237    21      http://spo…
#> # ℹ 1 more variable: team_ref <chr>
# }
# \donttest{
  # MVP award id = 33
  espn_nba_award(award_id = 33, season = 2024)
#> ── ESPN NBA Season Award Detail from ESPN.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:21 UTC
#> # A tibble: 1 × 9
#>   league season award_id name  description        athlete_id team_id athlete_ref
#>   <chr>   <int> <chr>    <chr> <chr>              <chr>      <chr>   <chr>      
#> 1 nba      2024 33       MVP   NBA Most Valuable… 3112335    7       http://spo…
#> # ℹ 1 more variable: team_ref <chr>
# }
```
