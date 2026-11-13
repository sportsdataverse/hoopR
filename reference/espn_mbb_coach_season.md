# **Get ESPN MBB Coach-in-Season Detail**

Per-season coach detail (name, birth info, `$ref`s to team/college/
person). ESPN's coverage of this endpoint is sparse; many (coach x
season) combinations return 404.

Per-season coach detail (name, birth info, `$ref`s to team/college/
person). ESPN's coverage of this endpoint is sparse; many (coach x
season) combinations return 404.

## Usage

``` r
espn_mbb_coach_season(coach_id, season = most_recent_mbb_season(), ...)

espn_nba_coach_season(coach_id, season = most_recent_nba_season(), ...)
```

## Arguments

- coach_id:

  ESPN coach identifier.

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per coach-season.

|               |           |                            |
|---------------|-----------|----------------------------|
| col_name      | types     | description                |
| league        | character | League slug.               |
| season        | integer   | Season year.               |
| coach_id      | character | ESPN coach id.             |
| uid           | character | ESPN UID string.           |
| first_name    | character | First name.                |
| last_name     | character | Last name.                 |
| date_of_birth | character | Date of birth.             |
| birth_city    | character | Birth city.                |
| birth_state   | character | Birth state / region.      |
| n_records     | integer   | Count of records entries.  |
| person_ref    | character | `$ref` to person resource. |
| college_ref   | character | `$ref` to college.         |
| team_ref      | character | `$ref` to team-in-season.  |

A `hoopR_data` tibble with one row per coach-season.

|               |           |                            |
|---------------|-----------|----------------------------|
| col_name      | types     | description                |
| league        | character | League slug.               |
| season        | integer   | Season year.               |
| coach_id      | character | ESPN coach id.             |
| uid           | character | ESPN UID string.           |
| first_name    | character | First name.                |
| last_name     | character | Last name.                 |
| date_of_birth | character | Date of birth.             |
| birth_city    | character | Birth city.                |
| birth_state   | character | Birth state / region.      |
| n_records     | integer   | Count of records entries.  |
| person_ref    | character | `$ref` to person resource. |
| college_ref   | character | `$ref` to college.         |
| team_ref      | character | `$ref` to team-in-season.  |

## Details

**Get ESPN MBB Coach-in-Season Detail**

**Get ESPN NBA Coach-in-Season Detail**

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
  espn_mbb_coach_season(coach_id = 32116, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Coach-in-Season Detail ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:11:54 UTC
#> # A tibble: 1 × 13
#>   league     season coach_id uid   first_name last_name date_of_birth birth_city
#>   <chr>       <int> <chr>    <chr> <chr>      <chr>     <chr>         <chr>     
#> 1 mens-coll…   2025 32116    s:40… Steven     Pearl     1987-09-14T0… Knoxville 
#> # ℹ 5 more variables: birth_state <chr>, n_records <int>, person_ref <chr>,
#> #   college_ref <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_coach_season(coach_id = 52120, season = 2025)
#> ── ESPN NBA Coach-in-Season Detail ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:11:54 UTC
#> # A tibble: 1 × 13
#>   league season coach_id uid       first_name last_name date_of_birth birth_city
#>   <chr>   <int> <chr>    <chr>     <chr>      <chr>     <chr>         <chr>     
#> 1 nba      2025 52120    s:40~l:4… Quin       Snyder    NA            NA        
#> # ℹ 5 more variables: birth_state <chr>, n_records <int>, person_ref <chr>,
#> #   college_ref <chr>, team_ref <chr>
# }
```
