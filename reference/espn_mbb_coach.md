# **Get ESPN MBB Single-Coach Detail**

Returns biography, current team / college refs, and counts of career
record entries + per-season coaching entries for one MBB head coach.

Returns biography, current team / college refs, and counts of career
record entries + per-season coaching entries for one NBA coach. Backed
by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/coaches/{coach_id}`.

## Usage

``` r
espn_mbb_coach(coach_id, ...)

espn_nba_coach(coach_id, ...)
```

## Arguments

- coach_id:

  ESPN coach identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble. See `espn_nba_coach()` for column schema.

A single-row tibble.

|                  |           |                                     |
|------------------|-----------|-------------------------------------|
| col_name         | types     | description                         |
| coach_id         | character | ESPN coach identifier.              |
| uid              | character | ESPN UID string.                    |
| first_name       | character | First name.                         |
| last_name        | character | Last name.                          |
| date_of_birth    | character | Date of birth (ISO 8601).           |
| birth_city       | character | Birth city.                         |
| birth_state      | character | Birth state / region.               |
| n_career_records | integer   | Count of career-records entries.    |
| n_coach_seasons  | integer   | Count of seasons coached.           |
| college_ref      | character | `$ref` to the coach's college.      |
| team_ref         | character | `$ref` to the coach's current team. |
| league           | character | League slug (`"nba"`).              |

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
  espn_mbb_coach(coach_id = 32116)
#> ── ESPN MENS-COLLEGE-BASKETBALL Coach Detail ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:08 UTC
#> # A tibble: 1 × 12
#>   coach_id uid         first_name last_name date_of_birth birth_city birth_state
#>   <chr>    <chr>       <chr>      <chr>     <chr>         <chr>      <chr>      
#> 1 32116    s:40~l:41~… Steven     Pearl     1987-09-14T0… Knoxville  TN         
#> # ℹ 5 more variables: n_career_records <int>, n_coach_seasons <int>,
#> #   college_ref <chr>, team_ref <chr>, league <chr>
# }
# \donttest{
  espn_nba_coach(coach_id = 52120)
#> ── ESPN NBA Coach Detail ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:08 UTC
#> # A tibble: 1 × 12
#>   coach_id uid         first_name last_name date_of_birth birth_city birth_state
#>   <chr>    <chr>       <chr>      <chr>     <chr>         <chr>      <chr>      
#> 1 52120    s:40~l:46~… Quin       Snyder    NA            NA         NA         
#> # ℹ 5 more variables: n_career_records <int>, n_coach_seasons <int>,
#> #   college_ref <chr>, team_ref <chr>, league <chr>
# }
```
