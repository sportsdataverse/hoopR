# **RealGM NBA Head Coaches**

**Get the current NBA head coaches from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_coaches()
```

## Value

A `hoopR_data` tibble with one row per coach:

|               |           |                                         |
|---------------|-----------|-----------------------------------------|
| col_name      | types     | description                             |
| staff         | character | Coach name.                             |
| team          | character | Team name.                              |
| start_season  | character | Season the coach started with the team. |
| years_in_role | integer   | Seasons in the role.                    |
| birth_date    | character | Birth date (when listed).               |
| nationality   | character | Nationality.                            |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_coaches())
} # }
```
