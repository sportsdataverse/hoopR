# **Get ESPN MBB Franchise Detail**

Returns franchise-level metadata for a men's college basketball program.
Franchise IDs are stable across program reorganization or rebrands.

Returns franchise-level metadata for an NBA franchise. Franchise IDs are
stable across relocations and rebrands - useful for tracking franchise
history independent of current team identity.

## Usage

``` r
espn_mbb_franchise(franchise_id, ...)

espn_nba_franchise(franchise_id, ...)
```

## Arguments

- franchise_id:

  ESPN franchise identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per franchise.

|                    |           |                                           |
|--------------------|-----------|-------------------------------------------|
| col_name           | types     | description                               |
| id                 | character | ESPN franchise identifier.                |
| uid                | character | ESPN UID string.                          |
| slug               | character | URL-safe identifier.                      |
| location           | character | Franchise location.                       |
| name               | character | Franchise name.                           |
| nickname           | character | Common nickname.                          |
| abbreviation       | character | Short abbreviation.                       |
| display_name       | character | Full display name.                        |
| short_display_name | character | Short display name.                       |
| color              | character | Primary color (hex, no leading '#').      |
| is_active          | logical   | Whether franchise is currently active.    |
| league             | character | League slug.                              |
| logo               | character | Primary logo URL.                         |
| logo_dark          | character | Dark-mode logo URL.                       |
| venue_ref          | character | `$ref` to franchise's primary venue.      |
| team_ref           | character | `$ref` to the current team for franchise. |

A `hoopR_data` tibble with one row per franchise.

|                    |           |                                           |
|--------------------|-----------|-------------------------------------------|
| col_name           | types     | description                               |
| id                 | character | ESPN franchise identifier.                |
| uid                | character | ESPN UID string.                          |
| slug               | character | URL-safe identifier.                      |
| location           | character | Franchise location.                       |
| name               | character | Franchise name.                           |
| nickname           | character | Common nickname (often same as name).     |
| abbreviation       | character | Short abbreviation.                       |
| display_name       | character | Full display name.                        |
| short_display_name | character | Short display name.                       |
| color              | character | Primary color (hex, no leading '#').      |
| is_active          | logical   | Whether franchise is currently active.    |
| league             | character | League slug (`"nba"`).                    |
| logo               | character | Primary logo URL.                         |
| logo_dark          | character | Dark-mode logo URL.                       |
| venue_ref          | character | `$ref` to franchise's primary venue.      |
| team_ref           | character | `$ref` to the current team for franchise. |

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
  espn_mbb_franchise(franchise_id = 150)
#> ── ESPN MENS-COLLEGE-BASKETBALL Franchise from ESPN.com ───────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:28 UTC
#> # A tibble: 1 × 16
#>   id    uid             slug   location name  nickname abbreviation display_name
#>   <chr> <chr>           <chr>  <chr>    <chr> <chr>    <chr>        <chr>       
#> 1 150   s:40~l:41~f:150 duke-… Duke     Blue… Duke     DUKE         Duke Blue D…
#> # ℹ 8 more variables: short_display_name <chr>, color <chr>, is_active <lgl>,
#> #   league <chr>, logo <chr>, logo_dark <chr>, venue_ref <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_franchise(franchise_id = 13)
#> ── ESPN NBA Franchise from ESPN.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:28 UTC
#> # A tibble: 1 × 16
#>   id    uid            slug    location name  nickname abbreviation display_name
#>   <chr> <chr>          <chr>   <chr>    <chr> <lgl>    <chr>        <chr>       
#> 1 13    s:40~l:46~f:13 los-an… Los Ang… Lake… NA       LAL          Los Angeles…
#> # ℹ 8 more variables: short_display_name <chr>, color <chr>, is_active <lgl>,
#> #   league <chr>, logo <chr>, logo_dark <chr>, venue_ref <chr>, team_ref <chr>
# }
```
