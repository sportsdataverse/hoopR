# **RealGM NBA Salary Cap History**

**Get the NBA salary-cap history (and projections) from RealGM
(basketball.realgm.com).**

One row per season with the cap, luxury-tax line, both aprons, bi-annual
exception and the mid-level exception tiers. Dollar figures are returned
as the formatted strings RealGM publishes (e.g. `"$140,588,000"`).

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_salary_cap()
```

## Value

A `hoopR_data` tibble with one row per season:

|                  |           |                                   |
|------------------|-----------|-----------------------------------|
| col_name         | types     | description                       |
| season           | character | Season (e.g. `2025-2026`).        |
| salary_cap       | character | Salary cap.                       |
| luxury_tax       | character | Luxury-tax threshold.             |
| x1st_apron       | character | First apron.                      |
| x2nd_apron       | character | Second apron.                     |
| bae              | character | Bi-annual exception.              |
| non_taxpayer_mle | character | Non-taxpayer mid-level exception. |
| taxpayer_mle     | character | Taxpayer mid-level exception.     |
| team_room_mle    | character | Room mid-level exception.         |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_salary_cap())
} # }
```
