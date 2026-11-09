# **Get ESPN MBB Tournament Detail**

Returns metadata for a single MBB tournament plus the `$ref` URL for the
tournament's seasons list. Tournament IDs of interest include the NCAA
Tournament and NIT (resolve via
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md)).

Returns metadata for a single tournament plus the `$ref` URL for the
tournament's seasons list. Use
[`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md)
to resolve the seasons.

## Usage

``` r
espn_mbb_tournament(tournament_id, ...)

espn_nba_tournament(tournament_id, ...)
```

## Arguments

- tournament_id:

  ESPN tournament identifier.

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

|               |           |                                      |
|---------------|-----------|--------------------------------------|
| col_name      | types     | description                          |
| tournament_id | character | ESPN tournament identifier.          |
| display_name  | character | Human-readable tournament name.      |
| seasons_ref   | character | `$ref` to the seasons-list endpoint. |
| league        | character | League slug.                         |

A single-row tibble.

|               |           |                                      |
|---------------|-----------|--------------------------------------|
| col_name      | types     | description                          |
| tournament_id | character | ESPN tournament identifier.          |
| display_name  | character | Human-readable tournament name.      |
| seasons_ref   | character | `$ref` to the seasons-list endpoint. |
| league        | character | League slug (`"nba"`).               |

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
  espn_mbb_tournament(tournament_id = 3)
#> ── ESPN MENS-COLLEGE-BASKETBALL Tournament Detail ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:39 UTC
#> # A tibble: 1 × 4
#>   tournament_id display_name                   seasons_ref                league
#>   <chr>         <chr>                          <chr>                      <chr> 
#> 1 3             Atlantic Coast Conf Tournament http://sports.core.api.es… mens-…
# }
# \donttest{
  espn_nba_tournament(tournament_id = 1)
#> ── ESPN NBA Tournament Detail ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:39 UTC
#> # A tibble: 1 × 4
#>   tournament_id display_name seasons_ref                                  league
#>   <chr>         <chr>        <chr>                                        <chr> 
#> 1 1             NBA Cup      http://sports.core.api.espn.com/v2/sports/b… nba   
# }
```
