# **RealGM NBA Teams Index**

**Get the NBA team index, with division and conference, from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_teams()
```

## Value

A `hoopR_data` tibble with one row per team:

|            |           |                             |
|------------|-----------|-----------------------------|
| col_name   | types     | description                 |
| team       | character | Team name.                  |
| division   | character | Division (e.g. `Atlantic`). |
| conference | character | `Eastern` or `Western`.     |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_teams())
} # }
```
